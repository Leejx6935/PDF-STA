# 检索依据与核查范围

核查日期：2026-10-21（Asia/Shanghai）。Zotero 分类：预定义时间控制（JTFVSPGW），7 条顶层论文记录，均有本地 PDF 附件。署名人数仅指论文作者数，不表示实验室或团队总人数。

## 动态指标

OpenAlex 按 DOI 精确匹配，原始响应保存在 `*_openalex.json`。引用该论文的记录通过 `filter=cites:W...` 获取，按引用量排序，最多取前 30 条，保存在 `*_citing.json`。这不是对全部后续论文的穷尽阅读。

Semantic Scholar 同样按 DOI 精确匹配；两库同日返回值汇总于 `metrics_snapshot_2026-10-21.json`。数字是各数据库当前索引计数，不能相加，也不应理解为 Google Scholar 或 Web of Science 引用量。0 表示该库尚未索引到引用。

## 机构及作者的一手资料

- [CINVESTAV 官方：建于 1961 年、研究与研究生培养定位](https://cce.cinvestav.mx/index.php/about-cce)。2015 年论文三名作者的发表时单位，按 PDF 第 1 页脚注认定，均为 Guadalajara 自动控制实验室。
- [燕山大学学校简介](https://www.ysu.edu.cn/xxgk/xxjj.htm)：历史源于 1920 年的哈尔滨工业大学，1960 年独立办学，1997 年更名；不能简单把 1920 年写为当前校名的独立建校年份。
- [华长春当选 IEEE Fellow 与中国自动化学会会士的校方报道](https://iee.ysu.edu.cn/info/1336/20490.htm)：2024 年度 IEEE Fellow，获选理由涉及非线性时滞系统智能控制。报道时间为 2023 年，不能将其当时累计论文量写作 2026 年实时指标。
- [扬州大学学校简介](https://www.yzu.edu.cn/xxgk/xxjj.htm)：1992 年合并组建，前身可追溯至张謇 1902 年创办的学校。2024 年论文的具体单位见 PDF 第 1 页，为信息工程学院自动化系及数学科学学院。
- [南京理工大学校方学校简介](https://zsb.njust.edu.cn/detail?id=1278)：1953 年哈军工渊源、211 与双一流身份；学校代表人物王泽山院士。本文使用“军工与机电液应用背景较强”作为研究定位说明，不以机构声誉代替论文质量判断。
- [姚建勇校方教师页](https://jszy.njust.edu.cn/jxgc/yjy_1302/list.psp)：机械工程学院、机电系统伺服控制等方向。该页数据较旧，不据此报告实时 h-index。
- [广东工业大学学校简介](https://www.gdut.edu.cn/xxgk/xxjj.htm)：1958 年本科教育、1995 年合并组建，工程应用型研究背景。
- [华南理工大学学校简介](https://www.scut.edu.cn/new/9015/list.htm)：1952 年正式组建，985、211、双一流背景。
- [陈俊龙的官方学术简介](https://dxkjme.cumt.edu.cn/info/1052/1283.htm)：IEEE Fellow 等荣誉及智能控制背景；仅使用可核验荣誉，不混用他人的引文指标。
- [包头职业技术学院校史](https://innovate.btvtc.cn/homexxgk/lshm.html)：1956 年前身、1998 年升格高职，兵器制造职业教育背景。

## 代码与公开评价

- [Hua 2022 第三方复现仓库](https://github.com/SZU-AdvTech-2024/149-Adaptive-Prescribed-Time-Control-for-a-Class-of-Uncertain-Nonlinear-Systems)：网页本次可见 10 stars、0 forks；文件有 `example1.m`、`e2.m`、`README.md`、`citation.txt`、`ResearchReport.pdf`。README 署名 gjh，日期 2024/11/26。不能认定为论文原作者官方仓库，也未在仓库根目录清单中确认到开源许可证。GitHub API 本次返回 403，star 数以可访问的仓库网页为据。
- 其余 6 篇未检索到可以确认归属的官方公开代码仓库；“未找到”不等于已证明绝对不存在。GitHub star 不适用时不用 0 冒充。
- 未取得 7 篇论文可核验的公开逐条审稿意见。两篇 MDPI 论文的 Review Reports 入口未能读取到实际审稿报告；不能据此断言审稿过程不公开或存在负面意见。报告中的审稿评价是独立模拟评审，不是真实审稿记录。

## 后续研究的一手链接

- [A class of predefined-time stable dynamical systems](https://doi.org/10.1093/imamci/dnx004)：2015 理论的后续系统化发展。
- [A Note on Predefined-Time Stability](https://doi.org/10.1016/j.ifacol.2018.07.332)：允许多项式项，弱化指数结构限制；出版社摘要明确说明与早期定理关系。
- [Event-triggered adaptive prescribed-time control for nonlinear systems with uncertain time-varying parameters](https://doi.org/10.1016/j.automatica.2023.111229)：Hua/Ning 团队向事件触发及未知时变参数方向的延续。
- [Composite learning-based prescribed-time control for time-varying nonlinear systems](https://doi.org/10.1016/j.apm.2026.117001)：引用 Zhang 2024，结合跟踪与估计误差进行复合学习，并扩展故障补偿。根据出版社摘要概述，未在本任务中逐页阅读此后续论文。
- [Self-adjusting performance-based adaptive event-triggered consensus control for nonlinear multi-agent systems](https://doi.org/10.1016/j.jfranklin.2026.108845)：引用 Peng 2025，延续命令滤波与误差补偿，并研究可自调性能边界、事件触发；不声称完整继承前作的抗攻击保证。
- [Motion control design for an electro-hydraulic actuator under ensured performance](https://doi.org/10.1016/j.cja.2025.103828)：引用 Yang 2025，关注各层控制误差的预设时间暂态性能。
- [Output feedback-based adaptive position control for hydraulic systems with preset performance](https://doi.org/10.1016/j.isatra.2026.06.016)：引用 Yang 2025，通过位置驱动观测器研究输出反馈，与前作结论提出的后续方向对应。

后续关系的证据分为“数据库引用边”“出版社摘要说明的技术延续”及“本报告对课题的建议”，三者不能混为一谈。
