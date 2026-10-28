你是液压伺服控制研究项目的文献执行者。本轮只做一批真实文献工作，不能生成新控制器、声称创新已成立，不能启动子代理。日期为2026-10-27，时区Asia/Shanghai。

通过 research MCP 工具完成检索、Zotero读取、PDF解析和报告保存。工具可以读取本地Zotero、调用本地MinerU、查Crossref、下载开放PDF、写本任务报告。不修改Zotero资料库、原始论文、其他草稿或最终输出目录。不读取账户配置/凭据，不使用其他项目材料覆盖本轮任务。若受限就报告事实，不切换解析器、远程上传或修改服务器设置。

实际模型沿用研究者现有Claude Code配置，本任务不调整模型。

任务1：先调用research status核实工具。然后在Zotero搜索题名“Prescribed-Time Control via Periodic Delayed Feedback”，记录真实条目key、DOI和附件是否存在。

任务2：阅读Ding、Zhou、Shi的TAC2026论文，DOI 10.1109/TAC.2025.3618707。原始PDF已在：
C:\Users\leejx\Desktop\基于PDF框架的自适应STA滑模控制\Prescribed-Time_Control_via_Periodic_Delayed_Feedback-Based_Super-Twisting_Sliding_Mode_Algorithm.pdf

用research parse_pdf处理本地PDF，保存名Ding2026_local_parse.md。已有MinerU缓存为doc:4871ce7/tier:standard，共16页；若解析返回缓存，直接使用，不重复计算。根节点的前10页不等于全篇。

至少使用read_document连续覆盖1—16页。例如page:4 context:3覆盖1—7，page:12 context:4覆盖8—16；若limit导致截断，按next_request补齐。每次查看返回的content_ranges，保留真实页范围。关键难读公式记为待原图核查，不自行修复后当作原文。

写01_Ding2026_method_card.md，约1500—2500字，包含：
- 原始文献信息、可定位页码、模型与已知输入增益条件；
- 两类STA的区别、扰动幅值/导数界、主要时间结论；
- 特别核对Lemma 5已有的受扰动PDF误差界，避免把它重报为创新；
- 非匹配扰动、观测、控制和总时间的关系；
- 作者明确写出的Future Work（未写则如实说明），与执行者根据假设提出的问题分列。
只输出分析和必要短公式，不复制整篇原文。

任务3：检索近邻“Practical Prescribed-Time Control for Active Suspension Systems via Periodic Delayed Sliding Mode Control”，DOI 10.1002/rnc.70302。可先用WebSearch/WebFetch，也可用research search_papers核对元数据。检查Zotero已有条目；尝试合法开放全文。若遇到付费墙、浏览器登录或验证，停止该获取路径，写入04_access_queue.md：DOI、准确网址、已试路径、需要何种访问，不声称读过全文。可下载到的PDF交给research parse_pdf，本轮不强求通读第二篇。

任务4：写02_Future_Work_candidates.md，列最多3个候选问题。每项必须写证据页码、属于作者建议还是你的推论、后续查重状态、可能的数学命题和最容易失败的假设。特别比较“未知输入增益的参数自适应与PDF耦合”和“指令滤波/非光滑观测补偿的可实现性”。不把未证猜想写成创新结论。

任务5：从Zotero导出初始参考文献，使用research zotero export-bibtex，传明确的逗号分隔item keys。已知分类内7篇key：JGP9TGM4,2AHU9T9F,FD2CBB3F,ASUHEN6J,5R6KWQGW,HLZCX7PE,473MM72M。若任务1找到Ding条目，把其真实key加入。保持Zotero导出的citation key，写05_references_seed.bib，不自行补造记录。

最后写03_source_manifest.json：每篇DOI、Zotero key、原文件路径、解析文件路径、MinerU locator、已读取页码、全文/摘要/元数据阅读等级、访问受限情况、BibTeX导出的条目数。不要加入凭据。

所有5个交付物都必须经research write_report写进本任务output目录。最终回复简明说明完成项、未完成项、实际路径；全部状态为待审核。不能因为输出了文件就称理论或桥接已全面验证。
