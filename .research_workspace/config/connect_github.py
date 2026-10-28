"""Create/resolve the authorized private repository using Git's credential manager.

Credentials remain in process memory and are never written to files or output.
This command configures origin; it does not stage files, commit, or push.
"""
from pathlib import Path
import json
import os
import subprocess
import urllib.error
import urllib.request

ROOT = Path(__file__).resolve().parents[2]
NAME = 'hydraulic-finite-time-control'


def git(*args, **kwargs):
    return subprocess.run(['git', *args], cwd=ROOT, capture_output=True,
                          text=True, encoding='utf-8', errors='replace', **kwargs)


def main():
    if not (ROOT/'.git').is_dir():
        raise RuntimeError('Local Git repository is missing.')
    credential_env = os.environ.copy()
    credential_env.update({'GIT_TERMINAL_PROMPT':'0', 'GCM_INTERACTIVE':'never'})
    result = git('credential', 'fill', input='protocol=https\nhost=github.com\n\n',
                 env=credential_env, timeout=25)
    values = dict(line.split('=', 1) for line in result.stdout.splitlines() if '=' in line)
    password = values.get('password')
    if result.returncode or not password:
        raise RuntimeError('GitHub authentication has not completed; no repository was created.')

    def request(route, payload=None, allow_missing=False):
        body = json.dumps(payload).encode() if payload is not None else None
        headers = {'Authorization':'Bearer '+password, 'Accept':'application/vnd.github+json',
                   'X-GitHub-Api-Version':'2022-11-28', 'User-Agent':'HydraulicResearchGitSetup/1.0'}
        if body is not None:
            headers['Content-Type'] = 'application/json'
        req = urllib.request.Request('https://api.github.com'+route, data=body, headers=headers)
        try:
            with urllib.request.urlopen(req, timeout=30) as response:
                return json.load(response)
        except urllib.error.HTTPError as error:
            if error.code == 404 and allow_missing:
                return None
            raise RuntimeError(f'GitHub API request failed (HTTP {error.code}, route {route}).') from None

    owner = request('/user')['login']
    repository = request(f'/repos/{owner}/{NAME}', allow_missing=True)
    created = repository is None
    if created:
        repository = request('/user/repos', {'name':NAME, 'private':True, 'auto_init':False,
                             'description':'Third-order hydraulic servo control research and theory review'})
    if repository.get('private') is not True:
        raise RuntimeError('The target repository is public; origin was not configured.')
    url = f'https://github.com/{owner}/{NAME}.git'
    previous = git('remote', 'get-url', 'origin')
    if previous.returncode == 0:
        if previous.stdout.strip() != url:
            raise RuntimeError('A different origin already exists; it was preserved.')
    else:
        added = git('remote', 'add', 'origin', url)
        if added.returncode:
            raise RuntimeError('Private repository is ready, but local origin configuration failed.')
    print(json.dumps({'owner':owner, 'repository':repository['full_name'],
                      'url':repository['html_url'], 'private':True, 'created':created,
                      'origin':url}, ensure_ascii=True))


if __name__ == '__main__':
    try:
        main()
    except Exception as error:
        print(json.dumps({'error':str(error)}, ensure_ascii=True))
        raise SystemExit(1)
