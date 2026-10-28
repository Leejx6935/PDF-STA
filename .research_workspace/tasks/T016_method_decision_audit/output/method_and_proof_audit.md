# 证明框架与两篇原文 Lyapunov 证据

**日期**：2026-10-27。**范围**：仅依据任务指定的解析稿与方法卡；未读新全文，未独立复算全部定理。标签：【原文】解析稿可核对；【自推】本文代入/推导；【待核】需原 PDF 或完整复算。

## 1 “学习控制与传统方法证明框架不同”在哪些情形成立

必须分开三类，不能把 RL 当成一种证明。

**(a) 物理参数自适应。** 以 Chen 2025 式 (11)(31) 为代表：未知常值 \(\theta\) 线性进入回归，\(\dot x=f_0+\varphi^\top\theta+d\)，\(\dot{\hat\theta}=\mathrm{Proj}(\Gamma\tau)\)。取
\[
V=V_z+\tfrac12\tilde\theta^\top\Gamma^{-1}\tilde\theta,\qquad \tilde\theta=\theta-\hat\theta .
\]
导数中的 \(\tilde\theta^\top\varphi z\) 由更新律抵消；投影只多一个非负项（原文 (35)）。新增误差是有限维 \(\tilde\theta\)，没有函数逼近残差；参数收敛仍需 PE，投影只给 \(\hat\theta\in\Omega_\theta\)（(34)）。【原文】这是增广的复合 Lyapunov，不是另一套框架。

**(b) RBF/模糊自适应。** \(f(\chi)=W^{*\top}\Phi(\chi)+\epsilon(\chi)\)。新增 \(\tilde W\) 与 \(\epsilon\)：\(V\) 多 \(\tfrac12\tilde W^\top\Gamma^{-1}\tilde W\)，\(\dot V\) 多 \(-\tilde W^\top\Phi z+\epsilon z\)。要得 UUB/实用有限时间，需在工作域上 \(\|\Phi\|\le\bar\Phi\)、\(|\epsilon|\le\bar\epsilon\)。仍是复合 Lyapunov；新增的是**逼近残差**，不是 Bellman 残差。

**(c) actor–critic。** 除 \(\tilde W_a,\tilde W_c\) 外还引入 Bellman/最优性残差。若更新律对 Bellman 误差做梯度，Lyapunov 导数会出现其平方项或其界；若 critic 精确，或证明只用权重有界加鲁棒项，则不必出现 Bellman 平方项。无模型的 DRL 甚至没有确定性 Lyapunov 结论。故“有学习就必有 Bellman 残差平方项”不成立。

**可成立的说法**：学习项改变误差状态维数、假设（逼近域、PE、残差界）和残差类型；残差非零时结论只能到实用有限时间/UUB。**不可成立的说法**：所有学习方法共用一种证明，或传统方法必然更轻。

## 2 Yang 2021：自适应 STA 的关键一步

【原文】(26) \(\chi=[\mathrm{sign}(s)|s|^{1/2},u_n]^\top\)，(28)
\[
V_{co}=V_o+\frac{(\beta_1-\beta_{10})^2}{2\omega_1}+\frac{(\beta_2-\beta_{20})^2}{2\omega_2},\quad V_o=\chi^\top P_1\chi .
\]
(29)–(32) 给 \(\dot V_o\le-\lambda_{\min}(Q)\|\chi\|^2/(2|\chi_1|)\)，再用 (33)(34) 得
\[
\dot V_o\le-r\sqrt{V_o},\quad r=\frac{\lambda_{\min}^{1/2}(P_1)\lambda_{\min}(Q)}{2\lambda_{\max}(P_1)} .
\]
于是 (39)
\[
\dot V_{co}\le-\kappa\sqrt{V_{co}}+\Theta .
\]
只有 S1（\(|s|-v\ge0,\ \beta_1>\alpha_s\)）且 (25) 的 \(\beta_1\) 阈值成立时，取 \(\varepsilon=\frac{\alpha_2}{2\alpha_1}\sqrt{\omega_2/\omega_1}\) 才得 (41) \(\dot V_{co}\le-\kappa\sqrt{V_{co}}\)。S2 中 \(\Theta>0\)，导数不定，只能维持 \(|s|\le v_m\)。【原文】

**对应误差**：\(s,u_n\)，不是 \(z_1=x_1-x_{1d}\)。**实际结论**：Theorem 2 只给 \(|s|\) 有限时间进入 \(|s|\le v\)，不是 \(s\to0\)，更不是位置有限时间。观测器 (12)(15) 给 \(\dot V_{ob}\le-\varpi\|\xi\|^2+\varsigma\)，指数到球；位置结论在 Theorem 3/4：常值扰动下 Barbalat 渐近，时变扰动下 UUB。三层不能混。

【自推】由 (32) 到 (35) 的代入已验证。【待核】式 (16) 印刷只保留 \(\delta_2^2\)，漏掉 \(\varsigma\) 中的 \(l_3|u|_{\max}\)；式 (20)(22) 的 \(u_n\) 系数 1/2 不一致。未数值复算。

## 3 Chen 2025：PFTO 的关键一步

【原文】(A.1)
\[
V_1=\frac{\omega_1}{2}\tilde x_{i+1}^2+\frac12\tilde\eta_i^2,
\]
(A.2) 代入 (16)(17)：
\[
\dot V_1=-k_{f1}\omega_1\tilde x_{i+1}^2-k_{f2}\omega_1|\tilde x_{i+1}|^{(2r-1)/r}-\omega_2\tilde\eta_i^2+(\omega_2D_1+D_2)\tilde\eta_i .
\]
Lemma 3 后写成 (A.3)
\[
\dot V_1\le-\varsigma V_1^{(2r-1)/(2r)}+\nabla,
\]
其中 \(\nabla=(\omega_2D_1+D_2)\tilde\eta_i+\text{常数}\)。【自推】\(\nabla\) 含 \(\tilde\eta_i\)，不是常数；Lemma 2 要求右端常数 \(\wp_2\)。原文直接引用 Lemma 2，隐含 \(|\tilde\eta_i|\) 已有界或又做了一次 Young/吸收，解析稿未展开；若不加处理存在循环。

【自推，已代入验证】取 \(r=3\)、四个增益为 1、\(\eta_0=3\)，则 \(e=1,h=2,\hat\eta=1\) 满足 \(\dot e=0,\dot{\tilde\eta}=0\)，而 \(\hat u=\hat\eta+k_{f1}e+k_{f2}|e|^{2/3}\mathrm{sign}(e)=3=\eta_0\)。状态误差可停在非零常值而补偿精确；与 Theorem 1 的“practical”一致，不能读成精确有限时间。

**滑模与位置**：(A.15) 在 \(\Upsilon_{1i},\Upsilon_{2i}>0\) 时给 \(s_i\) 有限时间到零；但 (A.6) 中 \(m_i\) 含 \(d_i\)，\(d_i\ne0\) 时 \(s_i=0\) 不是不变集，“精确到零”偏强【待核】。Theorem 3 的 (A.18) \(\dot V_3\le-\lambda_{\min}(\Lambda)V_3+\Delta\) 只给 UUB；\(z_1\to0\) 需 \(\Delta\to0\)，原文未建立。**对应误差**：\(V_1\) 对应 \((\tilde x_{i+1},\tilde\eta_i)\)，不是 \(z_1\)。

【待核】(A.7) 的 \(\varpi_{3i}m_i\) 疑应为 \(\varpi_{3i}m_i^2\)（否则 \(V_{2i}\) 非正定，与 (A.14) 的 \(\Phi_i\) 不符）；(A.9) 末项 \(+k_{i2}m_i^2/|s_i|^{1/2}\) 的符号与吸收方式。未完整复算。

## 4 可写入开题的结论

1. 复合 Lyapunov 是共同模板；差异在新增误差、残差类型与假设，不在“传统/学习”标签。
2. Yang 的有限时间只到 \(|s|\le v\)；Chen 的有限时间只到观测器/滑模的实用集；两篇的真实位置误差都未获得精确有限时间。
3. 任何“有限时间跟踪”主张必须分别列出 \(T_v,T_o,T_s,T_z\) 及各自初值，不能用一个 max 代替。
