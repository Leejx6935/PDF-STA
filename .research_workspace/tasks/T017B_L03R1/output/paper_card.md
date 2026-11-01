# L03 论文卡（修订版 R1）

**题名**：Disturbance observer-based nonlinear feedback control for position tracking of electro-hydraulic systems in a finite time
**作者**：Hamid Razmjooei, Gianluca Palli, Morad Nazari
**期刊**：European Journal of Control 67 (2022) 100659
**DOI**：10.1016/j.ejcon.2022.100659
**本地 PDF**：`inputs/four_papers/L03_Zotero.pdf`（SHA256 `87208032df294dddc897ed22f12f0d375667d2618cdea2a6c41a70d239e71520`，11 页）
**修订依据**：`reviews/T017B_L03_补核审核_2026-10-28.md`（C1–C9）；修订记录见本目录 `revision_notes.md`。
**版本说明**：本文件是 `tasks/T017B_L03_fulltext/output/paper_card.md` 的修订版，原文件保留不动。

---

## 0. 阅读路径与证据等级（本修订版的实际做法）

| 项 | 内容 |
|---|---|
| 原文文本 | 本地 MinerU 标准解析 `doc:8720803/tier:standard`（parse id 166，页范围 1–11，状态 done），经 `read_document` 分页读取 |
| 公式核对 | 页面图像 `sources/parsed/L03_flash_page3.png / page4.png / page5.png / page6.png / page7.png`，逐式目视核对 |
| 内置 Read 读 PDF | **不可用（实测）**：`Read(L03_Zotero.pdf, pages=4)` 返回「PDF is password-protected」。因此「用内置 Read 逐页读取 PDF」的说法在本次环境中不能成立，本修订版不沿用该表述 |
| WebFetch / 在线版 | 未使用 |

C1、C2、C3、C4、C5、C7、C8、C9 的结论均在页面图像上直接目视确认；C6 在 Table 1 原图上逐格确认；C7 另有独立反步复算佐证（见 `proof_reconstruction.md` §3）。

---

## 1. 一句话结论（定性判断不变）

L03 是**非学习、基于扰动观测器（DOB）+ 反步法 + 时间变换**的五阶 EHA 位置跟踪论文。它的"有限时间"主要来自**观测器滑模面中的非光滑符号项**；对**真实位置跟踪误差**，论文给出的 Lyapunov 不等式是负二次型（指数收敛），**没有**分数幂形式，也**没有**终端时刻 \(T\)，**不是预设时间方法**。输入有界性与饱和未进入定理；噪声只出现在仿真。

修订后的数学表述要点：

- 时间变换含时间常数 \(\tau\)：\(\mu(t,\tau)=\dfrac{1+e^{-t/\tau}}{2e^{-t/\tau}}\)，\(\dot\mu/\mu\in\left(\frac{1}{2\tau},\frac{1}{\tau}\right]\)，故增益条件为 \(a_1>\frac{1}{\tau},\ a_2>\frac{1}{\tau}-\frac{b}{m}\)（p.7 Eq.(36)）。原报告的 \((1/2,1)\) 与 \(a_1>1\) 只是 \(\tau=1\) 的特例。
- 定理 1 的滑动变量是**观测误差的一阶导**：\(s_i=\dot e_i+\beta e_i^{q/p}\)（p.5）。
- 定理假设界的是**扰动的导数**：\(|\dot\Delta_i|<\sigma_i\)（p.5 Eq.(21) 前文、Theorem 2）。
- 式 (35) 界的是 \(|\dot e_i|\)，不是 \(|e_i|\)。
- 定理 1 的证明缺口是作者**显式假设** \(\ddot{\hat x}_i=\ddot x_i\)（p.5 Eq.(20) 后），不是"悄悄丢掉线性项"。

---

## 2. 模型与控制链

### 2.1 实际阶次、物理状态与控制状态

被控对象是**五阶** EHA（不是三阶系统），相对阶 5：

| 状态 | 物理量 | 单位 | 是否可测 |
|---|---|---|---|
| \(x_1=y\) | 活塞位置 | m | 是 |
| \(x_2=\dot y\) | 活塞速度 | m/s | 否，由观测器估计 |
| \(x_3=P_L=P_A-P_B\) | 两腔压差 | Pa | 是（两腔压力可测） |
| \(x_4=v_e\) | 阀芯位移 | m | 是（论文明确列为可用，p.5） |
| \(x_5=\dot v_e\) | 阀芯速度 | m/s | 否，由观测器估计 |

对象方程（式 (1)，p.2）：

\[
\ddot y=-\frac{b}{m}\dot y-\frac{F_f(\dot y)}{m}+\frac{A_p}{m}P_L,
\]
\[
\dot P_L=-\frac{2\rho A_p}{V_0}\dot y+\frac{2\rho\,\Psi(v_e)}{V_0}\sqrt{P_s-|P_L|},
\]
\[
\ddot v_e=-\omega_{nv}^{2}v_e-2\epsilon_v\omega_{nv}\dot v_e+\omega_{nv}^{2}\left(k_eu+v_{e0}\right).
\]

**符号订正（原报告 → 原文）**：阀的固有频率与阻尼比在原文记作 \(\omega_{nv},\epsilon_v\)（不是 \(\omega_e,\epsilon_e\)）；\(\rho\) 是**有效体积模量**（Table 1 单位 Pa，不是密度）；\(k_e\) 是输入增益；\(v_{e0}\) 是阀芯零偏；\(k_q\) 是名义阀常数（式 (2)）。

**输入维数** 1（阀电压 \(u\)）；**量测维数** 3（\(y,P_L,v_e\)）。反步链为 4 个虚拟控制加 1 个实际输入。

### 2.2 不确定性与扰动结构

式 (2)（p.3）把不确定性写成 \(\Delta(t,x)=\bar\Delta(t,x)+\eta(t)\)，

\[
\Delta=[0,\ \Delta_2,\ \Delta_3,\ 0,\ \Delta_5]^{T},
\]
\[
\Delta_2=-\frac{F_f(\dot y)}{m}+\eta_y(t),\quad
\Delta_3=\frac{2\rho\big(\Psi(x_4)-k_qx_4\big)\sqrt{P_s-|x_3|}}{V_0}+\eta_{P_L}(t),\quad
\Delta_5=\omega_{nv}^2v_{e0}+\eta_{v_e}(t).
\]

- \(\Delta_2\)：速度通道，相对 \(u\) **非匹配**；
- \(\Delta_3\)：压力通道，**非匹配**；
- \(\Delta_5\)：阀加速度通道，**匹配**。

**界的对象（修订 C4）**：定理 1 与定理 2 的 Lipschitz 型条件是**对扰动导数**设界
\[
|\dot\Delta_2|<\sigma_2,\quad |\dot\Delta_3|<\sigma_3,\quad |\dot\Delta_5|<\sigma_5 \qquad(\text{p.5, Eq.(21) 前文；Theorem 2})
\]
\(\sigma_i\) 未知。原报告写成 \(|\Delta_i|<\sigma_i\) 属误读。（Lemma 1 用的是已知界情形的 \(|\Delta_i|<k_i\)，与定理 1/2 不是同一个界，勿混。）

### 2.3 误差坐标

- 跟踪误差：\(\bar e_1=x_1-y_d,\ \bar e_2=x_2-\dot y_d\)。
- 时间变换（p.3 Eq.(4)）：
\[
\mu(t,\tau)=\frac{1+e^{-t/\tau}}{2e^{-t/\tau}}=\frac{e^{t/\tau}+1}{2},\qquad \mu(0)=1,
\]
\[
\frac{\dot\mu}{\mu}=\frac{1}{2\tau}\left(2-\mu^{-1}\right)=\frac{1}{\tau}\cdot\frac{e^{t/\tau}}{1+e^{t/\tau}}\in\left(\frac{1}{2\tau},\ \frac{1}{\tau}\right),
\]
且 \(\mu\to\infty\) 当 \(t\to\infty\)。原文把设计常数排印为斜体 \(t\)（式 (4) 指数中可见分母符号），本报告统一记 \(\tau\)。
- 变换误差：\(E_1=\mu\bar e_1,\ E_2=\mu\bar e_2\)。
- 反步坐标：\(\Phi_1=-a_1E_1\)（\(\bar E_2=E_2-\Phi_1\)），\(\tilde x_3=x_3-\Phi_2\)、\(\tilde x_4=x_4-\Phi_3\)、\(\tilde x_5=x_5-\Phi_4\)。
  **符号订正**：反步增益是 \(a_i\)，观测器的类 K 增益是 \(\alpha_i(\cdot)\)；原报告把两者混写为 \(\alpha_1,\alpha_2\)。
- 观测误差：\(e_i=\hat x_i-x_i\ (i=2,3,5)\)。
- **滑动变量（修订 C2，p.5 Theorem 1）**：
\[
s_i(t)=\dot e_i+\beta e_i^{q/p},\qquad \beta>0,\ p>q>0\ \text{为奇数}.
\]
原报告写成 \(s_i=e_i+\beta e_i^{q/p}\)，少一阶导数。

### 2.4 从虚拟控制到实际阀输入的完整链条

| 层级 | 量 | 作用 | 依赖 |
|---|---|---|---|
| 1 | \(\Phi_1=-a_1E_1\) | 稳定 \(E_1\) | \(E_1\) |
| 2 | \(x_{3d}=\Phi_2(E_1,\bar E_2)\) | 期望压差 | \(\dot y_d,\ddot y_d,\dot\Phi_1\)（\(\Delta_2\) 版另需 \(\hat\Delta_2\)） |
| 3 | \(x_{4d}=\Phi_3(E_1,\bar E_2,\tilde x_3)\) | 期望阀芯位移 | \(\dot\Phi_2\)（\(\Rightarrow\dddot y_d\)） |
| 4 | \(x_{5d}=\Phi_4(E_1,\bar E_2,\tilde x_3,\tilde x_4)\) | 期望阀芯速度 | \(\dot\Phi_3\)（\(\Rightarrow y_d^{(4)}\)） |
| 5 | \(u\)（式 (14)/(22)） | 实际阀电压 | \(\dot\Phi_4\) |

名义控制律（p.5 Eq.(14)，据页面图像逐项核对）：

\[
u=(k_e\omega_{nv}^{2})^{-1}\Big(-\tilde x_4+\omega_{nv}^2(\tilde x_4+\Phi_3)+2\epsilon_v\omega_{nv}(\tilde x_5+\Phi_4)+\dot\Phi_4-a_5\tilde x_5-k_5\operatorname{sgn}(\tilde x_5)\Big),
\]
其中 \(a_5>0,\ k_5>|\Delta_5|\)。

DOB 版 FT-DOTC 律（p.5 Eq.(22)）：

\[
u=(k_e\omega_{nv}^{2})^{-1}\Big(-\tilde x_4+\omega_{nv}^2(\tilde x_4+\bar\Phi_3)+2\epsilon_v\omega_{nv}(\tilde x_5+\bar\Phi_4)+\dot{\bar\Phi}_4-a_5\tilde x_5-(\hat\Delta_5+\bar\Theta_5)\operatorname{sgn}(\tilde x_5)\Big).
\]

**修订 C7 附注**：式 (8) 的前置因子按原图确为 \(\left(\frac{A_p}{m}\mu\right)^{-1}=\dfrac{m}{A_p\mu}\)，**含 \(\mu\)**。原报告"可能漏印 \(1/\mu\)"的疑点撤回。独立反步复算也要求这个含 \(\mu\) 的前置因子（见 `proof_reconstruction.md` §3），二者一致。

**其它照原式抄录**（本修订仍标 B 级，见 §7 第 11 条）：式 (8) 与 (9)/(10)/(23)/(24) 之间 \(\mu\) 的记账不完全一致。

### 2.5 观测器（p.5 Eq.(16)(17)）

\[
\hat\Delta_i(t)=-\int_0^t\alpha_i\operatorname{sgn}\!\left(\dot e_i+\beta e_i^{q/p}\right)d\sigma-\beta e_i^{q/p},\qquad i=2,3,5,
\]
\[
\dot{\hat x}_2=-\frac{b}{m}\hat x_2+\frac{A_p}{m}x_3+\hat\Delta_2,
\]
\[
\dot{\hat x}_3=-\frac{2\rho A_p}{V_0}\hat x_2+\frac{2\rho k_q\sqrt{P_s-|x_3|}}{V_0}x_4+\hat\Delta_3,
\]
\[
\dot{\hat x}_5=-\omega_{nv}^2x_4-2\epsilon_v\omega_{nv}\hat x_5+k_e\omega_{nv}^2u+\hat\Delta_5.
\]

\(\alpha_i(\cdot)\) 为 class-K 函数；\(x_1,x_3,x_4\) 可测。注意：\(x_3\) 既被列为可测，又估计 \(\hat x_3\)，该通道结构上冗余（保留判断）。

---

## 3. 假设—误差—结论表（修订）

| 条目 | 假设 | 结论 | 误差变量 | 时间性质 | 依赖 | 审计判断 |
|---|---|---|---|---|---|---|
| Lemma 1（p.5） | \(|\Delta_2|<k_2,|\Delta_3|<k_3,|\Delta_5|<k_5\)；控制 (14)；\(a_1>\frac1\tau,\ a_2>\frac1\tau-\frac bm,\ a_i>0\) | 闭环状态有界；\(y,\dot y\) "in a finite time" 跟踪 | \(\bar e_1,\bar e_2,\tilde x_3,\tilde x_4,\tilde x_5\) | 证明给出 \(\dot V_5<0\) 的负二次型 | 已知界 \(k_i\) | 负二次型 ⇒ **指数收敛**，非有限时间 |
| Theorem 1（p.5） | 观测器 (16)(17)；**\(|\dot\Delta_i|<\sigma_i\)**；\(\alpha_i(\cdot)\) class-K | 观测误差 \(e_i\) 全局 FTUB；\(|s_i|\le\alpha_i^{-1}(\sigma_i)\)，时间 \(T_i=\frac{|s_i(0)|}{\alpha_i(|s_i(0)|)-\sigma_i}\) | **\(s_i=\dot e_i+\beta e_i^{q/p}\)** | FTUB | 未知 \(\sigma_i\) | 证明缺口：作者**显式假设** \(\ddot{\hat x}_i=\ddot x_i\)（p.5 (20) 后），该假设不被 (17) 保证；另有 (20) 中 \(\dot{\hat\Delta}_i\to\dot\Delta_i\) 的替换未说明 |
| Theorem 2（p.5–7） | 同 Theorem 1；\(\bar\Theta_i\gg\alpha_i^{-1}(\sigma_i)\)；\(a_1>\frac1\tau,\ a_2>\frac1\tau-\frac bm\) | 闭环 (2)(16)(17)(22) 有界；\(y,\dot y\) 有限时间跟踪 | 全部 | 声称 "finite time"；最终 \(V_5\) 为负二次型 | 未知 \(\sigma_i\)；"\(\gg\)" | 位置误差实际为指数收敛；**\(u\) 有界性未证**；且证明把 \(\alpha_i^{-1}(\sigma_i)\) 当作**估计误差界** \(|\hat\Delta_i|-|\Delta_i|\le\alpha_i^{-1}(\sigma_i)\) 使用，而定理 1 只给出 \(|\dot e_i|\) 的界 |

### 结论性质的关键区分（保留判断）

- **观测器**：非光滑项 \(-\alpha_i\operatorname{sgn}(s_i)\) 给出有限时间/FTUB 的**形式**，但证明有缺口。
- **跟踪**：\(\dot V\le -cV\)（\(c>0\)），指数渐近；**没有** \(\dot V\le-cV^{\rho}\ (0<\rho<1)\) 的有限时间不等式。
- 题目 "in a finite time" 对真实位置跟踪只能理解为 FTUB 意义下"任意小邻域可在某有限时刻进入"，**时间依赖初值与未知 \(\sigma_i\)，不可预设**。

---

## 4. 优先问题逐条回答（修订）

### 4.1 时间变换是否与指定时刻相关？

**否。** 全文没有终端时刻 \(T\)。\(\mu(t,\tau)=(e^{t/\tau}+1)/2\) 只依赖**绝对时间 \(t\)**，在任意有限 \(t\) 都有限，仅当 \(t\to\infty\) 发散；\(\tau\) 只改变增长快慢，不引入终点。它不是预设时间（prescribed-time）变换，也不是固定时间（fixed-time）设计。

式 (34)（p.7）的截断只避免 \(\mu\) 无界：

\[
\mu(t,\tau)=\begin{cases}\dfrac{1+e^{-t/\tau}}{2e^{-t/\tau}},& t\le\delta_t\\[4pt] \mu_{\max}=\dfrac{1+e^{-\delta_t/\tau}}{2e^{-\delta_t/\tau}},& t>\delta_t\end{cases}
\]

\(\mu\) 在 \(\delta_t\) 连续，但 \(\dot\mu(\delta_t^-)=\dfrac{e^{\delta_t/\tau}}{2\tau}\ne0=\dot\mu(\delta_t^+)\)。凡含 \(\dot\Phi_i\) 的控制项在 \(\delta_t\) 处都可能出现**输入跳变**，论文未分析。（原报告此处写 \(e^{\delta_t}/2\)，是 \(\tau=1\) 的特例。）

### 4.2 精确位置跟踪还是有限时间进入邻域？

- **不是精确有限时间跟踪**：没有 \(\bar e_1(T)=0\) 的结论。
- **式 (35) 界的不是位置/观测误差本身**（修订 C5）：原文为
\[
|\dot e_i|=|\hat\Delta_i-\Delta_i|\le|s_i(t)|\le\alpha_i^{-1}(\sigma_i)\qquad(\text{p.7 Eq.(35)}),
\]
即界的是**观测误差的导数**。因此**不能**据此宣称 \(e_i\) 落在 \(\alpha_i^{-1}(\sigma_i)\) 邻域内。（且该等式本身已忽略 (17) 与 (2) 相减得到的线性项，见 §7 第 2 条。）
- 真实位置误差：\(|\bar e_1(t)|=|E_1(t)|/\mu(t)\le\sqrt{2V_5(0)}\,e^{-c_5t}/\mu(t)\)。因 \(\mu\sim e^{t/\tau}/2\)，指数率约为 \(c_5+1/\tau\)。**仍是指数，不是有限时间。**
- 观测器：若 \(\alpha_i\) 取常数且 \(\alpha_i>\sigma_i\)，\(s_i\) 在 \(T_i=|s_i(0)|/(\alpha_i-\sigma_i)\) 内到 0（精确有限时间）；但论文把 \(\alpha_i(\cdot)\) 定义为 class-K，此时 \(T_i\) 的闭式不成立。论文给出的 \(T_i\) 用的是 \(\alpha_i(|s_i(0)|)\)，与常增益情形不一致（保留判断）。

### 4.3 噪声是定理还是仿真？

**只是仿真。** 定理假设只有 \(|\dot\Delta_i|<\sigma_i\)，没有量测噪声项。Fig. 7（p.10）在量测端加 Simulink Band-Limited White Noise，幅值/带宽未给解析界；位置误差在噪声下约 \(\pm0.05\) m，远大于无噪声情形。**不能**当作"噪声下仍有定理保证"的证据。

### 4.4 输入与闭环有界性

- 无终端 \(T\)，只有式 (34) 的 \(\delta_t\) 截断与仿真终点 10 s。
- **闭环状态**：Theorem 2 声称全部有界，但依赖含未知 \(\sigma_i\) 的 \(\bar\Theta_i\) 条件，属**存在性**条件，不能先验验证。
- **输入 \(u\)**：定理**没有** \(\sup|u|\) 的界，饱和明确留作 future work（p.10 结论）。Fig. 5（p.9）峰值约 20 V、稳态约 \(\pm15\) V 是仿真观测。
- \(\delta_t\) 处 \(\dot\mu\) 跳变；大 \(t\) 时若不截断 \(\mu\sim e^{t/\tau}/2\)，虚拟控制中的 \(\mu\) 因子需与 \(1/\mu\) 精确抵消才能保证 \(u\) 有界，论文未逐项证明。

### 4.5 各环节时间保证

| 环节 | 论文保证 | 实际可确认 |
|---|---|---|
| 对象状态 | Theorem 2：全部有界 | 条件性有界；依赖未知 \(\sigma_i\) 与 \(\bar\Theta_i\) |
| 观测器 | Theorem 1：\(e_i\) FTUB，时间 \(T_i\) | 证明有缺口；\(T_i\) 依赖 \(s_i(0)\) 与 \(\sigma_i\) |
| 滤波器 | 无 | — |
| 真实位置 \(y\) | "finite time tracking" | 指数渐近（率 \(\approx c_5+1/\tau\)）；非预设 |
| 速度 \(\dot y\) | 同上 | 同上 |

---

## 5. 量测条件与项目合同（保留判断，不修改合同）

- L03 量测集合：位置 \(y\)、两腔压力（得 \(P_L\)）、**阀芯位移 \(v_e\)**；速度与阀速由观测器估计。
- 与项目合同（位置 + 两腔压力可测、速度估计）**部分一致**；**额外要求 \(v_e\) 可测**，且控制器直接使用 \(x_3=P_L,\ x_4=v_e\)。若 \(v_e\) 不可测，需再设计一个观测器，论文未给。
- 对象为五阶（含二阶阀动态），**不能等同于三阶系统**；若项目对象为三阶，反步链缩短为 3 级，\(x_{4d},x_{5d},u\) 结构不能照搬。
- 参考信号需 \(\dot y_d,\ddot y_d\)，经反步微分实际需要 \(\dddot y_d\) 甚至 \(y_d^{(4)}\)；论文只声明 \(y_d,\dot y_d\)。

---

## 6. 实际优点（保留）

1. 模型较完整：五阶 EHA 含摩擦、死区、阀零偏、二阶阀动态；扰动分非匹配（速度、压力）与匹配（阀加速度）三类。
2. DOB + 反步组合合理：对非匹配扰动逐级估计并前馈。
3. 时间变换 \(\mu(t,\tau)\) 提高瞬态：\(E=\mu\bar e\) 稳定的同时 \(\bar e\) 额外获得 \(1/\mu\) 衰减。
4. 实现简单：无神经网络、无参数自适应、无滤波器；每步只有代数运算、符号函数与三个积分器。
5. 仿真对比完整：与 OFCDR [32] 对比，给出 RMS 指标与收敛时间（均为作者仿真值）。

---

## 7. 适用边界与未闭合点（修订后）

1. **"有限时间"名不副实（对跟踪）**：\(V_2,V_5\) 的不等式为负二次型，指数收敛；没有分数幂不等式。真实位置的"有限时间"只在 FTUB 弱意义上成立，时间不可预设。**L03 不是预设时间方法，不能作为精确有限时间跟踪的基线。**
2. **定理 1 的证明缺口（修订 C9）**：p.5 式 (20) 之后作者明确写 "it is assumed that \(\ddot{\hat x}_i=\ddot x_i\)"。该假设未被观测器 (17) 保证；由 (17)−(2) 得 \(\ddot e_2=-\frac bm e_2+\hat\Delta_2-\Delta_2\)，一般不为零。**这不是"悄悄丢掉线性项"，而是显式加了一个未经证明、且恰好抹掉待估误差的假设。**（"抹掉"是本报告的解读，不是作者措辞。）此外 (20) 右端写作 \(-\dot\Delta_i\)，而代入式给出的是 \(-\dot{\hat\Delta}_i\)，二者相等需 \(\dot e_i\) 的导数项为零，同样未说明。
3. **式 (35) 界错对象（修订 C5）**：界的是 \(|\dot e_i|\)，不是 \(|e_i|\)。若由 \(|s_i|\le r\) 反推观测误差带，需用 \(s_i=\dot e_i+\beta e_i^{q/p}\) 得 \(|e_i|\le(r/\beta)^{p/q}\)（本报告复算，非作者结论），比 \(\alpha_i^{-1}(\sigma_i)\) 大一个幂次。
4. **定理 2 依赖未证明的估计误差界**：p.6 (26)(29)(32) 的 Case 1 都用到 \(|\hat\Delta_i|-|\Delta_i|\le\alpha_i^{-1}(\sigma_i)\)，而定理 1 只给出 \(|\dot e_i|\) 的界。这是 C5 的实际后果，不只是措辞问题。
5. **\(\bar\Theta_i\gg\alpha_i^{-1}(\sigma_i)\) 依赖未知 \(\sigma_i\)**：\(\sigma_i\) 现在是**扰动导数**的界；"\(\gg\)" 不是严格不等式（作者在 p.6 自己解释为 "much greater than symbol"），仅凭控制律不显含 \(\sigma_i\) 不能说明条件可先验验证。
6. **符号情形与收敛前区间未分段处理**：Case 2 需额外 \(\bar\alpha\omega_i\) 项，要求 \(\bar\Theta_i\) 严格大于残差；\(t<T_i\) 的闭环有界性未单独证明（保留 O5/O8 的实质）。
7. **输入有界性/饱和缺失**：定理不保证 \(\sup|u|\)；饱和留作 future work；\(\delta_t\) 处 \(\dot\mu\) 跳变可引起 \(u\) 跳变。
8. **Table 1 缺 \(b\) 且缺 \(\tau\)**：\(b\)（粘性摩擦系数）与 \(\tau\)（时间常数）都未给数值，而增益条件同时含 \(1/\tau\) 与 \(b/m\)，故**无法用 Table 1 对 (36) 做数值核对**；仿真所用 \(\alpha_i,\beta,q/p,\bar\Theta_i,\delta_t\) 也未列出。
9. **\(e^{q/p-1}\) 在 \(e_i=0\) 奇异**：\(\dot{\hat\Delta}_i\) 含 \(e_i^{q/p-1}\dot e_i\)，反步对 \(\Phi_i\) 求导会产生此类项，在收敛点附近可能奇异/抖振。论文未处理。
10. **\(x_3\) 可测却又估计 \(x_3\)**：\(\dot{\hat x}_3\) 通道冗余，仅用于构造 \(\hat\Delta_3\)。
11. **式 (8) 与 (9)/(10)/(23)/(24) 的 \(\mu\) 记账不一致（本任务新增观察 O15）**：由 \(E_2=\mu\bar e_2\) 可知式 (5) 的 \((A_p/m)\mu x_3\) 不是排版选择、而是定义的结果，因此 (8) 必含 \(\mu^{-1}\)（与页面图像一致），(9) 的 \(\tilde x_3\) 项应为 \((A_p/m)\mu\tilde x_3\)、(10) 应为 \(-(A_p/m)\mu\bar E_2+(2\rho A_p/(\mu V_0))(\bar E_2+\Phi_1)+\cdots\)、(23) 的前置因子应为 \((A_p/m\,\mu)^{-1}\)。页面图像显示这几处**都没有** \(\mu\)，而 (9)(10)(11) 与 (23)(24) 彼此倒是自洽的。**后果有两种读法**：若照印刷把 (23) 当控制器，则 (25) 的 \(-E_1\) 会变成 \(-\mu E_1\)，\(\dot V_2\) 多出 \((1-\mu)E_1\bar E_2\) 交叉项；若把 (8)（由 (5) 唯一确定）当控制器，则只需把 \(\mu\) 补回上述三处，整条链即精确闭合、无残差。两种读法下问题都只是"缺一个 \(\mu\)"的排印/缩放疏漏，在 (34) 的截断 \(\mu\le\mu_{\max}\) 下有界，可由更大的 \(a_1,a_2\) 压住，**不改变指数收敛的定性结论**；但逐式复现必须澄清。**此项不构成对 C7 的翻案**（C7 关于 (8) 的结论已按要求撤回疑点并确认含 \(\mu\)）。
12. **参考导数阶数未声明**：反步到 \(u\) 需 \(y_d^{(4)}\)；论文只写 \(y_d,\dot y_d\)。
13. **噪声无定理**：见 §4.3。
14. **Definition 1/2 与 Table 2 指标**：Definition 1 的 "\(t\in[0,T]\)" 与 FTUB 通常定义（\(t\ge T\)）不符；Table 2 称 \(J_{\bar e}\) "based on the infinity norm"，公式却是 \(L_2\) 型积分。均为表述问题，不影响上述结论。

---

## 8. 作者仿真数据（作者结果，未复现）

Table 1（p.7 原表，逐格核对）：

| 物理量 | 符号 | 单位 | 数值 |
|---|---|---|---|
| 活塞质量 | \(m\) | kg | 440 |
| 活塞面积 | 表中符号栏印为 \(b\)（应为 \(A_p\)） | m² | 0.01 |
| 居中腔体积 | \(V_0\) | m³ | 0.004 |
| 体积模量 | \(\rho\) | Pa | \(10^9\) |
| 输入增益 | \(k_e\) | — | 0.49 |
| 阀固有频率 | \(\omega_{nv}\) | s⁻¹ | 152 |
| 阀阻尼系数 | \(\epsilon_v\) | — | 0.92 |
| 供油压力 | \(P_s\) | Pa | \(10^7\) |

**C6 说明**：原报告写 \(\omega_e=49\ \mathrm{s^{-1}}\)、无 \(k_e\)，均错。实际为 \(\omega_{nv}=152\)、\(k_e=0.49\)。"Piston area"行的**符号栏印作 \(b\)**（单位 m²、数值 0.01），按物理量应读作 \(A_p\)；这解释了"表中出现 \(b\)"的假象——**粘性摩擦系数 \(b\) 的数值仍然未给出**。\(b\) 未给出这一判断成立。

由表中数值可算的派生量（本报告计算，用于量级核对）：

| 量 | 值 |
|---|---|
| \(k_e\omega_{nv}^2\) | \(1.132\times10^{4}\ \mathrm{s^{-2}}\) |
| \((k_e\omega_{nv}^2)^{-1}\) | \(8.83\times10^{-5}\ \mathrm{s^{2}}\) |
| \(A_p/m\) | \(2.273\times10^{-5}\ \mathrm{m^2/kg}\) |
| \(2\rho A_p/V_0\) | \(5.0\times10^{9}\) |
| \(2\epsilon_v\omega_{nv}\) | 279.7 s⁻¹ |

其余作者仿真结果：

| 项目 | 数值/说明 |
|---|---|
| 仿真时长 | 10 s |
| 初值 | 所有状态与观测器初值 0 |
| 参考 | \(y_d=\sin t,\ \dot y_d=\cos t\) |
| 跟踪 RMS \(J_{\bar e}\) | 本文 454.3921；OFCDR 643.2316（降 29.36%） |
| 观测收敛时间 | 本文 <0.168 s、0.1 s、0.0005 s；对比 0.3 s、1.15±0.1 s、0.09 s |
| 跟踪收敛时间 | 位置 0.2 s vs 1±0.1 s；速度 0.5 s vs 1.5±0.5 s |
| 输入 | Fig. 5 峰值约 20 V、稳态约 ±15 V；无饱和 |
| 噪声 | Fig. 7 Band-Limited White Noise；位置误差约 ±0.05 m；无定量噪声界 |

以上均为作者特定工况结果，**不是本项目复现**，也不能当作定理保证。（原报告此处写"对比 0.9 s"，原解析为 0.09 s，本修订一并改正。）

---

## 9. 时间账本（修订，含 \(\tau\)）

| 阶段 | 论文时间结论 | 依赖 | 备注 |
|---|---|---|---|
| 时间变换 | \(\mu=(e^{t/\tau}+1)/2\)，\(\dot\mu/\mu\in\left(\frac{1}{2\tau},\frac{1}{\tau}\right]\) | 绝对时间 \(t\)、常数 \(\tau\) | 无终端 \(T\)；非预设时间；\(\tau\) 只缩放速率 |
| 观测器通道 \(i\) | \(T_i=\dfrac{|s_i(0)|}{\alpha_i(|s_i(0)|)-\sigma_i}\) | \(s_i(0),\alpha_i(\cdot),\sigma_i\)（\(\sigma_i\) 为 \(|\dot\Delta_i|\) 的界） | 闭式仅在常增益时严格成立 |
| 变换误差 \(E_1,\bar E_2\) | 无显式 \(T\)；\(\dot V_2\le-2c_2V_2\) | \(a_1,a_2,b/m,\tau\) | \(c_2=\min\left(a_1-\frac{\dot\mu}{\mu},\ a_2+\frac bm-\frac{\dot\mu}{\mu}\right)\) |
| 真实位置 \(\bar e_1\) | 无显式 \(T\)；\(|\bar e_1|\le|E_1|/\mu\) | 初值、增益、未知界、\(\tau\) | 指数；\(\mu\sim e^{t/\tau}/2\) 使附加率约 \(1/\tau\) |
| 截断 \(\delta_t\) 后 | 仅声称"仍有界" | \(\delta_t,\mu_{\max}\) | \(\dot\mu\) 跳变；无新收敛时间结论 |
| 仿真 | 10 s | — | 作者数值 |

**账本口径提醒**：原报告把 \(\dot\mu/\mu\in(1/2,1)\)、\(a_1>1\) 写成一般结论，实际只在 \(\tau=1\) 时成立。一般情形下可行增益随 \(\tau\) 缩小（下界 \(1/\tau\)）而放宽，附加衰减率随 \(\tau\) 增大而减小。

---

## 10. 对项目的定位（不宣称创新）

- **类别**：非学习、DOB + 反步 + 时间变换；**不是预设时间**，也不是严格有限时间跟踪；属 "FTUB + 指数跟踪" 一类。
- **可借鉴**：五阶 EHA 的扰动分解（非匹配/匹配）、逐级 DOB 前馈、时间变换改善瞬态、无学习环节的轻量实现。
- **不可直接照搬**：阀芯位移 \(v_e\) 的额外量测；\(y_d\) 的高阶导数；观测器证明缺口（\(\ddot{\hat x}=\ddot x\)）；\(\bar\Theta_i\) 依赖未知 \(|\dot\Delta_i|\) 的界；输入饱和与噪声均无定理；\(\tau,b\) 未给出导致增益条件不可数值核对。
- **若项目坚持"预设时间"**：本文不提供该性质；把 \(\mu\) 换成 \(T/(T-t)\) 一类是另一个设计问题，需重新证明（含 \(t\to T\) 奇异性、\(T\) 之后如何定义、输入是否有界），不能把本文结论平移。
