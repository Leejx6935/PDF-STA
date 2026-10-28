# 01_Ding2026_method_card

## 1. 文献信息与可定位页面

- 作者：Yi Ding、Bin Zhou、Yang Shi。
- 题名：Prescribed-Time Control via Periodic Delayed Feedback-Based Super-Twisting Sliding Mode Algorithm。
- 出处：IEEE Transactions on Automatic Control, vol. 71, no. 3, March 2026, pp. 1813–1828。
- DOI：10.1109/TAC.2025.3618707。收稿 2025-03-29，修回 2025-07-24，接收 2025-10-01，在线 2025-10-07（p.1813 页脚）。
- 本地原文：`C:\Users\leejx\Desktop\基于PDF框架的自适应STA滑模控制\Prescribed-Time_Control_via_Periodic_Delayed_Feedback-Based_Super-Twisting_Sliding_Mode_Algorithm.pdf`。
- Zotero：条目 key `ZLY8AKG6`；附件存在，attachment key `MKEKXJK7`，本地文件 `C:/Users/leejx/Zotero/storage/MKEKXJK7/Ding 等 - 2026 - Prescribed-Time Control via Periodic Delayed Feedback-Based Super-Twisting Sliding Mode Algorithm.pdf`。
- MinerU：缓存 `doc:4871ce7/tier:standard`，共 16 页；本次连续读取 PDF 第 1–16 页（正文、定理证明、附录与参考文献首页）。PDF 页码与期刊页码的对应为：PDF p.1 = p.1813，PDF p.4 = p.1816，PDF p.5 = p.1817，PDF p.7 = p.1819，PDF p.9 = p.1821，PDF p.11 = p.1823，PDF p.12 = p.1824，PDF p.14 = p.1826。

## 2. 模型与已知输入增益条件

受控对象为（12）式（p.1816）：

\[
\dot\xi_j=\xi_{j+1}+d_j(t,\xi),\quad j=1,\dots,n-1,\qquad
\dot\xi_n=f(t,\xi)+g(t,\xi)u+d_n(t,\xi),\qquad y=\xi_1 .
\]

其中 \(f,g\) 为已知函数，且文中只要求 \(g(t,\xi)\neq 0\)，没有给出 \(|g|\) 的上下界、\(g\) 的导数界，也没有未知增益、未知控制方向或增益自适应。控制器（51）直接使用 \(g^{-1}(\cdot)\)（p.1821）；输出反馈情形进一步取 \(n=2,\ f=0,\ g=1\)（p.1822，（57）式）。因此，“未知输入增益”不在该文的假设覆盖范围内，这是后文候选问题的主要依据，而不是作者已经解决的问题。

扰动分为非匹配与匹配两部分：\(d_1,\dots,d_{n-1}\) 通过积分链进入，属于非匹配扰动；\(d_n\) 与输入同通道，属于匹配扰动。Assumption 2（p.1816）要求

\[
\left|\frac{d^j d_i(t,\xi)}{dt^j}\right|\le D_{i,j},\qquad j=0,1,\dots,n-i+1,
\]

即已知各阶导数的上界，阶数随 \(i\) 增大而降低；这是把非匹配扰动搬到匹配通道并进行观测、补偿的前提。

## 3. 两类 STA 的区别

**第一类 STA（Sec. III，式（13）–（16），Theorem 1，p.1817）。** 两个通道都允许依赖延迟状态：

\[
\phi_1=-k_1(\cdot)|x_1|^{1/2}\mathrm{sign}(x_1)-k_2(\cdot)x_1,\qquad
\phi_2=-k_3(\cdot)\mathrm{sign}(x_1)-k_4(\cdot)x_2 .
\]

增益 \(k_1=(a-2ck_3)/b,\ k_2=2k_4\)，而 \(k_3,k_4\) 由 \(W_1(x),W_2(x)\) 和 PDF 核 \(K_{(l_4,h)}(t)\) 构造；\(h=\mathcal T/2\)。其结构是每 \(2h\) 为一个周期：前一半 \(K=0\)，增益退化为常数 \(l_i\)；后一半 \(K>0\)，用 \(V_2=\gamma(t)\eta^{\mathrm T}P\eta\) 把延迟项吸收，从而在 \(2h=\mathcal T\) 时精确收敛。该方法的 \(k_4\) 需要 \(x(t-h)\) 的完整信息（含 \(x_2\)），适合状态已知的观测器/控制器设计。

**第二类 STA（Sec. IV，式（32）–（36），Theorem 2，p.1819）。** 其第二通道只依赖 \(t\) 与 \(x_1\)：

\[
\phi_1=-k_4(\cdot)|x_1|^{1/2}\mathrm{sign}(x_1)-k_1k_3x_1,
\]

\[
\phi_2=-k_2(t)\left(\frac12\mathrm{sign}(x_1)+\frac32k_3|x_1|^{1/2}\mathrm{sign}(x_1)+k_3^2x_1\right).
\]

其中 \(k_4=k_1+2K_{\mathrm{sta}}(t)|x_1(t-h)|^{1/2}\)，\(h=\mathcal T/4\)；\(k_2(t)=0\) 于 \([0,2h]\)，之后取 \(\mu=\beta+4\varepsilon^2+2\varepsilon k_1\)。证明分两段：\([0,2h]\) 用 \(V_1=x_1^2/2\) 和 Lemma 6 得到 \(x_1(2h)\) 的界（37）；\([2h,\infty)\) 用变量增益 STA 的 Lyapunov 函数得到 \(T_0\le 4h=\mathcal T\)。该方法的代价是需要 \(|x_2(0)|\le\theta\)，且 \(k_1,k_3,\varepsilon,\beta,\alpha,\iota,r\) 的整定不等式较复杂（33）–（35）。

**核心差异：** 第一类用完整延迟状态构造增益，收敛时间 \(\mathcal T=2h\)；第二类只用 \(x_1\) 的延迟信息，收敛时间 \(\mathcal T=4h\)，但正因为 \(\phi_2\) 不依赖 \(x_2\)，它可以与状态观测器结合，形成输出反馈方案（Sec. VI）。两者都不是“把连续 STA 简单加一个延迟”，而是把 PDF 核 \(K_{(k,h)}(t)\) 嵌入增益，使延迟项在 Lyapunov 不等式中产生可积的负项。

## 4. 扰动界、Lemma 5 与主要时间结论

Assumption 1（p.1816）对 STA 的未知项给出 \(|\varrho_1|\le\delta_1,\ |\dot\varrho_1|\le\delta_2,\ |\varrho_2|\le\delta_3\)，三个界均已知。对原系统则用 Assumption 2 的 \(D_{i,j}\)。这些界既用于增益设计，也用于观测器误差的归纳。

**Lemma 5（p.1816，证明在 Appendix A，p.1824–1825）必须单独核对。** 它讨论受扰动的标量 PDF 系统

\[
\dot x=-kx-K_{(k,h)}(t)x(t-h)+\Delta(t),\qquad |\Delta(t)|\le\bar\Delta,
\]

结论是：\(x(t)\) 在 \([0,\infty)\) 有界，且存在只依赖 \(\bar\Delta\)、不依赖初值的 \(\Omega\)，使 \(|x(t)|\le\Omega,\ \forall t\ge 2h\)。这是一个“受扰 PDF 系统的最终有界/误差界”引理，不是“精确预设时间收敛”的新定理；它不声称 \(x(t)\to0\)。文中正是用它把观测误差、测量噪声等有界扰动吸收为 \(\Omega\)，进而得到 Corollary 1–4 的实用界。因此，把 Lemma 5 的 \(\Omega\) 界当作本文的创新点是不准确的：本文的主创新是两类 PDF-STA 及其与观测器/控制器组合后的精确时间结论；Lemma 5 是支撑噪声鲁棒性分析的辅助工具。

主要时间结论可整理为“时间账本”：

| 环节 | 时间参数 | 结论 | 页码 |
|---|---|---|---|
| 第一类 STA | \(h=\mathcal T/2\) | \(x_1=0,\ x_2+\varrho_1=0,\ \forall t\ge\mathcal T\) | p.1817, Thm 1 |
| 第二类 STA | \(h=\mathcal T/4\) | 同上，且需 \(|x_2(0)|\le\theta\) | p.1819, Thm 2 |
| 扰动观测器 | \(h=T_{\mathrm{ob}}/(2n)\) | 第 \(i\) 步在 \(2ih\) 收敛，总计 \(T_{\mathrm{ob}}=2nh\) | p.1820, Thm 3 |
| 状态反馈控制 | \(h_1=(T-T_{\mathrm{ob}})/(2n)\) | 观测 \(T_{\mathrm{ob}}\) 后，逐层 \(2h_1\)，总计 \(T\) | p.1821, Thm 4 |
| 输出反馈观测器 | \(T_{\mathrm{ob}}=T_s\) | \(\hat z_1=y,\ \hat z_2=z_2,\ \forall t\ge T_s\) | p.1823, Thm 5 |
| 输出反馈控制 | \(h_1=(T-2T_s)/2\) | \(s\) 在 \(2T_s\) 收敛，\(y\) 在 \(2T_s+2h_1=T\) 收敛 | p.1823, Thm 6 |

需要说明“恰好等于 \(T\)”的含义：Remark 4（p.1821）与 Remark 8（p.1823）指出，若切换时刻的滑动变量非零，则收敛时间正好是 \(T\)；若该变量已经为零，则实际收敛会更早。因此 \(T\) 是保证的上界/最坏情形，不是“任何初值都恰好等到 \(T\) 才收敛”。在测量噪声下，Corollary 1–4 给出的是有限时间 \(T_{mi}\) 之后的 \(|y|\le\Omega_i\)，而不是精确零。

## 5. 非匹配扰动、观测、控制与总时间的关系

作者先用（43）式的 \(z_m=\xi_m+\sum_{j=1}^{m-1}\frac{d^{m-j-1}}{dt^{m-j-1}}d_j\) 把非匹配扰动“搬”到最高阶通道，得到（44）式的匹配形式；代价是 \(z_i\) 不能由 \(\xi_i\) 直接量测。于是观测器（45）–（46）逐级估计 \(z_i\) 和综合扰动 \(\vartheta_i\)：第 1 步用 \(\bar z_1=\xi_1\)，第 \(i\) 步用 \(\bar z_i=\xi_i-\hat D_{i-1}\)，每一级都是一套第一类 STA。每级耗时 \(2h\)，共 \(n\) 级，所以 \(T_{\mathrm{ob}}=2nh\)；这也解释了为什么观测器时间必须严格小于控制器总时间 \(T\)。

控制器（48）–（51）构造分层滑动变量 \(s_i=\dot s_{i-1}+as_{i-1}+K_s(t)s_{i-1}(t-h_1)\)，并令 \(K_s(t)=0\) 于 \([0,T_{\mathrm{ob}})\)，之后才启动 PDF 核。这样观测阶段与滑动阶段在时间上分离：先保证 \(z_i,\hat D_i\) 在 \(T_{\mathrm{ob}}\) 到位，再让 \(s_{n-1},s_{n-2},\dots,s_0\) 逐层收敛，每层 \(2h_1\)，总计 \(T_{\mathrm{ob}}+2nh_1=T\)。输出反馈情形同理：第二类 STA 先作为状态观测器在 \(T_s\) 内估计 \(z_1,z_2\)，控制器再用（65）–（68）的 STA 估计复合扰动并使 \(s\) 在 \(2T_s\) 收敛，最后 \(z_1\) 在 \(2h_1\) 内收敛，总计 \(T=2T_s+2h_1\)。因此总时间是“观测时间 + 逐层滑动时间”的加法账本；非匹配扰动的阶数 \(n\) 直接放大观测时间，而测量噪声则把精确收敛替换为 \(\Omega\) 界。

## 6. 作者明确写出的 Future Work 与执行者问题（分列）

**作者明确写出的 Future Work：没有。** 结论（Sec. VII，p.1824）只总结了两类 STA、观测器和控制器，并说明“仿真验证有效”，未列 Future Work、未提实验计划、未提未知增益或采样实现。因此，凡涉及“作者建议后续研究……”的表述，都不应归到本文作者头上。

**执行者根据假设边界提出的问题（均为推论，不是作者结论，也未证明）：**

1. **未知输入增益与 PDF 的耦合。** 文中 \(g\) 已知且仅要求非零；若 \(g=g_0(x)+\Delta g\) 且 \(g_0\) 未知、符号未知或存在饱和，则（51）的 \(g^{-1}\) 不能直接实现。可研究带投影/σ-修正的参数自适应与 PDF-STA 的组合，但参数误差会进入非匹配通道，可能把精确 \(T\) 降为实用 \(T\) 加 \(\Omega\) 界；需要额外假设（如 \(g\) 有界远离零、参数线性化、持续激励）才可能恢复精确性。
2. **采样/离散实现。** 全文为连续时间 Filippov 解；Remark 6（p.1821）只说明延迟项 \(K_{\bar h}(t)\zeta(t-\bar h)\) 在 \([0,\bar h)\) 为零、不依赖 \(t<0\) 的历史，但没有分析采样保持、延迟缓冲量化、符号函数零阶保持带来的族拥。将 PDF 核和 \(h\) 离散化后，精确 \(T\) 是否保持、还是退化为 \(O(T_s/h)\) 的实用界，是一个可检验的问题。
3. **MIMO/高阶相对度与执行器约束。** 全文是 SISO、相对度 \(n\)；液压伺服常见多输入、饱和、死区。把（12）扩展到 MIMO 时，\(g^{-1}\) 变为矩阵逆，非匹配扰动的逐级观测和分层滑动面的时间账本都要重写；饱和还会破坏 \(g^{-1}u\) 的精确抵消。
4. **降低 Assumption 2 的保守性。** 需要 \(d_i\) 直到 \(n-i+1\) 阶导数的已知界；对液压系统，这些界往往难测。可用自适应/估计器替代已知 \(D_{i,j}\)，但这会改变 Lemma 5 中 \(\bar\Delta\) 的结构，进而改变 \(\Omega\)。

## 7. 待原图核查的公式

以下公式的 MinerU 文本存在指数、括号或矩阵元素的可疑断行，本文只按可读形式引用，未自行“修复”后当作原文；引用前应对照原 PDF 图像核查：

- （8）式 PDF 核 \(K_{(k,h)}(t)=R_h(t)W e^{-k(h-2t)}\) 的指数符号与 \(W_c\) 定义（p.1815）。
- （15）式 \(k_4\) 的长括号与 \(K(t)+\gamma_0\) 的位置（p.1816）。
- （24）式 \(\tilde Q_1+(b/2)I_2\succeq0\) 的矩阵元素（p.1817）。
- （33）式 \(\Delta_3,\Pi,D\) 的嵌套幂次（p.1818–1819）。
- （59）式 \(k_6,k_7,\omega\) 的定义及 \(k_5(t)\) 分段（p.1822）。
- （68）式 \(k_{si}(\cdot)\) 的四个增益与延迟区间（p.1823）。

以上页码均为期刊页码；对应 PDF 页码见第 1 节。
