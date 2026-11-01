# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

A supervised research workspace for an English SCI paper on third-order hydraulic servo control. Target: CAS Q2 journal; prescribed-time convergence is the preferred line, finite-time is the fallback. It is not a conventional software project: the artifacts are literature cards, proof audits, task prompts, run logs, and MATLAB/Simulink files.

The workflow is a two-role loop, and the distinction is load-bearing:

- **Supervisor** (the human plus the interactive session) defines a bounded task, audits the result, and is the only role allowed to publish into `最终输出/`.
- **Executor** (a headless Claude Code process launched by `config/run_claude_task.py`) works only inside one task directory and writes only its `output/`.

A successful run, a parsed PDF, a read paper, and an approved theory are four different states. `status.json` records execution state; scientific approval lives in `reviews/` and `最终输出/`, never in `status.json`.

## Layout and ownership

| Path | Contents | Who writes |
|---|---|---|
| `最终输出/` | Reviewed, publishable deliverables and release manifests | Supervisor only |
| `.research_workspace/tasks/<ID>/` | `prompt.md`, `required_outputs.json`, `output/`, `status.json` | Prompt: supervisor. Output: that task's executor |
| `.research_workspace/reviews/` | Audit opinions, corrections, provenance checks | Supervisor |
| `.research_workspace/runs/<TASK>_<stamp>/` | `mcp.json`, `prompt.md`, `stdout.json`, `stderr.log`, `worker_result.md` | Launcher |
| `.research_workspace/config/` | Launcher, MCP bridge, acquisition helpers | Maintained as tooling |
| `.research_workspace/inputs/`, `sources/` | Local PDFs, MinerU parses, provenance snapshots | Tools; gitignored |
| `仿真文件/` | MATLAB/Simulink controller and plant (`para.m`, `plant.m`, `ctrl.m`, `obs.m`, `check.m`, `Simulink.slx`, wiring docs) | Only through an approved simulation task |
| `literature_review/`, `publication_plan/`, `blobs/` | Earlier local review material and archives | Preserve in place |

Never overwrite original PDFs, existing drafts, or `仿真文件/`. Revisions go into a new task directory or a new versioned file. Do not edit another task's `output/`.

## Task lifecycle (the architecture that spans files)

1. Supervisor writes `tasks/<ID>/prompt.md` and `required_outputs.json`.
2. Supervisor runs the launcher (see Commands). It takes `runs/.worker.lock` (single worker), creates a timestamped run directory, and invokes the VS Code–bundled `claude.exe` with:
   - `--strict-mcp-config --mcp-config <run>/mcp.json` (only the `research` bridge),
   - `--tools Read,WebSearch,WebFetch,mcp__research` and `--permission-mode dontAsk`,
   - `--no-session-persistence --output-format json -p`, with `cwd` set to the task directory.
   The executor has no Bash, Write, or Edit; all deliverables go through the bridge's `write_report`.
3. The executor reads `prompt.md` (and the review file it points to), does the work, and saves outputs as plain filenames in `output/`.
4. The launcher writes `status.json` (`running` → `timed_out` / `failed` / `pending_review`), then downgrades to `incomplete` and lists `missing_outputs` if any declared output is absent. It always sets `approved: false`.
5. Supervisor audits into `reviews/`, may issue a revision task, and only then publishes to `最终输出/` with a manifest recording name, path, bytes, and sha256.

Status values in use: `prepared_not_started`, `running`, `pending_review`, `incomplete`, `failed`, `timed_out`, plus supervisor states such as `reviewed_waiting_fulltext`. Do not treat `pending_review` as accepted.

`runs/` is gitignored. If a run is interrupted, `runs/.worker.lock` may remain; remove it only after confirming no worker process is alive.

## The research MCP bridge

`config/research_bridge.py` is a stdio MCP server instantiated per task with `RESEARCH_TASK_DIR`. It is the executor's entire capability surface:

- `status`, `zotero` (read/search/children/file-url/export-bibtex), `zotero_catalogue`, `resolve_sources`, `export_references`
- `find_document`, `parse_pdf`, `read_document`, `parse_status` (local MinerU only; no remote/flash switching)
- `search_papers` (Crossref metadata only — not evidence of reading)
- `download_pdf` (public HTTP(S) only, 40 MB cap, `%PDF-` header check, sha256)
- `edge_browser` (existing Edge window via UI Automation; `Inspect`/`Navigate`/`Invoke`/`Save`; publisher allowlist: ScienceDirect, IEEE Xplore, cris.unibo.it)
- `write_report` (`.md`, `.json`, `.csv`, `.bib`, `.txt`, into this task's `output/` only)

Invariants: Zotero is read-only; no shell; no cookie/credential access; read roots are the repo root, `~/Desktop/基于PDF框架的自适应STA滑模控制`, and `~/Zotero/storage`; writes are confined to the task output, `sources/pdfs`, `sources/parsed`, and `inputs/four_papers`. Filenames must be plain (no directories, no `:`), item keys are 8-character Zotero keys, and `save_pdf` refuses to overwrite an existing input.

## Commands

Run from `.research_workspace` (or anywhere; paths derive from the script location):

```bash
# Launch one bounded executor task (defaults: --timeout 600 --max-turns 18)
python config/run_claude_task.py T017B_L13_fulltext
python config/run_claude_task.py T017B_L13_fulltext --timeout 1200 --max-turns 24

# Regenerate the four T017B reading prompts from Zotero (needs local Zotero API;
# overwrites prompt.md/required_outputs.json for L03/L07/L13/L09 — do not rerun mid-task)
python config/prepare_four_paper_reading.py

# Create the private GitHub repo if absent and configure origin (never commits/pushes)
python config/connect_github.py

# Edge UI Automation, normally reached through the bridge's edge_browser tool
powershell -NoProfile -ExecutionPolicy Bypass -File config/edge_session_ui.ps1 \
  -Action Inspect -EvidenceName my_probe
```

There is no build, lint, or test suite. Verification is: all `required_outputs.json` files present, supervisor audit, and for simulation work `check.m` run in MATLAB (pure MATLAB + `ode45`, independent of Simulink). `仿真文件/check.m` is the self-check entry point; do not use a Simulink run as proof of a theorem.

## Environment dependencies and fragile points

- Windows only, with Chinese path segments.
- The launcher hardcodes the extension binary path `~/.vscode/extensions/anthropic.claude-code-2.1.301-win32-x64/resources/native-binary/claude.exe`. Updating the VS Code extension breaks it; update the path in `config/run_claude_task.py` after inspecting the installed version.
- Zotero must be running for `prepare_four_paper_reading.py`, `zotero_catalogue`, `resolve_sources`, and BibTeX export (local API at `http://127.0.0.1:23119`). The Zotero CLI helper is at `~/.codex/plugins/cache/openai-curated-remote/zotero/0.1.2/skills/zotero/scripts/zotero.py`.
- MinerU is expected at `~/.local/bin/mineru.exe`. It is not always running; call `find_document` before `parse_pdf`, and use `parse_status` after a timeout rather than assuming failure.
- `edge_browser` requires an already-open Edge window and flashes the UI; a human completes any login/verification.
- The underlying engine uses the user's configured model, reported as `DeepSeek-V4-Flash[1m]`. "Claude Code" is the client name; do not describe the model as an Anthropic model.
- Git excludes PDFs, `*_Parsed.md`, `inputs/`, `sources/`, `runs/`, caches, logs, and `最终输出/*AI可读正文.md`. Their absence from Git is expected.

## Scientific rules that bind every task

These come from the supervisor's audit records and apply even when a prompt is terse. Read the task's cited review before working.

- Fixed measurement contract: position and both chamber pressures are measured; velocity is estimated. Do not silently change sensing, add input saturation as a main contribution, or add modules (neural/fuzzy, fault, event-trigger, unknown direction) without explicit approval. Each added assumption needs a stated necessity.
- Separate four registers in every report: the paper's own claim, your independent recomputation, numerical observation, and unproven conjecture. Cite DOI, page, equation/theorem number. Never invent papers, DOIs, formulas, citations, or simulation output.
- Abstract-level evidence is not full-text evidence. A "full paper read" claim requires recorded page coverage and stable MinerU locators, including `next_request` continuation. Incomplete coverage must be stated.
- Do not conflate finite-time, fixed-time, predefined-time, and prescribed-time, and do not translate "fixed-time" as "prescribed time". For any claim that T is presettable, state whether T is chosen a priori, whether the bound depends on initial conditions or unknown constants, whether gains are singular near T, and what holds after T.
- Keep error objects distinct: observer error, filter/compensation error, sliding variable, true position error, parameter error, weight error. Parameter or weight boundedness is not tracking convergence.
- Keep a state ledger. Algebraic quantities (e.g. `|s|^{1/2} sgn s`) are not dynamic states; plant states, controller states, and algebraic coordinates are counted separately.
- Do not assert impossibility results without proof and explicit assumptions. The T016 P0 counterexample (constant matched disturbance with bounded control still reaches zero in finite time) invalidates the blanket claim that "nonzero disturbance + bounded input precludes exact finite-time tracking".
- Distinguish exact finite time from practical finite time / UUB, and theorem conditions from simulation settings. Noise studied only in simulation is not a noise theorem.
- Never use "by a similar argument" for a load-bearing step. Preserve cross terms, unknown input-gain terms, filter errors, observer errors, and delayed history explicitly.
- Simulations validate only theory that has passed review, under identical plant, initial conditions, reference, sampling, and input limits. Real algorithm timing must be measured, never estimated; solver cost is not controller cost.

## Output conventions

- Task reports, reviews, and plans are in Chinese; the paper and citation metadata are in English.
- Paper-reading tasks deliver exactly `paper_card.md`, `proof_reconstruction.md`, `coverage_and_provenance.json` unless the prompt says otherwise.
- `required_outputs.json` must contain plain filenames only; the launcher rejects nested paths and marks the task `incomplete`.
- `最终输出/` filenames are numbered and dated (e.g. `13_下一阶段执行计划与选题门槛_2026-10-28.md`); manifests live in `releases/<date>_<topic>/manifest.json`.
- For MATLAB work, follow the user's global MATLAB/Simulink contract (Level-2 M-file S-functions, `Update` for discrete control, `Derivatives` for the plant, `ode4`, parameters in `para.m`, local helper functions, Chinese comments with equation numbers, an implementation cross-reference table).

## Where to start reading

1. `最终输出/13_下一阶段执行计划与选题门槛_2026-10-28.md` — current priorities and admission gates (newer than the older numbered plans).
2. `最终输出/02_执行AI任务书与审核模板.md` — task A–F prompts, the review form, and the audit verdict table.
3. `.research_workspace/tasks/<ID>/prompt.md` and its cited review — the binding scope for that task.
4. `.research_workspace/README.md` and `README.md` — division of labor and file rules.
5. `tasks/T017B_fulltext_reading_template.md` — required reading analysis for paper tasks.

Latest snapshot (2026-10-28): L03 produced reports pending review; L07, L13, L09 are `prepared_not_started`; the recommended next reading order is L03 补核 → L13 → L07 → L09; MinerU was reported not running and needs verification. Always re-read `status.json` and file 13 rather than trusting this snapshot.
