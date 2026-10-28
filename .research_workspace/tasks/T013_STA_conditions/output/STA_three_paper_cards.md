# 三篇 STA 文献——全文条件与 Future Work 核查卡

日期：2026-10-27　｜　状态：**所有结论待审核**　｜　依据：本地 MinerU 正常质量解析全文（未用 flash、未远程上传）

核查口径：只记录原文可定位的陈述；“未列”指原文没有 Future Work 小节或明确语句，不代替作者意图推测。公式编号沿用原文。

---

## A. Gonzalez, Moreno & Fridman (2012), IEEE TAC 57(8): 2100–2105
DOI 10.1109/TAC.2011.2179878　｜　Zotero JPJUFKHN

**1. 阅读范围与 Future Work**
实读 PDF 1–6/6，期刊 2100–2105，末页文献止于 [21]，完整。无 Future Work 节，Conclusion 仅总结贡献，**未列**。

**2. 何者有限时间到零**
定理 1：任意初值下 $s$ 与 $z$ 精确到 $(0,0)$；$T=\frac{2}{\gamma_2}\ln[\frac{\gamma_2}{\gamma_1}V^{1/2}(s_0,z_0)+1]$（15），依赖 $V(s_0,z_0)$ 与 $\gamma_1,\gamma_2$，后者由 $P(\beta,\epsilon)$、$k_3$ 及 $k_1,k_2$（即 $\varrho_1,\varrho_2$）决定。$\eta$ 无到达时间，仅在 $s\equiv0$ 上按 $A_{11}+A_{12}K$ 指数衰减。

**3. 关键条件**
LTI $\dot x=Ax+B(u+f)$，$\mathrm{rank}\,B=m$、$(A,B)$ 可控；单输入、控制系数归一化为 1；$b(t)\ge b_m$ 时取常值 $b_m$，**非辨识**。$f$ 及梯度 a.e. 由**已知连续函数**界住；分解 $f=g_1+g_2$，$g_1(\eta,0,t)=0$，$|g_1|\le\varrho_1|\phi_1|$、$|dg_2/dt|\le\varrho_2|\phi_2|$，$\varrho_1,\varrho_2$ 已知。可测有界类(7)不适用。初值任意。变增益(14)是对已知界的在线取值，不含估计或学习；界未知则定理无效。

**4. 对三阶液压可借用 / 仍需另证**
可借用：若等效控制把液压化为 $\dot s=v+\Delta$ 且 $\Delta$ 的界可写成 $\varrho_1,\varrho_2$，则(14)给显式增益、(15)给到达时间上界；$k_3>0$ 可覆盖随 $s$ 线性增长的扰动。需另证：三阶液压 $u$ 不直接进 $\dot s$、相对阶不为 1，须先反馈线性化并证明误差属(11)类；摩擦与流量–压力非线性使 $dg_2/dt$ 的界依赖状态，须自推；阀增益、容积模量属乘性输入增益，本文仅按已知 $b_m$ 归一化；饱和与离散未涉及。

**5. 待证问题（非创新声明）**
以估计界 $\hat\varrho$ 替代已知界后，(14)的有限时间结论不再自动成立，须重证；把 $k_1(t,x)$ 称为“学习到真实参数”是错的。另：式(14)解析中出现未定义符号 $a$，待核对。

---

## B. Moreno & Osorio (2012), IEEE TAC 57(4): 1035–1040
DOI 10.1109/TAC.2012.2186179　｜　Zotero Y5GKV8EY

**1. 阅读范围与 Future Work**
实读 PDF 1–6/6，期刊 1035–1040，完整。无 Future Work 节；Conclusion 仅提可利用函数族自由度优化到达时间估计、按给定时间反设计增益，属展望，记**未列**。

**2. 何者有限时间到零**
定理 1（无扰动）：$k_1,k_2>0\iff A$ Hurwitz $\iff$ 有限时间稳定；$x\to0$ 精确，$T=2V^{1/2}(x_0)/\sigma$，$\sigma=\lambda_{\min}^{1/2}(P)\lambda_{\min}(Q)/\lambda_{\max}(P)$。定理 2（$\varrho_1=0,|\varrho_2|\le L$）：按 Algorithm 1(11) 取增益仍精确到零，$\tilde T=2V^{1/2}(x_0)/\tilde\sigma$。定理 3：$|\varrho_1|\le\delta_1+\delta_2\sqrt{|x_1|+x_2^2}$；$\delta_1=0$ 且 $\delta_2<\lambda_{\min}(Q_R)/\eta$ 时精确有限时间(15)，$\delta_1>0$ 时**只最终有界**，界 $b$ 见(14)。示例 $t=5$ s 出现 $\phi(t)$ 后误差不再为零，正对应 $\delta_1\ne0$。

**3. 关键条件**
扰动全局有界；$L,\delta_1,\delta_2$ 为**常数**，且增益设计需**已知 $L$**（11 含 $\sqrt L$ 与 $L$）。$\varrho_1$ 仅需可测有界；Filippov 解；$V$ 连续非局部 Lipschitz，用 Zubov 与 Bihari；初值任意。与 A 之别：A 的界是已知**状态/时间函数**，B 是**常数**；二者都不是完全未知界，也都不含学习。

**4. 对三阶液压可借用 / 仍需另证**
可借用 ALE：取 $Q>0$ 解 $A^TP+PA=-Q$ 得 $P$，量化 $T$ 并反解限时增益；Algorithm 1 的椭圆条件给出可审计可行域。需另证：B 只针对二维 $(x_1,x_2)$ 子系统，三阶液压须先证 $s$ 通道可写成(1)（相对阶 1、扰动只进 $x_2$ 或满足(13)）；$\delta_1,\delta_2,L$ 须从物理模型推导；要精确到零须 $\delta_1=0$，否则只有最终界；输入增益、饱和、采样未涉及。

**5. 待证问题（非创新声明）**
$L$ 未知时 Algorithm 1 不可用；改用自适应 $\hat L$ 须证其有界且不破坏 $\dot V$ 负定——Wang 的 Case 2 正说明未解决。不得把“变增益 = 学习扰动界”当结论。

---

## C. Wang et al. (2026), IEEE TIE 73(3): 4308–4318
DOI 10.1109/TIE.2025.3613654　｜　Zotero JHU5WMJN

**1. 阅读范围与 Future Work**
实读 PDF 1–11/11，期刊 4308–4318，完整。**Future Work 明确写出**（p.4317）：① 局限——$\alpha$ 为常数，增益增长率不能随扰动界自适应；② 未来引入 online parameter adaptation，应对不同机型参数不确定性；③ 未来在小型无人机上试验。

**2. 何者有限时间到零**
**无任何量被证明到零。** 定理 2 仅为“converge to the vicinity of the origin in finite time”，摘要为“desired accuracy near the origin”，证明末给 $|x_1|<\varepsilon$、$T\le2V^{1/2}/\varpi^{1/2}$（51）：$\sigma$ 只进 $\varepsilon$ 带。ESO 误差亦仅 $\|\varphi\|\le\sqrt{\varsigma/\varpi_e}$，与 $\varsigma_m$ 成正比；定理 1 称渐近稳定，但 $H(t)\ne0$ 时只是最终有界。

**3. 关键条件**
Assumption 1：$|f|\le\eta_d$、$|\dot f|\le\varsigma_m$；ESO 设 $H(t)<\varsigma_m$，Remark 4 得 $|\dot{\tilde f}|<\Delta$，定理 2 写 $d(t)<\Delta$（漏绝对值）。控制通道 $rk_b/(JV_p)$ 取常值 $k_b$；等效控制(28)用 $\hat f$、$\hat F_f$ 与微分器给出的 $\dot\lambda_o$。$\lambda_o$ 来自[3]、$F_f$ 来自[5]，非本文内容。$\sigma=e_\lambda+\int e_\lambda$（26）。“自适应”为(33)(34)：$|x_1|>\varepsilon$ 时 $\dot k_1=\alpha/(|\psi|+\varepsilon)$、$\dot k_2=\alpha/(2|x_1|^{\theta_1})$，否则按 $-k_1,-k_2$ 衰减——**调增益，不辨参数**。全文无 $M_p,k_b,\mu(\lambda),J$ 的辨识；$k_b$ 变化只在实验扰动清单，模型(13)(27)仍用常值 $k_b$（时变即乘性输入增益，未处理）。

**4. 对三阶液压可借用 / 仍需另证**
可借用：连续化积分通道以适配伺服阀；增益随 $|\sigma|$ 升降的调度与 ESO 前馈降增益；$M_e,R_e$ 指标。需另证：定理 2 只证 Case 1（$|x_1|>\varepsilon$）；Case 2 明文承认增益下降时(45)(46)可能不成立、$\dot V$ 可为正、“overall stability cannot be guaranteed”，靠切回 Case 1，**非 Lyapunov 全局证明**；三阶液压相对阶、输入增益时变、压力饱和未覆盖；$\varepsilon$ 与压力/流量精度、噪声的关系须另给。

**5. 待证问题（非创新声明）**
$\theta_1+\theta_2=1$ 与 $\varepsilon,\alpha$ 仅实验整定（Remark 3：$\theta_1$ 影响“not definitely determined”）；移植到液压只是待证方案，不构成创新。若称“辨识”，须给回归模型与持续激励条件，本文没有；其 adaptive 仅为增益调度 + 集总扰动估计。

---

### 横向对照（供审核）
| 项 | A Gonzalez | B Moreno | C Wang |
|---|---|---|---|
| 扰动界 | 已知函数 $\varrho_1(t,x),\varrho_2(t,x)$，可随状态变 | 常数 $L,\delta_1,\delta_2$，须已知 | 未知界，靠自适应增益 |
| 到零还是邻域 | $s,z$ 精确到零 | $\delta_1=0$ 到零；$\delta_1>0$ 最终有界 | 仅到 $\varepsilon$ 带 |
| 时间估计 | (15)，对数型 | (6)/(15)，$2V^{1/2}/\sigma$ | (51)，依赖 $\varpi$ |
| 参数辨识 | 无 | 无 | 无 |
| 输入增益 | 归一化为已知 $b_m$ | 未含 | 常值 $k_b$ |
| 饱和/离散 | 未涉及 | 未涉及 | 未涉及 |

**禁止性提醒**：任何“换成自适应增益 / 加滤波 / 移植到液压”的想法，在未给出相对阶、界、饱和与离散化证明前，只能登记为待证问题，不能表述为创新点。
