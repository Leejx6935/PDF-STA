"""Launch the installed VS Code Claude engine and retain an auditable task run."""
from pathlib import Path
import argparse
from datetime import datetime
import hashlib
import json
import os
import subprocess
import sys

WORK = Path(__file__).resolve().parents[1]
ROOT = WORK.parent


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('task_id')
    parser.add_argument('--timeout', type=int, default=600)
    parser.add_argument('--max-turns', type=int, default=18)
    args = parser.parse_args()
    if Path(args.task_id).name != args.task_id or '/' in args.task_id or '\\' in args.task_id:
        raise ValueError('Use a plain task identifier')
    task = WORK / 'tasks' / args.task_id
    prompt_path = task / 'prompt.md'
    prompt = prompt_path.read_text(encoding='utf-8')
    cli = Path.home() / '.vscode/extensions/anthropic.claude-code-2.1.301-win32-x64/resources/native-binary/claude.exe'
    if not cli.is_file():
        raise FileNotFoundError('The recorded VS Code Claude engine is missing; update the project launcher after inspecting the installed version.')
    stamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    run_dir = WORK / 'runs' / (args.task_id + '_' + stamp)
    run_dir.mkdir(parents=True, exist_ok=False)
    lock = WORK / 'runs' / '.worker.lock'
    fd = os.open(lock, os.O_CREAT | os.O_EXCL | os.O_WRONLY)
    os.write(fd, str(os.getpid()).encode())
    os.close(fd)
    config = {'mcpServers': {'research': {'command': sys.executable,
              'args': [str(WORK / 'config/research_bridge.py')],
              'env': {'RESEARCH_TASK_DIR': str(task)}}}}
    config_path = run_dir / 'mcp.json'
    config_path.write_text(json.dumps(config, ensure_ascii=False, indent=2), encoding='utf-8')
    (run_dir / 'prompt.md').write_text(prompt, encoding='utf-8')
    state = {'task_id': args.task_id, 'status': 'running', 'run_directory': str(run_dir),
             'engine': str(cli), 'prompt_sha256': hashlib.sha256(prompt.encode()).hexdigest(),
             'started_at_host_time': stamp, 'date_context': '2026-10-27 Asia/Shanghai',
             'approved': False}
    state_path = task / 'status.json'
    def save():
        state_path.write_text(json.dumps(state, ensure_ascii=False, indent=2), encoding='utf-8')
    save()
    command = [str(cli), '--setting-sources', 'user', '--disable-slash-commands',
               '--settings', json.dumps({'disableAllHooks': True}),
               '--strict-mcp-config', '--mcp-config', str(config_path),
               '--permission-mode', 'dontAsk', '--tools', 'Read,WebSearch,WebFetch',
               '--allowedTools', 'Read', 'WebSearch', 'WebFetch', 'mcp__research',
               '--no-session-persistence', '--output-format', 'json', '--max-turns', str(args.max_turns), '-p']
    try:
        print('Task started:', args.task_id, flush=True)
        with (run_dir / 'stdout.json').open('w', encoding='utf-8') as out, (run_dir / 'stderr.log').open('w', encoding='utf-8') as err:
            process = subprocess.Popen(command, stdin=subprocess.PIPE, stdout=out, stderr=err,
                                       cwd=task, text=True, encoding='utf-8', errors='replace')
            try:
                process.communicate(prompt, timeout=args.timeout)
            except subprocess.TimeoutExpired:
                # Only terminate this worker's process tree; other Claude/VS Code sessions are untouched.
                subprocess.run(['taskkill', '/PID', str(process.pid), '/T', '/F'], capture_output=True)
                process.wait(timeout=15)
                state['status'] = 'timed_out'
        state['exit_code'] = process.returncode
        text = (run_dir / 'stdout.json').read_text(encoding='utf-8')
        try:
            result = json.loads(text)
        except ValueError:
            result = {'is_error': True, 'result': text[:2000]}
        state.update({k: result.get(k) for k in ['subtype', 'is_error', 'total_cost_usd', 'num_turns', 'permission_denials']})
        state['reported_model_identifiers'] = list(result.get('modelUsage', {}).keys())
        (run_dir / 'worker_result.md').write_text(result.get('result', ''), encoding='utf-8')
        if state['status'] != 'timed_out':
            state['status'] = 'pending_review' if process.returncode == 0 and not result.get('is_error') else 'failed'
        required_path = task / 'required_outputs.json'
        if state['status'] == 'pending_review' and required_path.exists():
            required = json.loads(required_path.read_text(encoding='utf-8'))
            missing = [name for name in required if Path(name).name != name or not (task/'output'/name).is_file()]
            if missing:
                state['status'] = 'incomplete'
                state['missing_outputs'] = missing
        print(json.dumps(state, ensure_ascii=False), flush=True)
    finally:
        save()
        lock.unlink(missing_ok=True)


if __name__ == '__main__':
    sys.stdout.reconfigure(encoding='utf-8')
    main()
