"""Run the four explicitly requested reading jobs once, serially and bounded."""
from pathlib import Path
import json
import subprocess
import sys
from datetime import datetime

WORK=Path(__file__).resolve().parents[1]
TASKS=['T021_L03_explained','T021_L13_explained','T021_L07_explained','T021_L09_explained']
state={'started':datetime.now().isoformat(),'status':'running','scientific_approval':False,'tasks':{}}
path=WORK/'tasks/T021_four_readings_batch.json'
def save():
    path.write_text(json.dumps(state,ensure_ascii=False,indent=2),encoding='utf-8')
save()
for task in TASKS:
    state['current_task']=task
    save()
    result=subprocess.run([sys.executable,str(WORK/'config/run_claude_task.py'),task,
                           '--timeout','600','--max-turns','32'],cwd=WORK.parent)
    task_state=WORK/'tasks'/task/'status.json'
    state['tasks'][task]={'launcher_returncode':result.returncode,
                         'execution_state':json.loads(task_state.read_text(encoding='utf-8')) if task_state.exists() else None}
    save()
state.update({'status':'finished_awaiting_supervisor_review','finished':datetime.now().isoformat(),'current_task':None})
save()
