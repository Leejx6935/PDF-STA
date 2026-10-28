# T017A 四篇指定论文全文定位报告

日期：2026-10-27（Asia/Shanghai）　范围：仅定位与身份核验，未阅读全文，未做任何内容结论。

## 一、总览

| ID | 篇名（缩写） | 本地 Zotero | 下载/全文状态 |
|---|---|---|---|
| L03 | Razmjooei et al., EJC 2022 | 无 | **机构仓储 OA 后印本已定位，下载被 Cloudflare 拦截（403）** |
| L07 | Jiang et al., APM 2024 | 无 | 付费墙，未找到任何开放副本 |
| L13 | Niu et al., APM 2026 | 无 | 付费墙，未找到任何开放副本 |
| L09 | Wang et al., MSSP 2025 | 无 | 付费墙，未找到任何开放副本 |

本地 Zotero（10.0.6，API 正常）中四篇均不存在：DOI 查询各 0 条，题名/作者片段查询亦无相关命中；既有元数据快照 `zotero_finite_time_catalogue_2026-10-27.json`（36 条顶层条目、20 条匹配）同样不含这四篇。未向 Zotero 写入或修改任何记录，因此四条记录均无 item key、无本地附件路径。MinerU 缓存查询四次均为 0 条（未启动解析）。

## 二、逐篇状态

**L03 — Disturbance observer-based nonlinear feedback control for position tracking of electro-hydraulic systems in a finite time**
Razmjooei, Palli, Nazari；*European Journal of Control* 67:100659，2022。
出版社：<https://www.sciencedirect.com/science/article/pii/S0947358022000528>（订阅访问）。
已定位开放版本：博洛尼亚大学 IRIS 机构仓储记录 <https://cris.unibo.it/handle/11585/904197>，附件 `(03-12-2021) FT-DOTC for EHAs (RPN).pdf`（1.83 MB，标注为作者接受稿 postprint，CC BY-NC-ND，禁售期 2024-08-20 结束）。两次直接下载均返回 HTTP 403（Cloudflare 挑战页），**未取得 PDF 字节，身份尚未核验**。
下一步：用普通浏览器打开上述 handle 页通过人机校验后下载；若失败，走机构 ScienceDirect 权限。使用时应按“作者接受稿”标注，正式引用以版本记录为准。

**L07 — Finite-time command filtered electro-hydraulic system position control with dead zone**
Jiang, Shen, Cheng；*Applied Mathematical Modelling* 131:190–204，2024。
出版社：<https://www.sciencedirect.com/science/article/pii/S0307904X24001434>。检索未见 arXiv、机构仓储、预印本或 CORE/Internet Archive Scholar 副本；ScienceDirect 为摘要页，全文需订阅。
下一步：机构账号登录 ScienceDirect 下载；备选 NSTL（<https://lz.nstl.gov.cn/paper_detail.html?doi=10.1016/j.apm.2024.03.026>）、馆际互借，或联系北京交通大学作者（js0723@bjtu.edu.cn 等）。

**L13 — Command filter and neural network-based fixed-time backstepping control of electro-hydraulic system with uncertainties**
Niu, Wang, Li, Liu, Zhao, Sun；*Applied Mathematical Modelling* 157:116848，2026。
出版社：<https://www.sciencedirect.com/science/article/pii/S0307904X26001095>。北京理工大学 Pure 页面 <https://pure.bit.edu.cn/en/publications/command-filter-and-neural-network-based-fixed-time-backstepping-c/> 仅有元数据，未发现文件链接；无 OA/预印本。
下一步：机构 ScienceDirect 登录；或经 Pure 页面联系通讯作者（赵江波 / 孙自铮，山东大学、北京理工大学）索取，或馆际互借。

**L09 — A reinforcement learning-based optimized backstepping control approach for uncertain electro-hydraulic systems**
Wang, Wang, Ye, Guo, Li；*Mechanical Systems and Signal Processing* 237:112928，2025。
出版社：<https://www.sciencedirect.com/science/article/pii/S0888327025006296>。未发现 arXiv、机构仓储或作者自存副本。
下一步：机构 ScienceDirect 登录；或联系通讯作者（郭庆 / 李铁山，电子科技大学、广州大学），或馆际互借。

## 三、工具与限制（影响结论强度）

- 本机 WebFetch 对所有域名（含 example.com）均返回 “Unable to verify if domain … is safe to fetch”，无法直接读取出版社/仓储页面；上述出版社、仓储、Pure 页面状态来自搜索结果与索引摘要，而非我逐页抓取。
- 因此**四篇均未做 PDF 身份核验**（无 PDF 字节可比对题名/作者/DOI）。L03 仅为“仓储元数据与题名作者吻合”，不等同于已核验全文。
- 下载预算 8 次，实际使用 2 次（均 L03，均 403），未对已知付费墙页面反复请求。
- 未使用任何影子图书馆；未修改 MinerU 配置或启动远程解析。

## 四、需要用户执行的准确操作

1. **L03**：浏览器打开 <https://cris.unibo.it/handle/11585/904197>，通过 Cloudflare 校验后下载 postprint；或将 PDF 交回以便核验与缓存。
2. **L07 / L13 / L09**：用机构账号登录对应 ScienceDirect 链接下载 PDF（三条链接见上），或提供馆际互借/作者索取得到的 PDF。
3. 任一 PDF 到位后，可再执行身份核验（题名、作者、DOI 与页眉比对）并登记 MinerU 文档 ID。

本任务通过仅表示“来源定位合格”，不代表全文已读或任何证明成立。
