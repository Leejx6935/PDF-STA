# L09 论文卡：A reinforcement learning-based optimized backstepping control approach for uncertain electro-hydraulic systems

**审读日期**：2026-10-28　**范围**：仅本篇，不扩展检索、不设计新控制器、不运行仿真。
**定位**：本卡只记录“论文自身写了什么、证明是否闭合、实验能支持什么”。作者宣称与审计结论分开列（§11）。

---

## 0. 身份与覆盖

| 项 | 内容 |
|---|---|
| 题名 | A reinforcement learning-based optimized backstepping control approach for uncertain electro-hydraulic systems |
| 作者 | Chen Wang, Jianhui Wang, Jinping Ye, Qing Guo, Tieshan Li |
| 出处 | Mechanical Systems and Signal Processing 237 (2025) 112928 |
| DOI | 10.1016/j.ymssp.2025.112928 |
| 时间线 | Received 2025-02-28；Revised 2025-04-27；Accepted 2025-05-27；Online 2025-06-17 |
| 本地 PDF | `inputs/four_papers/L09_Zotero.pdf`（Elsevier 版本，PDF 直读提示加密，MinerU 可解析） |
| SHA256 | 实测 `5a17f6ae…5ca8f19`，与下发值一致 |
| MinerU | `doc:5a17f6a`，tier=standard，page_range 1–16，cache_hit=true |
| 已读范围 | 第 1–16 页文本层全部（含定理 1、仿真/实验参数、表 3、结论、参考文献） |
| 不可读部分 | Fig.2（p.11）、Fig.3（p.13）、Fig.5（p.14）为图像，曲线数值不可读；表 3 数值可读 |

**身份核验**：题名、作者、DOI、卷期、在线日期五项全部匹配，SHA256 与下发值相同，判定为本篇。后续所有结论仅适用于该版本。

---

## 1. 审计结论摘要（先给判断）

1. **稳定性：条件式半全局 UUB，证明骨架可核，但按其字面不覆盖作者自己的仿真/实验。** 骨架（逐环 Lyapunov + Young + 级联相消 + σ 修正）本身是成立的，我逐项复算通过；问题出在三处：(i) 衰减率 $\ell_i$ 依赖 $S\Gamma_i S_\Gamma^\top$ 的最小特征值 $Y^{\min}$，而该矩阵秩为 1，$p_i=5$ 时 $Y^{\min}=0$，故 $\ell_i=0$，定理中的比较引理与稳态界 $\sqrt{2\varpi/\ell}$ 失效；(ii) 力环充分条件 $c_3>\frac{2+\hat\varphi_3+2\bar\varphi_2}{4}$、$\lambda_{a3}>\frac12\hat\varphi_3$ 被论文自己的参数违反约 12–14 个数量级；(iii) 若干 Young 步的系数/量纲与式面不一致（力环的 $\bar\varphi_3^4$ 因子）。
2. **优化：未建立，且优化问题按文中定义不适定。** 三个代价泛函都含 $\alpha_i^2$（$\alpha_1=x_2\approx\dot y_d\neq0$，$\alpha_2=x_3\neq0$，$\alpha_3=u\neq0$），在跟踪工况下 $\int_0^\infty\alpha_i^2=\infty$，Definition 1 的可行策略集为空。更新律 (30)(31)(49)(50)(67)(68) 不含任何代价、Q/R 或 Bellman 残差信息，是纯“遗忘”律；“$P\to0\Rightarrow H\to0\Rightarrow$ 近最优”的推理链不成立（§5.4 给出数值反例）。
3. **时间：无任何有限时间/固定时间/预设时间结论。** 只有渐近 UUB，$T$ 未建立；无奇异性、无 $T$ 后行为、无对象/滤波/观测/真实位置的分项时间保证。本篇不是“预设时间”候选。
4. **学习—优化对照价值（本篇的主要用途）**：它是“去掉激励条件”的最简样本——结构确实简化，但收敛目标同时被去掉了；学习项渐近消失，闭环渐近退化为反步+标识器（§5.6）。这正好回答本项目“优化到底证了什么”的对照问题。

---

## 2. 模型与控制对象（A）

### 2.1 实际阶次与物理状态

- $n=3,\ m=1,\ p=1$；$x=[x_1,x_2,x_3]^\top=[y,\dot y,AP_L]^\top\in\mathbb R^3$，$y_o=x_1$（式 (6d)）。
- 伺服阀为**静态增益** $x_v=K_{sv}u$（式 (1)），**不含阀芯动态**。因此这是三阶模型；与“三级阀”模型不可等同，也不能把三级阀直接代入本节。
- 负载压力以 $P_L=P_1-P_2$ 的**差值**进入模型，$P_1,P_2$ 不单独建模。

### 2.2 模型系数复算（我独立重推）

由 (2) $Q_L=\frac{1}{\sqrt\rho}C_dwx_v\sqrt{P_s-\mathrm{sign}(x_v)P_L}$ 与 (4) $Q_L=A\dot y+\frac{V_t}{4\beta_e}\dot P_L+C_{tl}P_L$，取 $x_3=AP_L$：

$$\dot x_3=\frac{4\beta_eA}{V_t}Q_L-\frac{4\beta_eA^2}{V_t}x_2-\frac{4\beta_eC_{tl}}{V_t}x_3,$$

与 (6c) 的系数逐项一致（含 $\frac{4\beta_eC_dwAK_{sv}}{V_t\sqrt\rho}$）。式 (7b) 中 $B$ 被印成 $\bar b$，(6c) 中 $C_{tl}$ 被印成 $C_{ll}$，均为排版错误，不影响结构。

### 2.3 不确定结构与“匹配/非匹配”

- 式 (7b)：$\Theta_2=-\frac{\tilde Kx_1+\tilde Bx_2}{m}$，与虚拟控制 $x_3$ **同通道**（逐级匹配）。
- 式 (7c)：$\Theta_3=\tilde\varphi_3(u,\tilde\beta_e,\tilde C_d,\tilde w,\tilde\rho,x_3)+\tilde f_3$。把 (8) 的 $\bar\varphi_3$ 写开可得

$$\Theta_3=\delta\,\bar\varphi_3(x_3,u)\,u+\tilde f_3,\qquad \delta=\frac{C}{C}-1\ (\text{即各参数的相对误差之积}),$$

**即 $\Theta_3$ 线性依赖控制量 $u$ 与 $\mathrm{sign}(u)$**。这一点是后文“标识器”部分的结构性缺陷来源（§5.4、§7）。

### 2.4 工作域与正则性（文中未列，我据式补出）

1. 根号需实值且非零：$P_s-\mathrm{sign}(u)x_3/A>0$，即 $|x_3|<AP_s$，且 $\bar\varphi_3$ 有正下界。否则 $1/\bar\varphi_3$ 无界，控制律 (66) 奇异。文中只写 $\bar\varphi_3^2\le\hat\varphi_3$，既未给出保证该界的**不变集**，也未给下界。
2. $u=0$ 处：$Q_L=k_+(x_3)u$（$u>0$）与 $k_-(x_3)u$（$u<0$），$k_+\neq k_-$（当 $x_3\neq0$）。$f+gu$ 在 $u=0$ **不是 Lipschitz**，与 §2.2 对 (10) 的 Lipschitz 假设冲突；同时 (15) 的 HJB 可微性前提不成立。
3. 控制律右端含 $\mathrm{sign}(u)$：$u=\Phi(u)$ 是隐式代数方程，文中未讨论解的存在唯一性与过零行为。

---

## 3. 控制链（从虚拟控制到实际阀电压）

| 环节 | 表达式 | 所需信号 | 是否需微分/滤波 | 备注 |
|---|---|---|---|---|
| 位置误差 | $e_1=x_1-y_d$ | $x_1,y_d$ | 否 | (19) |
| 虚拟控制 1 | $\hat\alpha_1^\star=-c_1e_1-\frac12\hat W_{a1}^\top S_{\Gamma1}(\mathcal X_{\Gamma1})$ | $x_1,y_d,\hat W_{a1}$ | 否 | (29)，$\mathcal X_{\Gamma1}=[x_1,y_d]^\top$ |
| 速度误差 | $e_2=x_2-\hat\alpha_1^\star$ | $x_2$ | 否 | 需 $x_2$ |
| 虚拟控制 2 | $\hat\alpha_2^\star=-\frac{c_2e_2}{\bar\varphi_2}-\frac{\bar f_2}{\bar\varphi_2}-\frac12\hat W_{a2}^\top S_{\Gamma2}\bar\varphi_2-\frac{\hat W_{\theta2}^\top S_{\theta2}}{\bar\varphi_2}$ | $x_1,x_2,y_d,\dot y_d$ | 否 | (48) |
| 力误差 | $e_3=x_3-\hat\alpha_2^\star$ | $x_3$ | 否 | 需 $P_L$ |
| 实际控制 | $u=-\frac{c_3e_3}{\bar\varphi_3}-\frac{\bar f_3}{\bar\varphi_3}-\frac12\hat W_{a3}^\top S_{\Gamma3}\bar\varphi_3-\frac{\hat W_{\theta3}^\top S_{\theta3}}{\bar\varphi_3}$ | $x_2,x_3,y_d,\dot y_d,\ddot y_d$ | 否 | (66)；右端隐含 $\mathrm{sign}(u)$ |

**关键结构性事实（优点与代价同时在此）**：

- **无观测器、无滤波器、无微分器、无指令滤波、无目标网络、无回放缓冲。** 全链代数，$\dot{\hat\alpha}_1^\star,\dot{\hat\alpha}_2^\star$ 只出现在分析式 (39)(41)(57)(59) 中，**被标识器目标吸收**，实现时不需要对虚拟控制求导。这避免了“微分爆炸”，是真实优点。
- **代价**：正因为 $\dot{\hat\alpha}_1^\star$ 被塞进标识器目标 $\Theta_2-\dot{\hat\alpha}_1^\star$，而 $\dot{\hat\alpha}_1^\star$ 依赖 $\hat W_{a1}$ 及其自身的更新律；$\Theta_3-\dot{\hat\alpha}_2^\star$ 还依赖 $u$（经 $\Theta_3$）与未知 $F_L$（经 $\dot x_2$）。**标识器的“理想权重”因此不是其声明输入 $\mathcal X_{\theta i}$ 的函数**（§5.4、§7）。这是把微分负担转嫁给辨识所付的代价。

**参考与导数阶数**：Assumption 1 要求 $y_d,\dot y_d,\ddot y_d,y_d^{(3)}$ 连续有界；$\mathcal X_{\Gamma3},\mathcal X_{\theta3}$ 为 6 维、含 $\ddot y_d$。扰动 $F_L$ 只需有界，不需要导数。

---

## 4. 假设—误差—结论表

| 假设/条件 | 位置 | 作用对象 | 结论/误差界 | 我的核对 |
|---|---|---|---|---|
| A1：$y_d$ 及一至三阶导连续有界 | p.5 | 参考轨迹 | 保证 $\mathcal X_{\Gamma i}$ 与 $\dot{\hat\alpha}$ 有界 | 仿真正弦满足；但 $y_d^{(3)}$ 只在分析里用到，实现不需要 |
| A2：$\theta_2,\theta_3,F_L$ 连续有界 | p.5 | 不确定项 | $\bar\Delta_{\theta i},\bar F_L$ 存在 | **不独立**：$\Theta_3$ 含 $u$，其界依赖控制器本身；不是先验常数 |
| Lipschitz/可控（§2.2） | p.4 | $f+gu$ | HJB 可解性 | 与 $u=0$ 处非 Lipschitz 冲突（§2.4） |
| NN 逼近在紧集 $\Omega$ 上成立 | p.5 | $S_\Gamma,S_\theta$ | $|\Delta|\le\bar\Delta$ | 未证轨迹留在 $\Omega$；半全局论证的典型循环 |
| $c_1>\frac54$ | p.6 | 位置环 | $e_1^2$ 负定项 | 仿真/实验均满足（300、650） |
| $c_2>\frac{8+\bar\varphi_2^2}{4}$ | p.8 | 速度环 | $e_2^2$ 负定项 | $\bar\varphi_2=1/30$，阈值 2.0003，满足 |
| $c_3>\frac{2+\hat\varphi_3+2\bar\varphi_2}{4}$ | p.10 | 力环 | $e_3^2$ 负定项 | **违反**：$\hat\varphi_3\ge\bar\varphi_3^2\approx4.3\times10^{17}$，需 $c_3>10^{17}$，实际 2000/650 |
| $\lambda_{a1}>\frac12$，$\lambda_{a1}>\lambda_{c1}>\frac12\lambda_{a1}$ | p.6 | 位置环权重 | 权重项负定 | 仿真 0.6/0.4 满足；**实验 0.1/0.06 不满足**（$0.1<\frac12$） |
| $\lambda_{a2}>\frac12\bar\varphi_2^2$ | p.8 | 速度环 | 同上 | 满足 |
| $\lambda_{a3}>\frac12\hat\varphi_3$ | p.10 | 力环 | 同上 | **违反**（需 $>10^{17}$，实际 0.6） |
| 初始域（半全局） | 未给 | 全部 | — | 未建立 |
| **结论 1**：$x_i,\hat W_{ci},\hat W_{ai},\hat W_{\theta i},e_i,\tilde W$ 半全局 UUB | Th.1, p.11 | 全部 | UUB | 骨架可核，但 $\ell=0$（§1 第 1 条），需按 §6 修复后才成立 |
| **结论 2**：$e_1$ 收敛到可调紧集，$\lim|e_1|\le\sqrt{2\varpi/\ell}$ | Th.1, p.11 | 位置误差 | 稳态界 | $\ell=0$ 时无定义；修复后界为 $\sqrt{\varpi/c_e}$，且 $\varpi$ 含 $\bar\Delta,\bar F_L,\|W^\star\|$，不可先验计算 |
| **结论 3**：$H_1\to0$，故近最优 | Remark 4, p.6–7 | 策略 | 最优性 | **不成立**（§5.4） |

**误差坐标的分离（按审核意见要求）**：$e_1=x_1-y_d$ 是**真实位置误差**，可直接用于跟踪结论；$\tilde W_{ci},\tilde W_{ai}$ 是**网络权重误差**；$\tilde W_{\theta i}$ 是**辨识误差**；$c_i$ 的偏差不是误差。定理把三者打包成 UUB，但 $e_1$ 的界含 $\bar\Delta,\bar F_L,\|W^\star\|$ 等未知常数，**“可调”不等于“可计算”**。无参数误差收敛结论（也不应有：σ 修正只给 UUB）。

---

## 5. 学习—优化对照：逐条回答优先问题

### 5.1 是否真实 actor/critic 结构？

**结构上是，功能上不是。**

- 三环共 **8 个网络**（位置环 2：critic+actor；速度环 3：identifier+critic+actor；力环 3：同），每网 $p_i=5$，共 40 个可积权重。结论 p.15 称“rely on five neural networks”，与文中结构不符（应为 8 个网络、5 个神经元/网络）。
- actor 与 critic **共享同一基函数 $S_{\Gamma i}$ 与同一输入 $\mathcal X_{\Gamma i}$**，但权重独立、更新独立。
- **不是 ADP 意义上的 actor–critic**：没有策略评估（无 Bellman 残差/代价的评估步骤），没有策略改进（actor 不是由 $\partial H/\partial u=0$ 从 critic 的 $\hat\nabla J$ 解出）。actor 仅在 $\hat W_a=\hat W_c$ 时形式上等于 $-\frac12\hat\nabla J$；两者是被两条独立 ODE 拉到一起的。
- 更新律 (30)(31) 的输入只有 $S_\Gamma$ 与权重本身，**不含 $e_i$、不含 $u$、不含代价**。它们是“遗忘律”。

### 5.2 独立动态状态台账（D）

| 类别 | 项 | 维数 | 积分方程 | 说明 |
|---|---|---|---|---|
| 对象 | $x_1,x_2,x_3$ | 3 | (7a)–(7c) | 物理状态 |
| 控制器 | $\hat W_{c1},\hat W_{a1}$ | 10 | (30)(31) | 位置环 |
| 控制器 | $\hat W_{c2},\hat W_{a2},\hat W_{\theta2}$ | 15 | (49)(50)(51) | 速度环 |
| 控制器 | $\hat W_{c3},\hat W_{a3},\hat W_{\theta3}$ | 15 | (67)(68)(69) | 力环 |
| **合计** | | **43 个一阶 ODE**（控制器 40） | | |
| 代数量 | $e_1,e_2,e_3$；$\hat\alpha_1^\star,\hat\alpha_2^\star$；$\hat\nabla J_{1,2,3}$；$u$；$S_{\Gamma1}(2)$、$S_{\Gamma2}(4)$、$S_{\theta2}(4)$、$S_{\Gamma3}(6)$、$S_{\theta3}(6)$；$P,H_i$ | — | 无 | 不可积分，不计入状态 |
| 观测/滤波/微分/指令滤波/目标网络/回放 | 无 | 0 | — | 实际优点 |

**每步结构成本**：40 个权重 RHS（每个 $O(p_i)$，因 $SS^\top\hat W=S(S^\top\hat W)$ 为标量×向量）+ 8 次高斯基（每次 5 个指数）+ 一次标量 $1/\bar\varphi_3$。$\mathcal K=I_{5\times5}$，无矩阵求逆。**未运行，故不给 ms、倍速或性能提升值。**

### 5.3 稳定性是怎么证的？

逐环：$L_i=\frac12e_i^2+\frac12\|\tilde W_{ci}\|^2+\frac12\|\tilde W_{ai}\|^2+\frac12\tilde W_{\theta i}^\top\mathcal K_i^{-1}\tilde W_{\theta i}$，用 Young 不等式消 $e_ie_{i+1}$、$e_i\Delta$、$e_iF_L$ 与 $e_i\hat W_a^\top S$，再用恒等式

$$\tilde W^\top SS^\top\hat W=\tfrac12\tilde W^\top SS^\top\tilde W+\tfrac12(\hat W^\top S)^2-\tfrac12(W^{\star\top}S)^2$$

把权重项配成 $-\frac12\lambda_c\tilde W^\top SS^\top\tilde W-\cdots$，最后三环的 $+\frac12e_2^2$ 与 $-\frac12e_2^2$、$+\frac12e_3^2\bar\varphi_2$ 与 $-\frac12e_3^2\bar\varphi_2$ 相消。骨架我逐项复算通过（§proof_reconstruction 4–5）。缺陷见 §1 第 1 条与 §6。

### 5.4 优化目标是怎么证的？

**没有证。** 三处独立断裂：

1. **代价泛函不适定。** $J_1=\int_t^\infty(\alpha_1^2+e_1^2)d\tau$，而 $\alpha_1=x_2$；任何跟踪 $\dot y_d\not\equiv0$ 的策略都有 $x_2\to\dot y_d$，故 $\int\alpha_1^2=\infty$。$J_2$（$\alpha_2=x_3\approx AP_L$）、$J_3$（$\alpha_3=u$）同理。于是 Definition 1 的可行集为空，(20)(40)(58) 的 min 无对象，(21)(41)(59) 的 HJB 只是形式推导。
   *若作者的意图是把 $\alpha_i$ 当“偏差量”、把前馈 $\dot y_d$ 单独拿出，则 (19)(21)(22) 必须重写，且 $\alpha_1^\star$ 的参数化 (24) 与 $e_2$ 的定义都要改；文中没有这样做。*
2. **$H=0$ 不被 $P\to0$ 蕴含。** 取 $\hat W_a=\hat W_c$（即 $P=0$），由 (28)(29) 有 $\hat\nabla J=2c_1e_1+\hat W_c^\top S=-2\hat\alpha_1^\star$，代入估计 HJB 得

$$H_1\big|_{a=c}=-\hat\alpha_1^{\star2}+2\hat\alpha_1^\star\dot y_d+e_1^2 .$$

   它一般不为零。数值反例：$e_1=0.01,\ \dot y_d=0.1,\ c_1=300$，取 $\hat W_a=\hat W_c=0$（$P=0$），则 $\hat\alpha_1^\star=-3$，$H_1=-9-0.6+10^{-4}=-9.6\neq0$。而 $\partial H_1/\partial\hat W_{a1}=\frac12SS^\top(\hat W_{a1}-\hat W_{c1})=0$ 此时自动满足。**“驻点 ⇒ 残差为零”不成立**；Remark 4 把向量方程与标量方程混为一谈。
3. **$P\to0$ 本身也未证。** (32) 只给 $\dot{\mathcal P}=-2\lambda_{a1}\|S^\top(\hat W_{a1}-\hat W_{c1})\|^2\le0$（我独立核对，正确），即 $\mathcal P$ 单调不增、有下界，故收敛到某极限；要得极限为 0 还需 $\dot{\mathcal P}$ 的一致连续/Barbalat 或 PE，文中直接用“$\mathcal P>0,\dot{\mathcal P}\le0\Rightarrow\mathcal P\to0$”，缺少一步。

补充：即便 $H\to0$，也只是**估计 HJB 的残差为零**，并不等于实现代价接近最优代价 $J^\star$；全文没有 $|J-J^\star|\le\varepsilon$ 型的任何估计。

### 5.5 激励假设、Bellman 残差、噪声

- **激励**：不假设 PE（字面成立）。代价是：既然不辨识 $W^\star$，也就**没有权重收敛到理想值的结论**；标准 critic 律（残差梯度 + PE）所换来的收敛性，被“简单结构”一并换掉了。这不是缺陷的推断，而是其更新律 (30)(31) 的直接结构：唯一平衡点是 $S^\top\hat W_c=0$，不是 $W^\star$。
- **Bellman 残差**：只在 Remark 4 定义 $\varepsilon_1=H_1(e_1,\hat\alpha_1^\star,\hat\nabla J)-H_1(e_1,\alpha_1^\star,\nabla J^\star)=H_1(\cdot)$，**从未进入任何更新律或任何界**。无残差界、无 ε-最优性。
- **噪声**：无噪声模型、无滤波、无带宽/幅值/采样设定，仿真无噪声；实验只给 1000 Hz 采样，未给传感器噪声或速度获取方式。**噪声下的性能与稳定性：未建立。** 更新律含 $S(X)S(X)^\top$ 的二次型，噪声进入 $S$ 会产生 errors-in-variables 型偏差，文中未讨论。

### 5.6 实际收敛性质（我的推论，由文中方程直接得出）

- $\frac{d}{dt}\|\hat W_{ci}\|^2=-2\lambda_{ci}(S^\top\hat W_{ci})^2\le0$，故 $\|\hat W_{ci}\|$ 不增；结合 $\dot{\mathcal P}\le0$ 得 $\|\hat W_{ai}\|\le\|\hat W_{ci}(0)\|+\sqrt{\mathcal P(0)}$。**权重有界，但这是初值界，不是收敛。**
- 由 $\int_0^\infty(S^\top\hat W_{ci})^2dt<\infty$ 与 $\int_0^\infty(S^\top(\hat W_{ai}-\hat W_{ci}))^2dt<\infty$，在 $S^\top\hat W$ 一致连续（状态与权重有界即成立）下得 $S^\top\hat W_{ci}\to0$、$S^\top\hat W_{ai}\to0$。**即学习项沿轨迹渐近消失**：$\hat\alpha_1^\star\to-c_1e_1$，$u\to-\frac{c_3e_3}{\bar\varphi_3}-\frac{\bar f_3}{\bar\varphi_3}-\frac{\hat W_{\theta3}^\top S_{\theta3}}{\bar\varphi_3}$。
- 因此**闭环渐近退化为“反步 + 标识器补偿”**，RL 部分自我关闭。这与表 3 的稳态控制代价 $J_c$（OBC 4.70 vs BC 4.70）几乎相同是自洽的；误差代价 $J_e$ 的改善更可能来自增益/标识器结构而非“优化”。
- 该推论是审计推论，不是作者结论；作者只声明“权重有界”。

### 5.7 作者自己的数据（注明为作者结果，非本项目复现）

表 3（p.14，实验，$y_d=0.03\sin\pi t$，$x_1(0)$ 取 30/20/10/0 mm）：
- 0–5 s 控制代价：OBC 51.45 / BC 13.25 / NN-BC 27.20 / PI 17.87（30 mm 工况）——**OBC 瞬态控制代价最差**，作者归因于“RL 学习慢”。
- 5–10 s 控制代价：OBC 4.70、BC 4.70、NN-BC 4.69、PI 4.81——**与 BC 持平**。
- 5–10 s 误差代价：OBC 3.58e-6、BC 7.97e-6、NN-BC 6.87e-6、PI 1.10e-5——OBC 约为 BC 的 45%。
- 结论：数据支持“稳态误差更小、稳态控制代价持平、瞬态控制代价更大”。**不支持“控制资源最优”**；也未做与“相同结构但去掉 RL 项”的消融（BC 的增益与结构不同，无法归因）。

---

## 6. 量测、噪声、饱和（C）

| 项 | 论文 | 说明 |
|---|---|---|
| 需要的量测 | $x_1$（位移）、$x_2$（速度）、$x_3=AP_L$（负载压差） | 全状态反馈 |
| 速度获取 | **未说明** | 无速度观测器、无微分器、无滤波；实验中速度如何得到未写。若由位移差分，则噪声放大与相位滞后均未分析 |
| 压力 | 只需 $P_L=P_1-P_2$ 的差值 | 与“两腔压力可测”合同**不冲突但不覆盖**：模型不单独使用 $P_1,P_2$；若按项目合同用两腔压力，须自行合成 $P_L$ |
| 噪声 | 无模型、无定量界、无滤波 | 噪声下性能：未建立 |
| 饱和 | 理论无、仿真无、实验无 | 结论 p.15 明确承认控制电压过冲“may lead to actuator saturation”，并列为未来工作 |
| 输入反解/过零 | 未处理 | $u$ 隐含 $\mathrm{sign}(u)$；$u=0$ 处增益跳变；$1/\bar\varphi_3$ 无下界保证 |
| 观测器启动 | 无观测器 | — |

**与项目量测合同的差异**：L09 需要 $x_2$，且没有给出速度估计器；项目合同是“位置 + 两腔压力可测、速度估计”。按 T016 意见，**不改变合同**：引用 L09 的结构时必须明确“其定理不覆盖用估计速度替换 $x_2$ 的情形”。

---

## 7. 复杂度与可复现性（D）

- 状态台账见 §5.2：43 个 ODE（对象 3 + 控制器 40），无观测器/滤波器/目标网络/回放。
- 网络真实结构：8 个单隐层（实为单层线性输出）RBF 型网络，每网 5 个高斯基、5 个权重；无批量、无训练轮次，权重按采样连续积分（仿真步长 0.1 ms，实验 1000 Hz）。
- 计算成本：仅结构分析，**未测**。
- 可复现性风险（逐条）：
  1. 结论称“五个网络”，实为 8 个（§5.1）。
  2. 实验 $\lambda_{a1}=0.1<\frac12$，违反 (30)(31) 的设计条件；仿真 $\lambda_{c1}=\lambda_{c2}=\lambda_{a3}=0.4$ 的下标疑为 $\lambda_{c3}$。
  3. 实验初值 $\hat W_{a3}(0)=2\times10^{-3}\mathbf 1_5$（解析稿作 $\hat W_{g3}$），仿真为 $10^{-8}$；按表 2 名义值 $\bar\varphi_3\approx6.5\times10^8$，控制项 $\frac12\hat W_{a3}^\top S\bar\varphi_3\sim10^5$ V，与伺服阀可行电压不相容。**疑为 OCR/下标误读，列待核**（§proof_reconstruction 10）。
  4. 基函数宽度不统一：$S_{\theta2}$ 用 $/2$，$S_{\Gamma2}$ 用 $/0.01$，$S_{\Gamma3},S_{\theta3}$ 用 $/10^4$；$\mathcal X_{\Gamma2}=\mathcal X_{\theta2}$ 但宽度差 200 倍，覆盖范围与状态量程（$x_2\sim0.28$、$x_3\sim10^2$ N）需逐项核对。
  5. 未给仿真时长、初值 $x(0)$（仅实验变化 $x_1(0)$）、积分器相对容差。

---

## 8. 实际优点（可用的部分）

1. **模型清楚、参数齐全**：三阶 EHS、静阀、名义/不确定分离，表 2 可直接用于对比基线。
2. **稳定性骨架正确可核**：逐环 Lyapunov + Young + 级联相消 + σ 修正，三环交叉项确实相消（我逐项验算），是一个可复用的“无滤波/无微分”反步结构。
3. **更新律极简**：$O(p)$/步，无残差梯度、无矩阵求逆、无 PE、无回放；1 kHz 实测可跑。
4. **诚实报告负面**：瞬态控制代价更高、电压过冲可能饱和、计算量偏大，均写入结论。
5. **仿真+实验双验证**，且实验做了 4 组初值与 3 个基线对比（表 3），提供了可引用的定性事实。

---

## 9. 适用边界

- 仅适用于 $|x_3|<AP_s$、$\bar\varphi_3$ 有正下界的工况；无不变集证明。
- 仅适用于全状态（含速度）可得的场合；无噪声、无饱和、无时滞。
- 名义模型 $\bar f_2,\bar f_3,\bar\varphi_2,\bar\varphi_3$ 已知；不确定为 10% 量级且缓变。
- **不覆盖**：有限/固定/预设时间；输入饱和；仅位置反馈；阀动态；多缸同步；参数收敛。
- 定理 1 按其字面**不覆盖其自身的仿真/实验参数**（力环条件违反 12–14 个数量级）。

---

## 10. 对本项目的含义（只记录，不设计控制器）

1. **不能把 L09 当作“近最优已被证明”的支撑。** 其优化部分是名义上的：代价发散、更新律无代价信息、$H\to0$ 不成立。若本项目要做“学习优化”，最低门槛是：(a) 给出对跟踪工况**适定**的代价（折扣/误差坐标/去前馈）；(b) 更新律中含残差或代价信息；(c) 给出 $|J-J^\star|$ 或 $\hat\nabla J-\nabla J^\star$ 的界；(d) 不用 PE 时给出显式辨识误差界。
2. **它的“无激励条件”是真实的，但代价明确**：去掉 PE 的同时去掉了收敛目标，学习项渐近归零。可作为“为什么不能只删激励条件”的反面样本。
3. **结构上可取的一点**：无微分器/无指令滤波的代数链 + 把虚拟控制导数并入标识器。但必须补上“标识器目标是否为声明输入的函数”这一环——L09 没补，且因 $\Theta_3\propto u$ 而不可补。
4. **时间维度**：零结论。与用户“预设时间优先”的方向无关，不能作为时间标签的依据。
5. **量测**：需 $x_2$；项目合同下须自行加估计器，届时 L09 的定理不再覆盖。

---

## 11. 作者宣称 vs 审计结论

| 作者宣称（原文位置） | 审计结论 |
|---|---|
| “near-optimal control performance”（Abstract, §1, Remark 4, Conclusion） | **未建立**：代价不适定、更新律无代价信息、$P\to0\nRightarrow H\to0$；且学习项渐近消失 |
| “removes the excitation condition of RL”（Abstract, Remark 5） | 字面成立（不假设 PE）；但收敛到 $W^\star$ 的结论同时不存在 |
| “all error signals … semi-globally uniformly ultimately bounded”（Th.1） | 骨架成立，但按字面因 $Y^{\min}=0$、力环条件被违反而不覆盖其仿真/实验；可按 §proof_reconstruction 6 修复为较弱的 UUB |
| “tracking error converges asymptotically to an adjustable compact set”（Th.1） | 措辞不当：实为 UUB（指数收敛到球），非渐近收敛；且界 $\sqrt{2\varpi/\ell}$ 失效 |
| “five neural networks”（Conclusion） | 实为 8 个网络（5 个神经元/网络） |
| “simulation and physical experiments demonstrate feasibility” | 可行性成立（有数据）；**不构成最优性或定理适用性的证据** |

---

## 12. 证据定位（供复核）

| 内容 | 位置 |
|---|---|
| 模型 (1)–(9) | p.2–4 |
| 最优控制与 HJB (10)–(16) | p.4 |
| NN 逼近 (17)–(18) | p.5 |
| 位置环 (19)–(38) | p.5–7 |
| 更新律 (30)(31)、$\mathcal P$ 与 (32) | p.6–7 |
| 速度环 (39)–(56) | p.7–9 |
| 力环 (57)–(73) | p.9–11 |
| 定理 1 | p.11 |
| 表 2 与仿真参数 | p.12 |
| 实验参数 | p.12 |
| 表 3 与对比 | p.14 |
| 结论（承认饱和/计算量） | p.15 |
