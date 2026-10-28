执行三篇STA文献的全文条件与Future Work核查。不启动子代理，不做网络检索，不生成新算法。日期2026-10-27。

真实附件路径：
A. Zotero JPJUFKHN，DOI10.1109/TAC.2011.2179878：C:\Users\leejx\Zotero\storage\ASXD8F6H\Gonzalez 等 - 2012 - Variable Gain Super-Twisting Sliding Mode Control.pdf
B. Zotero Y5GKV8EY，DOI10.1109/TAC.2012.2186179：C:\Users\leejx\Zotero\storage\XDLZQ7EJ\Moreno和Osorio - 2012 - Strict Lyapunov Functions for the Super-Twisting Algorithm.pdf
C. Zotero JHU5WMJN，DOI10.1109/TIE.2025.3613654：C:\Users\leejx\Zotero\storage\YGZ52Z2K\Wang 等 - 2026 - A Modified Super-Twisting Sliding Mode Control for Aircraft Braking System With Adaptive Gain Schedu.pdf

先research status。每篇可先find_document查缓存；无可用正常质量缓存时调用parse_pdf保存为Gonzalez2012_STA.md、Moreno2012_STA.md、Wang2026_braking_STA.md。仅正常本地解析，不使用flash、不远程上传、不重启或改配置。如果超时，只检查parse_status并用已完成locator续读；最后仍不能读到则准确标未读，不编造。

解析输出的Markdown可能直接覆盖全篇，也可能有截断。用Read读取文件全文并核对页标记；若工具返回不完整范围，按next_request/read_document补齐。避免无意义重复读取。

每篇不超过1000字，合写STA_three_paper_cards.md，包含：
1. 实际读到的页范围、原文Future Work是否明确写出（没有就写未列）；
2. 误差何者有限时间到零、何者只进邻域，收敛时间依赖何量；
3. 扰动、导数、输入增益、初值、理想量测等关键条件；
4. 对三阶液压可借用的结果、仍需另证的部分；
5. 候选改进只作为待证问题，严禁“换成自适应增益/加滤波/移植液压就是创新”。

尤其核查Wang2026将sign积分替换连续分数幂项后，是否只保证滑模变量在有限时间进入指定精度，是否真的含物理参数辨识或只是gain schedule。基础两篇要区分已知随状态变化的界与完全未知扰动界，不要把“变增益”误称已经学习真实参数。

写reading_scope.json，记录3篇来源、Markdown路径、doc locator、实际覆盖页、证据定位、无法核实的公式。用write_report提交两份文件。所有结论待审核。不要因PDF解析等待而重复查询超过两次。
