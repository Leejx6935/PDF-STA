# L03 证明重构与独立核对（修订版 R1）

**对象**：Razmjooei, Palli, Nazari, *Disturbance observer-based nonlinear feedback control for position tracking of electro-hydraulic systems in a finite time*, European Journal of Control 67 (2022) 100659, 11 pp.
**SHA256**：`87208032df294dddc897ed22f12f0d375667d2618cdea2a6c41a70d239e71520`
**核对方式**：本地 MinerU 标准解析 `doc:8720803/tier:standard`（parse id 166，1–11 页）分页读取；公式以页面图像 `sources/parsed/L03_flash_page3..7.png` 逐式目视核对；关键环节做独立复算。未使用 WebFetch 或在线版本。内置 Read 打开本文 PDF 实测返回 "password-protected"，故不以该路径作为依据。
**等级**：A = 页面图像清晰、符号唯一；B = 可读但上下标/系数有歧义；C = 无法从页面图像确认。

**修订说明**：本文件是 `T017B_L03_fulltext/output/proof_reconstruction.md` 的修订版。原文件的 O1（式 (8) 是否漏 \(1/\mu\)）与 O3（式 (31) 下标 3/5）已关闭；原"式 (19)(20) 多出 \(s_i\) 因子是笔误"的判断**撤回**。原文件保留不动。

---

## 0. 公式定位表（修订）

| 公式 | 页 | 内容（修订后） | 等级 | 修订 |
|---|---|---|---|---|
| (1) | 2 | 五阶 EHA 三式，符号为 \(\omega_{nv},\epsilon_v\) | A | 符号订正 |
| (2) | 3 | 误差坐标状态空间；\(\Delta=[0,\Delta_2,\Delta_3,0,\Delta_5]^T\) | A | — |
| (3) | 3 | FT-ISS 定义 | B | 排版含混，不影响结论 |
| (4) | 3 | \(\mu(t,\tau)=(1+e^{-t/\tau})/(2e^{-t/\tau})\) | A | **C1**：含 \(\tau\) |
| (5) | 4 | \(E_1,E_2\) 导数；\(E_2\) 行含 \((A_p/m)\mu x_3\) 与 \(\mu\Delta_2\) | A | 已核 |
| (6) | 4 | \(\dot E_1=(\dot\mu/\mu)E_1+E_2\) | A | — |
| (7) | 4 | \(\bar E_2\) 导数；\(\Phi_1=-a_1E_1\) | A | 已核，与独立推导一致 |
| (8) | 4 | \(x_{3d}=\left(\frac{A_p}{m}\mu\right)^{-1}(\cdots)\) | A | **C7**：确认含 \(\mu\)，疑点撤回 |
| (9) | 4 | 代入 \(x_{3d}\) 后的前四式；\(x_3\to\tfrac{A_p}{m}\tilde x_3\) | B | **O15**：由 (5)(8) 应为 \(\tfrac{A_p}{m}\mu\tilde x_3\)，见 §4.4 |
| (10) | 4 | \(x_{4d}=\Phi_3\) | B | **O15** 同上 |
| (11) | 4 | 代入 \(x_{4d}\) 后 | B | 与 (9)(10) 印刷式自洽，与 (5)(8) 不自洽 |
| (12) | 4 | \(x_{5d}=\Phi_4\) | A | 已核 |
| (13) | 4 | 最终五阶闭环 | B | — |
| (14) | 5 | 名义控制 \(u\) | A | 已逐项核对（含 \(-\tilde x_4+\omega^2(\tilde x_4+\Phi_3)\) 结构） |
| (15) | 5 | Lemma 1 证明的闭环式 | B | 第二行 \(\frac{A_p}{m}x_3\) 亦无 \(\mu\)（同 O15 家族） |
| (16) | 5 | \(\hat\Delta_i\) 的积分定义 | A | 已核 |
| (17) | 5 | 观测器三式 | A | 已核 |
| (18) | 5 | \(V_i=s_i^2/2\) | A | — |
| (19) | 5 | \(\dot V_i=s_i\dot s_i=s_i(\ddot e_i+\frac{\beta q}{p}e_i^{q/p-1}\dot e_i)=s_i(\ddot{\hat x}_i-\ddot x_i+\cdots)\) | A | **C3**：左端是 \(\dot V_i\)，论文正确 |
| (20) | 5 | \(\dot V_i=s_i(-\alpha_i\operatorname{sgn}(s_i)-\dot\Delta_i)\) | A | **C3**；另见 §5.3 关于 \(\dot{\hat\Delta}\to\dot\Delta\) |
| (21) | 5 | \(\dot V_i\le-(\alpha_i-\sigma_i)|s_i|\)，前提 \(|\dot\Delta_i|<\sigma_i\) | A | **C4**：界的是扰动导数 |
| (22) | 5 | DOB 版 \(u\) | B | 已核结构 |
| (23)–(24) | 6 | \(x_{3d},x_{4d}\) 的 DOB 版；前置因子 \((A_p/m)^{-1}\)（无 \(\mu\)） | B | **O15**：与 (8)(25) 互斥 |
| (25)–(33) | 6 | 逐级 \(V_i\) 不等式与两种符号情形 | B | Case 1 用到未证明的估计误差界，见 §6.2 |
| (31) | 6 | \(V_5\) 末式，各项下标均为 5 | A | **C8**：O3 关闭 |
| (34) | 7 | \(\mu\) 的截断 | A | 含 \(\tau\) |
| (35) | 7 | \(|\dot e_i|=|\hat\Delta_i-\Delta_i|\le|s_i|\le\alpha_i^{-1}(\sigma_i)\) | A | **C5**：界的是导数 |
| (36) | 7 | \(a_1>\frac1\tau,\ a_2>\frac1\tau-\frac bm,\ a_i>0\ (i=3,4,5)\) | A | **C1** |
| Table 1 | 7 | 8 个参数；面积行符号误印为 \(b\) | A | **C6** |

---

## 1. 对象 → 误差动态（独立推导，结论不变）

令 \(x_1=y,\ x_2=\dot y,\ x_3=P_L,\ x_4=v_e,\ x_5=\dot v_e\)，\(\bar e_1=x_1-y_d,\ \bar e_2=x_2-\dot y_d\)。

\[
\dot{\bar e}_1=\bar e_2,
\]
\[
\dot{\bar e}_2=-\frac bm\bar e_2+\frac{A_p}{m}x_3-\frac bm\dot y_d-\ddot y_d+\Delta_2,
\]
\[
\dot x_3=-\frac{2\rho A_p}{V_0}\bar e_2-\frac{2\rho A_p}{V_0}\dot y_d+\frac{2\rho k_q\sqrt{P_s-|x_3|}}{V_0}x_4+\Delta_3,
\]
\[
\dot x_4=x_5,\qquad \dot x_5=-\omega_{nv}^2x_4-2\epsilon_v\omega_{nv}x_5+k_e\omega_{nv}^2u+\Delta_5.
\]

与式 (2) 逐项一致。相对阶 5，积分链 \(u\to x_5\to x_4\to x_3\to x_2\to x_1\)。\(\Delta_2,\Delta_3\) 非匹配，\(\Delta_5\) 匹配（相对 \(u\)）。

---

## 2. \(\mu(t,\tau)\) 的性质与截断（修订 C1）

\[
\mu=\frac{1+e^{-t/\tau}}{2e^{-t/\tau}}=\frac{e^{t/\tau}+1}{2},\qquad \mu(0)=1,
\]
\[
\dot\mu=\frac{1}{2\tau}e^{t/\tau},\qquad
\frac{\dot\mu}{\mu}=\frac{1}{\tau}\cdot\frac{e^{t/\tau}}{1+e^{t/\tau}}=\frac{1}{2\tau}\left(2-\mu^{-1}\right).
\]

因此
\[
\frac{1}{2\tau}<\frac{\dot\mu}{\mu}<\frac{1}{\tau},\qquad \lim_{t\to\infty}\frac{\dot\mu}{\mu}=\frac{1}{\tau},
\]
（\(t=0\) 时取左端点 \(1/(2\tau)\)）。\(\mu\to\infty\)，**没有终端时刻 \(T\)**。

**这正是增益条件的来源**：Lemma 1 与 Theorem 2 要求 \(a_1>1/\tau\)、\(a_2>1/\tau-b/m\)（p.5 Lemma 1；p.7 Eq.(36)），等价于 \(\dot\mu/\mu-a_1<0\)、\(\dot\mu/\mu-b/m-a_2<0\) 对一切 \(t\) 成立。原报告写成的 \(a_1>1,\ a_2>1-b/m\) 只在 \(\tau=1\) 时正确。

**截断 (34)**：\(\mu\) 在 \(\delta_t\) 连续，
\[
\dot\mu(\delta_t^-)=\frac{e^{\delta_t/\tau}}{2\tau},\qquad \dot\mu(\delta_t^+)=0 .
\]
控制律含 \(\dot\Phi_4\)（而 \(\Phi_4\) 依赖 \(\mu,\dot\mu/\mu\)），故 \(u\) 在 \(\delta_t\) 可能跳变。论文只论证"\(\mu\) 有界后状态仍有界"，未分析导数跳变，也未给 \(u\) 的连续性/有界性。

**\(\tau\) 的双重作用**：\(\tau\) 越小，\(\dot\mu/\mu\) 越大，增益下界越紧，但 \(1/\mu\sim2e^{-t/\tau}\) 的附加衰减越快。作者只说"\(\tau\) 越大控制量越小、收敛越慢"，与此一致。

---

## 3. 第一步反步：独立求导并**证实**式 (8)（修订 C7）

\(E_1=\mu\bar e_1,\ E_2=\mu\bar e_2\)，由 \(\dot E_i=\dot\mu\bar e_i+\mu\dot{\bar e}_i\)：

\[
\dot E_1=\frac{\dot\mu}{\mu}E_1+E_2 \tag{A}
\]
\[
\dot E_2=\left(\frac{\dot\mu}{\mu}-\frac bm\right)E_2+\frac{A_p}{m}\mu x_3-\mu\left[\ddot y_d+\frac bm\dot y_d\right]+\mu\Delta_2 \tag{B}
\]
（与 (5) 一致。注意 \((A_p/m)\mu x_3\)：\(\mu\) 由 \(E_2=\mu\bar e_2\) 带出，不是排版选择。）

取 \(\Phi_1=-a_1E_1\)，\(\bar E_2=E_2-\Phi_1=E_2+a_1E_1\)，则

\[
\dot E_1=\left(\frac{\dot\mu}{\mu}-a_1\right)E_1+\bar E_2 \tag{C}
\]

\[
\dot{\bar E}_2=\dot E_2-\dot\Phi_1=\dot E_2+a_1\dot E_1
=\left(\frac{\dot\mu}{\mu}-\frac bm+a_1\right)\bar E_2+a_1\left(\frac bm-a_1\right)E_1+\frac{A_p}{m}\mu x_3-\mu\left[\ddot y_d+\frac bm\dot y_d\right]+\mu\Delta_2 \tag{D}
\]

（(D) 与 (7) 逐项一致：把 (7) 中的 \(-\dot\Phi_1\) 与 \(-(\dot\mu/\mu-b/m)\Phi_1\) 展开即得同样结果——这是对 (7) 的一个独立验证。）

**设计目标**（即由 (5)(8) 决定的闭环；印刷式 (9) 第二行此处缺一个 \(\mu\)，见 §4.4）：

\[
\dot{\bar E}_2=-E_1+\left(\frac{\dot\mu}{\mu}-\frac bm-a_2\right)\bar E_2+\frac{A_p}{m}\mu\tilde x_3-\mu\left(k_2\operatorname{sgn}(\bar E_2)-\Delta_2\right) \tag{E'}
\]

令 (D) 中 \(\frac{A_p}{m}\mu x_3=\frac{A_p}{m}\mu\tilde x_3+\frac{A_p}{m}\mu\Phi_2\)，由 (D)=(E') 解出

\[
\Phi_2=\left(\frac{A_p}{m}\mu\right)^{-1}\left\{-E_1-(a_1+a_2)\bar E_2-a_1\left(\frac bm-a_1\right)E_1+\mu\left[\ddot y_d+\frac bm\dot y_d\right]-\mu k_2\operatorname{sgn}(\bar E_2)\right\}
\]
\[
=\left(\frac{A_p}{m}\mu\right)^{-1}\left\{-E_1-a_2\bar E_2+\mu\left[\ddot y_d+\frac bm\dot y_d\right]-\left(\frac{\dot\mu}{\mu}-\frac bm\right)\Phi_1+\dot\Phi_1-\mu k_2\operatorname{sgn}(\bar E_2)\right\} \tag{F'}
\]

第二行用了 \(\Phi_1=-a_1E_1\) 与 \(\dot\Phi_1=-a_1\dot E_1\) 的回代（展开后 \(E_1\) 项恰为 \(a_1(a_1-b/m)E_1\)，\(\bar E_2\) 项恰为 \(-(a_1+a_2)\)）。

**(F') 与印刷式 (8) 逐项相同，包括前置因子 \(\left(\frac{A_p}{m}\mu\right)^{-1}\)。** 因此：

1. 式 (8) 的 \(\mu^{-1}\) **是正确的、也是必需的**——若缺 \(\mu\)，则 \((A_p/m)\mu\Phi_2\) 会给出 \(-\mu E_1\) 而不是 \(-E_1\)，\(E_1\bar E_2\) 交叉项无法抵消，\(\dot V_2\) 的负定性立即破坏。
2. **原报告 O1「(8) 可能漏印 \(1/\mu\)」撤回**：原图清晰含 \(\mu\)，独立推导也要求含 \(\mu\)，两条证据一致。
3. 由 (E') 可见：**式 (9) 第二行的 \(\tilde x_3\) 项必须是 \(\frac{A_p}{m}\mu\tilde x_3\)**。印刷式写作 \(\frac{A_p}{m}\tilde x_3\)，与 (5)(8) 相差一个 \(\mu\)——这是 O15 的起点，不是本步骤的推导结果。

由 \(V_2=\tfrac12E_1^2+\tfrac12\bar E_2^2\)：

\[
\dot V_2=\left(\frac{\dot\mu}{\mu}-a_1\right)E_1^2+\left(\frac{\dot\mu}{\mu}-\frac bm-a_2\right)\bar E_2^2-\mu k_2|\bar E_2|+\mu\bar E_2\Delta_2 \tag{G}
\]

\(k_2\ge|\Delta_2|\) 时

\[
\dot V_2\le\left(\frac{\dot\mu}{\mu}-a_1\right)E_1^2+\left(\frac{\dot\mu}{\mu}-\frac bm-a_2\right)\bar E_2^2\le-2c_2V_2,\quad
c_2=\min\left(a_1-\frac{\dot\mu}{\mu},\ a_2+\frac bm-\frac{\dot\mu}{\mu}\right)>0 . \tag{H'}
\]

**这是指数收敛，不是有限时间收敛。** 若要有限时间，需要 \(\dot V\le-cV^{\rho}\ (\rho<1)\)；全文没有任何分数幂的跟踪误差不等式。这条保留判断不因 C1–C9 的任何修订而改变。

---

## 4. 中段与末级反步

### 4.1 结构与导数阶数

逐级 \(x_{3d}=\Phi_2\to x_{4d}=\Phi_3\to x_{5d}=\Phi_4\to u\)，Lyapunov 逐级累加 \(\tfrac12\tilde x_i^2\)，交叉项按 \(\bar E_2\leftrightarrow\tilde x_3\leftrightarrow\tilde x_4\leftrightarrow\tilde x_5\) 逐级抵消。导数阶数：

- \(\Phi_2\) 含 \(\dot y_d,\ddot y_d,\dot\Phi_1\)；
- \(\Phi_3\) 含 \(\dot\Phi_2\Rightarrow\dddot y_d\)；
- \(\Phi_4\) 含 \(\dot\Phi_3\Rightarrow y_d^{(4)}\)；
- \(u\) 含 \(\dot\Phi_4\)。

论文只声明参考为 \(y_d,\dot y_d\)，**未列参考信号的光滑性阶数**（保留 O6）。仿真用 \(\sin t,\cos t\)，不暴露该问题。

### 4.2 式 (14) 的独立核对

把 \(x_4=\tilde x_4+\Phi_3,\ x_5=\tilde x_5+\Phi_4\) 代入 \(\dot{\tilde x}_5=\dot x_5-\dot\Phi_4\)，要求 \(\dot{\tilde x}_5=-\tilde x_4-a_5\tilde x_5-k_5\operatorname{sgn}(\tilde x_5)+\Delta_5\)，解出

\[
u=(k_e\omega_{nv}^2)^{-1}\Big(-\tilde x_4+\omega_{nv}^2(\tilde x_4+\Phi_3)+2\epsilon_v\omega_{nv}(\tilde x_5+\Phi_4)+\dot\Phi_4-a_5\tilde x_5-k_5\operatorname{sgn}(\tilde x_5)\Big),
\]

与 (14) **完全一致**（注意其中是 \(-\tilde x_4+\omega^2(\tilde x_4+\Phi_3)\)，不是 \(-\dot{\hat x}_4+\omega^2\hat x_4+\Phi_4\)；原报告此处转录有误，本修订改正）。

### 4.3 \(\hat\Delta_i\) 的导数奇异（保留 O4）

由 (16)，

\[
\dot{\hat\Delta}_i=-\alpha_i\operatorname{sgn}(\dot e_i+\beta e_i^{q/p})-\beta\frac qp e_i^{q/p-1}\dot e_i .
\]

\(q<p\Rightarrow q/p-1<0\)，\(e_i\to0\) 时 \(e_i^{q/p-1}\to\infty\)。反步对含 \(\hat\Delta_i\) 的 \(\Phi_i\) 求导会产生此类项，在观测收敛点附近可能奇异/抖振。论文未说明 \(\dot\Phi_i\) 是解析求导还是数值微分。

### 4.4 \(\mu\) 的记账不一致（本任务新增观察 O15）

按页面图像，\(\mu\) 出现在：式 (5) 的 \((A_p/m)\mu x_3\)、式 (8) 的前置因子、式 (9) 第三行的 \(-2\rho A_p/(\mu V_0)(\bar E_2+\Phi_1)\)、式 (15) 第三行同项；**不出现**在：式 (9) 第二行的 \((A_p/m)\tilde x_3\)、式 (10) 的 \(-(A_p/m)\bar E_2\) 与 \((2\rho A_p/V_0)(\bar E_2+\Phi_1)\)、式 (23) 的前置因子 \((A_p/m)^{-1}\)、式 (24) 的对应项，以及式 (15) 第二行的 \((A_p/m)x_3\)。

**判定（不是"可能"，而是可判定的矛盾）**：

- \(E_2=\mu\bar e_2\) 是定义，故 \(\dot E_2\) 中 \(x_3\) 的系数必须是 \((A_p/m)\mu\)——这不是排版选择。式 (5) 正确，因此 \((A_p/m)\mu\Phi_2\) 必须产出恰好 \(-E_1\)（而不是 \(-\mu E_1\)），式 (8) 的 \(\mu^{-1}\) 正确（§3 已独立证实）。
- 于是式 (9) 第二行的残差项必须是 \((A_p/m)\mu\tilde x_3\)；若如原样写 \((A_p/m)\tilde x_3\)，则 (9) 描述的闭环与由 (2)(5) 决定的系统不是同一个（相差 \(\mu\)）。
- 同理，(23) 若用 \((A_p/m)^{-1}\)，则 \((A_p/m)\mu\Phi_2\) 产出 \(-\mu E_1\)，与 (25) 打印的 \(-E_1\) 直接冲突。
- 而 (9)(10)(11) 三者彼此自洽、(23)(24) 彼此自洽——所以这是**两组各自自洽、但互相排斥**的写法，不是单一笔误可以解释的随机错字。

**最小自洽修法（本报告给出，非作者原文）**：以 (8) 为准，(9) 第二行改为 \((A_p/m)\mu\tilde x_3\)；(10) 内层改为
\[
-(A_p/m)\mu\bar E_2+\frac{2\rho A_p}{\mu V_0}(\bar E_2+\Phi_1)+\frac{2\rho A_p}{V_0}\dot y_d+\dot\Phi_2-a_3\tilde x_3-k_3\operatorname{sgn}(\tilde x_3);
\]
(23)(24) 同步改为 \((A_p/m\,\mu)^{-1}\) 与对应项。此时 (11) 按原样成立，整条链**精确闭合、无残差**。

**影响评估（按两种读法分别陈述）**：

- **读法甲（以 (8) 为控制器）**：把 \(\mu\) 补回上述三处后闭环精确成立，\(\dot V_2,\dot V_3\) 均如论文所写，**不存在额外残差**。即问题纯粹是排印遗漏。
- **读法乙（以 (23) 为控制器，照印刷使用）**：则 (25) 的交叉项抵消失效，\(\dot V_2\) 多出 \((1-\mu)E_1\bar E_2\)；\(\mu\) 未截断时该项随 \(t\) 增长，截断 (34) 后 \(\mu\le\mu_{\max}\) 使其有界，可由更大的 \(a_1,a_2\) 压住。
- 两种读法都**不改变"指数收敛"的定性结论**，也都使"对任意满足 (36) 的增益都有 \(\dot V_3<0\)"这句话需要附加条件。

**置信度**：中高。矛盾本身是可判定的（(8)(25) 与 (9)(10)(23)(24) 不能同时成立）；具体哪一处是排印错误、作者本意是哪一组，无法从页面图像唯一判定，故按"待作者澄清"处理，且**不据此改动任何定性结论**。

---

## 5. 定理 1：逐行重构（修订 C2/C3/C4/C5/C9）

### 5.1 真实误差动态

由 (17)−(2)，并假定 \(x_3,x_4\) 可测、两式用同一个 \(u\)：

\[
\dot e_2=-\frac bm e_2+\hat\Delta_2-\Delta_2,\qquad
\dot e_3=-\frac{2\rho A_p}{V_0}e_2+\hat\Delta_3-\Delta_3,\qquad
\dot e_5=-2\epsilon_v\omega_{nv}e_5+\hat\Delta_5-\Delta_5 . \tag{L}
\]

（式 (L) 与原文件一致。若 \(x_3\) 不可测而由 \(\hat x_3\) 替代，还会多出流量非线性差项。）

### 5.2 正确的滑模变量与 (19)–(20)（修订 C2、C3）

\[
s_i(t)=\dot e_i+\beta e_i^{q/p},\qquad V_i=\frac{s_i^2}{2},
\]
\[
\dot V_i=s_i\dot s_i=s_i\left(\ddot e_i+\frac{\beta q}{p}e_i^{q/p-1}\dot e_i\right)
=s_i\left(\ddot{\hat x}_i-\ddot x_i+\frac{\beta q}{p}e_i^{q/p-1}\dot e_i\right) \tag{19}
\]

**左端是 \(\dot V_i\)，不是 \(\dot s_i\)。** 论文写法正确，原报告"印刷式多出 \(s_i\) 因子、按字面量纲不成立"的判断是**误判，予以撤回**。

由 (16) 求导得
\[
\frac{\beta q}{p}e_i^{q/p-1}\dot e_i=-\alpha_i\operatorname{sgn}(s_i)-\dot{\hat\Delta}_i ,
\]
代入 (19) 得印刷式
\[
\dot V_i=s_i\left(-\alpha_i\operatorname{sgn}(s_i)-\dot\Delta_i\right). \tag{20}
\]

### 5.3 (20) 之后的两处未说明的替换（C9 的准确表述 + 本报告补充）

1. **作者显式假设**（p.5，(20) 之后原句）："it is assumed that \(\ddot{\hat x}_i=\ddot x_i\)"。**这是 C9 要求的准确表述**：缺口不是"悄悄丢掉线性项"，而是**额外假设估计的二阶导数等于真实二阶导数**，该假设未被观测器 (17) 保证。
   本报告的补充解读（非作者措辞）：由 (L)，\(\ddot e_2=-\frac bm e_2+\hat\Delta_2-\Delta_2\)，一般不为零；若强行令 \(\ddot{\hat x}=\ddot x\)，等于在证明开始时就把**待估的观测误差**设为零，属循环论证。
2. **符号替换未说明**：代入式给出的是 \(-\dot{\hat\Delta}_i\)，而 (20) 右端写作 \(-\dot\Delta_i\)。二者相等需 \(\dot{\hat\Delta}_i=\dot\Delta_i\)（估计误差导数为零），同样未证明。因此 (20) 的严格写法应为
\[
\dot V_i=s_i\left(-\alpha_i\operatorname{sgn}(s_i)-\dot{\hat\Delta}_i\right),
\]
再借 \(|\dot\Delta_i|<\sigma_i\) 与"估计已收敛"来界定 \(|\dot{\hat\Delta}_i|\)。

### 5.4 界、时间与邻域（修订 C4、C5）

在 \(|\dot\Delta_i|<\sigma_i\)（**扰动导数的界**，p.5 (21) 前文）下，

\[
\dot V_i\le-\alpha_i|s_i|+|\dot\Delta_i||s_i|\le-(\alpha_i-\sigma_i)|s_i| \tag{21}
\]

故 \(|s_i|>\alpha_i^{-1}(\sigma_i)\) 时 \(\dot V_i<0\)，且
\[
|s_i|\le\alpha_i^{-1}(\sigma_i)\quad\text{在有限时间}\quad T_i=\frac{|s_i(0)|}{\alpha_i(|s_i(0)|)-\sigma_i}.
\]

**关于 \(T_i\)**：若 \(\alpha_i\) 取常数，精确解为 \(T_i(r)=\dfrac{|s_i(0)|-r}{\alpha_i-\sigma_i}\)，\(r=\alpha_i^{-1}(\sigma_i)\)；若 \(\alpha_i(\cdot)\) 是 class-K（论文的正式定义），则应为 \(T_i=\int_r^{|s_i(0)|}\frac{ds}{\alpha_i(s)-\sigma_i}\)，一般无闭式。论文打印的 \(T_i\) 用了 \(\alpha_i(|s_i(0)|)\)，只在常增益下与闭式相容，两种表述未统一（保留 O2 的实质）。

**关于 (35)（修订 C5）**：论文写
\[
|\dot e_i|=|\hat\Delta_i-\Delta_i|\le|s_i(t)|\le\alpha_i^{-1}(\sigma_i) \tag{35}
\]
界的是**观测误差的导数**，不是 \(e_i\) 本身。因此不能据 (35) 宣称 \(e_i\le\alpha_i^{-1}(\sigma_i)\) 的邻域。另外，等号 \(|\dot e_i|=|\hat\Delta_i-\Delta_i|\) 本身已经忽略了 (L) 中的 \(-\frac bm e_2\)、\(-\frac{2\rho A_p}{V_0}e_2\)、\(-2\epsilon_v\omega_{nv}e_5\)，即带着 §5.3 同一缺口。

**本报告复算（非作者结论）**：若 (20) 型的 \(s_i\) 动力学成立且 \(|s_i|\le r:=\alpha_i^{-1}(\sigma_i)\)，则由 \(s_i=\dot e_i+\beta e_i^{q/p}\) 得 \(\dot e_i=s_i-\beta e_i^{q/p}\)。当 \(|e_i|>(r/\beta)^{p/q}\) 时，\(\dot e_i\) 与 \(e_i\) 反号且 \(|e_i|\) 单调减小，故
\[
|e_i|\le\left(\frac{r}{\beta}\right)^{p/q}=\left(\frac{\alpha_i^{-1}(\sigma_i)}{\beta}\right)^{p/q}
\]
在有限时间内成立。这个界**不是** \(\alpha_i^{-1}(\sigma_i)\)，而是它的 \(p/q>1\) 次幂再除以 \(\beta^{p/q}\)。所以即使补好证明缺口，定理 1 能给的观测误差带也比论文措辞暗示的宽。

---

## 6. 定理 2：\(V_5\) 关键步骤

### 6.1 最终不等式（修订 C8）

p.6 式 (31) 各项下标均为 5（页面图像清楚可辨）：

\[
\dot V_5=\left(\frac{\dot\mu}{\mu}-a_1\right)E_1^2+\left(\frac{\dot\mu}{\mu}-\frac bm-a_2\right)\bar E_2^2-a_3\tilde x_3^2-a_4\tilde x_4^2-a_5\tilde x_5^2-|\tilde x_5|\bar\Theta_5-\left(|\tilde x_5|\hat\Delta_5-\tilde x_5\Delta_5\right) \tag{31}
\]

原报告 O3「下标 3/5 不清」**关闭**。

### 6.2 残差项与两情形

记 \(\tilde\Delta_5=\hat\Delta_5-\Delta_5\)。当 \(\Delta_5\ge0\) 时 \(|\tilde x_5|\Delta_5-\tilde x_5\hat\Delta_5\ge-|\tilde x_5||\tilde\Delta_5|\)，故

\[
-|\tilde x_5|\bar\Theta_5-\left(|\tilde x_5|\hat\Delta_5-\tilde x_5\Delta_5\right)\le-|\tilde x_5|\left(\bar\Theta_5-|\tilde\Delta_5|\right),
\]

需 \(\bar\Theta_5\ge|\tilde\Delta_5|\)。但论文实际用的是更强的替换（p.6 (26)(29)(32) 的 Case 1）：

\[
|\hat\Delta_i|-|\Delta_i|\le\alpha_i^{-1}(\sigma_i)\quad\Longrightarrow\quad -|\tilde x_i|\bar\Theta_i-(\cdots)\le|\tilde x_i|\left(\alpha_i^{-1}(\sigma_i)-\bar\Theta_i\right).
\]

**这条替换依赖的是"估计误差本身的界"**，而定理 1 只给出 \(|\dot e_i|\) 的界（且带 §5.3 缺口）。这是 C5 的实质性后果：定理 2 的鲁棒裕度条件 \(\bar\Theta_i\gg\alpha_i^{-1}(\sigma_i)\) 建立在定理 1 未建立的量上。

当 \(\Delta_5<0\) 时 \(|\tilde x_5|-\tilde x_5\in[0,2|\tilde x_5|]\)，需要
\[
\bar\Theta_5\ge2|\Delta_5|+|\tilde\Delta_5|
\]
才能得到同样的负号；论文未声明 \(\Delta_5\ge0\)，也未给因子 2（保留 O5；按 C4 口径，此处应分别就 \(\Delta_i\) 与其导数的符号/界陈述，不再沿用原报告对 \(\Delta_i\) 符号的单点分析）。

### 6.3 "\(\gg\)" 与收敛前区间

- 定理 2 条件写作 \(\bar\Theta_i\gg\alpha_i^{-1}(\sigma_i)\)，作者在 p.6 自己注明 "\(\gg\) is a much greater than symbol"；证明中实际只用严格大于。由于 \(\sigma_i\) 现在是 \(|\dot\Delta_i|\) 的界且未知，"\(\gg\)"**不是可先验验证的严格不等式**（保留判断）。
- \(t<T_i\) 时段 \(\tilde\Delta_i\) 可能超过 \(\bar\Theta_i\)，闭环有界性未单独证明；严格证明需"先 Lemma 1 型有界、后 Theorem 2 型指数收敛"分段（保留 O8）。

### 6.4 由 \(V_5\) 能得到什么

若 \(a_1>1/\tau,\ a_2>1/\tau-b/m,\ a_3,a_4,a_5>0\)，且残差项被压住，则 \(\dot V_5\le-2c_5V_5\)，
\[
c_5=\min\left(a_1-\frac{\dot\mu}{\mu},\ a_2+\frac bm-\frac{\dot\mu}{\mu},\ a_3,a_4,a_5\right)>0,
\]
即**指数收敛**（观测收敛后）。**不是有限时间。**

---

## 7. 真实位置误差的最终结论

\[
|\bar e_1(t)|=\frac{|E_1(t)|}{\mu(t)}\le\frac{\sqrt{2V_5(t)}}{\mu(t)}\le\frac{\sqrt{2V_5(0)}\,e^{-c_5t}}{\mu(t)} .
\]

因 \(\mu(t)=(e^{t/\tau}+1)/2\sim e^{t/\tau}/2\)，有效衰减率约 \(c_5+1/\tau\)。对任意 \(r>0\)，
\[
t(r)\approx\frac{\ln\!\big(2\sqrt{2V_5(0)}/r\big)}{c_5+1/\tau},
\]
依赖 \(V_5(0)\)（初值、未知扰动导数界、观测初值）、\(c_5\) 与 \(\tau\)，**不能事先指定**，也不是论文中任何 \(T\)（全文没有 \(T\)）。

**因此**：
- 精确有限时间位置跟踪：**未建立**。
- "有限时间进入任意小邻域"：在 FTUB 弱意义上成立（指数收敛的推论），论文没有给出对应表述。
- 预设时间：**未建立**，方法结构不含 \(T\)；\(\mu\) 只依赖绝对时间。

---

## 8. 待核清单（修订：O1、O3 关闭；O15 新增）

| 编号 | 问题 | 位置 | 状态 | 影响 |
|---|---|---|---|---|
| O1 | (8) 前置因子是否含 \(1/\mu\) | p.4 (8) | **关闭**：图像含 \(\mu\)，独立推导也要求 \(\mu^{-1}\) | — |
| O2 | \(T_i\) 的形式、\(\alpha_i\) 是常数还是 class-K | p.5 (21) 后 | 保留 | 决定"有限时间"是精确还是邻域 |
| O3 | (31) 下标 3 还是 5 | p.6 (31) | **关闭**：全为 5 | — |
| O4 | \(\dot{\hat\Delta}_i\) 含 \(e^{q/p-1}\)，\(e=0\) 奇异 | p.5 (16) | 保留 | 反步求导可能无界 |
| O5 | 残差界需 \(\Delta_i\) 符号条件或更大 \(\bar\Theta_i\) | p.6 (31)–(33) | 保留（改按 \(\Delta_i\)/导数分别表述） | 鲁棒裕度条件不足 |
| O6 | 参考所需导数阶数（至 \(y_d^{(4)}\)） | p.3–5 | 保留 | 一般参考下控制律可能无定义 |
| O7 | \(\bar\Theta_i\gg\alpha_i^{-1}(\sigma_i)\) 依赖未知 \(|\dot\Delta_i|\) 界 | p.5–6 | 保留 | 条件不可先验验证 |
| O8 | \(t<T_i\) 段闭环有界性未分段证明 | p.5–7 | 保留 | 全局有界性不完整 |
| O9 | \(u\) 有界性、饱和未入定理 | p.5 (22)；p.10 | 保留 | 硬件实现风险 |
| O10 | \(\delta_t\) 处 \(\dot\mu\) 跳变 → \(u\) 可能跳变 | p.7 (34) | 保留（按 \(\tau\) 修订） | 实现/平滑性 |
| O11 | \(x_3\) 可测却又估计 \(x_3\) | p.5 (17) | 保留 | 观测器结构冗余 |
| O12 | Definition 1/2 排版含混 | p.3 | 保留 | 定义基础 |
| O13 | Table 1 缺 \(b\) 与 \(\tau\)（面积行符号误印为 \(b\)） | p.7 | 保留并细化 | 增益条件不可数值核对 |
| O14 | \(J_{\bar e}\) "infinity norm" 与积分定义不一致 | p.9 Table 2 | 保留 | 指标解释 |
| **O15** | (9)(10)(23)(24) 与 (5)(8)(25) 的 **\(\mu\) 记账互斥** | p.4 (8)–(10)、p.6 (23)(24) | **新增**（本任务观察，置信中高） | 逐式复现需澄清；定性结论不变（见 §4.4） |

---

## 9. 数值自检（按 Table 1 修订）

1. **\(\dot\mu/\mu\)**：以 \(\tau=1\) 为例，\(t=0\): \(1/2\)；\(t=1\): \(e/(e+1)=0.7311\)；\(t=10\): \(0.99995\)——均属 \(\tau=1\) 特例。一般 \(\tau\) 下整条曲线按 \(1/\tau\) 缩放。
2. **增益条件的可核性**：条件含 \(1/\tau\) 与 \(b/m\)。Table 1 给出 \(m=440\) kg，但**不给 \(b\)、也不给 \(\tau\)**，故 \(a_1,a_2\) 的可行下界**无法**用表中参数算出。原报告"若 \(b=0\) 则需 \(\alpha_2\) 足够大"的讨论失去对象（\(b\) 只是未给，不是可假定为 0）。
3. **派生量**：\(k_e\omega_{nv}^2=0.49\times152^2=1.132\times10^{4}\ \mathrm{s^{-2}}\)；\((k_e\omega_{nv}^2)^{-1}=8.83\times10^{-5}\ \mathrm{s^{2}}\)；\(A_p/m=2.273\times10^{-5}\)；\(2\rho A_p/V_0=5.0\times10^{9}\)；\(2\epsilon_v\omega_{nv}=279.7\ \mathrm{s^{-1}}\)。原报告"\(k_e\) 未在表中列出、无法反推"的说法**错误**，予以改正。
4. **30% 指标**：\(1-454.3921/643.2316=0.2936\)，与 "almost 30%" 一致；是作者仿真值，不是定理推论。
5. **输入量级**：Fig. 5 峰值约 20 V；无饱和。仅凭仿真图不能推断定理层面的 \(\sup|u|\)。

---

## 10. 结论（证明层面，修订）

1. 对象 → 误差方程 (2)/(5) 的推导**正确**。
2. 第一步反步的交叉项抵消、\(V_2\) 负定性**正确**；式 (8) 的具体形式（**含** \((A_p/m\,\mu)^{-1}\)）经独立复算**证实**，O1 撤回。
3. 跟踪误差由 \(\dot V\le-cV\) 得**指数收敛**，**没有**有限时间不等式；题目 "finite time" 对位置跟踪不成立（除非按 FTUB 的弱意义理解）。**L03 不是预设时间方法。**
4. 定理 1 的证明**不闭合**，其性质是作者**显式假设** \(\ddot{\hat x}_i=\ddot x_i\)（并另有 \(\dot{\hat\Delta}\to\dot\Delta\) 的未说明替换）；原报告"多出 \(s_i\) 因子是笔误"的判断**撤回**，(19)(20) 写法正确。
5. 定理 2 的 \(V_5\) 末级在"残差可压、观测已收敛"下给出**指数收敛**；其 Case 1 依赖的估计误差界 \(\alpha_i^{-1}(\sigma_i)\) 并未由定理 1 建立；(35) 界的是 \(|\dot e_i|\) 而非 \(|e_i|\)。
6. (8)/(5) 与 (9)(10)(23)(24) 的 \(\mu\) 记账互斥（O15），可修，且不改变定性结论。
7. 预设时间性质：**未建立**；全文无终端 \(T\)。
