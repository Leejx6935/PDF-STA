# Yang 2021（OASC）方法卡

**文献**：X. Yang, J. Yao, W. Deng, *ISA Transactions* 109 (2021) 175–185。DOI 10.1016/j.isatra.2020.09.014，Zotero BLFGZ6V4。

## 一、作者明确的 Future Work

一处：§5 结论末段（PDF 第 10 页／期刊第 184 页，已用 `doc:2f58eff/tier:standard/page:9` 邻域核对）——“the controller design with system parameter adaptation might possess more practical meanings… In the future, an output feedback SSMC controller with hydraulic system parameter adaptation will be worth being developed.” 即**液压系统物理参数的自适应**，不是增益自适应（增益自适应本文已做）。

## 二、adaptive 究竟调什么

式(21)（§3.3）：`β̇1=α1√(ω1/2)·sign(|s|−v)`（`β1>αs` 时），否则 `β̇1=ϑ`；`β2=2εβ1`。调的是 **STA 的两个反馈增益**，物理参数 `m,B,βe,Ct,kv` 一律不调；`f̂1,f̂2,f̂3` 只是把状态换成 `x̂2,x̂3`。因此本文的 “adaptive” 与 “parameter adaptation” 是两件事。

**与 Chen 2025 的重叠（不能声称无人做过）**：Chen (11)(31) 的投影律调的 `Θ=[θ1,θ2,θ3]`，其中 `θ1=∂y/∂q`、`θ2=A(∂y/∂q)βe`、`θ3=βe kq`，正是几何-液压物理参数，且带箱式投影。故“输出反馈 SSMC + 液压参数自适应”已被 Chen 2025 做过大半；Yang 的 FW 与之重叠，**不能作为全新贡献**。剩余窄口：纯位置输出反馈（不用压力传感器）+ 物理参数自适应 + SSMC——但 Yang 的 `f1(u,PL)` 本身也要 PL，这个窄口未必成立，需先核实其是否用压力传感器。

## 三、三层收敛性质

1. **观测误差** `ξ=[x̃1,x̃2/w0,x̃3/w0²,x̃4/w0³]`：Theorem 1（§3.2）给 `V̇ob≤−ϖ‖ξ‖²+ς`，即**指数收敛到球** `‖ξ‖≤√(ς/ϖ)`，**不是有限时间**。Remark 1 自述“estimation error has the asymptotic convergence”，却又说“converge to a known bound in limited period”，两种说法混用。式(16) 印刷上只保留了 `δ2²` 项，漏掉 `ς` 中的 `l3|u|max` 项（待核查）。
2. **滑模变量** `s=c1e1+c2e2+e3`：Theorem 2 给**有限时间进入 `|s|≤v`**（不是到零）。随后 `|s|<v` 时 `β1` 下降（S2，Θ 可正），s 越界再回，形成进出循环；Remark 2/4 自认只能保证 `|s|≤v_m`。式(41) 的 `V̇co≤−κ√Vco` 仅在 S1 成立。
3. **实际位置误差** `z1`：Theorem 3 在 `H(t)≡0`（常值扰动）下用 Barbalat 得 `z1→0`，**仅渐近**；Theorem 4 对时变 `d(t)` 给 `V≤V(0)e^{−γt}+ς1/γ`，**最终有界**，不到零。且 `s→0` 只使 `e1→0`（Hurwitz），而 `z1=e1−x̃1`，`z1→0` 的速度由观测误差决定——**滑模有限时间 ≠ 位置有限时间**。

## 四、假设及其在证明中的具体用处

- **A1**（`|d|≤δ1,|ḋ|≤δ2,|f|≤δ3`）：δ2 进 Thm 1 的 `Bob H/w0³` 与 Thm 4 的 `ς1=‖PBob‖δ2²/(2w0³)`。**缺口**：式(6) 的 `d` 含 `−ḟ/m`，故 `|ḋ|≤δ2` 实际要求 `|f̈|` 有界，A1 未列。
- **A2**（`|PL|≪Ps`，`f1` 远离零、除 `u=0` 外 Lipschitz）：用于 (20) 除以 `f̂1`，以及 (14) 的 `|f̃1|≤l1|ξ2|+l2|ξ3|+l3`；`l3` 正是 `u=0` 折点产生的偏置，也是 `ς` 的来源。**缺口**：`f1` 依赖 `PL`，而 `PL` 依赖 `x3`，所谓“全局 Lipschitz”实为局部。
- **A3**（`f2,f3` 全局 Lipschitz，`f1` 对 `x2,x3` Lipschitz）：经 (46) 的 `C_M,C_φ` 进 Λ(47)。
- **隐含未列**：`x1d∈C³` 且各阶导有界（`ẋ3eq` 及其导数要用）；无噪声模型（尽管降噪是动机）。

## 五、重点核验

**(a) Theorem 3 的证明闭环**：式(48) 的 V 不含增益误差项，Barbalat 步要求 (51) 全局成立；但 (21) 在 `|s|<v` 时会把 `β1` 降到阈值 (25) 之下，Q 不再正定，S2 下 `Ξ→0` 未建立。需混合系统/驻留时间论证（待核查）。

**(b) 符号不一致**：式(20) 第二行 `u̇n=−β2 sign(s)/2`，式(22) 为 `−β2 sign(s)`。这直接影响 (27) 的 A 与 (30) 的 Q 中 β2 的系数 2，需确认哪一处为准。

**(c) 自适应律的“有限时间”措辞**：结论称“feedback gains can be adapted online in finite time”，但 (21) 是符号型积分律，`β1` 的到达时间是 `(|s|−v)` 的穿越时间，不是 Lyapunov 意义的上界；且 S2 下无界定时。

## 六、可改进点（全部待审核）

1. 物理参数自适应（作者 FW）。障碍/风险：与 Chen 2025 投影律重叠；且需处理 `f1(u,PL)` 对 `PL` 的非线性与回归向量不可测（`PL` 需压力传感器）。
2. 用固定时间/预定时间 STA 增益替代 `|s|−v` 切换。障碍：需已知 ρ，而本文卖点是“界未知”；去掉死区后噪声下增益无界增长。
3. 把增益纳入 Lyapunov 的严格混合证明。障碍：切换导致 V 非光滑，S2 下 Θ>0，需 automaton/驻留时间。
4. 位置有限时间：FT 观测器 + FT 反步。障碍：级联时间账本；FT 观测器需已知扰动界，与“界未知”前提冲突。

## 七、不能直接当新贡献

ESO+SSMC 的组合；自适应增益 STA（源自其引文 [25]）；“chattering-free”（(20) 仍有 sign）；常值扰动下的渐近跟踪（经典 ESO 结果）；把 `V̇≤−aV^p+b`（b>0）读成“精确到零”。
