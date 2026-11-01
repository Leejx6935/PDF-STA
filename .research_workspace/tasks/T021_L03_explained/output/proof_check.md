# L03 关键证明独立复核

**对象**：Razmjooei, Palli, Nazari, *Disturbance observer-based nonlinear feedback control for position tracking of electro-hydraulic systems in a finite time*, European Journal of Control 67 (2022) 100659, pp. 1–11. DOI: 10.1016/j.ejcon.2022.100659.

**复核范围**：由式 (2)(16)(17) 重推观测误差与滑模动力学，检查式 (19)–(21) 的条件；复核式 (35)、定理 2 的 Case 1/2 与时间变换。原文页码与式号按出版版标注。

**证据口径**：MinerU 缓存 `doc:8720803/tier:standard` 全文 11 页；PDF 第 3–7 页原图已目视核对。本文所有“原文”均指这两条路径能直接看到的印刷式；“我的解释/复算”另行标明。未运行任何仿真，未复现作者数值。

---

## 0. 结论摘要

1. 由 (16)(17) 与 (2) 相减，观测误差动力学含三个漂移项：\(-\frac{b}{m}\dot e_2\)、\(-\frac{2\rho A_p}{V_0}\dot e_2\)、\(-2\epsilon_v\omega_{nv}\dot e_5\)。式 (20) 把这些项全部置零后才成立。
2. 原文的“假设 \(\ddot{\hat x}_i=\ddot x_i\)”等价于令 \(\ddot e_i=0\)。它不只是“丢掉线性项”，而是把待估误差的二阶导数设为零；同时 (20) 还把代入式给出的 \(\dot{\hat\Delta}_i\) 换成了 \(\dot\Delta_i\)。两处替换合在一起，才对实际轨迹成立需要额外条件。
3. 式 (21) 的 \( -(\alpha_i-\sigma_i)|s_i|\) 在 (20) 成立时是对的；但真实系统还多出 \(|d_i||s_i|\)，其中 \(d_3\) 依赖 \(\dot e_2\)，三个通道并不解耦。
4. 式 (35) 的 \(| \dot e_i | = |\hat\Delta_i-\Delta_i|\) 只在零漂移下成立；\(|\dot e_i|\le|s_i|\) 一般也不成立。可给瞬时代数反例：\(e=216,\ \dot e=-5,\ \beta=1,\ q/p=1/3\)，则 \(s=1\)，\(|\dot e|=5>|s|=1\)。
5. \(\mu(t)=(e^{t/\tau}+1)/2\) 在有限时刻不发散，全文没有终端 \(T\)。由 \(|E|\) 的指数界只能得到 \(|\bar e|\) 的指数界，不能推出精确有限时间；截断 (34) 后 \(1/\mu\) 的附加衰减也消失。
6. 定理 2 的最坏符号情形（\(\tilde x_i<0,\ \Delta_i=\hat\Delta_i=-D<0\)）给出残差 \(2D-\bar\Theta_i\)。要压住它需 \(\bar\Theta_i>2|\Delta_i|\)，而不只是 \(\bar\Theta_i\gg\alpha_i^{-1}(\sigma_i)\)。这与“不需要扰动上界”的主张冲突。
7. \(\mu\) 的记账在 (8) 与 (9)(10)(23)(24) 之间不一致；旧报告 O15 的方向正确，但它说 (9)(10)(11) 彼此自洽，这一点按原图不成立：压力项还差 \(1/\mu\)。

---

## 1. 记号与原文定位

状态取 \(x_1=y,\ x_2=\dot y,\ x_3=P_L,\ x_4=v_e,\ x_5=\dot v_e\)。对象 (1)(2)（p.2–3）：

\[
\dot x_1=x_2,\qquad
\dot x_2=-\frac{b}{m}x_2+\frac{A_p}{m}x_3+\Delta_2,
\]
\[
\dot x_3=-\frac{2\rho A_p}{V_0}x_2+
\frac{2\rho k_q\sqrt{P_s-|x_3|}}{V_0}x_4+\Delta_3,
\]
\[
\dot x_4=x_5,\qquad
\dot x_5=-\omega_{nv}^2x_4-2\epsilon_v\omega_{nv}x_5+k_e\omega_{nv}^2u+\Delta_5.
\]

其中
\[
\Delta_2=-\frac{F_f(\dot y)}{m}+\eta_y,\quad
\Delta_3=\frac{2\rho(\Psi(x_4)-k_qx_4)\sqrt{P_s-|x_3|}}{V_0}+\eta_{P_L},\quad
\Delta_5=\omega_{nv}^2v_{e0}+\eta_{v_e}.
\]

观测器 (17)（p.5）：
\[
\dot{\hat x}_2=-\frac{b}{m}\hat x_2+\frac{A_p}{m}x_3+\hat\Delta_2,
\]
\[
\dot{\hat x}_3=-\frac{2\rho A_p}{V_0}\hat x_2+
\frac{2\rho k_q\sqrt{P_s-|x_3|}}{V_0}x_4+\hat\Delta_3,
\]
\[
\dot{\hat x}_5=-\omega_{nv}^2x_4-2\epsilon_v\omega_{nv}\hat x_5+k_e\omega_{nv}^2u+\hat\Delta_5.
\]

注意：\(x_3,x_4\) 被原文明确当作可测量；\(x_2,x_5\) 由观测器给出。式 (17) 的第一、三式用 \(x_3,x_4\) 的真值，因此相减时这两项的模型差为零，只剩 \(\Delta_i\) 与 \(\hat\Delta_i\)。

---

## 2. 观测误差动力学（保留漂移差）

定义 \(e_i=\hat x_i-x_i\)。逐式相减：

\[
\boxed{\dot e_2=-\frac{b}{m}e_2+\hat\Delta_2-\Delta_2}
\tag{L2}
\]
\[
\boxed{\dot e_3=-\frac{2\rho A_p}{V_0}e_2+\hat\Delta_3-\Delta_3}
\tag{L3}
\]
\[
\boxed{\dot e_5=-2\epsilon_v\omega_{nv}e_5+\hat\Delta_5-\Delta_5}
\tag{L5}
\]

这三式是后面所有论证的底稿。它们与原文式 (17)−(2) 一致；旧报告式 (L) 也给出同样结果。

再对 (16) 求导。式 (16) 为（p.5）
\[
\hat\Delta_i(t)=-\int_0^t\alpha_i\,\mathrm{sgn}\!\left(\dot e_i+\beta e_i^{q/p}\right)d\sigma-\beta e_i^{q/p}.
\tag{16}
\]

在 \(e_i\ne0\) 时，
\[
\boxed{\dot{\hat\Delta}_i=-\alpha_i\,\mathrm{sgn}(s_i)-\beta\frac{q}{p}e_i^{q/p-1}\dot e_i}
\tag{D16}
\]
其中
\[
s_i=\dot e_i+\beta e_i^{q/p}.
\tag{S}
\]

\(q<p\) 且 \(q/p<1\)，所以 \(q/p-1<0\)。当 \(e_i\to0\) 时 \(e_i^{q/p-1}\to\infty\)。式 (D16) 在 \(e_i=0\) 处没有经典意义；这是 (16) 的光滑性缺口，后面还要用到。

---

## 3. 滑模动力学的精确形式

由 (S) 求导：
\[
\dot s_i=\ddot e_i+\beta\frac{q}{p}e_i^{q/p-1}\dot e_i.
\]

把 (D16) 代入：
\[
\dot s_i=\ddot e_i-\alpha_i\,\mathrm{sgn}(s_i)-\dot{\hat\Delta}_i.
\tag{S1}
\]

再对 (L2)(L3)(L5) 求导：
\[
\ddot e_2=-\frac{b}{m}\dot e_2+\dot{\hat\Delta}_2-\dot\Delta_2,
\]
\[
\ddot e_3=-\frac{2\rho A_p}{V_0}\dot e_2+\dot{\hat\Delta}_3-\dot\Delta_3,
\]
\[
\ddot e_5=-2\epsilon_v\omega_{nv}\dot e_5+\dot{\hat\Delta}_5-\dot\Delta_5.
\]

代入 (S1)，\(\dot{\hat\Delta}_i\) 恰好抵消，得到**精确**的滑模动力学：

\[
\boxed{\dot s_2=-\alpha_2\,\mathrm{sgn}(s_2)-\dot\Delta_2-\frac{b}{m}\dot e_2}
\tag{S2}
\]
\[
\boxed{\dot s_3=-\alpha_3\,\mathrm{sgn}(s_3)-\dot\Delta_3-\frac{2\rho A_p}{V_0}\dot e_2}
\tag{S3}
\]
\[
\boxed{\dot s_5=-\alpha_5\,\mathrm{sgn}(s_5)-\dot\Delta_5-2\epsilon_v\omega_{nv}\dot e_5}
\tag{S5}
\]

于是
\[
\dot V_i=s_i\dot s_i
=-\alpha_i|s_i|-s_i\dot\Delta_i-s_i d_i,
\tag{V-EXACT}
\]
其中
\[
d_2=\frac{b}{m}\dot e_2,\qquad
d_3=\frac{2\rho A_p}{V_0}\dot e_2,\qquad
d_5=2\epsilon_v\omega_{nv}\dot e_5.
\]

**这是本节的核心。** 原文式 (20)（p.5）写的是
\[
\dot V_i=s_i\left(-\alpha_i\,\mathrm{sgn}(s_i)-\dot\Delta_i\right),
\tag{20}
\]
即 (V-EXACT) 中 \(d_i=0\) 的特例。

---

## 4. 式 (20) 需要什么条件

### 4.1 “\(\ddot{\hat x}_i=\ddot x_i\)”的准确含义

原文在 (20) 之后写：“it is assumed that \(\ddot{\hat x}_i=\ddot x_i\)”（p.5，原图可辨）。由 \(e_i=\hat x_i-x_i\)，这就是
\[
\ddot e_i=0.
\]

代入 (L2)(L3)(L5) 的导数：
\[
0=-\frac{b}{m}\dot e_2+\dot{\hat\Delta}_2-\dot\Delta_2
\;\Longrightarrow\;
\dot{\hat\Delta}_2-\dot\Delta_2=\frac{b}{m}\dot e_2,
\]
\[
0=-\frac{2\rho A_p}{V_0}\dot e_2+\dot{\hat\Delta}_3-\dot\Delta_3
\;\Longrightarrow\;
\dot{\hat\Delta}_3-\dot\Delta_3=\frac{2\rho A_p}{V_0}\dot e_2,
\]
\[
0=-2\epsilon_v\omega_{nv}\dot e_5+\dot{\hat\Delta}_5-\dot\Delta_5
\;\Longrightarrow\;
\dot{\hat\Delta}_5-\dot\Delta_5=2\epsilon_v\omega_{nv}\dot e_5.
\]

所以“\(\ddot e_i=0\)”并不是“线性项为零”这么弱；它把漂移差与扰动估计差的导数绑在一起。若进一步要求 (20) 中的 \(\dot\Delta_i\) 就是代入式里的 \(\dot{\hat\Delta}_i\)，还要
\[
\dot{\hat\Delta}_i=\dot\Delta_i,
\]
两式合起来给出 \(\dot e_i=0\)（各通道系数非零时）。也就是说，**同时**施加“\(\ddot e_i=0\)”和“\(\dot{\hat\Delta}_i=\dot\Delta_i\)”，在非零误差轨迹上会强制 \(\dot e_i=0\)，进而 \(e_i\) 为常数；这与 (16) 的积分修正机制不相容，除非误差恰好落在一条非一般的流形上。

### 4.2 两种读法

- **逐点读法**：作者只是在某一步“暂时”令 \(\ddot e_i=0\)，以便把 (19) 化成 (20)。那么 (20) 只是该点上的恒等式，不能对整条实际轨迹积分成 (21)。要得到 (21)，必须证明 \(\ddot e_i=0\) 在所需时间段内成立；原文没有。
- **全局读法**：把 \(\ddot e_i=0\) 当作全局假设。由上面的推导，它迫使 \(\dot e_i=0\)、\(e_i\) 常数；这不是 (17) 的通解，也不能由 \(|\dot\Delta_i|<\sigma_i\) 推出。

两种读法都停在同一个缺口：**(20) 不是由 (16)(17)(2) 推出的恒等式，而是附加了未证明的误差加速度条件。**

### 4.3 正确的界

保留 \(d_i\)，在 \(|\dot\Delta_i|<\sigma_i\) 下：
\[
\dot V_i\le-\alpha_i|s_i|+\sigma_i|s_i|+|d_i||s_i|
=-\left(\alpha_i-\sigma_i-|d_i|\right)|s_i|.
\tag{V-DRIFT}
\]

要得到 \(\dot V_i<0\)，需要
\[
\alpha_i>\sigma_i+|d_i|.
\tag{C-DRIFT}
\]

这与原文 (21) 的 \(\alpha_i>\sigma_i\) 不同。由于 \(\sigma_i\) 已经未知，\(|d_i|\) 又依赖 \(\dot e_i\)，条件 (C-DRIFT) 不是先验可验证的。

**通道 3 还有结构问题。** \(d_3\) 依赖 \(\dot e_2\)，而 \(\dot e_2\) 属于另一个通道：
\[
\dot e_2=s_2-\beta e_2^{q/p}.
\]
所以 \(|d_3|\le\frac{2\rho A_p}{V_0}(|s_2|+\beta|e_2|^{q/p})\)。要压住它，先要 \(e_2\) 有界、\(s_2\) 有界；这正是定理 1 要证明的东西。原文把 \(i=2,3,5\) 当作三个独立的标量系统处理，实际是级联系统。旧报告只指出“漂移项被丢掉”，没有指出通道 3 的耦合；这里补上。

---

## 5. 式 (19)–(21) 的条件逐项检查

### 5.1 (19) 本身

式 (19)（p.5）：
\[
\dot V_i=s_i\dot s_i=s_i\left(\ddot e_i+\frac{\beta q}{p}e_i^{q/p-1}\dot e_i\right)
=s_i\left(\ddot{\hat x}_i-\ddot x_i+\frac{\beta q}{p}e_i^{q/p-1}\dot e_i\right).
\tag{19}
\]

左端是 \(\dot V_i\)，不是 \(\dot s_i\)；这一点原文正确。旧报告原来说“多乘了一个 \(s_i\)”，修订版已撤回，我同意撤回。式 (19) 的唯一条件是 \(e_i\ne0\)（否则 \(e_i^{q/p-1}\) 无定义），原文未声明。

### 5.2 (21) 的代数

在 (20) 成立的前提下：
\[
\dot V_i\le-\alpha_i|s_i|+|\dot\Delta_i||s_i|
\le-(\alpha_i-\sigma_i)|s_i|.
\tag{21}
\]
这一步本身正确。条件是 \(|\dot\Delta_i|<\sigma_i\)，不是 \(|\Delta_i|<\sigma_i\)。原文在 (21) 前明确写的是扰动导数的 Lipschitz 型条件；旧报告 C4 的更正正确。

### 5.3 \(T_i\) 的闭式

原文（p.5）给
\[
T_i=\frac{|s_i(0)|}{\alpha_i(|s_i(0)|)-\sigma_i}.
\tag{T-printed}
\]

这既不是常增益的精确时间，也不是 class-K 增益的积分时间。分两种情形：

- **常增益** \(\alpha_i\equiv\alpha_i^0>\sigma_i\)：由 \(\dot V_i\le-(\alpha_i^0-\sigma_i)|s_i|\) 得
\[
|s_i(t)|\le\max\left(0,\ |s_i(0)|-(\alpha_i^0-\sigma_i)t\right).
\]
到零的时间是
\[
T_i^0=\frac{|s_i(0)|}{\alpha_i^0-\sigma_i}.
\tag{T-const0}
\]
若要停在 \(r=\alpha_i^{-1}(\sigma_i)\)，则是
\[
T_i^{0}(r)=\frac{|s_i(0)|-r}{\alpha_i^0-\sigma_i}.
\tag{T-constr}
\]
原文的 (T-printed) 用 \(\alpha_i(|s_i(0)|)\) 作分母，只在“常增益且 \(r=0\)”时与 (T-const0) 相同；它没有减去 \(r\)，也没有处理 class-K。

- **class-K 增益** \(\alpha_i(\cdot)\)：\(\dot V_i\le-(\alpha_i(|s_i|)-\sigma_i)|s_i|\)，分离变量得
\[
T_i=\int_{r}^{|s_i(0)|}\frac{ds}{\alpha_i(s)-\sigma_i},\qquad r=\alpha_i^{-1}(\sigma_i).
\tag{T-int}
\]
一般没有闭式。原文把 \(\alpha_i(\cdot)\) 正式定义为 class-K（p.5），却又印出 (T-printed) 这种常增益形式，两种表述没有统一。

### 5.4 “必要且充分”不成立

定理 2 的证明多次写“\(\bar\Theta_i\gg\alpha_i^{-1}(\sigma_i)\) 是保证 \(\dot V_i\le\cdots\) 的 necessary and sufficient condition”（p.6）。至少从印刷的不等式看：
- \(\bar\Theta_i>\alpha_i^{-1}(\sigma_i)\) 是**充分**条件（在 Case 1 且无额外 \(\omega\) 项时）；
- 没有证明必要性；即使 \(\bar\Theta_i\) 不满足，其他负项仍可能使 \(\dot V_i<0\)；
- Case 2 还多出 \(\bar\alpha\omega_i\)，需要 \(\bar\Theta_i\) 更大；见 §7。

因此“necessary and sufficient”是过强表述。

---

## 6. 式 (35) 的复核与反例

原文 (35)（p.7）：
\[
|\dot e_i|=|\hat\Delta_i-\Delta_i|\le|s_i(t)|\le\alpha_i^{-1}(\sigma_i).
\tag{35}
\]

### 6.1 第一个等号

由 (L2)，\(\dot e_2=-\frac{b}{m}e_2+\hat\Delta_2-\Delta_2\)。只有在 \(e_2=0\)（或 \(b=0\) 且 \(e_2=0\)）时才有 \(\dot e_2=\hat\Delta_2-\Delta_2\)。通道 3、5 同理。因此 (35) 的第一个等号已经用了 §4 的零漂移假设。

### 6.2 第二个不等号

由 \(s_i=\dot e_i+\beta e_i^{q/p}\)，
\[
|\dot e_i|=|s_i-\beta e_i^{q/p}|\le|s_i|+\beta|e_i|^{q/p}.
\]
一般情况下不能去掉 \(\beta|e_i|^{q/p}\)。原文用
\[
\left(1-\frac{s_i}{\dot e_i}\right)\dot e_i+\beta e_i^{q/p}=0
\]
并称“令 \(\dot e_i>s_i(t)\)，则 \(1-s_i/\dot e_i>0\)”。但 \(s_i=\dot e_i+\beta e_i^{q/p}\)，所以
\[
1-\frac{s_i}{\dot e_i}=-\frac{\beta e_i^{q/p}}{\dot e_i}.
\]
它为正的条件是 \(e_i\) 与 \(\dot e_i\) 反号，不是 \(\dot e_i>s_i\)。原文的符号条件写错了；即使因子为正，也不能推出 \(|\dot e_i|\le|s_i|\)。

**瞬时代数反例（非仿真）**：取 \(e=216,\ \dot e=-5,\ \beta=1,\ q/p=1/3\)。则 \(e^{1/3}=6\)，\(s=-5+6=1\)。于是
\[
|\dot e|=5>|s|=1.
\]
同时取 \(b/m=1,\ \alpha=3,\ \dot\Delta=0\)，由 (V-EXACT)：
\[
\dot V=s\left(-3-0-(-5)\right)=1\cdot2=2>0,
\]
而原文 (20) 会给出 \(\dot V=-3<0\)。这说明省略 \(d_i\) 不只是“保守性损失”，而是可以**反号**。该点是否在具体轨迹上可达，本文不声明；它足以否定 (20)(21) 作为恒等式/普遍不等式的地位。

### 6.3 由 \(|s|\le r\) 能推出什么

若确实有 \(|s_i|\le r\)，则
\[
\dot e_i=s_i-\beta e_i^{q/p}.
\]
当 \(|e_i|>(r/\beta)^{p/q}\) 时，\(\beta|e_i|^{q/p}>r\ge|s_i|\)，所以 \(\dot e_i\) 与 \(e_i\) 反号，\(|e_i|\) 减小；于是最终
\[
|e_i|\le\left(\frac{r}{\beta}\right)^{p/q}
=\left(\frac{\alpha_i^{-1}(\sigma_i)}{\beta}\right)^{p/q}.
\tag{E-BOUND}
\]
这是**我的复算**，不是作者结论。它比 \(\alpha_i^{-1}(\sigma_i)\) 宽一个 \(p/q>1\) 次幂，再除以 \(\beta^{p/q}\)。因此即使把 (35) 的第一个等号补好，定理 1 能给的观测误差带也不是原文暗示的 \(r\)。

---

## 7. 定理 2 的符号陷阱：\(\bar\Theta_i\) 要压住什么

以通道 \(i\) 为例。控制律 (22) 的对应项是
\[
-(\hat\Delta_i+\bar\Theta_i)\,\mathrm{sgn}(\tilde x_i).
\]
它对 \(\dot V_i\) 的贡献是 \(-|\tilde x_i|(\hat\Delta_i+\bar\Theta_i)\)；扰动 \(\Delta_i\) 的贡献是 \(\tilde x_i\Delta_i\)。两者相加：
\[
-|\tilde x_i|\hat\Delta_i+\tilde x_i\Delta_i-|\tilde x_i|\bar\Theta_i.
\tag{RES}
\]

### 7.1 最坏符号

取 \(\tilde x_i<0\)，并设估计已经准确：\(\hat\Delta_i=\Delta_i=-D\)，\(D>0\)。则
\[
-|\tilde x_i|(-D)+(-|\tilde x_i|)(-D)-|\tilde x_i|\bar\Theta_i
=|\tilde x_i|(2D-\bar\Theta_i).
\tag{RES-NEG}
\]
要让它为负，必须
\[
\bar\Theta_i>2D=2|\Delta_i|.
\tag{THETA-2D}
\]

这不是“估计误差”的量级，而是**扰动本身**的量级。原文的 Case 1 条件
\[
-|\tilde x_i|\hat\Delta_i+\tilde x_i\Delta_i
\le-|\tilde x_i|\left(|\Delta_i|-|\hat\Delta_i|\right)
\tag{C1}
\]
在 \(\hat\Delta_i=\Delta_i=-D,\ \tilde x_i<0\) 时左边为 \(2D|\tilde x_i|\)，右边为 \(0\)，不成立；所以落入 Case 2。Case 2 定义
\[
\omega_i=-\left(|\tilde x_i|\hat\Delta_i-\tilde x_i\Delta_i\right)
+|\tilde x_i|\left(|\Delta_i|-|\hat\Delta_i|\right)=2D|\tilde x_i|,
\tag{OMEGA}
\]
并要求
\[
\bar\alpha\omega_i+|\tilde x_i|\left(\alpha_i^{-1}(\sigma_i)-\bar\Theta_i\right)\le0.
\tag{C2}
\]
代入 \(\omega_i=2D|\tilde x_i|\)，得到
\[
\bar\Theta_i\ge2\bar\alpha D+\alpha_i^{-1}(\sigma_i).
\tag{THETA-C2}
\]

**这就是精确缺口。** 原文只要求 \(\bar\Theta_i\gg\alpha_i^{-1}(\sigma_i)\)，但在 \(\Delta_i<0,\ \tilde x_i<0\) 的物理情形下，\(\bar\Theta_i\) 还必须大于 \(2\bar\alpha|\Delta_i|\)。由于 \(\Delta_i\) 的上界正是作者声称不需要知道的量，(THETA-C2) 与“without any knowledge about the upper bounds”冲突。至少在这一符号分支，定理 2 的鲁棒裕度条件依赖于扰动幅度本身。

### 7.2 这不是“保守”，而是条件不可先验验证

若作者愿意把 \(\bar\Theta_i\) 取得任意大，(THETA-C2) 当然可以满足；但那样 \(\bar\Theta_i\) 就不再是“抑制估计误差”的小裕度，而是“抑制扰动”的大增益。两者的工程含义不同：前者可以随观测器精度提高而减小，后者不能。原文把两者混在同一个 \(\bar\Theta_i\) 里，导致“未知上界”这一核心卖点在 Case 2 下没有兑现。

---

## 8. 时间变换：为什么改变尺度，却不产生有限时间

### 8.1 基本性质

式 (4)（p.3）：
\[
\mu(t,\tau)=\frac{1+e^{-t/\tau}}{2e^{-t/\tau}}=\frac{e^{t/\tau}+1}{2},\qquad \mu(0)=1.
\tag{4}
\]
\[
\dot\mu=\frac{1}{2\tau}e^{t/\tau},\qquad
\frac{\dot\mu}{\mu}=\frac{1}{\tau}\frac{e^{t/\tau}}{1+e^{t/\tau}}
=\frac{1}{2\tau}\left(2-\mu^{-1}\right).
\tag{MU-RATE}
\]
因此
\[
\frac{1}{2\tau}<\frac{\dot\mu}{\mu}<\frac{1}{\tau},\qquad
\lim_{t\to\infty}\frac{\dot\mu}{\mu}=\frac{1}{\tau}.
\tag{MU-BOUND}
\]
\(\mu\to\infty\) 只在 \(t\to\infty\)；对任意有限 \(t\)，\(\mu(t)<\infty\)。**全文没有终端时刻 \(T\)。**

### 8.2 尺度效应

令 \(E_i=\mu\bar e_i\)。则
\[
|\bar e_i(t)|=\frac{|E_i(t)|}{\mu(t)}.
\]
即使 \(E_i\) 只做到有界而不收敛，只要 \(\mu\to\infty\)，也有 \(\bar e_i\to0\)。这就是“移动标尺”：标尺的刻度随时间放大，同一个 \(E\) 在物理坐标里显得越来越小。

但“显得小”不等于“在有限时刻到零”。对任意有限 \(t\)，\(\mu(t)\) 有限，\(|E_i(t)|/\mu(t)>0\)（除非 \(E_i(t)=0\)）。因此仅凭 \(\mu\to\infty\)，只能得到**渐近**收敛。

### 8.3 指数比较不能给出精确有限时间

若 \(V_2(t)\le V_2(0)e^{-2c_2t}\)，且 \(\mu(t)\ge1\)，则
\[
|\bar e_1(t)|\le\frac{\sqrt{2V_2(0)}\,e^{-c_2t}}{\mu(t)}
\le\sqrt{2V_2(0)}\,e^{-c_2t}.
\tag{E-DECAY}
\]
更精细地，\(\mu(t)\sim e^{t/\tau}/2\)，所以渐近率约为 \(c_2+1/\tau\)。但
\[
e^{-(c_2+1/\tau)t}>0\quad\text{对一切有限 }t.
\]
比较两个指数只给出“衰减更快”，不给出“何时等于零”。指数函数在有限时间不到零；要得到精确有限时间，需要非 Lipschitz 项（如 \(-\beta e^{q/p}\) 或 \(-\alpha\,\mathrm{sgn}(s)\)）或一个在有限 \(T\) 发散的尺度。

### 8.4 与 Remark 1 的矛盾

Remark 1（p.3）说 \(C\) 在 \(t\to t_0+T\) 时发散到无穷，从而 \(\Sigma_1\) 在有限时间 FTUB。这个前提要求 \(T<\infty\)。但 (4) 的 \(\mu\) 在 \(t\to\infty\) 才发散，即 \(T=\infty\)。把 Remark 1 套到 (4) 上，得到的只是 \(t\to\infty\) 的渐近结论，不是有限时间。**这是全文“finite time”标签与时间变换之间的根本错位。**

### 8.5 截断 (34) 之后

式 (34)（p.7）在 \(t>\delta_t\) 取 \(\mu=\mu_{\max}\)。于是 \(1/\mu\) 的附加衰减消失，只剩 \(E\) 动力学的 \(c_2\) 率：
\[
|\bar e_1(t)|\le\frac{\sqrt{2V_2(0)}\,e^{-c_2t}}{\mu_{\max}},\qquad t>\delta_t.
\tag{E-AFTER}
\]
所以 \(c_2+1/\tau\) 只是 \(t\le\delta_t\) 的瞬态率；长期率是 \(c_2\)。旧报告时间账本写“指数率约为 \(c_5+1/\tau\)”，没有区分截断前后，这里补正。

另外，\(\mu\) 在 \(\delta_t\) 连续，但 \(\dot\mu(\delta_t^-)=e^{\delta_t/\tau}/(2\tau)\ne0=\dot\mu(\delta_t^+)\)。控制律含 \(\dot\Phi_4\)，而 \(\Phi_4\) 依赖 \(\mu,\dot\mu/\mu\)，所以 \(u\) 在 \(\delta_t\) 可能跳变。原文只说“状态仍有界”，没有分析输入跳变。

---

## 9. \(\mu\) 的记账：逐式核对

这一节只谈印刷式与 (5)(8) 的代数一致性，不猜测作者本意。

由 \(E_2=\mu\bar e_2\) 与 (2)，式 (5) 的 \(x_3\) 项必须是
\[
\frac{A_p}{m}\mu x_3.
\tag{MU-X3}
\]
这是定义的结果，不是排版选择。式 (8) 的前置因子
\[
\left(\frac{A_p}{m}\mu\right)^{-1}
\tag{8}
\]
与 (MU-X3) 匹配；若缺 \(\mu\)，\((A_p/m)\mu\Phi_2\) 会给出 \(-\mu E_1\) 而不是 \(-E_1\)。

逐式对照（原图已核）：

| 式 | 印刷项 | 由 (5)(8) 需要的项 | 后果 |
|---|---|---|---|
| (5) | \((A_p/m)\mu x_3\) | 同 | 正确 |
| (8) | \((A_p/m\,\mu)^{-1}\) | 同 | 正确 |
| (9) 第二行 | \((A_p/m)\tilde x_3\) | \((A_p/m)\mu\tilde x_3\) | 若照印刷，\(\dot{\tilde E}_2\) 的 \(-E_1\) 不成立 |
| (9) 第三行 | \(-\frac{2\rho A_p}{\mu V_0}(\tilde E_2+\Phi_1)\) | 同 | 正确 |
| (10) 第一项 | \(-\frac{A_p}{m}\tilde E_2\) | \(-\frac{A_p}{m}\mu\tilde E_2\) | 与 (9) 的 \(\mu\) 缩放不匹配 |
| (10) 压力项 | \(+\frac{2\rho A_p}{V_0}(\tilde E_2+\Phi_1)\) | \(+\frac{2\rho A_p}{\mu V_0}(\tilde E_2+\Phi_1)\) | 代回 \(\dot{\tilde x}_3\) 留下残差 |
| (23) | \((A_p/m)^{-1}\) | \((A_p/m\,\mu)^{-1}\) | 与 (5) 组合给出 \(-\mu E_1\) |
| (24) | 与 (10) 同 | 同 (10) | 同上 |

**具体残差**：若取 (9) 的第三行与 (10) 的压力项，则
\[
\dot{\tilde x}_3\Big|_{\text{pressure}}
=-\frac{2\rho A_p}{\mu V_0}(\tilde E_2+\Phi_1)
+\frac{2\rho A_p}{V_0}(\tilde E_2+\Phi_1)
=\frac{2\rho A_p}{V_0}\left(1-\frac1\mu\right)(\tilde E_2+\Phi_1).
\tag{MU-RES}
\]
这不是零。故 (9) 与 (10) 作为印刷式并不是一对自洽的式子；旧报告 O15 说“(9)(10)(11) 彼此自洽”，至少对压力项不成立。旧报告正确的地方是：\((A_p/m)\) 项的 \(\mu\) 确实缺失，且 (8) 含 \(\mu\) 是正确的。

**最小自洽修法（我的建议，非作者原文）**：以 (5)(8) 为准，把 (9) 第二行改为 \((A_p/m)\mu\tilde x_3\)，把 (10) 改为
\[
\Phi_3=\left(\frac{2\rho k_q\sqrt{P_s-|\tilde x_3+\Phi_2|}}{V_0}\right)^{-1}
\left(-\frac{A_p}{m}\mu\tilde E_2
+\frac{2\rho A_p}{\mu V_0}(\tilde E_2+\Phi_1)
+\frac{2\rho A_p}{V_0}\dot y_d+\dot\Phi_2-a_3\tilde x_3-k_3\,\mathrm{sgn}(\tilde x_3)\right),
\tag{10-FIX}
\]
并把 (23)(24) 同步补 \(\mu\)。这样 (13) 的整条链精确闭合，\(\dot V_3\) 如论文所写。两种读法都不改变“指数收敛”的定性结论，但逐式复现必须澄清。

---

## 10. 额外有界性假设（明示）

以下假设在原文中没有逐条列出，但证明要用：

1. \(\Delta_i\) 对 \(t\) 可微，且 \(|\dot\Delta_i|<\sigma_i<\infty\)。这是 (21) 的前提；原文只写 Lipschitz-like，没有说明 \(\Delta_i\) 的可微性。
2. \(e_i\ne0\)，使 \(e_i^{q/p-1}\) 有限；或对 (16) 做正则化。原文未处理 \(e_i=0\)。
3. \(\alpha_i(\cdot)\) 是 class-K，且存在 \(r_i=\alpha_i^{-1}(\sigma_i)\)；或者 \(\alpha_i\) 为常数且 \(>\sigma_i\)。原文两种用法混在一起。
4. 通道 3 需要 \(\dot e_2\) 的有界性（或 \(e_2,s_2\) 的有界性）来控制 \(d_3\)。这要求先证明通道 2 的 FTUB，形成级联；原文没有分段。
5. 定理 2 需要估计误差界 \(|\hat\Delta_i-\Delta_i|\le\alpha_i^{-1}(\sigma_i)\)。这不是定理 1 的结论；定理 1 只给 \(|s_i|\) 的界（且带 §4 缺口）。
6. 最坏符号分支需要 \(\bar\Theta_i\ge2\bar\alpha|\Delta_i|+\alpha_i^{-1}(\sigma_i)\)。这比印刷条件强，且依赖未知的 \(|\Delta_i|\)。
7. \(u\) 的有界性需要 \(\dot\Phi_4\) 有界，进而需要 \(y_d\) 直到四阶导数有界、\(\mu\) 截断、且 \(P_s-|x_3|>0\)。原文没有给 \(y_d\) 的光滑性阶数，也没有给 \(\sup|u|\)。
8. \(x_3,x_4\) 可测，且 \(|x_3|<P_s\) 使平方根为实。原文把它们当作可用，但没有列入定理假设。

---

## 11. 与旧报告的分歧

| 项 | 旧报告 | 本次复核 |
|---|---|---|
| (19)(20) 是否多乘 \(s_i\) | 原报告说多乘，修订版撤回 | 同意修订版：(19) 左端是 \(\dot V_i\)，写法正确 |
| (21) 的界 | 修订版改为 \(|\dot\Delta_i|<\sigma_i\) | 同意；并补充真实系统还有 \(d_i\) 项 |
| (8) 是否缺 \(1/\mu\) | 修订版撤回疑点，确认含 \(\mu\) | 同意；独立反步也要求含 \(\mu\) |
| (9)(10)(11) 是否自洽 | 修订版 O15 说三者彼此自洽 | **不完全同意**：压力项 (9) 有 \(1/(\mu V_0)\)、(10) 没有 \(1/\mu\)，代回有 (MU-RES) 残差；\((A_p/m)\) 项则如 O15 所述 |
| (35) | 修订版说界的是 \(|\dot e_i|\) | 同意；并补充 \(|\dot e_i|\le|s_i|\) 本身不普遍成立，给出代数反例 |
| 时间账本 | 修订版写速率约 \(c_5+1/\tau\) | 补充：这只是 \(t\le\delta_t\) 的瞬态率；截断后长期率为 \(c_5\) |
| 定理 2 的 \(\bar\Theta_i\) | 修订版指出依赖未证估计误差界 | 同意；并进一步指出最坏符号下还要压住 \(2|\Delta_i|\)，与“未知上界”冲突 |
| 定理 1 缺口 | 修订版说是作者显式假设 \(\ddot{\hat x}=\ddot x\) | 同意；并说明该假设等价于 \(\ddot e=0\)，与 \(\dot{\hat\Delta}=\dot\Delta\) 合用会强制 \(\dot e=0\) |

---

## 12. 停在哪里

- **能确认的**：对象→误差方程 (5) 正确；第一步反步的 \(V_2\) 负定性在 (8) 含 \(\mu\) 时正确；跟踪只有 \(\dot V\le-2cV\)，没有分数幂，没有终端 \(T\)。
- **不能确认的**：定理 1 的 FTUB 对实际观测器轨迹成立；定理 2 在“未知扰动上界”下的闭环有界性；\(u\) 的有界性；噪声下的定理保证。
- **精确缺口**：要闭合定理 1，需额外证明 \(\sup_t|d_i(t)|\) 有界（或 \(\alpha_i>\sigma_i+|d_i|\)），并对通道 3 做级联；要闭合定理 2，需把 \(\bar\Theta_i\) 的条件加强到 (THETA-C2)，这等于重新引入扰动上界。本文不写“类似可得”，也不替作者补证。

---

**一手来源**：https://doi.org/10.1016/j.ejcon.2022.100659  
**出版版**：European Journal of Control 67 (2022) 100659, pp. 1–11.  
**访问日期**：2026-11-01.
