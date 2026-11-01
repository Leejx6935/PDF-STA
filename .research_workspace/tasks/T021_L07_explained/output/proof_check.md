# L07 关键步骤独立复算

复算对象：Jiang, Shen, Cheng, *Applied Mathematical Modelling* **131** (2024) 190–204，doi:10.1016/j.apm.2024.03.026。
版本：MinerU `doc:36d2694/tier:standard`（SHA256 `36d2694f…b758`，15 页），MinerU 文本全文 + 原图核对 PDF p.6–p.9。
本文件是我自己的推导，不是原文结论，也不是旧报告或旧审核的复述。凡属假设的都写明。

---

## 0. 复算清单与结论速览

| 编号 | 对象 | 位置 | 我的结论 |
|---|---|---|---|
| C1 | \(z_1\) 的坐标定义 | 式 (21)(29)，p.194–195 | 原文自洽，\(z_1=x_1-x_1^{c}\) |
| C2 | (51) 的归属 | 式 (51)，p.197 | **(51) 属于对比控制器 CFB，不是本文控制器**；旧报告的"内部矛盾"判断不成立 |
| C3 | \(z_1\to\) 真实位置误差 | 式 (24)(25)(29) | 桥接式成立；真实误差界被 \(k_0\) 放大，约 21–26 倍 |
| C4 | (44) 的 \(-3/4\) 配平 | 式 (42)(44)，p.196 | **成立，且 \(3/4\) 最优可达**；旧报告"多计 3 倍"错误 |
| C5 | (45)–(46) 的分数幂常数 | p.196 | **成立且紧**，\(6\sigma_1(1-p)p^{p/(1-p)}\) 恰好够用 |
| C6 | (47) 的 \(\alpha\) | p.197 | 成立；但 \(k_3>D/2\) 未验证，阈值 \(\pi_0<0.041\) V |
| C7 | (47) 的 \(\beta\) | p.197 | **\(\beta<0\)，无条件失败**：需 \(p>1\) |
| C8 | (48)(49)(50) | p.197 | 按自给增益，三式均无定义 |
| C9 | 可挽救的结论 | — | 可由 \(\beta<0\) 改证**指数实用稳定**，非有限时间 |

---

## 1. C1：坐标审计

**原式**（21，p.194）：\(z_0=\int_0^t x_1\,\mathrm dt-x_0^{c}\)，\(x_0^{c}=\int_0^t x_d\,\mathrm dt\)；\(z_i=x_i-x_i^{c}\ (i>0)\)。
**原式**（29，p.195）：\(\dot z_1=x_2-\dot x_1^{c}=z_2+x_2^{c}+\alpha_1-\alpha_1-\dot x_1^{c}\)。

中间插入的 \(+\alpha_1-\alpha_1\) 是拆项：\(x_2=z_2+x_2^{c}\)（按 (21)），故 \(\dot z_1=z_2+x_2^{c}-\dot x_1^{c}\)。

**结论**：该式只在 \(z_1=x_1-x_1^{c}\) 时成立，与 (21) 一致。原文此处自洽。

---

## 2. C2：(51) 是谁的坐标

**原式**（p.197）："(51) \(z_i=x_1-x_d\ (i=1)\)；\(z_i=x_i-x_i^{c}\ (i>1)\)，\(v_i=z_i-\xi_i\)"。

**上下文证据（两条，均出自 p.197–198 原文）**：

1. (51) 前一句是 "we compare it with the command-filtered control method presented in [24]. **The latter is described as follows**: The Tracking errors \(z_i\) … are defined as (51)"。"The latter" 指 [24]。
2. p.198 第 (3) 条："**CFB: This controller is described as (52)**"。而 (52) 的 \(\alpha_1=-k_1z_1+\dot x_d-c_1v_1^{2p-1}\) 显式使用 \(\dot x_d\)——正是本文批评的特征。

**结论**：(51)–(52) 是对比控制器 [24] 的设计，不是本文控制器的坐标重定义。**旧报告 D5 的"原文内部不一致"判断不成立**，应撤回。

**但**：由此产生的实质问题仍然成立，且方向不同于旧报告——本文定理界定的是 \(z_1=x_1-x_1^{c}\)，而跟踪目标与 Table 2 的 \(M_e,\mu_e,\sigma_e\) 是 \(x_1-x_d\)。二者之间缺桥（见 C3），缺的是**推导**，不是定义冲突。

---

## 3. C3：从 (29) 到真实位置误差（核心）

### 3.1 原式

- (24)：\(\dot z_0=x_1-\dot x_0^{c}\)
- Fig. 3（p.198 原图）：左上角标注 \(\dot x_0^{c}=x_d\)
- (25)：\(\alpha_0=x_d-k_0z_0-c_0v_0^{2p-1}\)
- (21)：\(x_1=z_1+x_1^{c}\)
- (23)：\(v_0=z_0-\xi_0\)

### 3.2 推导

第一步。由 \(x_0^{c}=\int x_d\) 得 \(\dot x_0^{c}=x_d\)，代入 (24)：

\[
\dot z_0=x_1-x_d=:e .
\tag{D1}
\]

这是恒等式，不含任何近似。它说明状态扩张的实际内容：\(z_0\) 是位置误差的积分。

第二步。\(e=z_1+x_1^{c}-x_d\)，插入 \(\pm\alpha_0\)：

\[
e=z_1+(x_1^{c}-\alpha_0)+(\alpha_0-x_d)=z_1+(x_1^{c}-\alpha_0)-k_0z_0-c_0v_0^{2p-1}.
\tag{D2}
\]

第三步。由 (23)，\(z_0=v_0+\xi_0\)。

### 3.3 界

记定理残差半径 \(\rho\)，使 \(|v_i|\le\rho,\ |\xi_i|\le\rho\)（由 \(V_3\ge\frac12v_i^2,\frac12\xi_i^2\) 对所有 \(i\) 成立，不只 (48) 写的 \(i=1\)）。Lemma 4 给 \(|x_1^{c}-\alpha_0|\le\varphi_0\)。则

\[
|e|\le|z_1|+\varphi_0+k_0|z_0|+c_0|v_0|^{2p-1}
\le(2k_0+2)\rho+\varphi_0+c_0\rho^{2p-1},
\qquad |z_1|\le2\rho .
\tag{D3}
\]

**成立条件**：\(v_i,\xi_i\) 确实进入残差集（即 C7 之后仍然成立的界）；\(\varphi_0\) 存在（即 C9 讨论的一致性问题）。若这两条不成立，(D3) 只是形式界。

### 3.4 标量复算（对界做算术，不是仿真）

取 \(\rho=10^{-4}\)、\(\varphi_0=10^{-3}\)、\(k_0=20\)、\(c_0=0.1\)、\(2p-1=0.960396\)：

| 项 | 值 |
|---|---|
| \(|z_1|\le2\rho\) | \(2.0\times10^{-4}\) |
| \(\varphi_0\) | \(1.0\times10^{-3}\) |
| \(k_0|z_0|\le20\cdot2\rho\) | \(4.0\times10^{-3}\) |
| \(c_0|v_0|^{2p-1}=0.1\times(10^{-4})^{0.960396}\) | \(1.44\times10^{-5}\) |
| 合计 | \(\approx5.21\times10^{-3}\) |

\(|e|\) 的界是 \(|z_1|\) 界的 **26 倍**；若只看 \(k_0\) 一项，放大因子是 **21**。

**结论**：(50) 作为 \(z_1\) 的界正确；把它读作跟踪误差界则低估一个量级。真实误差仍是可调残差（因为 \(k_0\) 固定、\(\rho\) 可压），但 (50) 报出的数字不是它的数字。

---

## 4. C4：(44) 的 \(-3/4\) 配平

### 4.1 代数恒等式

对任意实数 \(a,b\)：

\[
-a^2+ab\le-\tfrac34a^2+b^2,
\qquad\text{因 }(-a^2+b^2)-(-a^2+ab)=b^2-ab=\big(b-\tfrac a2\big)^2-\tfrac{a^2}{4}\ge-\tfrac{a^2}{4}.
\]

更直接：\(-\tfrac34a^2+b^2-(-a^2+ab)=\tfrac14a^2-ab+b^2=(a/2-b)^2\ge0\)。等式当且仅当 \(a=2b\)。**\(3/4\) 是此形式下的最优系数**，不能更大。

### 4.2 参数通道

自适应律 (42)：\(\tau_{\hat\theta_1}=-\gamma_1x_2v_2-\sigma_1\hat\theta_1\)，配合 (19)(20) 的投影。为使 (44) 成立，(19) 必须读作 \(\hat\theta_i\) 的时间导数 \(=\operatorname{Proj}(\tau_{\hat\theta_i})\)（理由见 4.5）。

\[
\frac1{\gamma_i}\tilde\theta_i\dot{\tilde\theta}_i
=-\frac1{\gamma_i}\tilde\theta_i\operatorname{Proj}(\tau_i)
\overset{(20)}{\le}-\frac1{\gamma_i}\tilde\theta_i\tau_i
=\tilde\theta_ix_2v_i+\frac{\sigma_1}{\gamma_i}\tilde\theta_i\hat\theta_i .
\]

与 (40) 的交叉项 \(-\tilde\theta_ix_2v_i\) 精确抵消，剩

\[
\frac{\sigma_1}{\gamma_i}\tilde\theta_i\hat\theta_i
=\frac{\sigma_1}{\gamma_i}\tilde\theta_i(\theta_i-\tilde\theta_i)
=\frac{\sigma_1}{\gamma_i}\tilde\theta_i\theta_i-\frac{\sigma_1}{\gamma_i}\tilde\theta_i^2
\le-\frac{3\sigma_1}{4\gamma_i}\tilde\theta_i^2+\frac{\sigma_1}{\gamma_i}\theta_i^2 .
\tag{D4}
\]

上文用 \(\tilde\theta\theta\le\frac14\tilde\theta^2+\theta^2\)（即 (16) 取 \(b_1=b_2=1,b_3=1/2\)）。

### 4.3 扰动通道

(42)：\(\dot{\hat\Delta}_i=\mu_iv_i-\sigma_1\hat\Delta_i\)，无投影。由 \(\tilde\Delta_i=\Delta_i-\hat\Delta_i\)：

\[
\frac1{\mu_i}\tilde\Delta_i\dot{\tilde\Delta}_i
=\frac1{\mu_i}\tilde\Delta_i\dot\Delta_i-\tilde\Delta_iv_i+\frac{\sigma_1}{\mu_i}\tilde\Delta_i\hat\Delta_i .
\]

加回 \(+\tilde\Delta_iv_i\) 后，

\[
=\frac1{\mu_i}\tilde\Delta_i\dot\Delta_i+\frac{\sigma_1}{\mu_i}\tilde\Delta_i\Delta_i-\frac{\sigma_1}{\mu_i}\tilde\Delta_i^2
=-\frac{\sigma_1}{\mu_i}\tilde\Delta_i^2+\frac{\sigma_1}{\mu_i}\tilde\Delta_i\Big(\Delta_i+\frac{\dot\Delta_i}{\sigma_1}\Big).
\]

用 \(\tilde\Delta Y\le\frac14\tilde\Delta^2+Y^2\)（\(Y=\Delta_i+\dot\Delta_i/\sigma_1\)）：

\[
\le-\frac{3\sigma_1}{4\mu_i}\tilde\Delta_i^2+\frac{\sigma_1}{\mu_i}\Big(\Delta_i+\frac{\dot\Delta_i}{\sigma_1}\Big)^2 .
\tag{D5}
\]

**逐项对应 (44)**：\(\tilde\Delta\) 的 \(-\frac{\sigma_1}{2\mu}\) 与 \(-\frac{\sigma_1}{4\mu}\) 合计 \(-\frac{3\sigma_1}{4\mu}\)，加项 \((\sigma_1/\mu)[\dot\Delta/\sigma_1+\Delta]^2\)。**完全一致。** \(g_1\) 通道同理，得 \(-\frac{3\sigma_1}{4\delta_1}\tilde g_1^2+\frac{\sigma_1}{\delta_1}g_1^2\)。

### 4.4 与旧报告的分歧

旧报告称 (44) "同时列出 \(-\frac{\sigma_1}{2\mu}\) 与 \(-\frac{\sigma_1}{4\mu}\)，只能得到 \(-\frac{\sigma_1}{4\mu}\)，合计 3/4 是把 1/4 放大了 3 倍"。

**该判断错误。** 上方 (D5) 是一条单链：代数整理产生 \(-\frac{\sigma_1}{\mu}\tilde\Delta^2\) 的**全额**，一次 Young 收回 \(\frac14\)，净剩 \(\frac34\)。原文把 \(\frac34\) 拆印成两处只是排版分项，合计正确。审核备忘 E2 的方向正确，此处给出完整链条作为独立佐证。

### 4.5 一个未闭合的排版疑点

MinerU 文本把 (19) 读作 \(\hat\theta_i=-\operatorname{Proj}_{\hat\theta_i}(\tau_i)\)（无时间导数、带负号）。

**若字面成立**：\(\frac1\gamma\tilde\theta\dot{\tilde\theta}=+\frac1\gamma\tilde\theta\operatorname{Proj}(\tau)=\frac1\gamma\tilde\theta\tau=-\tilde\theta x_2v-\frac{\sigma_1}{\gamma}\tilde\theta\hat\theta\)，与 \(-\tilde\theta x_2v\) 相加得 \(-2\tilde\theta x_2v\)，交叉项**不抵消**，且泄漏项变号为正。此时 (44) 从第一步就不成立。

**因此**：以 (44) 为准则，(19) 必为 \(\dot{\hat\theta}_i=\operatorname{Proj}(\tau_{\hat\theta_i})\)。MinerU 的 OCR 大概率丢了点号。

**【待验证】** p.5（印刷 194）原图我未查看，无法确认 (19) 的排版。这属于"需要原图才能定论"的项，不影响 C4–C8 的结论，但应记录。

---

## 5. C5：(45)–(46) 的分数幂常数是紧的

**原式**（46）：额外加入 \(-\frac{\sigma_1}{2^p}\sum(\tilde\theta_i^2/2\gamma_i)^p\) 等，并把常数额外计为 \(6\sigma_1(1-p)p^{p/(1-p)}\)。

注意 \(\frac{\sigma_1}{2^p}\big(\frac{\tilde\theta^2}{2\gamma}\big)^p=\sigma_1\big(\frac{\tilde\theta^2}{4\gamma}\big)^p\)，与 (45) 的写法一致。

**预算**：由 (D4)，可用于转换的余额是 \(-\frac{\sigma_1}{4\gamma}\tilde\theta^2\)。令 \(u=\tilde\theta^2/(4\gamma)\ge0\)，余额为 \(-\sigma_1u\)，需换得 \(-\sigma_1u^p\)，即要求

\[
\sigma_1u\ \ge\ \sigma_1u^p-C
\iff C\ \ge\ \sigma_1\max_{u\ge0}\big(u^p-u\big).
\]

\(f(u)=u^p-u\) 在 \(u=p^{1/(1-p)}\) 取极大，极大值 \(p^{p/(1-p)}-p^{1/(1-p)}=p^{p/(1-p)}(1-p)\)。故

\[
C_{\min}=\sigma_1(1-p)p^{p/(1-p)} .
\tag{D6}
\]

恰为 (46) 每通道的常数。三通道 \(\tilde\theta\) + 一通道 \(\tilde g\) + 两通道 \(\tilde\Delta\) = 6 个，故 \(6\sigma_1(1-p)p^{p/(1-p)}\)。

**数值校验**（\(p=99/101\)）：\((1-p)p^{p/(1-p)}=0.019802\times0.371577=7.358\times10^{-3}\)；在 \(u=p^{1/(1-p)}=0.36422\) 处 \(u^p-u=0.37158-0.36422=7.36\times10^{-3}\)。**两者相等**。

**结论**：这一步不仅正确，而且**紧**——常数不能再小。这是本文证明里做得最干净的一段，应作为正面评价保留。

---

## 6. C6：(47) 的 \(\alpha\)

**原式**：\(\alpha=2\min\{k_0-\frac12,k_1-\frac12,k_2-\frac12,k_3-\frac D2,\sigma_1\}\ge0\)。

**核算**。由 (46)，各通道对 \(V_3\) 的系数：

- \(v_i^2\ (i\le2)\)：系数 \(k_i\)，\(V_3\) 中为 \(\frac12v_i^2\) ⇒ \(\alpha\le2k_i\)；
- \(v_3^2\)：\(k_3-\frac D2\) ⇒ \(\alpha\le2(k_3-\frac D2)\)；
- \(\xi_i^2\ (i\le2)\)：\(k_i-\frac12\) ⇒ \(\alpha\le2(k_i-\frac12)\)；
- \(\xi_3^2\)：\(k_3\) ⇒ \(\alpha\le2k_3\)（被 \(2(k_3-\frac D2)\) 支配，\(D>0\)）；
- \(\tilde\theta_i^2\)：系数 \(\frac{\sigma_1}{2\gamma_i}\)，\(V_3\) 中为 \(\frac1{2\gamma_i}\) ⇒ \(\alpha\le\sigma_1\)；\(\tilde g,\tilde\Delta\) 同理。

**结论**：\(\alpha\) 的写法**正确**（我最初怀疑 \(\theta\) 通道应为 \(\frac{3\sigma_1}{4}\)，是因为没有先扣掉进 (46) 分数幂的 \(\frac14\) 余额；扣除后余额正是 \(\frac{\sigma_1}{2\gamma}\)，折算到 \(V_3\) 即 \(\sigma_1\)）。

**但**：\(k_3-\frac D2>0\) 无验证。\(D=g_{1\max}f_{\max}\pi_0\)，\(f_{\max}=\sqrt{2P_s}=\sqrt{2\times10^7}=4.472\times10^3\)。取 Table 1 的 \(g_1\approx5.52\) 作为 \(g_{1\max}\) 的量级：

\[
D\approx5.52\times4.472\times10^3\times\pi_0=2.469\times10^4\,\pi_0,
\qquad
k_3-\frac D2>0\iff \pi_0<\frac{2k_3}{g_{1\max}f_{\max}}\approx0.0405\ \mathrm V .
\]

**【待验证】** 论文未给 \(\pi_0\) 与 \(g_{1\max}\)。若死区半宽超过约 0.04 V（伺服阀常见量级），\(\alpha<0\)，定理从 (47) 第一行就失效。这是本文与 C7 并列的第二个不可判定项。

---

## 7. C7：(47) 的 \(\beta\)（决定性缺陷）

### 7.1 结构核算

**原式**：\(\beta=\min\{2^p(c_i-\frac{l_i}{2p}),\ \frac{2^pl_i}{2p},\ \frac{\sigma_1}{2^p}\}\ge0,\ i=0,1,2,3\)。

**系数来源**：

- \(V_3\ge\frac12v_i^2\Rightarrow V_3^p\ge2^{-p}v_i^{2p}\Rightarrow v_i^{2p}\le2^pV_3^p\)。故 \(-(c_i-\frac{l_i}{2p})v_i^{2p}\ge-2^p(c_i-\frac{l_i}{2p})V_3^p\) ⇒ 第一项。
- 同理 \(-(l_i/2p)\xi_i^{2p}\ge-2^p(l_i/2p)V_3^p\) ⇒ 第二项。
- \(V_3\ge\frac{\tilde\theta^2}{2\gamma}\Rightarrow V_3^p\ge(\frac{\tilde\theta^2}{2\gamma})^p\)。故 \(-\frac{\sigma_1}{2^p}(\frac{\tilde\theta^2}{2\gamma})^p\ge-\frac{\sigma_1}{2^p}V_3^p\) ⇒ 第三项。

结构本身**正确**。问题在数值。

### 7.2 正性条件

\(\beta>0\) 要求三个入口全为正，其中最苛刻的是第一个：

\[
c_i-\frac{l_i}{2p}>0\iff l_i<2pc_i\iff p>\frac{l_i}{2c_i}.
\tag{D7}
\]

【原文事实，p.198 原图确认】\(c_i=0.5\ (i=1,2,3)\)，\(l_i=1\)，\(p=99/101\)。

代入 (D7)：\(p>\dfrac{1}{2\times0.5}=1\)。**与 \(0<p<1\) 直接冲突，无解。**

即：这一对 \((c_i,l_i)\) 的取值使 \(\beta>0\) 对**任何**容许的 \(p\) 都不可能成立。不是"选得不好"，是"临界点正好落在 \(l_i=2c_i\) 上，而 \(2p<2\)"。

### 7.3 数值

\(p=99/101=0.9801980\)，\(2p=1.9603960\)，\(2^p=1.97273\)，\(l_i/(2p)=0.5101006\)。

| \(i\) | \(c_i\) | \(c_i-l_i/(2p)\) | \(2^p(\cdot)\) |
|---|---|---|---|
| 1,2,3 | 0.50 | \(-0.0101006\) | \(-0.019925\) |
| 0 | 0.10 | \(-0.4101006\) | \(-0.80902\) |

其余入口：\(2^pl_i/(2p)=1.00629>0\)；\(\sigma_1/2^p>0\)（\(\sigma_1\) 正）。

\[
\beta=\min\{-0.019925,\ -0.80902,\ 1.00629,\ 0.50691\sigma_1\}<0 .
\]

若 \(l_0\) 不取 1（原文 "\(l_i=1,\ i=1,2,3,4\)" 的指标范围本身有歧义，未单列 \(l_0\)），\(i=0\) 一行不可定；但 \(i=1,2,3\) 已给出 \(-0.0199<0\)，**\(\beta<0\) 的结论不依赖该歧义**。

---

## 8. C8：(48)(49)(50) 按自给增益均无定义

记 \(b>0\)（(47) 第三行全为正项之和，设 \(\sigma_1>0\)）。

**(48)** 第二支 \(\sqrt{2\,[\,b/((1-\eta)\beta)\,]^{1/p}}\)：\(\beta<0\Rightarrow b/((1-\eta)\beta)<0\Rightarrow\) 实数意义下 \((\cdot)^{1/p}\) 无定义（\(1/p\approx1.02\) 非整数）。整个 \(\min\{\cdot,\cdot\}\) 因此无意义。

**(49)** 第一支的对数真数 \(\dfrac{\eta\alpha V_3^{1-p}(0)+\beta}{\beta}=1-\dfrac{\eta\alpha V_3^{1-p}(0)}{|\beta|}\)。取 \(\alpha\approx39\)（当 \(\sigma_1\ge19.5\)）、\(|\beta|=0.809\)：

- 若 \(V_3^{1-p}(0)>\dfrac{|\beta|}{\eta\alpha}=\dfrac{0.0207}{\eta}\)，真数为负，对数无定义。
- 因 \(1-p=0.019802\) 极小，\(V_3^{1-p}(0)\) 对任何物理初值都接近 1：\(V_3(0)=10^{-3}\) 给 \(0.872\)，\(V_3(0)=1\) 给 \(1\)。取 \(\eta=0.5\) 需 \(V_3^{1-p}(0)<0.0415\)，等价于 \(V_3(0)<10^{-70}\)。

**结论**：对任何实际初值，(49) 的第一支真数为负，式子无定义。第二支同理（真数 \(1-\alpha V_3^{1-p}(0)/(\eta|\beta|)\)）。

**(50)** 沿用 (48)，同样无定义。

**补充**：\(\beta<0\) 时 (46) 变为 \(\dot V_3\le-\alpha V_3+|\beta|V_3^p+b\)。因 \(0<p<1\) 时 \(V^p\le V+1\)（\(V\le1\) 时 \(V^p\le1\le V+1\)；\(V\ge1\) 时 \(V^p\le V\)），在 \(V_3\) 很小时 \(V_3^p\gg V_3\)，右端可以为正。**这个不等式连"原点邻域吸引"都推不出。** 但这是对界成立与否的判断，不是对闭环行为的判断。

---

## 9. C9：能挽救多少（我的保守修补，非原文结论）

由 \(V_3^p\le V_3+1\)：

\[
\dot V_3\le-\alpha V_3+|\beta|(V_3+1)+b=-(\alpha-|\beta|)V_3+(b+|\beta|).
\tag{D8}
\]

若 \(\alpha>|\beta|\)（数值上 \(39>0.809\)，成立），则

\[
V_3(t)\le e^{-(\alpha-|\beta|)t}V_3(0)+\frac{b+|\beta|}{\alpha-|\beta|}.
\tag{D9}
\]

**这是什么**：指数实用稳定 + 显式残差集。**这不是什么**：不是有限时间，不是 (48)–(50)，不是原文的任何陈述。

[D8] 的代价是把 \(|\beta|V_3^p\) 退化到 \(|\beta|(V_3+1)\)，对小 \(V_3\) 是非常松的估计；因此 (D9) 的残差比真实收敛值大得多。它只用于说明"\(\beta<0\) 时闭环仍可能有界"，**不能**用来给本文背书。

**仍然缺的**：(D9) 需要 \(\alpha>|\beta|\) 且 \(\alpha>0\)，而 \(\alpha>0\) 又依赖 C6 的 \(\pi_0\) 条件与 \(\sigma_1\) 的取值。论文两者都未给，所以连 (D9) 也无法代入数字。

---

## 10. 滤波器与非光滑虚拟控制

### 10.1 能说的

\(\alpha_i\) 只出现在 (22) 的右端作为输入。\(v_i^{2p-1}\) 在 \(\mathbb R\) 上连续（\(2p-1=0.9604\in(0,1)\)，Hölder 连续）。故闭环右端连续，Carathéodory/Peano 意义下解存在；滤波器输出 \(x_i^{c}\) 是其自身 ODE 的解，始终 \(C^1\)。**不存在"因为 \(\dot\alpha\) 无界所以 \(x_i^{c}\) 无界"的推理**。

### 10.2 不能说的

Lemma 4 的**一致**界未证，三处缺口：

1. **区间**：Lemma 4 写 \(\forall t\in[0,T_c)\)，而 (43)(46) 用于 \(t>T_1>T_c\)。延拓需 \(\phi_i\) 对一切 \(t\) 成立，原文未做。
2. **正则性**：Lemma 4 引 [27]，其证明通常要 \(|\dot\alpha|\) 有界。此处 \(|\dot\alpha|\sim|v|^{-0.04}\)，在 \(v=0\) 处退化。指数 0.04 意味着退化极弱且可积，但不能当作没有。
3. **初值**：\(\xi_i(0)=0\) 与 \(x_i^{c}(0)=\alpha_{i-1}(0)\) 必须同时成立，否则起始有跳变、(43) 的前提不干净。

**准确表述**：非光滑虚拟控制的导数问题是**一致 \(\phi_i\) 未证**，不是"必然无界"。对方波参考（\(\alpha_0\) 跳变）尤其如此——滤波器把它抹平，抹平的量取决于 \(\omega_n\)，而 \(\omega_n\) 与 \(\phi\) 的定量关系原文未给。

---

## 11. 与旧报告、旧审核的分歧汇总

| 编号 | 旧判断 | 我的复算 | 处理 |
|---|---|---|---|
| D1 | (36) 首项符号印成正，应为负 | 原图确认 (36) 为 \(+\sum k_iv_i^2\)，(40) 为 \(-\)；两式同源，不能并存 | 维持 |
| D2 | \(-3/4\) "多计 3 倍" | **(D5) 单链给出全额 \(-3/4\)，且为最优** | **撤回旧判断**；E2 方向正确，此处补全链条 |
| D3 | \(\beta<0\) | 确认；并加强为 \(p>1\) 才可救，即**任何 \(p\) 都不行** | 维持并加强 |
| D5 | (29) 与 (51) 定义不一致 | **(51) 属对比控制器 [24]**，p.198 "CFB: This controller is described as (52)" 为证 | **撤回"内部矛盾"**；改为"缺桥" |
| — | （旧报告未提） | (48)(49)(50) 三式均无定义，不只 (49) | 新增 |
| — | （旧报告未提） | \(k_3>D/2\) 需 \(\pi_0<0.041\) V，未验证 | 新增 |
| — | （旧报告未提） | (45)–(46) 常数紧，是证明中最干净的一段 | 新增（正面） |

**关于审核备忘 E2 的使用**：我按原文重推了该步，得到与 E2 相同的结论，但**没有**引用其"已核"字样作为我的核对依据；4.2–4.3 的推导是我自己写的。

---

## 12. 仍未闭合的缺口（精确停在这里）

1. **(19) 的排版**：MinerU 显示 \(\hat\theta=-\operatorname{Proj}(\tau)\)，与 (44) 不相容。需 p.5 原图。若真带负号，整个 (44) 的符号前提失效，问题比 \(\beta<0\) 更早。
2. **\(\sigma_1\) 的取值**：4.2 节未给。\(\alpha\)、(D9)、残差集全部依赖它。
3. **\(\pi_0\)、\(g_{1\max}\)**：未给，故 \(D\) 与 \(k_3-D/2\) 的符号不可判。
4. **\(\theta_i\)、\(g_1\) 的上下界**：投影 (18) 需要，未给数值，故投影实际未定义。
5. **\(\varepsilon\)、\(l_0\)、\(\hat\Delta_i(0)\)、\(x(0)\)、求解器与步长**：均未给，按原文不可复现。
6. **一致 \(\phi_i\)**：见 10.2，未证。
7. **\(f_{\min}\)**：(38) 除以 \(f(P_L,u)\)，假设 2 只有"far away from zero"的定性说法，无下界。

以上 7 项都不能用"类似可得"跨过；它们是**具体缺失的数值或具体缺失的引理**，各自需要单独补。
