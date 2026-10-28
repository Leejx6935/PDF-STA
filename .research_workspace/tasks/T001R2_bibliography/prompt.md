只执行一个引用导出短任务，不做检索、阅读或理论分析，不启动子代理。之前Zotero帮助程序的Windows stdout编码问题已由审核者在工具桥接中修正为UTF-8。

1. 调用research status。
2. 调用research zotero，operation=export-bibtex，value=JGP9TGM4,2AHU9T9F,FD2CBB3F,ASUHEN6J,5R6KWQGW,HLZCX7PE,473MM72M,ZLY8AKG6。
3. 成功后把真实导出的全部BibTeX字符串原样交write_report写入references_seed.bib。不要改citation key，不要自行增加记录。
4. 写bibliography_manifest.json，记录真实条目数、citation key、DOI、请求的8个Zotero key，状态pending_review。失败时如实记录，不用占位注释伪装成成功的.bib。

完成后结束。最多约4次工具调用。任务日期2026-10-27。
