# L03 证明重构与独立核对

**对象**：Razmjooei, Palli, Nazari, *Disturbance observer-based nonlinear feedback control for position tracking of electro-hydraulic systems in a finite time*, European Journal of Control 67 (2022) 100659.
**核对方式**：本地 PDF 第 1–11 页逐页页面图像精读；MinerU 本地服务未运行，未使用其 OCR 文本。公式以页面图像为准，凡字号过小或上下标不能唯一确定者，标为 B/C 级并列入 §8 待核清单。

**核对等级**：A = 页面图像清晰、符号可唯一确定；B = 可读但上下标/符号/系数存在歧义；C = 无法从页面图像确认。

---

## 0. 公式定位表

| 公式 | 页 | 内容 | 等级 |
|---|---|---|---|
| (1) | 2 | 五阶 EHA 三个方程 | A（首行是否为 \(\ddot y\) 已按上下文确认） |
| (2) | 3 | 误差坐标状态空间、\(\Delta=[0,\Delta_2,\Delta_3,0,\Delta_5]^T\) | A |
| (3) | 3 | FT-ISS 定义 | B（定义排版含混） |
| (4) | 3 | \(\mu(t)=(1+e^{-t})/(2e^{-t})\) | A |
| (5) | 4 | \(E_1,E_2\) 的导数 | A |
| (6) | 4 | \(\dot E_1=(\dot\mu/\mu)E_1+E_2\) | A |
| (7) | 4 | \(\bar E_2\) 的导数、\(\Phi_1\) | B（\(\alpha_2\) 是否在系数中需核） |
| (8) | 4 | \(x_{3d}=\Phi_2\) | B（\(1/\mu\) 前置因子与 \(\alpha_2\) 需核） |
| (9) | 4 | 代入 \(x_{3d}\) 后的前四式 | B |
| (10) | 4 | \(x_{4d}=\Phi_3\) | B |
| (11) | 4 | 代入 \(x_{4d}\) 后的前四式 | B |
| (12) | 4 | \(x_{5d}=\Phi_4\) | B |
| (13) | 4 | 代入 \(x_{5d}\) 后的前五式 | B |
| (14) | 5 | 名义控制 \(u\) | B |
| (15) | 5 | Lemma 1 证明用的闭环矩阵 | B |
| (16) | 5 | \(\hat\Delta_i\) 的积分定义 | A |
| (17) | 5 | 观测器 \(\dot{\hat x}_2,\dot{\hat x}_3,\dot{\hat x}_5\) | A（但 \(\hat x_3\) 与“\(x_3\) 可测”矛盾） |
| (18) | 5 | \(V_i=s_i^2/2\) | A |
| (19) | 5 | \(\dot s_i\) 的展开 | A（印刷式多出 \(s_i\) 因子） |
| (20) | 5 | \(\dot s_i=-\alpha_i\operatorname{sgn}(s_i)-\tilde\Delta_i\) | A（印刷式多出 \(s_i\) 因子） |
| (21) | 5 | \(\dot V_i\le-(\alpha_i-\sigma_i)|s_i|\) | A |
| (22) | 5 | DOB 版控制 \(u\) | B |
| (23)–(24) | 6 | \(x_{3d},x_{4d}\) 的 DOB 版 | B |
| (25)–(33) | 6 | \(V_2,V_3,V_4,V_5\) 的逐级不等式与两种情况 | B |
| (34) | 7 | \(\mu\) 的截断 | A |
| (35) | 7 | \(|\varepsilon_i|\le|s_i|\le\alpha_i^{-1}(\sigma_i)\) | A |
| (36) | 7 | 增益条件 | B（\(\alpha_2>1-b/m\) 的符号需核） |
| Table 1 | 7 | 对象参数 | A（无 \(b\)） |

---

## 1. 对象 → 误差动态（独立推导）

由 (1)：

\[
\ddot y=-\frac{b}{m}\dot y+\frac{A_p}{m}P_L+\Delta_2,\qquad
\Delta_2=-\frac{F_f(\dot y)}{m}+\eta_2,
\]
\[
\dot P_L=-\frac{2\rho A_p}{V_0}\dot y+\frac{2\rho\psi(V_e)}{V_0}\sqrt{P_s-|P_L|}+\Delta_3,
\]
\[
\ddot V_e=-\omega_e^2V_e-2\varepsilon_e\omega_e\dot V_e+k_e\omega_e^2u+\Delta_5,
\qquad \Delta_5=\omega_e^2v_{e0}+\eta_5.
\]

令 \(x_1=y,x_2=\dot y,x_3=P_L,x_4=V_e,x_5=\dot V_e\)，\(\varepsilon_1=x_1-y_d,\varepsilon_2=x_2-\dot y_d\)。则

\[
\dot\varepsilon_1=\varepsilon_2,
\]
\[
\dot\varepsilon_2=-\frac{b}{m}\varepsilon_2+\frac{A_p}{m}x_3-\frac{b}{m}\dot y_d-\ddot y_d+\Delta_2,
\]
\[
\dot x_3=-\frac{2\rho A_p}{V_0}\varepsilon_2-\frac{2\rho A_p}{V_0}\dot y_d+\frac{2\rho\psi(x_4)}{V_0}\sqrt{P_s-|x_3|}+\Delta_3,
\]
\[
\dot x_4=x_5,\qquad
\dot x_5=-\omega_e^2x_4-2\varepsilon_e\omega_e x_5+k_e\omega_e^2u+\Delta_5.
\]

这与 (2) 的三行一致（符号逐项核对通过）。相对阶为 5；从 \(u\) 到 \(y\) 的积分链为 \(x_5\to x_4\to x_3\to x_2\to x_1\)。

**检查点**：\(\Delta_2\) 与 \(\Delta_3\) 进入的通道不含 \(u\)，故相对 \(u\) 是**非匹配**扰动；\(\Delta_5\) 与 \(u\) 同通道，是**匹配**扰动。这一结构决定了必须逐级用 DOB 前馈，不能用单一匹配滑模直接压住全部扰动。

---

## 2. \(\mu(t)\) 的性质与截断

\[
\mu(t)=\frac{1+e^{-t}}{2e^{-t}}=\frac{e^t+1}{2},\qquad \mu(0)=1.
\]
\[
\dot\mu=\frac{e^t}{2}=\mu-\frac12,\qquad
\frac{\dot\mu}{\mu}=1-\frac{1}{2\mu}=\frac{e^t}{e^t+1}.
\]

因此

\[
\frac12<\frac{\dot\mu}{\mu}<1,\qquad \lim_{t\to\infty}\frac{\dot\mu}{\mu}=1,
\]

且 \(\mu\to\infty\)。**没有终端时刻 \(T\)**；\(\mu\) 在任意有限 \(t\) 都有限。

截断 (34)：

\[
\mu(t)=
\begin{cases}
\dfrac{1+e^{-t}}{2e^{-t}},& t\le\delta_t,\\[4pt]
\mu_{\max}=\dfrac{1+e^{-\delta_t}}{2e^{-\delta_t}},& t>\delta_t.
\end{cases}
\]

\(\mu\) 在 \(\delta_t\) 连续，但

\[
\dot\mu(\delta_t^-)=\frac{e^{\delta_t}}{2},\qquad \dot\mu(\delta_t^+)=0.
\]

若控制律显式含 \(\dot\Phi_i\)（而 \(\Phi_i\) 含 \(\mu\) 或 \(\dot\mu/\mu\)），则 \(u\) 在 \(\delta_t\) 可能出现**跳变**。论文只论证“\(\mu\) 有界后状态仍有界”，没有分析这个导数跳变，也没有给出 \(u\) 的连续性/有界性。

**结论**：这不是预设时间变换；\(\mu\) 的时钟是绝对时间，不是 \(T-t\)。截断只防止 \(\mu\) 无界，不产生“到 \(\delta_t\) 收敛”的保证。

---

## 3. 第一步反步：独立求导

令 \(E_1=\mu\varepsilon_1,\ E_2=\mu\varepsilon_2\)。由 \(\dot E_i=\dot\mu\varepsilon_i+\mu\dot\varepsilon_i\)：

\[
\dot E_1=\frac{\dot\mu}{\mu}E_1+E_2. \tag{A}
\]
\[
\dot E_2=\frac{\dot\mu}{\mu}E_2+\mu\left[-\frac{b}{m}\varepsilon_2+\frac{A_p}{m}x_3-\frac{b}{m}\dot y_d-\ddot y_d+\Delta_2\right]
\]
\[
=\left(\frac{\dot\mu}{\mu}-\frac{b}{m}\right)E_2+\frac{A_p}{m}\mu x_3-\mu\left[\ddot y_d+\frac{b}{m}\dot y_d\right]+\mu\Delta_2. \tag{B}
\]

这与 (5) 一致（括号内次序为 \(\ddot y_d+(b/m)\dot y_d\)）。

取

\[
\Phi_1=-\alpha_1E_1,\qquad \bar E_2=E_2-\Phi_1=E_2+\alpha_1E_1,
\]

则 \(E_2=\bar E_2-\alpha_1E_1\)，代入 (A)：

\[
\dot E_1=\left(\frac{\dot\mu}{\mu}-\alpha_1\right)E_1+\bar E_2. \tag{C}
\]

对 \(\bar E_2\) 求导：

\[
\dot{\bar E}_2=\dot E_2-\dot\Phi_1
=\dot E_2+\alpha_1\dot E_1.
\]

逐项展开：

\[
\dot{\bar E}_2=
\left(\frac{\dot\mu}{\mu}-\frac{b}{m}\right)(\bar E_2-\alpha_1E_1)
+\frac{A_p}{m}\mu x_3-\mu\left[\ddot y_d+\frac{b}{m}\dot y_d\right]+\mu\Delta_2
+\alpha_1\left[\left(\frac{\dot\mu}{\mu}-\alpha_1\right)E_1+\bar E_2\right].
\]

合并：

\[
\dot{\bar E}_2=
\left(\frac{\dot\mu}{\mu}-\frac{b}{m}+\alpha_1\right)\bar E_2
+\alpha_1\left(\frac{b}{m}-\alpha_1\right)E_1
+\frac{A_p}{m}\mu x_3-\mu\left[\ddot y_d+\frac{b}{m}\dot y_d\right]+\mu\Delta_2. \tag{D}
\]

**设计目标**：选 \(x_{3d}\) 使

\[
\dot{\bar E}_2=-E_1+\left(\frac{\dot\mu}{\mu}-\frac{b}{m}-\alpha_2\right)\bar E_2-\mu k_2\operatorname{sgn}(\bar E_2)+\mu\Delta_2. \tag{E}
\]

由 (D)=(E) 解出

\[
\frac{A_p}{m}\mu x_{3d}
=-E_1-\left(\alpha_1+\alpha_2+? \right)\bar E_2-\alpha_1\left(\frac{b}{m}-\alpha_1\right)E_1
+\mu\left[\ddot y_d+\frac{b}{m}\dot y_d\right]-\mu k_2\operatorname{sgn}(\bar E_2),
\]

即

\[
x_{3d}=\frac{m}{A_p\mu}\Big\{-\big[1+\alpha_1(b/m-\alpha_1)\big]E_1
-\big(\alpha_1+\alpha_2+\tfrac{\dot\mu}{\mu}-\tfrac{b}{m}\big)\bar E_2
+\mu[\ddot y_d+\tfrac{b}{m}\dot y_d]-\mu k_2\operatorname{sgn}(\bar E_2)\Big\}. \tag{F}
\]

**与印刷式 (8) 的对照**：
- (8) 的结构包含 \(-E_1\)、\(-\big(\dot\mu/\mu-b/m+\alpha_2\big)\bar E_2\)、\(+\mu[\ddot y_d+(b/m)\dot y_d]\)、\(-(\dot\mu/\mu-b/m)\Phi_1+\dot\Phi_1\)、\(-\mu k_2\operatorname{sgn}(\bar E_2)\)，并冠以 \((A_p/m)^{-1}\)。
- 由独立推导，**前置因子必须是 \(m/(A_p\mu)\)（含 \(1/\mu\)）**，否则 (9) 中 \((A_p/m)\mu x_3\) 不能与 \(\mu\) 抵消。页面图像上 \((A_p/m)^{-1}\) 是否漏印 \(\mu\)，字号过小，列为待核 O1。
- 印刷式的 \(-\big(\dot\mu/\mu-b/m\big)\Phi_1+\dot\Phi_1\) 与我的展开在符号/归并方式上不同（我把 \(\Phi_1\) 完全展开成 \(E_1,\bar E_2\)）。两种写法可以等价，但必须逐项核对；在未核对前，不能把 (8) 当作已独立验证的公式。

**关键点**：不论 (8) 的具体写法如何，只要闭环 (9) 确实化为 (E)，则 \(V_2=\tfrac12E_1^2+\tfrac12\bar E_2^2\) 的导数可独立核对：

\[
\dot V_2=
\left(\frac{\dot\mu}{\mu}-\alpha_1\right)E_1^2
+\left(\frac{\dot\mu}{\mu}-\frac{b}{m}-\alpha_2\right)\bar E_2^2
-\mu k_2|\bar E_2|+\mu\bar E_2\Delta_2. \tag{G}
\]

交叉项 \(E_1\bar E_2\) 精确抵消（这是反步设计的核心）。若 \(k_2\ge|\Delta_2|\)，则

\[
-\mu k_2|\bar E_2|+\mu\bar E_2\Delta_2\le0,
\]
\[
\dot V_2\le
\left(\frac{\dot\mu}{\mu}-\alpha_1\right)E_1^2
+\left(\frac{\dot\mu}{\mu}-\frac{b}{m}-\alpha_2\right)\bar E_2^2. \tag{H}
\]

由于 \(\dot\mu/\mu<1\)，条件

\[
\alpha_1>1,\qquad \alpha_2>1-\frac{b}{m} \tag{I}
\]

保证两个系数严格负。于是

\[
\dot V_2\le -2c_2V_2,\qquad
c_2=\min\left(\alpha_1-\frac{\dot\mu}{\mu},\ \alpha_2+\frac{b}{m}-\frac{\dot\mu}{\mu}\right)>0. \tag{J}
\]

**这是指数收敛，不是有限时间收敛。** 若要有限时间，需要 \(\dot V\le-cV^\rho\)（\(\rho<1\)）；这里是指数型 \(\dot V\le-cV\)。论文没有给出任何分数幂的跟踪误差不等式。

---

## 4. 中段与末级反步（结构核对）

后续三级结构相同：

- \(x_{3d}=\Phi_2\) 使 \(\dot{\bar E}_2\) 含 \(-E_1\) 与 \(-\alpha_2\bar E_2\)；
- \(x_{4d}=\Phi_3\) 使 \(\tilde x_3=x_3-\Phi_2\) 的动力学含 \(-\bar E_2\) 与 \(-\alpha_3\tilde x_3\)；
- \(x_{5d}=\Phi_4\) 使 \(\tilde x_4=x_4-\Phi_3\) 的动力学含 \(-\tilde x_3\) 与 \(-\alpha_4\tilde x_4\)；
- \(u\) 使 \(\tilde x_5=x_5-\Phi_4\) 的动力学含 \(-\tilde x_4\) 与 \(-\alpha_5\tilde x_5\)。

逐级 Lyapunov：

\[
V_3=V_2+\tfrac12\tilde x_3^2,\quad
V_4=V_3+\tfrac12\tilde x_4^2,\quad
V_5=V_4+\tfrac12\tilde x_5^2.
\]

在已知界 \(|\Delta_i|<k_i\) 的情形（Lemma 1），每级加入 \(-k_i|\tilde x_i|\) 项，交叉项逐级抵消，最终

\[
\dot V_5\le
\left(\frac{\dot\mu}{\mu}-\alpha_1\right)E_1^2
+\left(\frac{\dot\mu}{\mu}-\frac{b}{m}-\alpha_2\right)\bar E_2^2
-\alpha_3\tilde x_3^2-\alpha_4\tilde x_4^2-\alpha_5\tilde x_5^2. \tag{K}
\]

若 (I) 成立，则 \(\dot V_5\le-2c_5V_5\)，仍是**指数收敛**。

**导数阶数与实现**：
- \(\Phi_2\) 含 \(\dot y_d,\ddot y_d,\dot\Phi_1\)；
- \(\Phi_3\) 含 \(\dot\Phi_2\)，从而含 \(\dddot y_d\)；
- \(\Phi_4\) 含 \(\dot\Phi_3\)，从而含 \(y_d^{(4)}\) 与 \(\dot{\hat\Delta}_2,\dot{\hat\Delta}_3\)；
- \(u\) 含 \(\dot\Phi_4\)，从而含 \(y_d^{(4)}\) 及 \(\ddot{\hat\Delta}\) 类项。

论文只声明参考为 \(y_d,\dot y_d\)，**没有列出参考信号所需的光滑性阶数**。仿真用 \(\sin t,\cos t\)，所以不暴露该问题；对一般参考，若 \(y_d^{(3)},y_d^{(4)}\) 不存在或不连续，反步控制律无定义。列入 O6。

**\(\hat\Delta_i\) 的导数奇异**：由 (16)，

\[
\dot{\hat\Delta}_i=-\alpha_i\operatorname{sgn}(s_i)-\beta\frac{q}{p}\varepsilon_i^{q/p-1}\dot\varepsilon_i.
\]

因 \(q<p\)，\(q/p-1<0\)，当 \(\varepsilon_i\to0\) 时 \(\varepsilon_i^{q/p-1}\to\infty\)。若反步对含 \(\hat\Delta_i\) 的 \(\Phi_i\) 求导，\(\dot{\hat\Delta}_i\) 在观测收敛点附近**可能奇异/无界**。论文没有讨论这个奇异性，也没有说明 \(\dot\Phi_i\) 是解析求导还是数值微分。这是实现层面的重要缺口（O4）。

---

## 5. 观测器定理 1：逐行核对

### 5.1 从 (17) 出发的真实误差动态

由 (17) 与 (2) 相减（假设 \(x_3,x_4\) 可测，且 \(u\) 相同）：

\[
\dot\varepsilon_2=\dot{\hat x}_2-\dot x_2
=-\frac{b}{m}\varepsilon_2+\hat\Delta_2-\Delta_2. \tag{L2}
\]
\[
\dot\varepsilon_3=\dot{\hat x}_3-\dot x_3
=-\frac{2\rho A_p}{V_0}\varepsilon_2+\hat\Delta_3-\Delta_3. \tag{L3}
\]
\[
\dot\varepsilon_5=\dot{\hat x}_5-\dot x_5
=-2\varepsilon_e\omega_e\varepsilon_5+\hat\Delta_5-\Delta_5. \tag{L5}
\]

其中 (L3) 假定流量项中的 \(x_3,V_e\) 可测，误差只通过 \(\hat x_2\) 进入；若 \(x_3\) 不可测而由 \(\hat x_3\) 替代，还会多出流量非线性差项。

### 5.2 论文的 (19)–(21) 要求什么

论文定义 \(s_i=\varepsilon_i+\beta\varepsilon_i^{q/p}\)，\(V_i=\tfrac12s_i^2\)，然后写

\[
\dot s_i=\varepsilon_i+\beta\frac{q}{p}\varepsilon_i^{q/p-1}\dot\varepsilon_i
\quad\text{（印刷式 (19) 在左侧多乘了一个 }s_i\text{）}
\]

并直接给出

\[
\dot s_i=-\alpha_i\operatorname{sgn}(s_i)-\tilde\Delta_i
\quad\text{（印刷式 (20) 同样多乘了 }s_i\text{）}.
\]

要让 (20) 成立，必须有

\[
\dot\varepsilon_i=-\alpha_i\operatorname{sgn}(s_i)-\tilde\Delta_i. \tag{M}
\]

但 (L2)–(L5) 的真实右端分别是

\[
-\frac{b}{m}\varepsilon_2+\tilde\Delta_2,\qquad
-\frac{2\rho A_p}{V_0}\varepsilon_2+\tilde\Delta_3,\qquad
-2\varepsilon_e\omega_e\varepsilon_5+\tilde\Delta_5.
\]

它们都**多出线性/耦合项**，不是 (M)。论文说“after substituting ... and some simplification”，但没有说明这些项如何被吸收。可能的修补：

- 通道 2：\(-(b/m)\varepsilon_2\) 是耗散项（若 \(b>0\)），可帮助稳定，但不能直接丢掉；
- 通道 5：\(-2\varepsilon_e\omega_e\varepsilon_5\) 也是耗散项；
- 通道 3：\(-(2\rho A_p/V_0)\varepsilon_2\) 是**耦合项**，不是 \(\varepsilon_3\) 的耗散项；需要级联/ISS 论证：先证 \(\varepsilon_2\) 有限时间小，再把 \(\varepsilon_2\) 当作 \(\varepsilon_3\) 的输入。论文没有做这个论证。

**结论**：定理 1 的证明按印刷内容**不闭合**。有限时间观测器的结论可能是对的（这类积分符号观测器在文献中常见），但本文展示的推导不足以证明它。

### 5.3 印刷式的两个明显笔误

(19) 左侧是 \(\dot s_i\)，右侧却写成 \(s_i(\dot\varepsilon_i+\beta\frac{q}{p}\varepsilon_i^{q/p-1}\dot\varepsilon_i)\)。按字面，\(\dot s_i\) 被等于 \(s_i\) 乘一个导数，量纲/结构都不对。合理的读法是

\[
\dot s_i=\dot\varepsilon_i+\beta\frac{q}{p}\varepsilon_i^{q/p-1}\dot\varepsilon_i
=\left(1+\beta\frac{q}{p}\varepsilon_i^{q/p-1}\right)\dot\varepsilon_i.
\]

(20) 同理，合理读法是 \(\dot s_i=-\alpha_i\operatorname{sgn}(s_i)-\tilde\Delta_i\)，而不是 \(\dot s_i=s_i(\cdots)\)。

这两个笔误不影响 (21) 的后续不等式（(21) 用的是 \(V_i=s_i^2/2\)、\(\dot V_i=s_i\dot s_i\)），但说明该段排版/校对不可靠，引用时必须按修正后的结构理解。

### 5.4 时间与邻域

在 (M) 成立且 \(\alpha_i\) 为常数、\(\alpha_i>\sigma_i\) 的假设下：

\[
\dot V_i=s_i\dot s_i\le-\alpha_i|s_i|+|\tilde\Delta_i||s_i|
\le-(\alpha_i-\sigma_i)|s_i|=-(\alpha_i-\sigma_i)\sqrt{2V_i}.
\]

于是

\[
\sqrt{V_i(t)}\le\sqrt{V_i(0)}-\frac{\alpha_i-\sigma_i}{\sqrt2}t,
\]
\[
T_i=\frac{\sqrt{2V_i(0)}}{\alpha_i-\sigma_i}
=\frac{|s_i(0)|}{\alpha_i-\sigma_i}. \tag{N}
\]

若要停在 \(|s_i|=\alpha_i^{-1}(\sigma_i)=:r_i\)，则

\[
T_i(r_i)=\frac{|s_i(0)|-r_i}{\alpha_i-\sigma_i}. \tag{O}
\]

页面图像上 (21) 之后给出的 \(t_i\) 是一个分式；按上式应为 (O)。**但论文同时把 \(\alpha_i(\cdot)\) 定义为 class-K 函数**：若 \(\alpha_i\) 随 \(|s_i|\) 变，则

\[
T_i=\int_{r_i}^{|s_i(0)|}\frac{ds}{\alpha_i(s)-\sigma_i}, \tag{P}
\]

一般无闭式。论文没有说清 (N)/(O)/(P) 哪一个是其定理中的 \(t_i\)。列入 O2。

**内部矛盾**：若 \(\alpha_i\) 是常数且 \(\alpha_i>\sigma_i\)，(N) 给出 \(s_i\to0\) 的**精确有限时间**，比论文声称的“\(|s_i|\le\alpha_i^{-1}(\sigma_i)\) 的 FTUB”更强；若 \(\alpha_i\) 是 class-K，则只能得到邻域 (P)。论文把两种情形混在一起，定理 1 的“FTUB + 时间”陈述需要重新写清。

---

## 6. 定理 2 的 \(V_5\) 关键步骤（决定位置跟踪结论）

### 6.1 最终不等式

论文 (31)（p.6 底部）的形式为

\[
\dot V_5=
\left(\frac{\dot\mu}{\mu}-\alpha_1\right)E_1^2
+\left(\frac{\dot\mu}{\mu}-\frac{b}{m}-\alpha_2\right)\bar E_2^2
-\alpha_3\tilde x_3^2-\alpha_4\tilde x_4^2-\alpha_5\tilde x_5^2
-|\tilde x_3|\Theta_5-\big(|\tilde x_3|\Delta_5-\tilde x_3\hat\Delta_5\big). \tag{Q}
\]

（下标 3/5 在页面图像上不易区分；按上下文，最后一项应为 \(\tilde x_5,\Delta_5,\hat\Delta_5\)。列入 O3。）

### 6.2 交叉项与残差逐项处理

**(a) \(E_1\bar E_2\) 交叉项**：由 (E) 的设计精确抵消，已在 (G) 核对。

**(b) 各级 \(\tilde x_i\) 交叉项**：每一级虚拟控制都含上一级误差的负反馈（\(-\bar E_2,-\tilde x_3,-\tilde x_4\)），逐级相乘后抵消，剩下纯负二次项。这与 (K) 的结构一致。

**(c) 扰动残差**：设 \(\tilde\Delta_5=\hat\Delta_5-\Delta_5\)。则

\[
|\tilde x_5|\Delta_5-\tilde x_5\hat\Delta_5
=|\tilde x_5|\Delta_5-\tilde x_5\Delta_5-\tilde x_5\tilde\Delta_5
=\Delta_5\big(|\tilde x_5|-\tilde x_5\big)-\tilde x_5\tilde\Delta_5. \tag{R}
\]

- 若 \(\Delta_5\ge0\)：\(|\tilde x_5|-\tilde x_5\ge0\)，故 (R) \(\ge-\tilde x_5\tilde\Delta_5\ge-|\tilde x_5||\tilde\Delta_5|\)。于是
  \[
  -|\tilde x_5|\Theta_5-(R)\le-|\tilde x_5|\big(\Theta_5-|\tilde\Delta_5|\big)\le0
  \quad\text{若 }\Theta_5\ge|\tilde\Delta_5|. \tag{S}
  \]
- 若 \(\Delta_5<0\)：\(|\tilde x_5|-\tilde x_5\in[0,2|\tilde x_5|]\)，故 (R) \(\le 2|\Delta_5||\tilde x_5|+|\tilde x_5||\tilde\Delta_5|\)，需要
  \[
  \Theta_5\ge 2|\Delta_5|+|\tilde\Delta_5| \tag{T}
  \]
  才能保证同样的负号。

**论文只写了 \(\Theta_5\gg\alpha_5^{-1}(\sigma_5)\)，没有声明 \(\Delta_5\ge0\)，也没有给 (T) 的因子 2。** 这是定理 2 的一个符号条件缺口（O5）。若实际扰动/偏置可正可负，鲁棒裕度必须按 (T) 取值，论文的条件不足。

**(d) “\(\gg\)” 不是严格不等式**：定理 2 的条件写作 \(\Theta_2\gg\alpha_2^{-1}(\sigma_2)\) 等，并在页 6 明确说 “\(\gg\) is a much greater than symbol”。证明中实际只用到 \(\Theta_i>\alpha_i^{-1}(\sigma_i)\)（即严格大于）。把“远大于”写进定理假设不是标准做法，也无法在 \(\sigma_i\) 未知时验证。列入 O7。

**(e) 观测收敛前的时间段**：在 \(t<T_i\) 时，\(\tilde\Delta_i\) 可能大于 \(\Theta_i\)，(S) 不成立。论文用 \(k_i\operatorname{sgn}\) 项处理已知界情形（Lemma 1），但在 Theorem 2 的 DOB 版本中，前 \(T_i\) 段的闭环有界性没有被单独证明。严格证明需要：先由 Lemma 1 型的 \(k_i\) 保证前段有界，再在 \(t\ge T_i\) 切换到 (S)。论文的证明顺序没有明确区分这两个时间段。列入 O8。

### 6.3 由 \(V_5\) 能得到什么

若 (I) 与 (S)（或 (T)）成立，则

\[
\dot V_5\le-2c_5V_5,\qquad
c_5=\min\left(\alpha_1-\frac{\dot\mu}{\mu},\ \alpha_2+\frac{b}{m}-\frac{\dot\mu}{\mu},\ \alpha_3,\alpha_4,\alpha_5\right)>0. \tag{U}
\]

因此 \(V_5(t)\le V_5(0)e^{-2c_5t}\)，所有误差**指数收敛到 0**（在观测收敛后）。这比论文声称的“bounded”更强，但**仍然不是有限时间**。

**注意**：若 \(V_5\) 中某个误差不可控（例如观测器误差在 \(t<T_i\) 很大），(U) 只对 \(t\ge T_i\) 成立；全局结论应为“前段有界 + 后段指数收敛”，不是全局指数收敛。论文没有明确写出这个分段。

---

## 7. 真实位置误差的最终结论

由 \(E_1=\mu\varepsilon_1\)：

\[
|\varepsilon_1(t)|=\frac{|E_1(t)|}{\mu(t)}
\le\frac{\sqrt{2V_5(t)}}{\mu(t)}
\le\frac{\sqrt{2V_5(0)}\,e^{-c_5t}}{\mu(t)}. \tag{V}
\]

因 \(\mu(t)=(e^t+1)/2\ge1\)，即使去掉 \(\mu\)，\(|E_1|\to0\) 也已保证 \(|\varepsilon_1|\to0\)。时间变换的额外作用是让 \(\varepsilon_1\) 多一个 \(1/\mu\sim2e^{-t}\) 的因子，即把衰减率从 \(c_5\) 提高到约 \(c_5+1\)。**这不是有限时间**。

对任意目标半径 \(r>0\)，存在有限时刻

\[
t(r)\approx\frac{1}{c_5+1}\ln\frac{2\sqrt{2V_5(0)}}{r} \tag{W}
\]

使 \(|\varepsilon_1|\le r\)。但 \(t(r)\) 依赖 \(V_5(0)\)（初值、未知扰动界、观测初值）与 \(c_5\)，**不能事先指定**，也不是论文中的任何 \(T\)。

**因此**：
- “精确有限时间位置跟踪”：**未建立**。
- “有限时间进入任意小邻域”：在 FTUB 的弱意义上成立（指数收敛的推论），但论文没有给出这个精确表述；其定理文字“in a finite time”没有对应的有限时间不等式。
- “预设时间”：**未建立**，且方法结构不含 \(T\)。

---

## 8. 未闭合/待核对清单（按优先级）

| 编号 | 问题 | 位置 | 影响 | 建议 |
|---|---|---|---|---|
| O1 | (8) 的前置因子是否含 \(1/\mu\)、\(\bar E_2\) 系数是否含 \(\alpha_2\) | p.4, (8) | 决定 (9) 是否成立 | 用原图高倍放大逐字核对；按 (F) 独立复算 |
| O2 | 定理 1 的 \(t_i\) 是 (N)、(O) 还是 (P)；\(\alpha_i\) 是常数还是 class-K | p.5, (21) 后 | 决定“有限时间”是精确还是邻域 | 要求作者给出 \(\alpha_i\) 定义与积分表达式 |
| O3 | (31) 的下标是 \(\tilde x_3\) 还是 \(\tilde x_5\) | p.6, (31) | 末级证明的对象 | 原图核对 |
| O4 | \(\dot{\hat\Delta}_i\) 含 \(\varepsilon^{q/p-1}\)，在 \(\varepsilon=0\) 奇异 | p.5, (16) | 反步求导可能无界/抖振 | 需给出正则化或避免对 \(\hat\Delta\) 求导 |
| O5 | 残差界 (S) 仅在 \(\Delta_i\ge0\) 时成立；负扰动需 (T) 的因子 2 | p.6, (31)–(33) | 定理 2 的鲁棒裕度条件不足 | 明确 \(\Delta_i\) 符号或改 \(\Theta_i\) 条件 |
| O6 | 参考 \(y_d\) 所需导数阶数未声明（至少到 \(y_d^{(4)}\)） | p.3–5 | 一般参考下控制律可能无定义 | 补 \(C^4\) 类假设 |
| O7 | \(\Theta_i\gg\alpha_i^{-1}(\sigma_i)\) 依赖未知 \(\sigma_i\)，“\(\gg\)”非严格 | p.5–6 | 条件不可先验验证 | 改为存在性陈述或给出自适应 \(\Theta\) |
| O8 | 观测收敛前 \(t<T_i\) 的闭环有界性未分段证明 | p.5–7 | 全局有界性不完整 | 先 Lemma 1 后 Theorem 2 分段 |
| O9 | 输入 \(u\) 的有界性未证明；饱和未进入定理 | p.5, (22)；p.10 结论 | 硬件实现风险 | 单独分析 \(\sup|u|\) 或加饱和证明 |
| O10 | 截断 \(\delta_t\) 处 \(\dot\mu\) 跳变 → \(u\) 可能跳变 | p.7, (34) | 实现/平滑性 | 检查 \(\dot\Phi_i\) 中 \(\dot\mu\) 项 |
| O11 | \(x_3\) 可测却又估计 \(x_3\)；传感器集合不一致 | p.5, (17) | 观测器结构/状态台账 | 明确 \(\hat x_3\) 是否冗余 |
| O12 | Definition 1/2 排版含混（\(t\in[0,T]\) vs \(t\ge T\)） | p.3 | 定义基础 | 原图核对 |
| O13 | Table 1 无 \(b\)；增益条件含 \(b/m\) | p.7 | 数值可复现性 | 补 \(b\) 的仿真取值 |
| O14 | \(J_e\) 的“infinity norm”与积分定义不一致 | p.9, Table 2 | 指标解释 | 按公式重算 |

---

## 9. 数值自检

1. **\(\dot\mu/\mu\)**：
   - \(t=0\)：\(\mu=1\)，\(\dot\mu/\mu=1/2\)；
   - \(t=1\)：\(e/(e+1)=0.7311\)；
   - \(t=10\)：\(e^{10}/(e^{10}+1)=0.99995\)。
   与 (4) 后的 \(1/2<\dot\mu/\mu<1\) 一致。

2. **30% 指标**：
   \[
   1-\frac{454.3921}{643.2316}=0.2936,
   \]
   即 29.36%，与文中 “almost 30%” 一致。但这是作者仿真值，不是定理推论。

3. **指数收敛率**：若 \(\alpha_1=2,\alpha_2=1,b/m=0.5\)，则
   \[
   c_2=\min(2-0.5,\ 1+0.5-0.5)=1,
   \]
   \(V_2\le V_2(0)e^{-2t}\)，幅值按 \(e^{-t}\) 衰减；加 \(\mu\) 后约 \(e^{-2t}\)。仍是渐近，不是有限时间。

4. **有限时间公式**：常增益下 \(T_i=|s_i(0)|/(\alpha_i-\sigma_i)\)；若 \(\alpha_i=2,\sigma_i=1,s_i(0)=0.1\)，则 \(T_i=0.1\) s。与作者报告的 0.168 s、0.1 s、0.0005 s 同量级，但作者未给 \(\alpha_i,\sigma_i\) 的具体值，无法逐一复核。

5. **输入量级**：Fig. 5 峰值约 20 V、稳态约 \(\pm15\) V。按 Table 1 的 \(k_e\omega_e^2\) 无法反推（\(k_e\) 未在表中列出），只能确认仿真未饱和。

---

## 10. 结论（证明层面）

1. 从对象方程到误差方程 (2)/(5) 的推导**正确**。
2. 第一步反步的交叉项抵消与 \(V_2\) 负定性**正确**，但 (8) 的具体系数/前置因子需要原图复核；按独立推导应含 \(1/\mu\) 与 \(\alpha_2\)。
3. 闭环跟踪误差由 \(\dot V\le-cV\) 得**指数收敛**，**没有**有限时间不等式；题目中的 “finite time” 对位置跟踪不成立（除非把 FTUB 的弱意义也算作“有限时间”）。
4. 观测器定理 1 的证明**不闭合**：真实误差动态的线性/耦合项被丢掉，(19)(20) 还有印刷笔误；有限时间观测器结论需重新证明。
5. 定理 2 的 \(V_5\) 末级在“\(\Delta_i\ge0\)、\(\Theta_i>\alpha_i^{-1}(\sigma_i)\)、观测已收敛”的条件下可给出指数收敛；对负扰动、收敛前时间段、输入有界性均未覆盖。
6. 预设时间性质：**未建立**；全文无终端 \(T\)，\(\mu\) 只随绝对时间增长。
