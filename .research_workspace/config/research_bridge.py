"""Small stdio MCP bridge for the supervised local literature workflow.

Only exports/reads Zotero. MinerU runs locally. Reports stay in the task folder.
Edge UI operations are restricted to publisher navigation, opening a PDF and
saving a file into the research input folder. No arbitrary shell commands,
browser credentials, cookie exports, or Zotero writes are exposed.
"""
from pathlib import Path
import hashlib
import json
import os
import re
import subprocess
import sys
import urllib.parse
import urllib.request

ROOT = Path(__file__).resolve().parents[2]
WORK = ROOT / '.research_workspace'
TASK = Path(os.environ.get('RESEARCH_TASK_DIR', str(WORK / 'tasks' / 'T001_literature_pilot'))).resolve()
if not TASK.is_relative_to(WORK / 'tasks'):
    raise ValueError('Task directory must be inside the research task directory')
OUTPUT = TASK / 'output'
SOURCES = WORK / 'sources'
MINERU = Path.home() / '.local' / 'bin' / 'mineru.exe'
HELPER = Path.home() / '.codex/plugins/cache/openai-curated-remote/zotero/0.1.2/skills/zotero/scripts/zotero.py'
READ_ROOTS = [ROOT, Path.home() / 'Desktop/基于PDF框架的自适应STA滑模控制', Path.home() / 'Zotero/storage']


def run(argv, timeout=80):
    try:
        child_env = os.environ.copy()
        child_env['PYTHONIOENCODING'] = 'utf-8'
        child_env['PYTHONUTF8'] = '1'
        p = subprocess.run([str(x) for x in argv], capture_output=True, text=True,
                           encoding='utf-8', errors='replace', timeout=timeout, env=child_env)
        try:
            value = json.loads(p.stdout)
        except ValueError:
            value = p.stdout
        return {'exit_code': p.returncode, 'data': value, 'stderr': p.stderr[:1200]}
    except subprocess.TimeoutExpired:
        return {'error': 'timeout', 'message': 'The process exceeded its wait limit. Check MinerU parse status; do not assume parsing failed.'}


def local_path(value):
    p = Path(value).resolve()
    if not any(p.is_relative_to(r.resolve()) for r in READ_ROOTS):
        raise ValueError('Path outside research inputs')
    return p


def output_path(name, folder=OUTPUT):
    if not name or Path(name).name != name or any(c in name for c in '/\\:'):
        raise ValueError('Use a plain filename without directories')
    folder.mkdir(parents=True, exist_ok=True)
    return folder / name


def fetch_json(url):
    req = urllib.request.Request(url, headers={'User-Agent': 'HydraulicResearchLiterature/0.1'})
    with urllib.request.urlopen(req, timeout=25) as r:
        return json.load(r)


def fetch_url_value(url):
    req = urllib.request.Request(url, headers={'User-Agent': 'HydraulicResearchLiterature/0.1'})
    with urllib.request.urlopen(req, timeout=25) as response:
        text = response.read().decode('utf-8').strip()
    try:
        return json.loads(text)
    except ValueError:
        return text


def schema(name, description, properties, required=()):
    return {'name': name, 'description': description,
            'inputSchema': {'type': 'object', 'properties': properties,
                            'required': list(required), 'additionalProperties': False}}


STRING = {'type': 'string'}
TOOLS = [
    schema('status', 'Check the Zotero local API and MinerU version; call before using Zotero.', {}),
    schema('zotero', 'Read/search Zotero collections and items, retrieve attachment URLs, or export BibTeX. Does not modify the library.',
           {'operation': {'type': 'string', 'enum': ['collections', 'search', 'children', 'file-url', 'export-bibtex']},
            'value': STRING}, ['operation']),
    schema('zotero_catalogue', 'Read all top-level library metadata and filter finite/fixed/prescribed-time and super-twisting papers; save a local provenance snapshot. Not a full-text reading.', {}),
    schema('resolve_sources', 'Resolve PDF attachments for up to 10 explicit Zotero parent item keys. Read-only; returns actual local file paths.',
           {'item_keys': {'type': 'array', 'items': STRING, 'minItems': 1, 'maxItems': 10}}, ['item_keys']),
    schema('find_document', 'Find an already indexed local document in MinerU; use this before reparsing an existing PDF.', {'query': STRING}, ['query']),
    schema('export_references', 'Export an explicit list of Zotero keys directly to a task BibTeX file, avoiding copying long citation records through model text.',
           {'item_keys': {'type': 'array', 'items': STRING, 'minItems': 1, 'maxItems': 100}, 'filename': STRING}, ['item_keys', 'filename']),
    schema('search_papers', 'Search Crossref metadata by title or topic. Results are discovery metadata, not evidence of reading a full paper.',
           {'query': STRING, 'limit': {'type': 'integer', 'minimum': 1, 'maximum': 15}}, ['query']),
    schema('download_pdf', 'Download a public HTTP(S) PDF into research sources. Browser login/cookies are not inherited. Report paywalls honestly.',
           {'url': STRING, 'filename': STRING}, ['url', 'filename']),
    schema('parse_pdf', 'Parse a local PDF using local MinerU normal quality; retain continuation locators. Never switches to remote or flash.',
           {'path': STRING, 'filename': STRING}, ['path', 'filename']),
    schema('read_document', 'Read a cached MinerU page/block locator and save the returned metadata/content in research sources.',
           {'locator': STRING, 'context': {'type': 'integer', 'minimum': 0, 'maximum': 30},
            'limit': {'type': 'integer', 'minimum': 1000, 'maximum': 60000}}, ['locator']),
    schema('parse_status', 'List MinerU parse jobs after a timeout. Does not restart or reconfigure the server.', {}),
    schema('edge_browser', 'Use the user-authorized existing Edge window through Windows UI Automation. Open publisher articles, inspect controls, open an observed PDF link, or save a loaded PDF. Human verification must be completed by the user. Does not read cookies or passwords. Browser UI becomes visible.',
           {'action': {'type': 'string', 'enum': ['inspect', 'open_article', 'open_pdf', 'save_pdf']},
            'url': STRING, 'name': STRING, 'filename': STRING}, ['action']),
    schema('write_report', 'Write a task report or readable paper note. Only writes inside this task output directory; cannot publish final files.',
           {'filename': STRING, 'content': STRING}, ['filename', 'content']),
]


def call(name, a):
    if name == 'status':
        return {'zotero': run([sys.executable, HELPER, 'status', '--json'], 20),
                'mineru': run([MINERU, 'version', '--json'], 20),
                'task_output': str(OUTPUT), 'source_directory': str(SOURCES)}
    if name == 'zotero_catalogue':
        base = 'http://127.0.0.1:23119/api/users/0'
        collections = fetch_json(base + '/collections?limit=100')
        collection_names = {x['key']: x.get('data', {}).get('name', x.get('name', '')) for x in collections}
        items, start = [], 0
        while True:
            batch = fetch_json(base + '/items/top?' + urllib.parse.urlencode({'limit': 100, 'start': start}))
            items.extend(batch)
            if len(batch) < 100:
                break
            start += 100
        pattern = re.compile(r'finite[\s\-\u2010-\u2015]*time|fixed[\s\-\u2010-\u2015]*time|prescribed[\s\-\u2010-\u2015]*time|predefined[\s\-\u2010-\u2015]*time|appointed[\s\-\u2010-\u2015]*time|super[\s\-\u2010-\u2015]*twist|terminal[\s\-\u2010-\u2015]*slid|有限时间|固定时间|预设时间|预定义时间', re.I)
        rows = []
        for x in items:
            d = x.get('data', {})
            if d.get('itemType') in ['attachment', 'note', 'annotation']:
                continue
            title, abstract = d.get('title', ''), d.get('abstractNote', '')
            tags = ' '.join(t.get('tag', '') for t in d.get('tags', []))
            matches = [field for field, value in [('title', title), ('abstract', abstract), ('tags', tags)] if pattern.search(value)]
            if not matches:
                continue
            rows.append({'item_key': x['key'], 'title': title, 'doi': d.get('DOI', ''),
                         'date': d.get('date', ''), 'journal': d.get('publicationTitle', ''),
                         'authors': [c.get('firstName', '')+' '+c.get('lastName', '') for c in d.get('creators', [])],
                         'collections': [collection_names.get(k, k) for k in d.get('collections', [])],
                         'matched_fields': matches, 'abstract_excerpt': abstract[:1100],
                         'abstract_truncated': len(abstract) > 1100, 'child_count': x.get('meta', {}).get('numChildren')})
        result = {'library_top_item_count': len(items), 'matched_count': len(rows),
                  'date': '2026-10-27', 'collections': collection_names, 'items': rows,
                  'scope': 'Metadata screening, not full-text evidence. Title matches and abstract-only matches are distinguished.'}
        p = output_path('zotero_finite_time_catalogue_2026-10-27.json', SOURCES)
        p.write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding='utf-8')
        return {'snapshot_path': str(p), **result}
    if name == 'resolve_sources':
        result = []
        for key in a['item_keys']:
            if not re.fullmatch(r'[A-Z0-9]{8}', key):
                raise ValueError('Invalid item key')
            base = 'http://127.0.0.1:23119/api/users/0/items/'
            children = fetch_json(base + key + '/children')
            attachments = []
            for child in children:
                d = child.get('data', {})
                if d.get('itemType') != 'attachment' or d.get('contentType') != 'application/pdf':
                    continue
                try:
                    url = fetch_url_value(base + child['key'] + '/file/view/url')
                    parsed = urllib.parse.urlparse(url)
                    path = urllib.request.url2pathname(parsed.path) if parsed.scheme == 'file' else None
                    attachments.append({'attachment_key': child['key'], 'title': d.get('title'),
                                        'file_url': url, 'local_path': path,
                                        'exists': bool(path and Path(path).is_file())})
                except Exception as e:
                    attachments.append({'attachment_key': child['key'], 'error': str(e)})
            result.append({'item_key': key, 'pdf_attachments': attachments})
        p = output_path('resolved_sources_' + '_'.join(a['item_keys']) + '.json', SOURCES)
        p.write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding='utf-8')
        return result
    if name == 'find_document':
        return run([MINERU, 'find', a['query'], '--json'], 25)
    if name == 'export_references':
        keys = a['item_keys']
        if any(not re.fullmatch(r'[A-Z0-9]{8}', key) for key in keys):
            raise ValueError('Invalid Zotero item key')
        p = output_path(a['filename'])
        if p.suffix.lower() != '.bib':
            raise ValueError('Expected a .bib filename')
        # A prior large keyed export did not return every requested record.
        # Use small batches and verify counts; the truncation cause is unconfirmed.
        export_cache = TASK / 'cache' / 'bibtex'
        export_cache.mkdir(parents=True, exist_ok=True)
        chunks = []
        for start in range(0, len(keys), 10):
            chunk_path = export_cache / ('chunk_' + str(start // 10 + 1) + '.bib')
            result = run([sys.executable, HELPER, 'export-bibtex', '--item-key', ','.join(keys[start:start+10]), '--out', chunk_path], 40)
            if result.get('exit_code') != 0 or not chunk_path.is_file():
                return result
            chunks.append(chunk_path.read_text(encoding='utf-8').strip())
        text = '\n\n'.join(chunks) + '\n'
        citation_keys = re.findall(r'@\w+\s*\{\s*([^,\s]+)', text)
        if len(citation_keys) != len(keys) or len(set(citation_keys)) != len(citation_keys):
            return {'error': 'export_count_or_citation_key_conflict', 'requested': len(keys),
                    'exported': len(citation_keys), 'citation_keys': citation_keys,
                    'note': 'No final BibTeX file has been published; review the individual export chunks.'}
        p.write_text(text, encoding='utf-8')
        return {'path': str(p), 'entry_count': len(re.findall(r'@\w+\s*\{', text)),
                'citation_keys': re.findall(r'@\w+\s*\{\s*([^,\s]+)', text),
                'bytes': p.stat().st_size, 'sha256': hashlib.sha256(p.read_bytes()).hexdigest(),
                'item_keys': keys}
    if name == 'zotero':
        op, value = a['operation'], a.get('value', '')
        if op == 'collections':
            args = ['collections', '--json']
        elif op == 'search':
            args = ['search', value, '--json']
        elif op == 'children':
            if not re.fullmatch(r'[A-Z0-9]{8}', value):
                raise ValueError('Invalid Zotero item key')
            args = ['children', value, '--json']
        elif op == 'file-url':
            if not re.fullmatch(r'[A-Z0-9]{8}', value):
                raise ValueError('Invalid attachment key')
            args = ['file-url', value]
        else:
            if not re.fullmatch(r'[A-Z0-9]{8}(,[A-Z0-9]{8})*', value):
                raise ValueError('Export requires an explicit comma-separated item key list')
            args = ['export-bibtex', '--item-key', value]
        return run([sys.executable, HELPER, *args], 35)
    if name == 'search_papers':
        query = urllib.parse.urlencode({'query.bibliographic': a['query'], 'rows': min(a.get('limit', 6), 15)})
        data = fetch_json('https://api.crossref.org/works?' + query)
        rows = []
        for x in data.get('message', {}).get('items', []):
            rows.append({k: x.get(k) for k in ['DOI', 'title', 'author', 'container-title', 'published', 'URL', 'link', 'abstract']})
        return {'source': 'Crossref', 'query': a['query'], 'items': rows}
    if name == 'download_pdf':
        url = urllib.parse.urlparse(a['url'])
        if url.scheme not in ['http', 'https'] or url.hostname in ['localhost', '127.0.0.1', '::1'] or url.username:
            raise ValueError('Expected a public HTTP(S) PDF URL')
        p = output_path(a['filename'], SOURCES / 'pdfs')
        if p.suffix.lower() != '.pdf':
            raise ValueError('Expected a .pdf filename')
        req = urllib.request.Request(a['url'], headers={'User-Agent': 'HydraulicResearchLiterature/0.1'})
        with urllib.request.urlopen(req, timeout=40) as r:
            data = r.read(40_000_001)
        if len(data) > 40_000_000:
            raise ValueError('PDF exceeds the 40 MB download limit')
        if not data.lstrip().startswith(b'%PDF-'):
            raise ValueError('The response is not a PDF; possible paywall or login page')
        if p.exists() and p.read_bytes() != data:
            raise ValueError('Filename already contains a different file; choose a new version name')
        p.write_bytes(data)
        return {'path': str(p), 'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}
    if name == 'parse_pdf':
        p = local_path(a['path'])
        if p.suffix.lower() != '.pdf' or not p.is_file():
            raise ValueError('Expected an existing local PDF')
        target = output_path(a['filename'], SOURCES / 'parsed')
        if target.suffix.lower() != '.md':
            raise ValueError('Readable extraction should use .md')
        result = run([MINERU, 'parse', p, '--pages', 'all', '--limit', '60000', '--json', '--output', target], 85)
        return {'saved_to': str(target), 'warning': 'Check page coverage and next_request. A saved file is not automatically the full paper.', **result}
    if name == 'read_document':
        locator = a['locator']
        if not re.fullmatch(r'doc:[a-f0-9]+/tier:(standard|advanced|basic|flash)(/page:\d+(/block:\d+)?)?', locator):
            raise ValueError('Expected a stable MinerU locator')
        result = run([MINERU, 'read', locator, '--context', str(a.get('context', 0)),
                      '--limit', str(min(a.get('limit', 25000), 60000)), '--json'], 40)
        safe_name = locator.replace(':', '_').replace('/', '_')
        p = output_path(safe_name + '.json', SOURCES / 'parsed')
        p.write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding='utf-8')
        return result
    if name == 'parse_status':
        return run([MINERU, 'list', 'parses', '--json', '--limit', '12'], 20)
    if name == 'edge_browser':
        action = a['action']
        script = WORK / 'config/edge_session_ui.ps1'
        command = ['powershell.exe', '-NoProfile', '-ExecutionPolicy', 'Bypass',
                   '-File', str(script), '-EvidenceName', 'bridge_' + action]
        if action == 'inspect':
            command += ['-Action', 'Inspect']
        elif action == 'open_article':
            url = urllib.parse.urlparse(a.get('url', ''))
            allowed = {'www.sciencedirect.com', 'sciencedirect.com', 'ieeexplore.ieee.org', 'cris.unibo.it'}
            if url.scheme != 'https' or url.hostname not in allowed or url.username or url.query or url.fragment:
                raise ValueError('Use a canonical HTTPS publisher or repository article URL, without credentials or query tokens.')
            command += ['-Action', 'Navigate', '-Url', url.geturl()]
        elif action == 'open_pdf':
            label = a.get('name', 'View PDF. Opens in a new window.')
            if label not in ['View PDF. Opens in a new window.', 'View PDF', 'PDF', 'Download PDF']:
                raise ValueError('Only a recognized PDF link label is allowed; inspect the current page first.')
            command += ['-Action', 'Invoke', '-Name', label]
        elif action == 'save_pdf':
            filename = a.get('filename', '')
            target = output_path(filename, WORK / 'inputs/four_papers')
            if target.suffix.lower() != '.pdf':
                raise ValueError('Expected a .pdf filename')
            if target.exists():
                return {'error': 'target_exists', 'path': str(target), 'note': 'Preserve the source; verify or choose another filename.'}
            command += ['-Action', 'Save', '-SavePath', str(target)]
        else:
            raise ValueError('Unsupported Edge action')
        result = run(command, 55)
        if action == 'save_pdf' and result.get('exit_code') == 0:
            if not target.is_file():
                return {'error': 'saved_file_not_found', 'path': str(target), 'ui_result': result}
            prefix = target.read_bytes()[:1024]
            if not prefix.lstrip().startswith(b'%PDF-'):
                return {'error': 'not_a_pdf', 'path': str(target), 'note': 'Do not mark the paper acquired or start parsing this file.', 'ui_result': result}
            return {'path': str(target), 'bytes': target.stat().st_size,
                    'sha256': hashlib.sha256(target.read_bytes()).hexdigest(),
                    'pdf_header_verified': True, 'content_identity': 'pending_mineru_read', 'ui_result': result}
        return result
    if name == 'write_report':
        p = output_path(a['filename'])
        if p.suffix.lower() not in ['.md', '.json', '.csv', '.bib', '.txt']:
            raise ValueError('Unsupported report extension')
        p.write_text(a['content'], encoding='utf-8')
        return {'path': str(p), 'chars': len(a['content']), 'review_status': 'pending_review'}
    raise ValueError('Unknown tool')


def serve():
    sys.stdin.reconfigure(encoding='utf-8')
    sys.stdout.reconfigure(encoding='utf-8')
    for line in sys.stdin:
        try:
            req = json.loads(line)
            if 'id' not in req:
                continue
            method = req.get('method')
            if method == 'initialize':
                value = {'protocolVersion': req.get('params', {}).get('protocolVersion', '2024-11-05'),
                         'capabilities': {'tools': {}},
                         'serverInfo': {'name': 'hydraulic-research', 'version': '0.1.0'}}
            elif method == 'ping':
                value = {}
            elif method == 'tools/list':
                value = {'tools': TOOLS}
            elif method == 'tools/call':
                try:
                    data = call(req['params']['name'], req['params'].get('arguments', {}))
                    value = {'content': [{'type': 'text', 'text': json.dumps(data, ensure_ascii=False)}]}
                except Exception as e:
                    value = {'isError': True, 'content': [{'type': 'text', 'text': str(e)}]}
            else:
                print(json.dumps({'jsonrpc': '2.0', 'id': req['id'], 'error': {'code': -32601, 'message': 'Method not found'}}), flush=True)
                continue
            print(json.dumps({'jsonrpc': '2.0', 'id': req['id'], 'result': value}, ensure_ascii=False), flush=True)
        except Exception as e:
            print(str(e), file=sys.stderr, flush=True)


if __name__ == '__main__':
    serve()
