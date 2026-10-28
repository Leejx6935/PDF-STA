你执行两篇真实液压论文的全文条件与Future Work提取，不启动子代理，不做网络检索，不生成新算法。日期2026-10-27。

已有MinerU全文解析，直接用Read读取，不重新解析：
1. C:\Users\leejx\Desktop\三阶系统PDF-STA\Chen2025_PFTO_ABSTC_DeepSea_Hydraulic_Manipulator_Parsed.md
2. C:\Users\leejx\Desktop\三阶系统PDF-STA\Yang2021_Output_Feedback_Adaptive_STA_Hydraulic_Parsed.md

这两篇对应Zotero FS9EHUTH（DOI10.1109/TIE.2025.3541284）和BLFGZ6V4（DOI10.1016/j.isatra.2020.09.014），本轮附件已经核实存在；不要使用上个任务附件读取失败的旧判断。

任务步骤：
1. 调用research status，读取上述两份完整Markdown，遇到Read截断按offset续读。
2. 用research read_document核对关键原文定位：Chen缓存doc:5b4728a/tier:advanced/page:4与page:8；Yang缓存doc:2f58eff/tier:standard/page:9，context=2。若定位缺失就写待核查，不伪造页码。
3. 每篇写一份不超过1800字方法卡：作者明确Future Work（中文转述、页码/章节）；观测误差/滑模变量/实际位置误差三层收敛性质；主要假设与具体用在哪个证明；可改进点及其数学障碍；哪些不能直接当新贡献。
4. 写evidence_scope.json，记录来源、阅读范围、定位、待核查公式。

必须特别检查：
- Chen的“实用有限时间观测”与最终跟踪是否仅渐近；式(16)的滤波观测结构能否在常值非零扰动下同时保持状态误差和扰动误差恒为零；只做代入检验，不把查出疑点写成全篇无效。
- Chen Theorem 1对集总残差及导数有界的条件，是否能由原始外扰/参数箱自动推出；dot(tildeTheta*phi+f)有哪些项。
- Chen Remark 2直接取max(t_LD,t_PFTO)是否有级联初始误差/速度估计耦合的额外条件。
- Yang的adaptive究竟调整STA增益还是物理参数；明确Future Work的系统参数适应与Chen2025已做的投影更新之间存在重叠，不能声称无人做过。

严禁：把PE当有限时间辨识保证；把估计收敛当精确跟踪必要条件；把dotV<=-aV^p+b且b>0解释为精确到零；把有限时间到滑模面等同位置有限时间归零。

用write_report写Chen2025_card.md、Yang2021_card.md、evidence_scope.json。全部候选改进标待审核；完成后停止。总调用控制在约12次以内。
