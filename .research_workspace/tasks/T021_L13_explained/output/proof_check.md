# L13 关键证明步骤独立重算

对象：Niu S., Wang J., Li Z., Liu Z., Zhao J., Sun Z., *Command filter and neural network-based fixed-time backstepping control of electro-hydraulic system with uncertainties*, Applied Mathematical Modelling 157 (2026) 116848, doi:10.1016/j.apm.2026.116848。

本文件是**本轮独立重算**，不是原文作者结论，也不沿用旧报告或旧审核的判断作为前提。凡属我亲自核对原图的事实，标 `[原图]`；凡属解析文本、未看原图，标 `[文本]`；凡属我的推导，标 `[本轮]`。

原图核对范围：p.6、p.7、p.8、p.11、p.12，由本地页面图 `L13_page6/7/8/11/12.png` 直接查看。

---

## 0. 记号与已固定的原文内容

$$
\Gamma=\frac{\gamma+1}{2},\qquad \Lambda=\frac{\lambda+1}{2},\qquad 0<\gamma<1<\lambda .
$$

$$
V=\sum_{i=1}^{3}V_i+\frac{\tilde w^{T}\tilde w}{2\tau},\quad
V_1=\frac{z_1^2}{2},\ V_2=\frac{z_2^2}{2},\ V_3=\frac{z_3^2}{2\beta_e}.
$$

$[原图]$ p.6 式 (9)：$\dot V\le -a_1V^{b_1}-a_2V^{b_2}-a_3V+c$，$a_i>0$，$0<b_1<1<b_2$，$c>0$。

$[原图]$ p.6 式 (10)：残差集取 $\min\{(\tfrac{c}{(1-\theta)a_1})^{1/b_1},(\tfrac{c}{(1-\theta)a_2})^{1/b_2},\tfrac{c}{(1-\theta)a_3}\}$。

$[原图]$ p.6 式 (11)：
$$
T_{\max}=\frac{1}{a_3(1-b_1)}\ln\!\Big(1+\frac{a_3}{a_1}\Big)+\frac{1}{a_3(b_2-1)}\ln\!\Big(1+\frac{a_3}{a_2}\Big).
$$

$[原图]$ p.11 式 (40)：$\dot V\le -r_2\sum V_i-r_1(\sum V_i)^\Gamma-r_3(\sum V_i)^\Lambda-\frac{\delta}{2\tau}\tilde w^{T}\tilde w+\pi_1$，
其中
$$
r_1=\min\{2^\Gamma k_{\gamma1},\,2^\Gamma k_{\gamma2},\,2^\Gamma\beta_{e\min}^{\Gamma}k_{\gamma3}\},
$$
$$
r_2=\min\{2k_1-1-r_1,\ 2k_2-1-r_1,\ \beta_{e\min}(2k_3-1)-r_1\},
$$
$$
r_3=\min\{2^{\Lambda}k_{\lambda1},\,2^{\Lambda}k_{\lambda2},\,2^{\Lambda}\beta_{e\min}^{\Lambda}k_{\lambda3}\},
$$
$$
\pi_1=r_1(1-\Gamma)\Gamma^{\frac{\Gamma}{1-\Gamma}}+\sum_{i=1}^{3}\frac{\varepsilon_i^{*2}}{2}+\frac{\delta\|w^*\|^2}{2\tau}.
$$

$[原图]$ p.11 式 (44)：
$$
\dot V\le -r_4V-r_5V^{\Gamma}-r_6V^{\Lambda}+\pi_4,
$$
$$
\pi_4=\pi_1+\frac{\delta\varrho}{2\tau}\pi_3,\quad
r_4=\min\{r_2,\delta(1-\varrho)\},\quad
r_5=\min\{r_1,\delta\varrho(2\tau)^{\Gamma-1}\theta^{\Gamma}\},\quad
r_6=\min\{r_3,\delta\varrho(2\tau)^{\Lambda-1}\theta^{\Lambda}\}.
$$

$[原图]$ p.11 末行："Replace symbol representation and let $a_1=r_4,\ a_2=r_5,\ a_3=r_6$, $b_1=\Gamma$ and $b_2=\Lambda$."

$[原图]$ p.11 式 (41) 后文字："Choosing a constant $\theta=1-\theta^{\Gamma}$ yields $0<\theta<1$."

---

## 1. 第 A 步：把式 (44) 还原为"四个可合并支"

式 (44) 的第一行是四个来源不同的项相加。重算时不能直接跳到最后一行，必须先拆开：

**A1 线性支。** 由式 (36) 与式 (37) 的 $+r_1\sum V_i$、式 (38) 的 $z_i\varepsilon_i\le z_i^2/2+\varepsilon_i^{*2}/2$：

$$
-k_iz_i^2+\tfrac12 z_i^2=-(2k_i-1)V_i\quad(i=1,2),
$$
$$
-k_3z_3^2+\tfrac12z_3^2=-\beta_e(2k_3-1)V_3 .
$$

用 $\beta_e\ge\beta_{e\min}$ 统一化、再减去 $+r_1\sum V_i$，得 $-r_2\sum V_i$，$r_2$ 如式 (40)。

**A2 Γ 支。** 来自式 (37) 的 $-r_1(\sum V_i)^\Gamma$。

**A3 Λ 支。** 来自 $\sum_i-k_{\lambda i}|z_i|^{\lambda+1}$。逐项：

$$
-k_{\lambda1}|z_1|^{\lambda+1}=-k_{\lambda1}(2V_1)^{\Lambda}=-2^{\Lambda}k_{\lambda1}V_1^{\Lambda},
$$
$$
-k_{\lambda2}|z_2|^{\lambda+1}=-2^{\Lambda}k_{\lambda2}V_2^{\Lambda},\qquad
-k_{\lambda3}|z_3|^{\lambda+1}=-k_{\lambda3}(2\beta_eV_3)^{\Lambda}.
$$

用 $\beta_e\ge\beta_{e\min}$ 得 $-r_3\sum V_i^{\Lambda}$，$r_3$ 如式 (40)。**注意这一步用的是"逐通道幂次"，不是"合计幂次"**，这是后面缺口的来源。

**A4 权重支。** 式 (41)–(42) 把 $-m$ 拆成 $-(θm)^\Gamma-(θm)^\Lambda$ 加一个常数 $\pi_3$，其中 $m=\tilde w^{T}\tilde w=2\tau V_w$，$V_w$ 为权重分量。式 (43) 把 $\delta/(2\tau)$ 拆成 $1-\varrho$ 与 $\varrho$ 两份，式 (44) 用式 (42) 替换后者。

于是式 (44) 第一行的四个"阻尼"支为
$$
\underbrace{r_2x+\delta(1-\varrho)y}_{\text{线性}}\quad
\underbrace{r_1x^{\Gamma}+c_\Gamma y^{\Gamma}}_{\Gamma}\quad
\underbrace{r_3x^{\Lambda}+c_\Lambda y^{\Lambda}}_{\Lambda}\quad
\underbrace{\left(\text{已并入上两式的 }\varrho\text{ 份}\right)}_{\varrho-\text{拆分}}
$$
其中 $x=\sum V_i$，$y=V_w=m/(2\tau)$，并已算出

$$
c_\Gamma=\frac{\delta\varrho}{2\tau}\theta^{\Gamma}(2\tau)^{\Gamma}=\delta\varrho(2\tau)^{\Gamma-1}\theta^{\Gamma},
\qquad
c_\Lambda=\frac{\delta\varrho}{2\tau}\theta^{\Lambda}(2\tau)^{\Lambda}=\delta\varrho(2\tau)^{\Lambda-1}\theta^{\Lambda}.
$$

（用 $(\theta m)^{a}=\theta^{a}(2\tau)^{a}y^{a}$，$a\in\{\Gamma,\Lambda\}$。两个 $c$ 与式 (44) 的 $r_5,r_6$ 第二项逐字一致，说明我对拆分的读法正确。）

**A 步结论：** 式 (44) 的 $r_4,r_5,r_6$ 是"把 $x$ 通道与 $y$ 通道的同类项取小后合并到 $V=x+y$"的产物。合并这一步对 $\Gamma$ 和 $\Lambda$ 不对称。

---

## 2. 第 B 步：$\Gamma$ 支与线性支的合并——精确，无损失

**线性支。** 直接代换：
$$
r_2x+\delta(1-\varrho)y\ \ge\ \min\{r_2,\delta(1-\varrho)\}\,(x+y)=r_4V .
$$
成立条件：$x,y\ge0$，$r_2>0$（否则取小后为负，$r_4<0$，见第 6 节）。**无近似。**

**Γ 支。** 用次可加性：对 $0<\Gamma<1$、$x,y\ge0$ 有 $(x+y)^{\Gamma}\le x^{\Gamma}+y^{\Gamma}$。于是
$$
r_1x^{\Gamma}+c_\Gamma y^{\Gamma}\ \ge\ \min\{r_1,c_\Gamma\}(x^{\Gamma}+y^{\Gamma})\ \ge\ \min\{r_1,c_\Gamma\}(x+y)^{\Gamma}=r_5V^{\Gamma}.
$$
成立条件：$\Gamma\in(0,1)$（即 $0<\gamma<1$，原文已给）。**取同系数即可，无损失。**

**这一步与旧报告的判断一致**（旧报告 §8.1 写"用 $x^\Gamma+y^\Gamma\ge(x+y)^\Gamma$"，方向正确）。我没有发现旧报告在此处有误。

---

## 3. 第 C 步：$\Lambda$ 支的合并——缺一个 $2^{1-\Lambda}$

**问题。** 对 $\Lambda>1$，次可加性方向相反：$(x+y)^{\Lambda}\ \ge\ x^{\Lambda}+y^{\Lambda}$。因此
$$
r_3x^{\Lambda}+c_\Lambda y^{\Lambda}\ \ge\ \min\{r_3,c_\Lambda\}(x^{\Lambda}+y^{\Lambda})
$$
不能再往下推到 $V^{\Lambda}$。可用的正确不等式是凸性给出的
$$
(x+y)^{\Lambda}\le 2^{\Lambda-1}\big(x^{\Lambda}+y^{\Lambda}\big)
\quad\Longleftrightarrow\quad
x^{\Lambda}+y^{\Lambda}\ \ge\ 2^{1-\Lambda}(x+y)^{\Lambda}.
$$
（推导：$t\mapsto t^{\Lambda}$ 凸，$(x+y)^{\Lambda}=2^{\Lambda}\big(\tfrac{x+y}{2}\big)^{\Lambda}\le 2^{\Lambda}\cdot\tfrac{x^{\Lambda}+y^{\Lambda}}{2}$。）

**因此可证的常数是**
$$
r_6^{\ \mathrm{fix}}=2^{1-\Lambda}\min\{r_3,\ c_\Lambda\},
$$
而原文写 $r_6=\min\{r_3,c_\Lambda\}$，**高估 $2^{\Lambda-1}$ 倍**。

**尖锐性（不是"取弱界"的问题）。** 取 $x=y=s>0$：
$$
x^{\Lambda}+y^{\Lambda}=2s^{\Lambda},\qquad
2^{1-\Lambda}(x+y)^{\Lambda}=2^{1-\Lambda}(2s)^{\Lambda}=2s^{\Lambda}.
$$
等号成立。所以不存在对一切 $(x,y)$ 都成立且常数大于 $2^{1-\Lambda}$ 的同类不等式；这不是我用了较弱的 Young 配平，而是该不等式的**精确常数**。这一点与旧审核对 L07 的更正（"较弱配平不能否定较强界"）不冲突：那里是存在更强的可行界，这里是常数已达最优。

**最小反例（标量，$\Lambda=1.3$）。** 取 $x=y=1$、$r_3=c_\Lambda=1$，则 $r_6=1$。原文断言的
$$
-r_3x^{\Lambda}-c_\Lambda y^{\Lambda}\le -r_6V^{\Lambda}
$$
变成 $-2\le-2^{1.3}=-2.462$，**为假**。取 $r_6^{\mathrm{fix}}=2^{-0.3}=0.8123$ 后：$-2\le-0.8123\times2^{1.3}=-2$，等号成立。

**后果的量化。** 用原文自己的 $r_3$ 代入，若 $r_3\le c_\Lambda$（本文参数下成立），
$$
2^{1-\Lambda}r_3=2^{1-\Lambda}\cdot 2^{\Lambda}k_{\lambda i}=2k_{\lambda i}.
$$
即"若把两通道合并的损失计入，$\Lambda$ 支的净系数是 $2k_{\lambda i}$，而不是 $2^{\Lambda}k_{\lambda i}$"。$2^{1.3}=2.462$ 相对 $2$ 高估 23%。

**结论的定性影响：无。** $r_6^{\mathrm{fix}}>0$ 仍成立，固定时间结构不变，只有 $T_{\max}$ 的第二个对数里 $r_6$ 换数（见第 5 节数值）。所以这是**可修的常数缺口，不是结论崩塌**；但按原文写法直接代入 $r_6$ 会得到一个并未被证明的不等式。

---

## 4. 第 D 步：与 Lemma 1 的系数对应

Lemma 1 的三项按**指数**定位，不按出现顺序：
$$
-a_1V^{b_1}\ (0<b_1<1)\ \longleftrightarrow\ -r_5V^{\Gamma}\ \Rightarrow\ a_1=r_5,\ b_1=\Gamma;
$$
$$
-a_2V^{b_2}\ (b_2>1)\ \longleftrightarrow\ -r_6V^{\Lambda}\ \Rightarrow\ a_2=r_6,\ b_2=\Lambda;
$$
$$
-a_3V\ \longleftrightarrow\ -r_4V\ \Rightarrow\ a_3=r_4 .
$$

**正确映射：$a_1=r_5,\ a_2=r_6,\ a_3=r_4$。**

**原文 $[原图]$：$a_1=r_4,\ a_2=r_5,\ a_3=r_6$。三项全部错位一格**，且 $b_1=\Gamma$、$b_2=\Lambda$ 保持不变——所以错位后配对完全失效：

| Lemma 1 位置 | 应有系数 | 原文填入 | 实际后果 |
|---|---|---|---|
| $a_1V^{b_1}=a_1V^{\Gamma}$ | $r_5$ | $r_4$ | 用线性系数当 $\Gamma$ 系数 |
| $a_2V^{b_2}=a_2V^{\Lambda}$ | $r_6$ | $r_5$ | 用 $\Gamma$ 系数当 $\Lambda$ 系数 |
| $a_3V$ | $r_4$ | $r_6$ | 用 $\Lambda$ 系数当线性系数 |

**这为什么不是笔误级别。** $a_3$ 在式 (11) 中出现 4 次（两个前置因子、两个对数内的分母参数），$a_1,a_2$ 各在对数内出现一次。错位后：

- 正确：$T_{\max}=\dfrac{\ln(1+r_4/r_5)}{r_4(1-\Gamma)}+\dfrac{\ln(1+r_4/r_6)}{r_4(\Lambda-1)}$；
- 错位：$T_{\max}^{\mathrm{wrong}}=\dfrac{\ln(1+r_6/r_4)}{r_6(1-\Gamma)}+\dfrac{\ln(1+r_6/r_5)}{r_6(\Lambda-1)}$。

残差集式 (10) 的三个阈值同样错位（$c/((1-\theta)a_i)$ 的分母换成不同量纲的增益），失去可比性。

**与旧报告的分歧：无。** 旧报告 §8.2 的判断（"三项全部错位，正确为 $a_1=r_5,a_2=r_6,a_3=r_4$"）经我核对原图后成立。T021 备忘录 E3 的同一判断也成立。我在此只补充：错位的**方向**是把"出现顺序"当成了"指数顺序"，改法唯一，且不改变 $b_1,b_2$ 的取值。

---

## 5. 第 E 步：式 (11) 的两段积分逐行重推（$c=0$，即 $a_1,a_2,a_3>0$ 且忽略常数项）

设 $\dot V\le -a_1V^{b_1}-a_2V^{b_2}-a_3V$，$0<b_1<1<b_2$，$a_i>0$。

### 5.1 第一段：$V\ge1$ 降到 $V=1$

丢弃 $-a_1V^{b_1}$（在 $V\ge1$ 时为负项，丢弃得**上界**，方向正确）：
$$
\dot V\le -a_2V^{b_2}-a_3V .
$$
令 $u=V^{b_2-1}$。因 $b_2>1$ 且 $V>0$，
$$
\dot u=(b_2-1)V^{b_2-2}\dot V
\le (b_2-1)V^{b_2-2}\big(-a_2V^{b_2}-a_3V\big)
=-(b_2-1)\big(a_2u^2+a_3u\big).
$$
$u>0$，两边除以 $a_2u^2+a_3u>0$：
$$
\frac{\dot u}{a_2u^2+a_3u}\le -(b_2-1).
$$
积分（$u$ 从 $u_0=V(0)^{b_2-1}$ 降到 $1$）：
$$
\int_{u_0}^{1}\frac{du}{a_2u^2+a_3u}
=\frac{1}{a_3}\Big[\ln u-\ln(a_2u+a_3)\Big]_{u_0}^{1}
=\frac{1}{a_3}\ln\frac{a_2u_0+a_3}{u_0(a_2+a_3)} .
$$
令 $u_0\to\infty$（即 $V(0)\to\infty$，取一致上界）：$\dfrac{a_2u_0+a_3}{u_0(a_2+a_3)}\to\dfrac{a_2}{a_2+a_3}$，故积分 $\to-\dfrac{1}{a_3}\ln\big(1+\dfrac{a_3}{a_2}\big)$。于是
$$
-(b_2-1)T_A\ \ge\ -\frac{1}{a_3}\ln\Big(1+\frac{a_3}{a_2}\Big)
\ \Longrightarrow\
T_A\le\frac{1}{a_3(b_2-1)}\ln\Big(1+\frac{a_3}{a_2}\Big).
$$

### 5.2 第二段：$V$ 从 $1$ 降到 $0$

丢弃 $-a_2V^{b_2}$：
$$
\dot V\le -a_1V^{b_1}-a_3V .
$$
令 $u=V^{1-b_1}$（$1-b_1>0$）：
$$
\dot u=(1-b_1)V^{-b_1}\dot V\le (1-b_1)V^{-b_1}\big(-a_1V^{b_1}-a_3V\big)=-(1-b_1)(a_1+a_3u).
$$
$$
\int_{0}^{1}\frac{du}{a_1+a_3u}=\frac{1}{a_3}\ln\frac{a_1+a_3}{a_1}=\frac{1}{a_3}\ln\Big(1+\frac{a_3}{a_1}\Big),
$$
$$
T_B\le\frac{1}{a_3(1-b_1)}\ln\Big(1+\frac{a_3}{a_1}\Big).
$$

### 5.3 相加

$$
T_A+T_B=\frac{1}{a_3(1-b_1)}\ln\Big(1+\frac{a_3}{a_1}\Big)+\frac{1}{a_3(b_2-1)}\ln\Big(1+\frac{a_3}{a_2}\Big),
$$
与式 (11) 逐字相同。**式 (11) 的结构正确、可复现，且与初值无关（上限取 $u_0\to\infty$）。**

**旧报告的判断（§8.3"式 (11) 是 $c=0$ 的精确两段积分"）经我重算成立。**

**但必须写明前提：** 上式从"$\dot V\le$ 三项负"出发，全程没有 $+c$。式 (44) 有 $+\pi_4$，所以式 (11) 直接套用未经证明。

---

## 6. 第 F 步：$c>0$ 时的严格版本

### 6.1 为什么不能直接套

$+c$ 削弱下降速率，且当 $V$ 接近残差水平时速率趋于 $0$。上式两段积分都在分母上依赖 $a_i$ 与 $u$，一旦加上 $+c$，第二段会变成 $\dot u\le-(1-b_1)(a_1+a_3u)+cV^{b_1}$，不能直接分离变量。原文只写 "Since (44) satisfies Lemma 1" 并引 [42]，本篇未复述证明。

### 6.2 可补的严格版本

取 $\eta\in(0,1)$，令 $R>0$ 满足
$$
F(R):=a_1R^{b_1}+a_2R^{b_2}+a_3R=\frac{c}{1-\eta}.
$$
则当 $V\ge R$ 时 $F(V)\ge F(R)=c/(1-\eta)$，故
$$
\dot V\le -F(V)+c\le -\eta F(V)=-\eta\big(a_1V^{b_1}+a_2V^{b_2}+a_3V\big).
$$
此时第 5 节的两段积分只需把每段乘 $\eta$。若 $R<1$：
$$
T_R\le\frac{1}{\eta}\left[\frac{\ln(1+a_3/a_1)}{a_3(1-b_1)}+\frac{\ln(1+a_3/a_2)}{a_3(b_2-1)}\right]=\frac{T_{\max}}{\eta}.
$$
若 $R\ge1$，只需第一段，界更小，$T_{\max}/\eta$ 仍是上界。

**成立条件（须明示）：**
1. $a_i>0$，$0<b_1<1<b_2$；
2. $F$ 在 $(R,\infty)$ 上局部 Lipschitz（$b_i>0$ 已保证），解在区间上存在；
3. $c>0$ 且 $F(R)=c/(1-\eta)$ 有解（$F$ 严格增、$F(0)=0$、$F(\infty)=\infty$，唯一解存在）；
4. 比较定理适用（$\dot V\le-\eta F(V)$ 的右端连续且在 $\{V\ge R\}$ 上负）。

**$R$ 取式 (10) 的水平时 $\eta\ge\theta$。** 设 $R=\min\{T_1',T_2',T_3'\}$，$T_i'=\big(\tfrac{c}{(1-\theta)a_i}\big)^{1/b_i}$。若最小值取在 $i$，则 $a_i(T_i')^{b_i}=\tfrac{c}{1-\theta}$，故 $F(R)\ge\tfrac{c}{1-\theta}$，于是
$$
\eta=1-\frac{c}{F(R)}\ \ge\ 1-(1-\theta)=\theta .
$$
所以严格的表述是：**$c>0$ 时，进入式 (10) 残差集的时间上界是 $T_{\max}/\eta$，且 $\eta\ge\theta$；原文的 $T_{\max}$（即 $\eta=1$）只对应 $c=0$。**

**这一点与 T021 备忘录的补充方向一致**（该备忘录给出 $F(R)=d/(1-\eta)$ 与 $T_R\le\frac1\eta[\cdot]$ 的框架）。我在此新增的是：当 $R$ 取式 (10) 的具体水平时，$\eta\ge\theta$，从而把"$1/\eta$"与原文已有的 $\theta$ 挂钩，不需要引入新参数。

### 6.3 数值示例（假定值，非原文给出）

原文未给 $\varrho$、$\theta$、$W$、$\beta_{e\min}$。取 $\varrho=0.5$、$\tau=30$、$\delta=4$、$\beta_{e\min}=1.7\times10^{9}$ Pa，并由 $\theta+\theta^{\Gamma}=1$（见 7.3）得 $\theta=0.4302$：

| 量 | 值 | 来源 |
|---|---|---|
| $\Gamma$ | $0.6667$ | $\gamma=1/3$ |
| $\Lambda$ | $1.3$ | $\lambda=8/5$ |
| $r_1$ | $0.02381$ | 由 $k_{\gamma2}=0.015$ 限定 |
| $r_2$ | $-0.8238$ | 由 $k_2=0.1$ 限定，**为负** |
| $r_3$ | $0.24623$ | 由 $k_{\lambda2}=0.1$ 限定 |
| $c_\Gamma$ | $0.2911$ | $\delta\varrho\theta^\Gamma(2\tau)^{\Gamma-1}$ |
| $c_\Lambda$ | $2.282$ | $\delta\varrho\theta^\Lambda(2\tau)^{\Lambda-1}$ |
| $r_5$ | $0.02381$ | $\min\{r_1,c_\Gamma\}$ |
| $r_6$（原文） | $0.24623$ | $\min\{r_3,c_\Lambda\}$ |
| $r_6$（修正） | $0.20000$ | $2^{-0.3}\times0.24623$ |

$r_6^{\mathrm{fix}}=0.2$ 恰等于 $2k_{\lambda2}$，印证 3 节的恒等式。

若强行取 $r_4=\delta(1-\varrho)=2$（绕过 $r_2<0$）：
$$
T_{\max}^{\mathrm{fix}}\approx 1.5\ln(1+2/0.02381)+1.6667\ln(1+2/0.2)\approx 6.65+4.00=10.65\ \mathrm{s},
$$
$$
T_{\max}^{\mathrm{paper}\ r_6}\approx 6.65+1.6667\ln(11.12)\approx 6.65+3.68=10.33\ \mathrm{s},
$$
$$
T_{\max}^{\mathrm{wrong\ map}}\approx 1.415+32.88=34.3\ \mathrm{s}.
$$
三项差异说明：映射错误是量值级的（10 s vs 34 s），$2^{1-\Lambda}$ 是 3% 级。论文声称 C1 在 0.1 s 内收敛（p.14，作者自报），与任一 $T_{\max}$ 都不矛盾（上界保守），但足以说明 $T_{\max}$ 不可当设计时间使用。

---

## 7. 参数条件的独立核查

### 7.1 $r_2>0$ 的充要条件，及论文增益为何违反

由 1 节 A1，需要
$$
2k_i-1>r_1\ (i=1,2),\qquad \beta_{e\min}(2k_3-1)>r_1 .
$$
$[原图]$ p.12 增益行：$k_1=1000$，$k_2=0.1$，$k_3=12000$；$k_{\gamma\cdot}=(0.2,0.015,12)$；$k_{\lambda\cdot}=(1000,0.1,1000)$。原文该行下标有重复（$k_{\gamma2}$ 出现两次、$k_{\lambda2}$ 出现两次、第三位误标 $k_{\lambda3}$），数值本身清楚；$k_2=0.1$ 无歧义。

$$
2k_2-1-r_1=0.2-1-0.02381=-0.82381<0 .
$$
**即使令 $r_1=0$ 仍有 $-0.8<0$。** 故 $r_2<0$，$r_4=\min\{r_2,\delta(1-\varrho)\}<0$，Lemma 1 的 $a_3>0$ 不成立，式 (11) 不能由这组增益得出。

**这不是说仿真一定发散。** 充分条件保守时闭环仍可能收敛；结论只是：**这套仿真不构成定理成立的经验证据**。若要满足条件，最低要求是 $k_2>0.5$（更严格地 $k_2>(1+r_1)/2\approx0.512$）。

对 $r_1$ 的稳健性说明：$r_1=\min\{0.317,0.0238,\ \text{极大}\}=0.0238$，即使下标重构把 $0.015$ 分给 $k_{\gamma1}$ 或 $k_{\gamma3}$，最小值仍是 $2^\Gamma\times0.015$，故 $r_1$ 与 $r_2<0$ 的结论对标签歧义不敏感。

### 7.2 $c_{i1}+c_{i2}>0$ 的隐含可行域

$[原图]$ p.7 式 (16)：$\psi(z_i)=[z_i]^\gamma$（$|z_i|\ge\xi_i$），$c_{i1}z_i+c_{i2}z_i^{3}$（$|z_i|<\xi_i$），
$c_{i1}=\frac{3-\gamma}{2}\xi_i^{\gamma-1}$，$c_{i2}=\frac{\gamma-1}{2}\xi_i^{\gamma-3}$。

（原图确认是**三次**；解析文本的 $z_i^2$ 是 OCR 伪影。旧报告"应为三次"的判断成立，其"待原图"标记本轮关闭。）

$$
c_{i1}+c_{i2}=\frac{(3-\gamma)\xi_i^{\gamma-1}+(\gamma-1)\xi_i^{\gamma-3}}{2}
=\frac{\xi_i^{\gamma-3}}{2}\Big[(3-\gamma)\xi_i^{2}+(\gamma-1)\Big].
$$
$\xi_i>0$ 时 $\xi_i^{\gamma-3}>0$，故
$$
c_{i1}+c_{i2}>0\iff \xi_i^{2}>\frac{1-\gamma}{3-\gamma}.
$$
$\gamma=1/3$ 时阈值 $\xi_i^{2}>1/4$，即 $\xi_i>0.5$。标量核对：$\xi=1$ 时 $c_1+c_2=4/3-1/3=1>0$；$\xi=0.4$ 时 $c_1=2.456$、$c_2=-3.837$，和为 $-1.381<0$，违反。

论文只写 $0<\xi_i\le1$ 并声称 $c_{i1}+c_{i2}>0$，未给该下界；Remark 4 又说"取足够小的 $\xi_i$"，方向相反。仿真未给 $\xi_i$，无法核对。

另：$c_{i2}<0$ 对一切 $\gamma<1$ 成立（$\frac{\gamma-1}{2}<0$），这是 Case 2 用 $z^4\le z^2$ 放缩的前提，无附加条件。

### 7.3 $\theta$ 是隐式方程的唯一根，不是自由参数

$[原图]$ p.11：式 (41) 是恒等式（对任意 $\theta$ 成立），但式 (42) 的推导把
$$
(\theta m)^{\Lambda}-(1-\theta^{\Gamma})m
$$
改写为 $(\theta m)^{\Lambda}-\theta m$，这**要求 $1-\theta^{\Gamma}=\theta$**。同一页又写 "Choosing a constant $\theta=1-\theta^{\Gamma}$"，即 $\theta$ 是
$$
\theta+\theta^{\Gamma}=1
$$
在 $(0,1)$ 上的唯一根（左端在 $0$ 处为 $1>0$，在 $1$ 处为 $1>0$… 更精确地，$g(\theta)=1-\theta-\theta^{\Gamma}$ 严格递减，$g(0)=1$，$g(1)=-1$，故唯一根）。

$\Gamma=2/3$：令 $t=\theta^{1/3}$，$t^{3}+t^{2}=1$，$t=0.7549$，$\theta=t^{3}=0.4302$。

**须与式 (10) 的 $\theta$ 区分。** 式 (10) 的 $\theta$ 是任意裕度参数（$0<\theta<1$），式 (41)–(42) 的 $\theta$ 被方程钉死。两处共用同一符号，论文未说明。若实现时把二者当同一个量，$\theta$ 就没有自由度，残差与时间都无法权衡；若当作两个量，则式 (44) 的 $r_5,r_6$ 里的 $\theta$ 必须取 $0.4302$。

---

## 8. 与原式、旧报告、旧审核的分歧汇总

| 项 | 原文（我核到的） | 旧报告 | 旧审核 | 本轮我的判断 |
|---|---|---|---|---|
| 式 (8) $p_2$ | $[原图]$ 印为 $-A_1/m$，与式 (1)/(6) 冲突 | 指为内部不一致，按物理应取 $+A_1/m$ | 确认是原文内部不一致，非 OCR | **同意**。补：式 (7)(25)(33) 彼此自洽，错的只是 $p_2$ 的取值 |
| 式 (16) 次数 | $[原图]$ 三次 | 判为 OCR/印刷问题，标"待原图" | 关闭为 OCR 伪影 | **同意，并关闭**：原图确为三次 |
| 式 (40) $2^3$ | $[原图]$ $2^{\Lambda}$ | 标"待原图" | 关闭为 OCR 伪影 | **同意，并关闭** |
| 式 (44) 映射 | $[原图]$ $a_1=r_4,a_2=r_5,a_3=r_6$ | 判为实质性错位 | 确认 $a_1=r_5,a_2=r_6,a_3=r_4$ | **确认错位**，与两者一致 |
| 式 (11) 结构 | $c=0$ 两段积分 | 判为正确 | 未反对 | **确认正确**，逐行重推通过 |
| $c>0$ 的上界性 | 未证，引 [42] | 判为缺口 | 保留为待 [42] 核对 | **确认缺口**，给出 $T_{\max}/\eta$ 且 $\eta\ge\theta$ |
| $\Lambda$ 支合并 | 少 $2^{1-\Lambda}$ | **未提** | **未提** | **本轮新增**，含尖锐性反例与最小反例 |
| $z_1$ 坐标 | $[原图]$ $z_1=x_1-x_d$ | 正确 | T021 更正旧对照表混入 L07 | **确认 T021 更正成立**；补：Fig. 2 求和点同向 |
| $r_2<0$ | $k_2=0.1$ | 算出 $-0.8238$ | 确认 | **确认**，并说明对标签歧义稳健 |
| $W$ 循环 | 假设，无投影 | 判为高优先级未闭合 | 保留 | **同意**，且指出只破坏"给定容差下与初值无关"，不破坏 $T_{\max}$ 不显含 $V(0)$ |

旧报告中我未能复现的一处：其 §9.5 写"按错位映射约 33 s"，我算得 34.3 s；差异来自其 $r_6$ 取值与四舍五入，不影响结论。

---

## 9. 未闭合缺口（停在精确位置，不写"类似可得"）

1. **Lemma 1 在 $c>0$ 时的原始证明**。我未读 [42]，不能确认式 (11) 是否在 [42] 中已被推广到 $c>0$。本轮给出的是**替代性充分界** $T_{\max}/\eta$，不是对原文的证实。
2. **$W$ 的先验界**。式 (35) 无投影、无死区、无归一化；若 $W$ 由 $V(0)$ 反推，则 $\pi_3,\pi_4,R$ 均依赖初值。要闭合需新增投影算子或饱和自适应，本篇无。精确缺口：无法在不加机制的前提下把 $W$ 与 $x_0$ 解耦。
3. **滤波器幂次递推**。$[原图]$ p.8：$r_{0,i}=1-(n-i)d_0$，$d_0=-1$，$i=1,\dots,n+1$。$n=2$ 时 $r_{0,1}=2,r_{0,2}=1,r_{0,3}=0$，$l_2$ 的指数 $r_{0,3}/r_{0,2}=0$。**这是直接代入的结果，不是猜测。** 若改为从 $r_{0,n+1}=1$ 出发（$r_{0,i}=1-(n+1-i)d_0$），指数为 $2/3$ 与 $1/2$，均合法；但这是我的重构，未经 [49] 核实。同时 $r_{\infty,i}$ 用印刷式在 $n=2$ 时给出指数 $1/(1-d_\infty)$ 与 $1+d_\infty$，均 $>1$，合法——两个递推的索引基点不一致，至少一处印刷有误，我无法判定是哪一处。
4. **滤波器收敛时间未进入 $T_{\max}$**。Remark 6 只给 $|v_i-\Xi^{(i-1)}|\le L_i\Delta^{(i-1)/n}\epsilon^{(n-i+1)/n}$，$\epsilon_i^*$ 依赖 $\Delta$（轨迹的高阶导数），而 $\Delta$ 又依赖初值与轨迹。论文未把滤波器收敛时间与 $T_{\max}$ 相加，因此"从 $t=0$ 起总时间有界"没有被建立。
5. **量纲**。$V_1$[m²]、$V_2$[(m/s)²]、$V_3$[Pa] 直接相加，$V^{\Gamma}$ 与 $\sqrt{2V_{\rm res}}$ 只有形式意义。要闭合需逐通道引入尺度 $z_{i,\rm scale}$ 并重推全部常数，论文未做；我在此只报告缺口，不做重推（重推会改变全部数值，超出"复核"范围）。
6. **$p_3$ 的下界与切换面**。$u=-(1/p_3)B$，$p_3=k_qk_u(h_1g_1+\alpha h_2g_2)$，$g_i$ 含 $H(u)$。$x_3\to P_s$ 或 $x_4\to0$ 时 $p_3\to0$，$u$ 可能无界；$B=0$ 时 $H(0)$ 未定义。论文未给 $p_3>0$ 的下界，也未讨论 Filippov 解。
7. **$0<x_3,x_4<P_s$ 的正向不变性**。$\bar x_3=x_3-\alpha x_4$ 不可逆，$p_3$ 分别依赖 $x_3,x_4$，第四阶动态未进入 Lyapunov 分析。

以上 7 项中，1、3 需外部文献（[42]、[49]）；2、4、5、6、7 需新增分析；本轮只到缺口为止。

---

## 10. 额外假设声明

本文件在重算中**显式引入**了以下原文未写明的假设，读者须注意它们不是论文结论：

- **H1**：$x,y\ge0$（即 $V_i\ge0$、$V_w\ge0$），用于所有幂次不等式。由 $V_i=z_i^2/2$ 等定义自动成立。
- **H2**：$R<1$ 时的两段分割；若 $R\ge1$ 只用第一段，界更小，结论不变。
- **H3**：比较定理适用所需的正则性（$F$ 局部 Lipschitz、解在 $[0,T_R]$ 存在）。
- **H4**：6.3 节的数值示例使用 $\varrho=0.5$、$\tau=30$、$\delta=4$、$\beta_{e\min}=1.7\times10^{9}$ Pa 的**假定值**；原文未给 $\varrho$、$\beta_{e\min}$。表中 $T_{\max}$ 仅用于量级比较，不是论文数值。
- **H5**：增益行按 $(k_{\gamma1},k_{\gamma2},k_{\gamma3})=(0.2,0.015,12)$、$(k_{\lambda1},k_{\lambda2},k_{\lambda3})=(1000,0.1,1000)$ 重构。我已说明 $r_1$ 与 $r_2<0$ 的结论对此重构不敏感。
- **H6**：$2^{1-\Lambda}$ 的推导假定合并方式与原文相同（把 $x$ 通道与 $y$ 通道的 $\Lambda$ 阻尼按同系数取小后合并到 $V$）。若改用"保留两通道分立项"的广义 Lemma，则不需要该因子，但那已不是 Lemma 1。

---

## 11. 一句话总结

式 (11) 的两段积分是对的；式 (44) 到 Lemma 1 的**指数—系数配对错了**，改法唯一（$a_1=r_5,a_2=r_6,a_3=r_4$）；$\Lambda$ 支的合并还少 $2^{1-\Lambda}$（可修，不影响定性）；$c>0$ 时严格界是 $T_{\max}/\eta$、$\eta\ge\theta$；而论文自报的 $k_2=0.1$ 使 $r_2<0$，其定理在这组增益下无法启动。四者相互独立，须分别记账。
