# Zotero 有限时间收敛研究：元数据筛选清单

- 任务：T010_finite_time_inventory
- 日期：2026-10-27
- 数据源：本机 Zotero 10.0.6 本地 API（只读）
- 快照：`.research_workspace/sources/zotero_finite_time_catalogue_2026-10-27.json`
- 范围声明：**仅元数据筛选**。依据题名、摘要、标签与馆藏集合判断；未下载、未解析、未阅读任何 PDF 全文，不声称全文结论。未做网络检索，未启动子代理，未提出新理论。

## 1. 真实检索计数

| 指标 | 数值 | 说明 |
|---|---:|---|
| 顶层资料总数 | 36 | 工具 `library_top_item_count`，含论文与可能的技术报告/笔记 |
| 关键词匹配记录数 | 20 | `matched_count`，匹配字段为 title / abstract / tags |
| 去重后独立工作数 | 18 | 检出 2 组重复记录（见 §5） |
| 本清单候选数 | 15 | 上限 15，按相关性排序 |
| 优先全文阅读数 | 8 | 见 `02_priority_queue.json` |
| 成功解析 PDF 路径数 | 0 / 8 | 附件解析服务连续两次返回空响应，详见 §6 |

匹配词口径：finite-time、fixed-time、predefined-time、prescribed-time、appointed-time、super-twisting / STA、finite-time observer、command filter。该口径会同时命中“有限时间”“预设/预定义时间”“实用有限时间/有界”等不同概念，**不能据此等同为同一种收敛结论**。

## 2. 相关性排序（最多 15 篇）

排序优先考虑：三阶电液/液压伺服对象 > 未知/时变参数 > 机械/压力扰动与观测器 > 有限时间观测或滤波 > 延迟反馈/STA 理论基座。未单按期刊或年份排序。

| # | 题名 | 年 | DOI | Zotero key | 初筛类别 | 优先理由（含收敛层次） |
|---:|---|---|---|---|---|---|
| 1 | Practical Finite-Time Observer-Based Adaptive Backstepping Super-Twisting Sliding Mode Control for Deep-Sea Hydraulic Manipulator | 2025 | 10.1109/TIE.2025.3541284 | FS9EHUTH | finite-time + STA + hydraulic | 与本任务最贴合：液压机械臂、投影型自适应处理参数不确定、Levant 微分器、**实用有限时间观测器**估计集总扰动、反步 STA 无抖振。摘要明确“practical finite-time observer”，但位置跟踪是否严格有限时间仍需全文核实。 |
| 2 | Prescribed-Time Control via Periodic Delayed Feedback-Based Super-Twisting Sliding Mode Algorithm | 2026 | 10.1109/TAC.2025.3618707 | ZLY8AKG6 | prescribed-time + STA + observer | 直接覆盖“延迟核 + STA + 观测器”：周期延迟反馈 STA、扰动观测器、输出反馈状态观测器；声称输出在匹配/不匹配扰动下于**恰好预设时刻**收敛。是核对 `K(t)s(t-h)`、时变核与时滞观测器实现的关键文献；观测器自身收敛性质需全文确认。 |
| 3 | Output feedback adaptive super-twisting sliding mode control of hydraulic systems with disturbance compensation | 2021 | 10.1016/j.isatra.2020.09.014 | BLFGZ6V4 | STA + hydraulic；asymptotic/UB | 液压系统输出反馈 + ESO + 自适应 STA 的基线文献。关键反例价值：摘要只承诺**常值扰动下渐近稳定、时变扰动下最终有界**，并未承诺跟踪有限时间。可用来区分“滑模变量 STA 有限时间”与“实际跟踪仅渐近/有界”。 |
| 4 | Adaptive Prescribed-Time Tracking Control for Output-Constrained Hydraulic Servo Systems with Time-Varying Parameters | 2026 | 10.3390/sym18081397 | 473MM72M | prescribed-time + hydraulic | 液压伺服、时变参数、外扰、输出约束；动态面避免反步爆炸；**预设时间驱动的自适应更新与扰动估计律**分别构造。跟踪为进入预设小区域（实用预设时间），参数/扰动估计是否有限时间需全文核实。 |
| 5 | Adaptive Motion Control for Electro-hydraulic Servo Systems With Appointed-Time Performance | 2025 | 10.1109/TMECH.2024.3525013 | ASUHEN6J | appointed-time + hydraulic；asymptotic | 电液伺服、未知非定常线性化/非线性参数与扰动。标题易被误读为有限时间；摘要明确是“**asymptotic** adaptive appointed-time performance”：预设时间只约束误差进入指定边界，稳态仍为渐近。是概念分层的关键对照。 |
| 6 | Strong Prescribed-Time Stabilization of Uncertain Nonlinear Systems by Periodic Delayed Feedback | 2024 | 10.1109/TAC.2023.3347703 | AYKCDA4Q | prescribed-time + delayed feedback | 周期延迟反馈实现强预设时间稳定的理论基座；避免时变高增益奇异，控制项对当前/延迟状态线性增长，扰动下保持固定时间性质。为延迟反馈核的合法性提供依据，非液压对象。 |
| 7 | Prescribed time control based on the periodic delayed sliding mode surface without singularities | 2024 | 10.1007/s11432-023-4052-4 | MX4W2ZZU | prescribed-time + sliding surface | 周期延迟滑模面 + 无奇异预设时间控制，与“延迟滑模面”设计直接相关。**摘要为空**，仅题名可判，概念细节完全待全文核实；且解析器未列出 PDF 附件。 |
| 8 | Strict Lyapunov Functions for the Super-Twisting Algorithm | 2012 | 10.1109/TAC.2012.2186179 | Y5GKV8EY | STA foundation（finite-time） | STA 严格 Lyapunov 函数，给出有限时间收敛与**收敛时间估计**，并覆盖有扰动时的有限时间/最终有界性。是判断第 1–4 篇“有限时间”声称是否成立的必备理论尺子。 |
| 9 | Command-Filtered Adaptive Prescribed-Time Tracking Control with Application to Output-Constrained Hydraulic Servo Systems | 2026 | 10.3390/act15050238 | HLZCX7PE | prescribed-time + hydraulic + filtering | 液压伺服 + 命令滤波 + 预设时间；输出收敛到零附近的小**有界区间**，预设收敛时间可独立设定。适合回答“滤波器误差是否有限时间收敛”，但摘要只承诺有界区间。 |
| 10 | Prescribed-Time Tracking Control of Electro-Hydraulic Servo Systems with Non-Vanishing Uncertainties | 2024 | 10.1109/CCDC62350.2024.10587765 | 46DP86DN | prescribed-time + hydraulic | 电液伺服、匹配/不匹配非消失不确定性；声称跟踪误差**有限时间到零**且收敛时间可预设、与初值无关。会议论文，需核查证明强度；与 ZVJ9U5J2 为重复记录。 |
| 11 | Adaptive practical prescribed-time control for uncertain nonlinear systems with time-varying parameters | 2024 | 10.1016/j.chaos.2024.115677 | FD2CBB3F | practical prescribed-time | 时变参数 + 未建模动态；时变缩放函数与非线性映射，跟踪误差在预设时间内进入预设区域，信号半全局一致最终有界。属“实用预设时间”，非精确有限时间到零。 |
| 12 | Adaptive Prescribed-Time Control for a Class of Uncertain Nonlinear Systems | 2022 | 10.1109/TAC.2021.3130883 | 2AHU9T9F | prescribed-time theory | 预设时间稳定性定理 + 反步，连续时变反馈使全状态在预设时间内到零，时间与初值无关。为上层理论提供严格定义与证明模板，非液压。 |
| 13 | Variable Gain Super-Twisting Sliding Mode Control | 2012 | 10.1109/TAC.2011.2179878 | JPJUFKHN | STA foundation（finite-time） | 变增益 STA，匹配扰动为 Lipschitz 且有已知界时，保证全局**有限时间**到达滑模面。对应推导中的时变增益 `k(t)` 与 `K(t)` 设计。 |
| 14 | Prescribed-Time Control and Its Latest Developments | 2022 | 10.48550/arXiv.2210.12712 | LXD8I4BW | prescribed-time survey | 预设时间控制综述与分类（robust/adaptive、SISO/MIMO、单体/多智能体），用于校准术语与避免把 fixed/predefined/prescribed 混为一谈。非原始贡献。 |
| 15 | Adaptive Prescribed-Time Control of Electro-Hydraulic Servo with Output Constraints | 2026 | 10.1109/ISAES70982.2026.11669267 | CF8H6QQY | prescribed-time + hydraulic | 电液伺服、未知参数与外扰、输出约束；跟踪误差在预设时间内到**有界值**。**无附件子项（child_count=0）**，只能保留为元数据候选，无法进入全文队列。 |

### 未列入 15 条候选但仍在匹配集中的工作

| 题名 | 年 | DOI | key | 不列入理由 |
|---|---|---|---|---|
| Predefined-time stability of dynamical systems with sliding modes | 2015 | 10.1109/ACC.2015.7172255 | JGP9TGM4 | 预定义时间稳定性与一阶滑模的基础文献，相关但偏早期；若需严格定义可补读。 |
| Command filter-based adaptive predefined-time control for nonlinear multi-agent systems under unknown control directions and actuator attacks | 2025 | 10.1016/j.jfranklin.2025.107855 | 5R6KWQGW | 多智能体 + 执行器攻击，对象与三阶液压伺服距离较远；命令滤波思路可参考。 |
| A Modified Super-Twisting Sliding Mode Control for Aircraft Braking System With Adaptive Gain Schedule and Disturbance Compensation | 2026 | 10.1109/TIE.2025.3613654 | JHU5WMJN | STA + ESO 的工程变体，但对象为飞机防滑刹车，迁移性弱于液压文献。 |

## 3. 有限时间概念的分层核对表（仅据摘要）

必须分开记录四个层次，不能把“预设时间性能”直接写成“位置跟踪有限时间”。

| 工作 | 观测器/估计器 | 滑模变量 | 实际位置跟踪 | 摘要证据强度 |
|---|---|---|---|---|
| FS9EHUTH | **实用有限时间**（明确） | STA，名义上有限时间 | 摘要称精确跟踪，未给收敛时间界 | 中高，仍需全文 |
| ZLY8AKG6 | 设计了扰动/状态观测器，收敛层次未在摘要说明 | 预设时间连续滑模 | **预设时间到零**（声称恰好等于预设值） | 高（声称），需核证明 |
| BLFGZ6V4 | ESO，未声称有限时间 | STA（名义有限时间） | **常值扰动渐近 / 时变扰动最终有界** | 高（明确否定 FT） |
| 473MM72M | 预设时间驱动的扰动估计律，是否 FT 未说明 | 未明确 | 预设时间内进入有界区域（实用） | 中 |
| ASUHEN6J | 无 | 无 | 指定时间进入边界，**稳态渐近** | 高（明确 asymptotic） |
| AYKCDA4Q | 无 | 预设时间滑模（延迟反馈） | 状态强预设时间；扰动下固定时间 | 高（理论） |
| MX4W2ZZU | 未说明 | 预设时间延迟滑模面 | 未知 | **低（无摘要）** |
| Y5GKV8EY | 可用于观测器/微分器 | STA 有限时间 + 时间估计 | 不涉及 | 高（理论） |

结论（元数据层面）：本批文献至少存在三种不同承诺——(i) 观测器有限时间、滑模有限时间而跟踪仅渐近/最终有界（BLFGZ6V4 最典型）；(ii) 跟踪预设时间到零（ZLY8AKG6、46DP86DN 声称）；(iii) 指定时间进入边界但稳态渐近（ASUHEN6J）。第 (iii) 类最容易被题名误判，全文阅读时必须逐条摘出定理陈述中的“finite time / prescribed time / ultimately bounded”原句。

## 4. 与“三阶液压伺服、未知参数、机械/压力扰动、观测与滤波”的对应

- 三阶结构：电液伺服通常取位置、速度、负载压力三状态；这是领域常规建模，**并非从本批摘要逐篇核实**。因此“三阶”匹配度按题名/摘要中的 EHS/hydraulic 判断，不当作已读结论。
- 未知/时变参数：473MM72M、ASUHEN6J、FS9EHUTH、CF8H6QQY 明确涉及；FD2CBB3F 为一般非线性系统。
- 机械/压力扰动：BLFGZ6V4、FS9EHUTH、473MM72M、46DP86DN 涉及负载/外扰与扰动补偿；压力动态的具体处理需全文。
- 有限时间观测/滤波：FS9EHUTH（PFTO）、ZLY8AKG6（扰动/状态观测器）、HLZCX7PE（命令滤波，但只承诺有界）。BLFGZ6V4 的 ESO 是渐近型，不应归入有限时间观测器。

## 5. 重复记录与元数据缺陷

| 情况 | 记录 | 处理 |
|---|---|---|
| 同 DOI 重复 | 46DP86DN = ZVJ9U5J2（10.1109/CCDC62350.2024.10587765） | 保留 46DP86DN，另一条不重复计数 |
| 同题重复、其中一条无 DOI/作者/年份 | MX4W2ZZU（有 DOI）与 DQFUNVI5（空元数据） | 保留 MX4W2ZZU |
| 无摘要 | MX4W2ZZU / DQFUNVI5 | 仅题名匹配，概念判断置信度最低 |
| 无附件 | CF8H6QQY（child_count=0） | 仅保留为元数据候选 |
| 摘要截断 | ASUHEN6J、473MM72M、HLZCX7PE、ZLY8AKG6 等标 `abstract_truncated=true` | 结论只基于可见片段 |

## 6. PDF 附件解析状态（重要）

对 8 篇优先文献批量调用 `resolve_sources`，连续两次均返回：

`{"error": "Expecting value: line 1 column 1 (char 0)"}`

即 Zotero 本地附件端点返回空/非 JSON 响应，**未能取得任何真实 PDF 路径**。`02_priority_queue.json` 中 `pdf_path` 一律为 `null`，并保留 `pdf_attachment_key` 供在 Zotero 中手工定位。此项不影响元数据筛选结论，但意味着：目前没有任何一篇可被称为“已获取全文”，更不构成全文证据。

## 7. 建议的阅读顺序（全文可用后）

1. 先读 Y5GKV8EY、JPJUFKHN，锁定 STA 有限时间收敛与时间估计的判据。
2. 再读 AYKCDA4Q、MX4W2ZZU、ZLY8AKG6，核对周期延迟反馈、延迟滑模面与 `K(t)s(t-h)` 的假设。
3. 然后读 FS9EHUTH、BLFGZ6V4、473MM72M、ASUHEN6J，逐篇提取“观测器 / 滑模 / 跟踪”三层定理原句。
4. 最后用 LXD8I4BW 校准术语，避免 fixed / predefined / prescribed 混用。

## 8. 尚需全文核实的问题清单

1. 每篇定理中有限时间的主体到底是观测误差、滑模变量、还是位置跟踪误差？
2. 收敛时间是否依赖初值？是固定上界、可预设值，还是仅“存在”？
3. 扰动界假设是常值、Lipschitz、还是未知但有界？压力动态是否被当作匹配扰动？
4. STA 增益是常值、自适应，还是时变 `k(t)`？是否要求扰动导数已知界？
5. 延迟核 `K(t)`、`s(t-h)` 的稳定性证明用的是 Lyapunov-Krasovskii、轨迹分析还是比较引理？
6. 命令滤波/动态面的滤波误差只证有界，还是证有限时间？
