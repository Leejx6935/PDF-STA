# L09 证明重构与独立复算

**对象**：Wang et al., *A reinforcement learning-based optimized backstepping control approach for uncertain electro-hydraulic systems*, MSSP 237 (2025) 112928, DOI 10.1016/j.ymssp.2025.112928。
**方法**：不照抄原文步骤。凡决定结论的步骤，均从原误差方程重新求导、逐项处理交叉项，并与原文式面对照。原文省略的步骤若不能补齐，标“待证”，不以“类似可得”代替。
**约定**：$\bar\varphi_2=1/m$，$\bar\varphi_3$ 如 (8)；$S_i:=S_{\Gamma i}(\mathcal X_{\Gamma i})$，$\Sigma_i:=S_iS_i^\top$；$W^\star:=W^\star_{\Gamma i}$（原文令 actor、critic 共享同一理想权重）。

## 0. 核对等级

| 等级 | 含义 |
|---|---|
| **A** | 独立复算通过，可逐行对照 |
| **B** | 结构正确，但结论依赖额外不等式/特征值条件，非充分条件本身 |
| **C** | 不成立、未闭合或按字面不可用 |
| **D** | 疑似 OCR/排版，需原图核对（不作为数学结论） |

---

## 1. 模型复算（A）

由 (2)(4)，取 $x_3=AP_L$、$\dot P_L=\dot x_3/A$：

$$Q_L=A x_2+\frac{V_t}{4\beta_eA}\dot x_3+\frac{C_{tl}}{A}x_3
\;\Longrightarrow\;
\dot x_3=\frac{4\beta_eA}{V_t}Q_L-\frac{4\beta_eA^2}{V_t}x_2-\frac{4\beta_eC_{tl}}{V_t}x_3 .$$

代入 $Q_L=\frac{C_dwK_{sv}}{\sqrt\rho}u\sqrt{P_s-\mathrm{sign}(u)x_3/A}$，得 (6c)，系数逐项一致。**A**。

两点原文未处理、但影响后续：

1. $\bar\varphi_3(x_3,u)=\dfrac{4\bar\beta_e\bar C_d\bar wK_{sv}A}{V_t\sqrt{\bar\rho}}\sqrt{P_s-\mathrm{sign}(u)x_3/A}$ 在 $u=0$ 两侧取不同分支，$k_+\neq k_-$（$x_3\neq0$），故 $f+gu$ 在 $u=0$ 非 Lipschitz，与 §2.2 的 Lipschitz 假设冲突。
2. $1/\bar\varphi_3$ 需要 $\bar\varphi_3$ 有**正下界**（$|x_3|$ 远离 $AP_s$）。全文只用到上界 $\bar\varphi_3^2\le\hat\varphi_3$，下界与不变集均未给。

---

## 2. 一阶条件与“梯度重构”的实质（A，但揭示平凡性）

三环的驻点条件 (22)(42)(60)：

$$\alpha_1^\star=-\tfrac12\nabla_{e_1}J_1^\star,\qquad
\alpha_2^\star=-\tfrac12\bar\varphi_2\nabla_{e_2}J_2^\star,\qquad
u^\star=-\tfrac12\bar\varphi_3\nabla_{e_3}J_3^\star,$$

由 $\partial H_i/\partial\alpha_i=0$ 直接得到，**与 $\dot y_d$ 无关**（$\dot y_d$ 项不含 $\alpha_i$），正确。**A**。

“梯度重构” (23)(24)：$\Gamma_1:=-2c_1e_1+\nabla J_1^\star$，代回 (23) 得 $\nabla J_1^\star=2c_1e_1+\Gamma_1$，再代入 (24) 得 $\alpha_1^\star=-c_1e_1-\frac12\Gamma_1$。这是**恒等式**，不引入任何信息：对任意 $\Gamma_1$ 都成立。它只是把“未知梯度”改写成“未知函数 $\Gamma_1$”，使之可被 NN 逼近。同理 (43)(44)、(61)(62)。**A（但须明确：这不是推导，而是变量替换）**。

由此可立即看出：**全部“优化”内容都在 $\Gamma_i$ 里**，因为线性项 $-c_ie_i$ 只由设计参数 $c_i$ 决定。

---

## 3. 代价泛函在跟踪工况下发散（C，独立计算）

### 3.1 位置环

$\dot e_1=u_1-\dot y_d$（$u_1:=x_2$），$J_1=\int_t^\infty(u_1^2+e_1^2)d\tau$。HJB：

$$p(u_1-\dot y_d)+u_1^2+e_1^2=0,\quad p=\partial J_1^\star/\partial e_1 .$$

$\partial/\partial u_1$ 给 $p+2u_1=0\Rightarrow u_1=-p/2$，代入：

$$-\tfrac{p^2}{4}-p\dot y_d+e_1^2=0\;\Longrightarrow\;p=-2\dot y_d\pm2\sqrt{\dot y_d^2+e_1^2},\qquad
u_1=\dot y_d\mp\sqrt{\dot y_d^2+e_1^2}.$$

闭环：$\dot e_1=u_1-\dot y_d=\mp\sqrt{\dot y_d^2+e_1^2}$。取“负”支，$\dot e_1<0$ 恒成立且 $|\dot e_1|\ge|\dot y_d|$，故 $e_1\to-\infty$；取“正”支则 $e_1\to+\infty$。**两支都不镇定**。原因清楚：$\dot y_d\neq0$ 时误差系统原点不是平衡点，而代价把绝对速度 $u_1$ 当作控制量来罚。

另一条更直接的论证：任何使 $e_1\equiv0$ 的策略必满足 $x_2\equiv\dot y_d$，于是

$$J_1=\int_0^\infty(\dot y_d^2+0)\,d\tau=\infty\quad(\dot y_d=0.05\pi\cos\pi t+0.04\pi\cos2\pi t\not\equiv0).$$

Definition 1 要求 $J$ 有限，故可行策略集 $\Psi(\Omega_{e_1})$ 为空，(20) 的 min 无对象，(21) 只是形式推导。**C（对“近最优”是致命的；对稳定性结论不致命，因为稳定性只用到控制律，不用 $J$）**。

### 3.2 速度环与力环

同理，$\alpha_2=x_3\approx AP_L\neq0$（稳态需持续出力），$\alpha_3=u\neq0$（稳态控制电压周期变化），故 $J_2=\int(\alpha_2^2+e_2^2)$、$J_3=\int(u^2+e_3^2)$ 同样发散。三环皆不适定。

**若作者本意**是把 $\alpha_i$ 当“偏差量”、前馈 $\dot y_d$ 单列，则 (19)(21)(22) 与 $e_2$ 的定义都须重写，(24)(48)(66) 的参数化也要改。文中没有这样做。此点应在引用时明确写出，不能默认“作者其实是想说偏差量”。

---

## 4. 位置环 Lyapunov：独立求导与 (37) 逐项核对（A）

### 4.1 误差方程

$$e_2=x_2-\hat\alpha_1^\star\;\Rightarrow\;x_2=e_2-c_1e_1-\tfrac12\hat W_{a1}^\top S_1,$$

$$\boxed{\dot e_1=-c_1e_1-\tfrac12\hat W_{a1}^\top S_1+e_2-\dot y_d}\tag{D1}$$

与 (34) 中 $e_1(\cdot)$ 括号内一致。

### 4.2 求导

$$L_1=\tfrac12e_1^2+\tfrac12\|\tilde W_{c1}\|^2+\tfrac12\|\tilde W_{a1}\|^2,$$

$$\dot L_1=\underbrace{-c_1e_1^2-\tfrac12e_1\hat W_{a1}^\top S_1+e_1e_2-e_1\dot y_d}_{(i)}
\underbrace{-\lambda_{c1}\tilde W_{c1}^\top\Sigma_1\hat W_{c1}}_{(ii)}
\underbrace{-\tilde W_{a1}^\top\Sigma_1\big[\lambda_{a1}(\hat W_{a1}-\hat W_{c1})+\lambda_{c1}\hat W_{c1}\big]}_{(iii)}\tag{D2}$$

（$\tilde W=\hat W-W^\star$，$\dot{\hat W}$ 由 (30)(31) 代入，$\dot W^\star=0$ 按常规划归。）

### 4.3 所用不等式

$$e_1e_2\le\tfrac12e_1^2+\tfrac12e_2^2,\qquad
-e_1\dot y_d\le\tfrac12e_1^2+\tfrac12\dot y_d^2,\qquad
-\tfrac12e_1\hat W_{a1}^\top S_1\le\tfrac14e_1^2+\tfrac14(\hat W_{a1}^\top S_1)^2 .$$

前两条是 $ab\le\frac12a^2+\frac12b^2$；第三条是 $ab\le\frac14a^2+b^2$（$a=e_1,b=\frac12\hat W^\top S$），再乘 $\frac12$… 逐项核对后与原文 (35) 的 $-(c_1-\frac54)e_1^2$ 一致：$-\big(c_1-\frac12-\frac12-\frac14\big)=-(c_1-\frac54)$。**A**。

### 4.4 权重恒等式（我给证明）

$$\tilde W^\top\Sigma\hat W=\tfrac12\tilde W^\top\Sigma\tilde W+\tfrac12(\hat W^\top S)^2-\tfrac12(W^{\star\top}S)^2 .\tag{D3}$$

证：令 $a=\tilde W^\top S$，$b=W^{\star\top}S$，则 $\hat W^\top S=a+b$，右端 $=\frac12a^2+\frac12(a+b)^2-\frac12b^2=a^2+ab=a(a+b)=\tilde W^\top SS^\top\hat W$。**A**。

### 4.5 (37) 逐项核对表

| (37) 中的项 | 我推出的系数 | 是否一致 |
|---|---|---|
| $e_1^2$ | $-\big(c_1-\frac54\big)$ | ✓ |
| $(\hat W_{a1}^\top S_1)^2$ | $+\frac14$（Young）$-\frac12\lambda_{a1}$（(iii) 经 D3）$=-\frac{2\lambda_{a1}-1}{4}$ | ✓ |
| $(\hat W_{c1}^\top S_1)^2$ | $-\frac12\lambda_{c1}$（(ii)）$+\frac12(\lambda_{a1}-\lambda_{c1})$（交叉项 Young）$=-\frac{2\lambda_{c1}-\lambda_{a1}}{2}$ | ✓ |
| $\tilde W_{a1}^\top\Sigma_1\tilde W_{a1}$ | $-\frac12\lambda_{a1}+\frac12(\lambda_{a1}-\lambda_{c1})=-\frac12\lambda_{c1}$ | ✓ |
| $\tilde W_{c1}^\top\Sigma_1\tilde W_{c1}$ | $-\frac12\lambda_{c1}$ | ✓ |
| 常数项 | $\frac12\dot y_d^2+\frac{\lambda_{a1}+\lambda_{c1}}{2}(W^{\star\top}S_1)^2=\varpi_1$ | ✓ |
| $e_2^2$ | $+\frac12e_2^2$ | ✓ |

结论：**(37) 在给定三条不等式下是正确的**，且条件 $\lambda_{a1}>\frac12$、$\lambda_{c1}>\frac12\lambda_{a1}$ 恰好对应两个非负系数。**A**。速度环 (55)、力环 (72) 的同类展开结构相同（标识器项见 §8）。

---

## 5. 级联相消（A）

三环求和，交叉项按原文系数：

$$\dot L\le-\Big(c_1-\tfrac54\Big)e_1^2-\Big(c_2-\tfrac{8+\bar\varphi_2^2}{4}\Big)e_2^2-\Big(c_3-\tfrac{2+\bar\varphi_3^2+2\bar\varphi_2}{4}\Big)e_3^2
+\underbrace{\tfrac12e_2^2-\tfrac12e_2^2}_{=0}
+\underbrace{\tfrac12e_3^2\bar\varphi_2-\tfrac12e_3^2\bar\varphi_2}_{=0}
+\varpi .$$

$(38)$ 的 $+\frac12e_2^2$ 与 $(56)$ 的 $-\frac12e_2^2$ 相消；$(56)$ 的 $+\frac12e_3^2\bar\varphi_2$ 与 $(73)$ 的 $-\frac12e_3^2\bar\varphi_2$ 相消。**A（内部自洽）**。

但两处系数本身来自不精确的 Young 步：$\bar\varphi_2e_2e_3\le\frac12e_2^2+\frac12\bar\varphi_2^2e_3^2$（应为 $\bar\varphi_2^2$，原文写线性 $\bar\varphi_2$，三处一致地错，故相消仍成立）；力环同理（§9）。**B**。

---

## 6. $\ell_i$ 失效：$Y^{\min}=0$（C，关键）

(38)(56)(73) 都用了
$$-\tfrac12\lambda_{ci}\tilde W^\top\Sigma_i\tilde W\;\le\;-\tfrac12\lambda_{ci}Y^{\min}_i\|\tilde W\|^2,$$
其中 $Y^{\min}_i$ 取 $\Sigma_i=S_iS_i^\top$ 的最小特征值。

**事实**：$\Sigma_i\in\mathbb R^{p_i\times p_i}$ 秩为 1，特征值为 $\{\|S_i\|^2,0,\dots,0\}$。仿真/实验均 $p_i=5$，故

$$Y^{\min}_i=0\quad\Longrightarrow\quad \ell_i=\min\{2(c_i-\cdot),\ \lambda_{ci}Y^{\min}_i,\ \cdots\}=0 .$$

于是：

1. $-\ell_iL_i$ 项消失，(38)(56)(73) 退化为 $\dot L_i\le(\text{负的 }e_i^2\text{ 项})+\varpi_i$；
2. 定理 1 的比较引理 $L\le e^{-\ell t}\big(L(0)-\frac\varpi\ell\big)+\frac\varpi\ell$ 在 $\ell=0$ 时**无定义**（$\varpi/\ell$ 发散），且 $\dot L\le\varpi$ 的解是 $L\le L(0)+\varpi t$，**不蕴含 UUB**；
3. 稳态界 $\lim|e_1|\le\sqrt{2\varpi/\ell}$ 随之失效。

**这不是“保守”，而是字面错误**：$\Sigma_i$ 的秩为 1 是初等事实，与参数无关。

### 6.1 可修复的替代（我给）

不依赖 $Y^{\min}$：

1. $\dfrac{d}{dt}\|\hat W_{ci}\|^2=-2\lambda_{ci}(S_i^\top\hat W_{ci})^2\le0\Rightarrow\|\hat W_{ci}(t)\|\le\|\hat W_{ci}(0)\|$。
2. 由 (32) $\dot{\mathcal P}\le0$ 得 $\|\hat W_{ai}-\hat W_{ci}\|\le\|\hat W_{ai}(0)-\hat W_{ci}(0)\|$，故 $\|\hat W_{ai}\|\le\|\hat W_{ci}(0)\|+\sqrt{\mathcal P(0)}$。
3. 于是 $L\le\frac12\sum e_i^2+\text{const}$，且 $\dot L\le-\sum c_{ei}e_i^2+\varpi$（$c_{ei}$ 为三个负定系数），从而 $L$ 有界、$e_i$ 终值有界：
$$\limsup_{t\to\infty}|e_1|\le\sqrt{\varpi/c_{e1}} .$$
4. 得到的是**较弱的 SGUUB**：只保证 $e_i$ 与权重有界，**没有权重的指数衰减，也没有任何最优性**。

注意：该修复对力环仍需 $c_{e3}>0$，而按作者参数 $c_{e3}<0$（§9），故修复也救不了力环。**C→修复后为 B（且力环仍不满足）**。

---

## 7. $\dot{\mathcal P}\le0$ 核对与 $H\to0$ 的缺口（A + C）

### 7.1 (32) 正确

令 $D=\hat W_{a1}-\hat W_{c1}$，$P=D^\top D$，$\partial P/\partial\hat W_a=2D$，$\partial P/\partial\hat W_c=-2D$：

$$\dot{\mathcal P}=2D^\top\dot{\hat W}_a-2D^\top\dot{\hat W}_c
=-2\lambda_{a1}D^\top\Sigma_1D-2\lambda_{c1}D^\top\Sigma_1\hat W_{c1}+2\lambda_{c1}D^\top\Sigma_1\hat W_{c1}
=-2\lambda_{a1}\|S_1^\top D\|^2\le0 .$$

与 (32) 的 $-\frac12\lambda_{a1}\frac{\partial\mathcal P}{\partial\hat W_a^\top}\Sigma_1\frac{\partial\mathcal P}{\partial\hat W_a}$ 相同（因 $\frac{\partial P}{\partial\hat W_a}=2D$）。**A**。交叉项精确相消这一步是全文最干净的地方。

### 7.2 $\mathcal P\to0$ 未证（C，可补）

$\dot{\mathcal P}\le0$ 只给 $\mathcal P\downarrow\mathcal P_\infty\ge0$ 与 $\int_0^\infty\|S_1^\top D\|^2dt<\infty$。要得 $\mathcal P_\infty=0$ 需 $\frac{d}{dt}(S_1^\top D)$ 有界（Barbalat）或 PE；原文由“$\mathcal P>0,\dot{\mathcal P}\le0$”直接写“$\mathcal P(t)\to0$”，缺一步。**C（易补，但不是已证）**。

### 7.3 即使 $\mathcal P\to0$ 也推不出 $H_1\to0$（C，致命）

$\hat W_a=\hat W_c$ 时：$\hat\nabla J_1=2c_1e_1+\hat W_c^\top S_1$，$\hat\alpha_1^\star=-c_1e_1-\frac12\hat W_a^\top S_1$，故恒有 $\hat\nabla J_1=-2\hat\alpha_1^\star$。代入估计 HJB：

$$H_1=\hat\nabla J_1(\hat\alpha_1^\star-\dot y_d)+\hat\alpha_1^{\star2}+e_1^2
=-\hat\alpha_1^{\star2}+2\hat\alpha_1^\star\dot y_d+e_1^2 .$$

**反例（数值）**：$e_1=0.01$，$\dot y_d=0.1$，$c_1=300$，$\hat W_a=\hat W_c=0$（于是 $\mathcal P=0$）：
$\hat\alpha_1^\star=-3$，$H_1=-9+2(-3)(0.1)+10^{-4}=-9.5999\neq0$。

同时 $\partial H_1/\partial\hat W_{a1}=\frac12S_1S_1^\top(\hat W_{a1}-\hat W_{c1})=0$ 自动成立。**故“驻点 ⇒ 残差为零”不成立**；Remark 4 把“$\partial H/\partial\hat W_a=0$（向量方程，只约束沿 $S_1$ 的分量）”与“$H=0$（标量方程）”当成等价，这是逻辑跳跃。

补充：$H_1=0$ 的真实解是 $\hat\alpha_1^\star=\dot y_d\pm\sqrt{\dot y_d^2+e_1^2}$，与 §3 的 $u_1^\star$ 同形——**它并不跟踪**（$e_1\to\pm\infty$）。所以“残差为零”即便成立也不是合格的最优控制器。

### 7.4 无 $J-J^\star$ 估计

全文没有 $\big|J-J^\star\big|\le\varepsilon$、$\|\hat\nabla J-\nabla J^\star\|\le\varepsilon$ 或任何 ε-最优性表述。**“near-optimal”在证明层面没有对应命题**。

---

## 8. 标识器项：交叉相消（A）与 (53) 的截断（D）

速度环 $\dot e_2$ 中含 $-\tilde W_{\theta2}^\top S_{\theta2}$（由 (45) 代入）。$L_2$ 的标识器部分：

$$\tilde W_{\theta2}^\top\mathcal K_2^{-1}\dot{\hat W}_{\theta2}
=\tilde W_{\theta2}^\top\big(S_{\theta2}e_2-\sigma_2\hat W_{\theta2}\big).$$

与 $e_2\dot e_2$ 中的 $-e_2\tilde W_{\theta2}^\top S_{\theta2}$ **精确相消**，余

$$-\sigma_2\tilde W_{\theta2}^\top\hat W_{\theta2}
=-\tfrac{\sigma_2}{2}\|\tilde W_{\theta2}\|^2+\tfrac{\sigma_2}{2}\|W^\star_{\theta2}\|^2-\tfrac{\sigma_2}{2}\|\hat W_{\theta2}\|^2 .$$

这正是 (55) 的形式（$-\frac12\sigma_2\tilde W^\top\tilde W$，$\varpi_2$ 含 $\frac12\sigma_2W^{\star\top}W^\star$）。**A**。

原文 (53) 末尾印作“$-\sigma_2\tilde W_{\Theta2}^\top$”即截断，缺 $-e_2\tilde W^\top S$ 项与 $\hat W$ 因子。**D（截断/排版），不影响 (55)**。

小瑕：由 $-\frac{\sigma_2}{2}\|\tilde W\|^2$ 推到 $-\frac{\sigma_2}{2Y^{\max}_{\mathcal K}}\tilde W^\top\mathcal K^{-1}\tilde W$ 需要 $Y^{\min}_{\mathcal K}\ge1/Y^{\max}_{\mathcal K}$；$\mathcal K=I$ 时成立，一般 $\mathcal K$ 不成立（正确形式用 $Y^{\min}_{\mathcal K}$）。**B**。

---

## 9. 力环：Young 系数与充分条件的数值核对（C）

### 9.1 系数

$\dot e_3$ 中含 $-\frac12\bar\varphi_3^2e_3(\hat W_{a3}^\top S_{\Gamma3})$。取 $a=e_3$，$b=\frac12\bar\varphi_3^2(\hat W^\top S)$，$ab\le\frac14a^2+b^2$：

$$-\tfrac12\bar\varphi_3^2e_3(\hat W_{a3}^\top S)\le\tfrac14e_3^2+\tfrac14\bar\varphi_3^4(\hat W_{a3}^\top S)^2 .$$

原文 (72) 的 $e_3^2$ 系数为 $-\big(c_3-\frac{2+\bar\varphi_3^2}{4}\big)$：其中 $\frac12$ 来自 $e_3\Delta_{\Theta3}$、$\frac14$ 来自本式，应为 $-\big(c_3-\frac34\big)$；而 $(\hat W^\top S)^2$ 的系数是按 $\frac14$（无 $\bar\varphi_3^4$）配的。即 (72) 的 $\bar\varphi_3$ 幂次**不一致**：要么 $e_3^2$ 系数为 $-\big(c_3-\frac34\big)$ 且权重项带 $\bar\varphi_3^4$，要么反之。**B/C**。

### 9.2 数值（按表 2 名义值）

$\bar\beta_e=7\times10^3$ bar $=7\times10^8$ Pa，其余如表 2：

$$\bar\varphi_3=\frac{4\bar\beta_e\bar C_d\bar wK_{sv}A}{V_t\sqrt{\bar\rho}}\sqrt{P_s}
=\frac{2.8\times10^9\times0.62\times0.024\times7.9\times10^{-3}\times2.9\times10^{-4}}{1.74\times10^{-5}\times\sqrt{850}}\sqrt{1.2\times10^7}
\approx6.52\times10^8 .$$

（$\bar\varphi_3$ 在 $x_3=0$ 取最大，故 $\hat\varphi_3=\bar\varphi_3^2=4.25\times10^{17}$ 是自然上界，无需额外假设；**缺的是下界**。）

| 条件（原文） | 需要的量级 | 作者取值 | 结论 |
|---|---|---|---|
| $c_3>\frac{2+\hat\varphi_3+2\bar\varphi_2}{4}$ | $>1.06\times10^{17}$ | 仿真 2000、实验 650 | 违反 $\sim5\times10^{13}$ |
| $\lambda_{a3}>\frac12\hat\varphi_3$ | $>2.1\times10^{17}$ | 0.6 | 违反 |
| 若按 §9.1 正确配平：$\lambda_{a3}>\frac12\bar\varphi_3^4$ | $>9\times10^{34}$ | 0.6 | 违反更甚 |
| 若把 $\hat\varphi_3$ 误当 $\bar\varphi_3$ 的界 | $c_3>1.6\times10^8$ | 2000 | 仍违反 $8\times10^4$ |

**结论**：无论采用哪种读法，定理 1 的力环充分条件都被作者自己的参数违反 4–14 个数量级，故**定理 1 不覆盖其仿真与实验**。

**但要区分两件事**（避免过度断言）：条件被违反说明的是**该 Lyapunov 界太保守/配平有误**，不等于闭环必然不稳定。实际回路增益为 $c_3$（$\bar\varphi_3$ 在 $u$ 的表达式中被抵消），2000 是合理增益；$\frac14\bar\varphi_3^4(\hat W^\top S)^2$ 中的巨大系数被极小的 $(\hat W^\top S)^2$ 抵消。**不能由此推断实验发散，只能推断“定理未覆盖”**。

---

## 10. 数值与结构一致性清单

| 项 | 观察 | 影响 | 等级 |
|---|---|---|---|
| 网络数 | 文中 8 个（2+3+3），结论称 5 个 | 复杂度叙述错误 | 已核 |
| 实验 $\lambda_{a1}=0.1$ | 违反 $\lambda_{a1}>\frac12$ | 实验不满足自身设计条件 | 已核 |
| 仿真 $\lambda_{c1}=\lambda_{c2}=\lambda_{a3}=0.4$ | 第三个下标疑为 $\lambda_{c3}$ | 排版 | D |
| 实验初值 $\hat W_{a3}(0)=2\times10^{-3}\mathbf 1_5$ | 按 $\bar\varphi_3\approx6.5\times10^8$，控制项 $\frac12\hat W_{a3}^\top S\bar\varphi_3\sim10^5$ V | 与可行电压不相容 | **D（需原图）** |
| 仿真 $\hat W_{a3}(0)=10^{-8}$ | 同一式给 $\sim3$ V | 与“初始抖振”描述自洽 | 已核 |
| 基函数宽度 | $S_{\theta2}$: $/2$；$S_{\Gamma2}$: $/0.01$；$S_{\Gamma3},S_{\theta3}$: $/10^4$ | 覆盖范围差异大，需核 | D |
| $\mathcal X_{\Gamma2}=\mathcal X_{\theta2}=[x_1,x_2,y_d,\dot y_d]$ | 同一输入、宽度差 200 倍 | 两个网络近似同一函数空间的不同尺度 | 已核 |
| 定理 1 措辞 | “increasing $\varpi$ while decreasing $\ell$ leads to improved precision” | 与 $\sqrt{2\varpi/\ell}$ 相反（应为减小 $\varpi$、增大 $\ell$） | D/C |
| 表 2 单位 | $\bar\beta_e=7\times10^3$ bar | 若实为 $7\times10^7$ Pa，$\bar\varphi_3^2$ 降 100 倍，结论（违反 12 个数量级）不变 | 已核（稳健） |

$\bar\varphi_3$ 的计算对表 2 的读数敏感，但对**定性结论不敏感**：即使 $\bar\beta_e$ 读小两个数量级，条件仍被违反 $\ge10^{11}$。

---

## 11. 未闭合清单（按对结论的影响分级）

### C1（否定“近最优”）
1. 代价泛函在跟踪工况下发散，优化问题不适定（§3）。
2. 三个估计 HJB 的“$H=0$”不被权重一致蕴含；给出数值反例（§7.3）。
3. 更新律不含代价/Q/R/残差信息，无 $J-J^\star$ 估计（§7.4）。

### C2（否定“定理 1 按其字面成立/覆盖其实验”）
4. $Y^{\min}=0$ 使 $\ell=0$，比较引理与稳态界失效（§6）。
5. 力环充分条件被自身参数违反 4–14 个数量级（§9）。
6. 实验 $\lambda_{a1}<1/2$ 违反设计条件（§10）。

### C3（可修复，但原文未做）
7. $\mathcal P\to0$ 缺 Barbalat/PE 一步（§7.2）。
8. (72) 的 $\bar\varphi_3$ 幂次不一致；(53) 截断；$\mathcal K^{-1}$ 特征值方向；$\varpi/\ell$ 的解释句反向（§8、§9、§10）。
9. 半全局初始域未给；NN 逼近的紧集 $\Omega$ 与轨迹不变性循环（§4 前提）。

### C4（结构性，非笔误）
10. $\Theta_3=\delta\bar\varphi_3(x_3,u)u+\tilde f_3$ 依赖 $u$，而标识器输入 $\mathcal X_{\theta3}$ 不含 $u$（也不含 $F_L$，后者经 $\dot{\hat\alpha}_2^\star$ 进入目标）。**标识器的“理想权重”不是其声明输入的函数**，恒定 $W^\star_{\theta3}$ 不存在（§2.3、§5.4）。
11. 同理 $\Theta_2-\dot{\hat\alpha}_1^\star$ 依赖 $\hat W_{a1}$ 及其更新律，$\mathcal X_{\theta2}$ 不含这些量。
12. $\bar\varphi_3$ 无正下界、无不变集；$u=0$ 处非 Lipschitz；控制律右端含 $\mathrm{sign}(u)$ 的隐式方程未讨论解的存在唯一性。
13. $\bar\Delta_{\theta i}$ 的有界性依赖状态有界，而状态有界又是待证结论（循环），只能靠半全局论证闭合，原文未做。

### C5（完全未涉及）
14. 量测噪声、速度获取方式、滤波带宽。
15. 输入饱和（结论承认可能饱和，但理论与仿真均无）。
16. **任何时间保证**：无有限/固定/预设时间，$T$ 未建立；无 $T$ 附近奇异性问题（因为不存在），也无 $T$ 后行为定义。

---

## 12. 待原图核对项（当前工具只能读文本层）

| 编号 | 位置 | 待核内容 | 若不同的影响 |
|---|---|---|---|
| D1 | p.9 (53) | 末尾 $-\sigma_2\tilde W^\top_{\Theta2}$ 是否被截断 | 不影响 (55) |
| D2 | p.10 (71) | $(\lambda_{a2}-\lambda_{c2})$ 是否应为 $(\lambda_{a3}-\lambda_{c3})$ | 仅排版 |
| D3 | p.12 实验初值 | $\hat W_{g3}(0)=2\times10^{-3}$ 是否为 $\hat W_{a3}(0)$、指数是否 $10^{-8}$ | 影响可复现性与 §10 的相容性判断 |
| D4 | p.12 表 2 | $\bar\beta_e=7\times10^3$ bar 的指数与单位 | 影响 $\bar\varphi_3$ 的绝对量级，不影响定性结论 |
| D5 | p.11 定理 1 | “increasing $\varpi$ while decreasing $\ell$” 原文措辞 | 若原文如此，则为逻辑/表述错误 |
| D6 | p.6–7 (32) | 公式排版是否与解析稿一致（多重下标） | 我已在 §7.1 独立复核，结论不受影响 |
