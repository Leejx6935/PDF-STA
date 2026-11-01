# 实际下发任务 T017B_L03R1（L03 定向修订）

你是执行者。本任务是 L03 初读报告的定向修订，不是重新泛读，也不是设计控制器或运行仿真。只改 L03 的三份产物，不扩展论文范围，不改项目量测合同。

必须先读审核意见：
`C:\Users\leejx\Desktop\三阶系统PDF-STA\.research_workspace\reviews\T017B_L03_补核审核_2026-10-28.md`

论文：Disturbance observer-based nonlinear feedback control for position tracking of electro-hydraulic systems in a finite time
DOI：10.1016/j.ejcon.2022.100659
本地 PDF：`C:\Users\leejx\Desktop\三阶系统PDF-STA\.research_workspace\inputs\four_papers\L03_Zotero.pdf`
SHA256：87208032df294dddc897ed22f12f0d375667d2618cdea2a6c41a70d239e71520

本地 MinerU 服务已恢复，标准解析已缓存：`doc:8720803/tier:standard`（parse id 166，1–11 页，done）。先用 `find_document` 或 `read_document` 使用缓存；确无缓存再 `parse_pdf`。公式有疑问时用页面图像核对，保留定位。禁止用 WebFetch 代替本地原文。

## 任务范围

逐项核对并改正审核意见中的 C1–C9。对每一项，在 `revision_notes.md` 写明：原报告写法、原文页码/式号、原文实际写法、是否撤回原判断、对后续结论的影响。不要只改数字而不说明依据。

C1 时间变换含时间常数 τ：p.3 Eq.(4) 为 \(\mu(t,\tau)=\frac{1+e^{-t/\tau}}{2e^{-t/\tau}}\)；p.7 Eq.(34) 同；p.7 Eq.(36) 为 \(a_1>1/\tau,\ a_2>1/\tau-b/m\)。原报告漏掉 τ，其 \(\dot\mu/\mu\in(1/2,1)\) 与 \(\alpha_1>1\) 仅是 τ=1 的特例。

C2 滑模变量：p.5 Theorem 1 为 \(s_i(t)=\dot e_i+\beta e_i^{q/p}\)，第一个误差带导数；原报告写成 \(e_i+\beta e_i^{q/p}\)。

C3 式 (19)–(20) 左端是 \(\dot V_i=s_i\dot s_i\)，不是 \(\dot s_i\)。原报告“印刷式多出 \(s_i\) 因子”的判断错误，必须撤回，并改为正确解读：\(\dot V_i=s_i(\ddot e_i+\frac{\beta q}{p}e_i^{q/p-1}\dot e_i)\)，代入观测器后为 \(\dot V_i=s_i(-\alpha_i\operatorname{sgn}(s_i)-\dot\Delta_i)\)。

C4 定理 1 与定理 2 的界是对扰动导数：\(|\dot\Delta_i|<\sigma_i\)（p.5 Eq.(21) 前文与 Theorem 2），不是 \(|\Delta_i|<\sigma_i\)。相应改写 Theorem 2 的 \(\bar\Theta_i\gg\alpha_i^{-1}(\sigma_i)\) 解释。

C5 式 (35) 界的是 \(|\dot e_i|\)：\(|\dot e_i|=|\hat\Delta_i-\Delta_i|\le|s_i(t)|\le\alpha_i^{-1}(\sigma_i)\)，不是 \(|e_i|\)。

C6 Table 1（p.7）：\(m=440\) kg，\(A_p=0.01\) m²，\(V_0=0.004\) m³，\(\rho=10^9\)，\(k_e=0.49\)，\(\omega_{nv}=152\) s⁻¹，\(\epsilon_v=0.92\)，\(P_s=10^7\) Pa。原报告的 \(\omega_e=49\) 与“无 \(k_e\)”均错误；\(b\) 确实未给出。

C7 式 (8) 前置因子原图为 \(\left(\frac{A_p}{m}\mu\right)^{-1}=m/(A_p\mu)\)，含 μ。原报告“可能漏印 1/μ”的疑点未成立，应撤回或标为已核对。

C8 式 (31) 末项下标为 5：\(-|\tilde x_5|\bar\Theta_5-(|\tilde x_5|\Delta_5-\tilde x_5\hat\Delta_5)\)。原报告 O3 可关闭。

C9 定理 1 的证明缺口应准确表述为：p.5 Eq.(20) 后作者明确假设 \(\ddot{\hat x}_i=\ddot x_i\)（估计的二阶导数等于真实二阶导数），该假设未被观测器 (17) 保证。不要再说“悄悄丢掉线性项”而不引用该句。

## 仍需保留的判断

- L03 不是预设时间方法，全文没有终端时刻 T；μ 只依赖绝对时间。
- 真实位置跟踪的不等式是指数/负二次型，没有有限时间（分数幂）不等式。
- 输入有界性与饱和未进入定理；噪声只在仿真中出现。
- 对象为五阶，量测包含阀芯位移 \(V_e\)，项目合同只覆盖位置与两腔压力，额外量测要求成立。
- 定理 2 的 \(\bar\Theta_i\gg\alpha_i^{-1}(\sigma_i)\) 依赖未知的扰动导数界，“\(\gg\)”不是严格不等式；观测收敛前区间未单独证明。

## 交付物（写入本任务 output）

1. `paper_card.md`（改正后的论文卡）
2. `proof_reconstruction.md`（改正后的证明重构）
3. `coverage_and_provenance.json`（改正后的覆盖与来源；包含 MinerU doc id、页范围、关键公式定位）
4. `revision_notes.md`（C1–C9 逐项对照表与撤回声明）

不得覆盖原任务 `T017B_L03_fulltext/output/` 的文件；本任务只写自己的 output。中文报告，公式保留页码与式号。不得把作者结论、你的复算和待证猜想混为一谈。
