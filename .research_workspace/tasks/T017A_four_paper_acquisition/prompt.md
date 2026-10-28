# T017A：四篇指定论文全文定位与获取

日期：2026-10-27 Asia/Shanghai。你是研究执行者。本任务只获取和核验全文来源，不撰写阅读结论、不设计控制器。

## 指定四篇（不得替换）

- L03: Disturbance observer-based nonlinear feedback control for position tracking of electro-hydraulic systems in a finite time. European Journal of Control 2022. DOI 10.1016/j.ejcon.2022.100659. Publisher https://www.sciencedirect.com/science/article/pii/S0947358022000528
- L07: Finite-time command filtered electro-hydraulic system position control with dead zone. Applied Mathematical Modelling 2024. DOI 10.1016/j.apm.2024.03.026. Publisher https://www.sciencedirect.com/science/article/pii/S0307904X24001434
- L13: Command filter and neural network-based fixed-time backstepping control of electro-hydraulic system with uncertainties. Applied Mathematical Modelling 2026. DOI 10.1016/j.apm.2026.116848. Publisher https://www.sciencedirect.com/science/article/pii/S0307904X26001095
- L09: A reinforcement learning-based optimized backstepping control approach for uncertain electro-hydraulic systems. Mechanical Systems and Signal Processing 2025. DOI 10.1016/j.ymssp.2025.112928. Publisher https://www.sciencedirect.com/science/article/pii/S0888327025006296

## 工具与限制

1. 先用research status检查Zotero/MinerU；Zotero相关遵循 C:\Users\leejx\.codex\plugins\cache\openai-curated-remote\zotero\0.1.2\skills\zotero\SKILL.md；文档遵循 C:\Users\leejx\.agents\skills\mineru\SKILL.md。技能按需读，不展开安装流程。
2. 先本地Zotero搜索上述DOI，必要时使用短题名补查，resolve_sources读取实际附件路径。优先复用，不向Zotero新增或修改记录。可以读取已有 .research_workspace\sources\zotero_finite_time_catalogue_2026-10-27.json 的元数据，但它不是全文。
3. 完成本地定位后，立即写第一版acquisition_manifest.json，保证任务中断仍留下真实检查结果。
4. 缺失全文再用WebSearch/WebFetch或Crossref寻找出版社公开稿、作者机构仓储／预印本。不要使用未经授权的影子库。最多进行8次候选PDF下载尝试，避免反复请求被拒页面。
5. 下载通过research download_pdf，使用L03_2022_EJC.pdf等清楚文件名；工具核验PDF头，但PDF内容身份仍需后续核验。链接元数据、摘要网页和PDF三者分开记录，不把网页当全文。
6. 如果命中本地附件或成功下载，可用find_document检查缓存并保留文档ID；本任务不启动长时间全文解析。不修改MinerU配置、质量、服务或启用远程。
7. 用户已表示需要登录时由用户输入。你不能接管或假定已拥有其浏览器登录状态，不索取账户密码。需登录的条目保存准确的出版社页面及下一步操作说明，由审核者向用户汇总。不要因为某一篇受限就停止另外三篇定位。
8. 只向本任务output写报告；来源PDF由research工具保存到sources。不要覆盖最终输出或已有论文。不要绕过工具写权限。

## 输出

acquisition_manifest.json：4条记录，每条包含id/title/doi/issue_year/publisher_url、Zotero搜索词与结果item key、local_pdf_path（没有则null）、来源版本、PDF身份核验状态、下载尝试及错误、MinerU缓存状态（若查）、全文状态、reading_status（统一not_read_in_this_task）、需要用户操作的准确说明。路径和错误依据真实工具结果。

acquisition_report.md：一页内，逐篇说明现有全文／成功下载／待登录／未定位等实际状态，保留来源和下一步。不要给出假定的全文内容结论。

完成后立即结束。本任务的通过仅表示来源定位合格，不表示全文已读或证明成立。
