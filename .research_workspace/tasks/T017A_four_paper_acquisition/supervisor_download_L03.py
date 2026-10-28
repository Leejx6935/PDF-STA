"""Acquire the publicly available accepted manuscript from its university repository."""
import hashlib
import json
from pathlib import Path
import urllib.request

root = Path(__file__).resolve().parents[3]
url = "https://cris.unibo.it/retrieve/handle/11585/904197/e9a6c4a3-0ec1-4783-970b-55a9b51c89c6/%2803-12-2021%29%20FT-DOTC%20for%20EHAs%20%28RPN%29.pdf"
target = root / ".research_workspace/sources/pdfs/L03_2022_EJC.pdf"
target.parent.mkdir(parents=True, exist_ok=True)
request = urllib.request.Request(url, headers={"User-Agent": "HydraulicResearchLiterature/0.1"})
with urllib.request.urlopen(request, timeout=40) as response:
    payload = response.read(40_000_001)
if len(payload) > 40_000_000 or not payload.lstrip().startswith(b"%PDF-"):
    raise ValueError("Response is not a supported PDF download")
if target.exists() and target.read_bytes() != payload:
    raise ValueError("Existing source differs; preserve it for version review")
target.write_bytes(payload)
record = {
    "id": "L03", "doi": "10.1016/j.ejcon.2022.100659",
    "source": url, "repository_record": "https://cris.unibo.it/handle/11585/904197",
    "version_claimed_by_repository": "Author accepted manuscript",
    "path": str(target), "bytes": len(payload),
    "sha256": hashlib.sha256(payload).hexdigest(),
    "pdf_header_verified": True, "content_identity": "pending_mineru_read",
}
output = Path(__file__).resolve().parent / "supervisor_L03_source.json"
output.write_text(json.dumps(record, ensure_ascii=False, indent=2), encoding="utf-8")
print(json.dumps(record, ensure_ascii=False))
