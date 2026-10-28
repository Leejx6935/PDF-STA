# Pipeline Check — Research MCP Status

Date: 2026-10-27
Task: T000_bridge_check

## Tool statuses actually returned

`research_status` returned successfully (exit_code 0) with both service blocks:

### Zotero — available
- API running: `true`, API status: `200`, API error: `null`
- Base URL: `http://127.0.0.1:23119`
- Zotero version: `10.0.6`, API version: `3`, schema version: `44`
- Connector running: `true`, connector status: `200`
- Local API enabled pref: `true`
- Profile: `C:\Users\leejx\AppData\Roaming\Zotero\Zotero\Profiles\xibgjf0h.default`

### MinerU — available
- MinerU version: `4.0.2`
- Python version: `3.12.14`

## Verdict

Both Zotero and MinerU are available and reporting normally. `research_write_report` also executed successfully, so the research MCP bridge is fully operational.

## Task paths

- Task output directory: `C:\Users\leejx\Desktop\三阶系统PDF-STA\.research_workspace\tasks\T000_bridge_check\output`
- Source directory: `C:\Users\leejx\Desktop\三阶系统PDF-STA\.research_workspace\sources`
