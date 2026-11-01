---
interpretation_contract: research-literature-interpretation-evidence-v1
source_id: L03_Razmjooei_2022_EJC_100659
evidence_depth: fulltext_11_pages_text_all_key_pages_3_7_image_checked
read_scope: 正文与证明第2-7页全文，仿真第8-10页，结论与参考文献第10-11页；PDF第3-7页原图目视核对
stable_citation: Razmjooei, Palli and Nazari (2022), European Journal of Control 67, 100659, doi 10.1016/j.ejcon.2022.100659
question: L03 的有限时间性来自哪里，观测器与跟踪证明各缺什么，时间变换为何不产生预设时间
method: MinerU 缓存全文阅读、PDF 第3-7页原图核对、由(2)(16)(17)独立重推观测误差与滑模动力学、代数反例与数值量级复算
key_results: 位置跟踪只有指数收敛；观测器有限时间性依赖符号项但(19)-(21)抹去漂移差；定理2的鲁棒裕度需覆盖扰动本身；mu时间变换无终端时刻
limitations: 未复现作者仿真；b、tau、alpha_i、beta、q/p、Theta_i、delta_t 未给；定理1缺口未闭合；原图仅核第3-7页
supports_or_refutes: 反驳将L03视为预设时间或精确有限时间跟踪基线；有条件支持其DOB加反步的FTUB工程思路；不直接支持本项目三阶且仅位置与两腔压力可测的合同
---

# 把“有限时间”拆开看：L03 的 DOB、反步与时间变换

这篇论文要解决五阶电液执行器在摩擦、死区、阀零偏和外部扰动下的位置跟踪。作者把扰动观测器（DOB）嵌进反步法，再用一个随时间增大的尺度 \(\mu\) 变换误差。全文最强的证据是观测器滑模面上的符号项能给 \(s\) 一个有限时间界；最大的边界是位置跟踪的 Lyapunov 不等式只有负二次型，没有分数幂，也没有终端时刻 \(T\)。读这篇论文的关键，是分清“观测器滑模量的有限时间”与“真实位置误差的有限时间”。

> 标记：〔原文〕页面可核对的式子；〔主张〕作者判断；〔解释〕我的推导；〔待验证〕需作者澄清或复现。

## 一、三个核心命题

**命题 1：\(\mu\) 是移动标尺，不是预设时间钟。** 它把 \(E=\mu\bar e\) 的有界性翻译成 \(\bar e\) 的收敛，但 \(\mu\) 只在 \(t\to\infty\) 发散，所以给的是指数收敛。

**命题 2：观测器的有限时间来自 \(-\alpha_i\operatorname{sgn}(s_i)\)，但证明抹掉了漂移差。** 由对象与观测器相减得到的 \(\dot e_i\) 含三个线性漂移项；式 (20) 把它们置零后才成立。

**命题 3：定理 2 的鲁棒裕度在最坏符号下要压住扰动本身，而不只是估计误差。** 这与“不需要扰动上界”的核心主张冲突。

## 二、五阶对象与反步链

对象见 p.2–3 式 (1)(2)。状态为位置 \(y\)、速度 \(\dot y\)、负载压差 \(P_L\)、阀芯位移 \(v_e\)、阀芯速度 \(\dot v_e\)，相对阶 5。\(\Delta_2,\Delta_3\) 在速度与压力通道，相对 \(u\) 非匹配；\(\Delta_5\) 在阀加速度通道，是匹配扰动。

反步链是 \(\Phi_1\to\Phi_2\to\Phi_3\to\Phi_4\to u\)（p.4–5，式 (8)(10)(12)(14)）。量测条件是关键差异：作者明确把 \(y,P_L,v_e\) 当作可测（p.5，式 (17) 后），真正不可测的是 \(\dot y,\dot v_e\)。观测器 (17) 仍积分 \(\hat x_3\)，但原文同时称 \(x_3\) 可测，故该通道结构冗余。控制器直接使用阀芯位移；若它不可测，整条链要重设计。

## 三、时间变换：改变尺度，不改变终点

式 (4)（p.3）：
\[
\mu(t,\tau)=\frac{1+e^{-t/\tau}}{2e^{-t/\tau}}=\frac{e^{t/\tau}+1}{2},\qquad \mu(0)=1,
\]
\[
\frac{\dot\mu}{\mu}=\frac{1}{\tau}\frac{e^{t/\tau}}{1+e^{t/\tau}}\in\left(\frac{1}{2\tau},\frac{1}{\tau}\right).
\]
这正是 (36)（p.7）增益条件的来源：\(a_1>1/\tau\)、\(a_2>1/\tau-b/m\) 保证 \(\dot\mu/\mu-a_1<0\)、\(\dot\mu/\mu-b/m-a_2<0\)。

〔解释〕因为 \(E_i=\mu\bar e_i\)，同一个 \(E_i\) 在物理坐标里对应 \(\bar e_i=E_i/\mu\)，随 \(\mu\) 增大而变小。但任意有限 \(t\) 时 \(\mu(t)<\infty\)，只有 \(t\to\infty\) 才发散。所以 \(E\) 有界只能推出 \(\bar e\to0\)，不能推出某个有限时刻等于零。

Remark 1（p.3）说变换函数在 \(t\to t_0+T\) 发散，因而有限时间 FTUB；这要求 \(T<\infty\)。式 (4) 的 \(\mu\) 却在 \(t\to\infty\) 才发散，即 \(T=\infty\)。套用 Remark 1 得到的是渐近结论。截断 (34)（p.7）后 \(\mu=\mu_{\max}\)，\(1/\mu\) 的附加衰减消失，长期只剩 \(E\) 动力学的指数率。

## 四、决定性推导：有限时间从哪里来，又漏了什么

原文式 (16)(17) 在 p.5，式 (2) 在 p.3。先相减，注意 \(x_3,x_4\) 用同一可测值：
\[
\dot e_2=-\frac{b}{m}e_2+\hat\Delta_2-\Delta_2,\quad
\dot e_3=-\frac{2\rho A_p}{V_0}e_2+\hat\Delta_3-\Delta_3,
\]
\[
\dot e_5=-2\epsilon_v\omega_{nv}e_5+\hat\Delta_5-\Delta_5.
\]
三个漂移项真实存在，不会因观测器增益大而自动消失。

对式 (16) 求导，在 \(e_i\ne0\) 时
\[
\dot{\hat\Delta}_i=-\alpha_i\operatorname{sgn}(s_i)-\beta\frac{q}{p}e_i^{q/p-1}\dot e_i,
\qquad s_i=\dot e_i+\beta e_i^{q/p}.
\]
对 \(s_i\) 求导并代入，\(\dot{\hat\Delta}_i\) 恰好抵消：
\[
\dot s_2=-\alpha_2\operatorname{sgn}(s_2)-\dot\Delta_2-\frac{b}{m}\dot e_2,
\]
\[
\dot s_3=-\alpha_3\operatorname{sgn}(s_3)-\dot\Delta_3-\frac{2\rho A_p}{V_0}\dot e_2,
\]
\[
\dot s_5=-\alpha_5\operatorname{sgn}(s_5)-\dot\Delta_5-2\epsilon_v\omega_{nv}\dot e_5.
\]
于是
\[
\dot V_i=s_i\dot s_i=-\alpha_i|s_i|-s_i\dot\Delta_i-s_i d_i,
\]
其中 \(d_2=(b/m)\dot e_2\)、\(d_3=(2\rho A_p/V_0)\dot e_2\)、\(d_5=2\epsilon_v\omega_{nv}\dot e_5\)。

原文 (20)（p.5）写的是
\[
\dot V_i=s_i\left(-\alpha_i\operatorname{sgn}(s_i)-\dot\Delta_i\right),
\]
即 \(d_i=0\) 的特例。作者在 (20) 后写“it is assumed that \(\ddot{\hat x}_i=\ddot x_i\)”。由 \(e_i=\hat x_i-x_i\)，这就是 \(\ddot e_i=0\)。它不是“丢掉一个线性项”那么轻：它把待估误差的二阶导数直接设为零，还要把代入式给出的 \(\dot{\hat\Delta}_i\) 换成 \(\dot\Delta_i\)。

〔解释〕若只在某一点令 \(\ddot e_i=0\)，式 (20) 只是该点恒等式，不能沿轨迹积分成 (21)。若当全局假设，则由误差方程可推出 \(\dot e_i=0\)、\(e_i\) 为常数；这既不是 (17) 的通解，也不能由 \(|\dot\Delta_i|<\sigma_i\) 推出。两种读法都停在同一个缺口：**(20) 不是由 (16)(17)(2) 推出的恒等式。**

## 五、(19)–(21) 的三个细节

**第一，界的是扰动导数。** 原文 (21) 前写 \(|\dot\Delta_i|<\sigma_i\)。这一步旧报告已更正，我同意。但真实系统还有 \(-s_i d_i\)，正确条件是
\[
\alpha_i>\sigma_i+|d_i|,
\]
不是 \(\alpha_i>\sigma_i\)。通道 3 的 \(d_3\) 依赖 \(\dot e_2\)，属于另一通道；三个通道并不解耦。

**第二，\(\alpha_i\) 是 class-K 还是常数，原文没有统一。** 常增益且 \(>\sigma_i\) 时，到零时间是 \(|s_i(0)|/(\alpha_i-\sigma_i)\)，到 \(r=\alpha_i^{-1}(\sigma_i)\) 是 \((|s_i(0)|-r)/(\alpha_i-\sigma_i)\)。class-K 时应为
\[
T_i=\int_r^{|s_i(0)|}\frac{ds}{\alpha_i(s)-\sigma_i},
\]
一般无闭式。原文印的 \(T_i=|s_i(0)|/(\alpha_i(|s_i(0)|)-\sigma_i)\) 既不是常增益的精确时间（没有减 \(r\)），也不是 class-K 的积分时间。

**第三，式 (35) 界的不是 \(e_i\)，而且 \(|\dot e_i|\le|s_i|\) 本身不普遍成立。** 由 \(s_i=\dot e_i+\beta e_i^{q/p}\) 只能得 \(|\dot e_i|\le|s_i|+\beta|e_i|^{q/p}\)。瞬时代数反例：\(e=216,\ \dot e=-5,\ \beta=1,\ q/p=1/3\)，则 \(e^{1/3}=6,\ s=1\)，故 \(|\dot e|=5>|s|=1\)。再取 \(b/m=1,\ \alpha=3,\ \dot\Delta=0\)，真实 \(\dot V=1\cdot(-3+5)=2>0\)，而 (20) 会给 \(-3<0\)。省略 \(d_i\) 不只是保守，而是能让符号翻转。

若确实有 \(|s_i|\le r\)，由 \(\dot e_i=s_i-\beta e_i^{q/p}\) 可得最终
\[
|e_i|\le\left(\frac{r}{\beta}\right)^{p/q}
=\left(\frac{\alpha_i^{-1}(\sigma_i)}{\beta}\right)^{p/q},
\]
这是〔解释〕，比原文暗示的 \(r\) 宽一个 \(p/q>1\) 次幂。

## 六、定理 2：鲁棒裕度在压什么

定理 2 的控制律 (22)（p.5）在末级用 \(-(\hat\Delta_5+\bar\Theta_5)\operatorname{sgn}(\tilde x_5)\)。对一般通道 \(i\)，该项对 \(\dot V_i\) 的贡献是 \(-|\tilde x_i|(\hat\Delta_i+\bar\Theta_i)\)，扰动贡献是 \(\tilde x_i\Delta_i\)，相加为
\[
-|\tilde x_i|\hat\Delta_i+\tilde x_i\Delta_i-|\tilde x_i|\bar\Theta_i.
\]
取最坏符号 \(\tilde x_i<0\)，且估计已准确 \(\hat\Delta_i=\Delta_i=-D<0\)，上式变成 \(|\tilde x_i|(2D-\bar\Theta_i)\)。要它为负，必须
\[
\bar\Theta_i>2D=2|\Delta_i|.
\]

〔解释〕这不是估计误差的量级，而是扰动本身的量级。原文只要求 \(\bar\Theta_i\gg\alpha_i^{-1}(\sigma_i)\)；但此时代入 Case 2 的 \(\omega_i=2D|\tilde x_i|\)，条件变成 \(\bar\Theta_i\ge2\bar\alpha D+\alpha_i^{-1}(\sigma_i)\)。由于 \(\Delta_i\) 的上界正是作者声称不需要知道的量，这与“without any knowledge about the upper bounds”冲突。把 \(\bar\Theta_i\) 取任意大当然能满足，但那样它就不再是“抑制估计误差”的小裕度，而是“抑制扰动”的大增益。

## 七、证据与边界

〔原文〕作者仿真用 \(y_d=\sin t\)、10 s、零初值（p.7–8）。Table 1（p.7）给 \(m=440\)、\(A_p=0.01\)、\(V_0=0.004\)、\(\rho=10^9\)、\(k_e=0.49\)、\(\omega_{nv}=152\)、\(\epsilon_v=0.92\)、\(P_s=10^7\)。表中“Piston area”的符号栏印作 \(b\)，应读作 \(A_p\)；粘性摩擦 \(b\) 的数值仍未给。

作者报告的 0.2 s、0.5 s 收敛时间和 \(J_{\bar e}=454.3921\) 对 643.2316，都是**作者特定工况的仿真值，不是本项目复现结果**，也不是定理保证。噪声实验只在仿真中出现；饱和被留作 future work（p.9–11）。〔待验证〕Table 1 缺 \(b,\tau\)，也没给 \(\alpha_i,\beta,q/p,\bar\Theta_i,\delta_t\)，所以 (36) 无法用表中参数核对。

还有一个排版硬问题：\(\mu\) 的记账不一致。式 (8) 的前置因子 \((A_p/m\,\mu)^{-1}\) 是由 \(E_2=\mu\bar e_2\) 唯一确定的；但式 (9) 第二行的 \((A_p/m)\tilde x_3\) 没有 \(\mu\)，式 (10) 的压力项没有 \(1/\mu\)。按 p.4 原图，式 (9) 第三行确有 \(1/(\mu V_0)\)，所以 (9) 与 (10) 代回会留下
\[
\frac{2\rho A_p}{V_0}\left(1-\frac1\mu\right)(\tilde E_2+\Phi_1)
\]
的残差。式 (23) 的前置因子 \((A_p/m)^{-1}\) 与 (5) 组合至少会把 \(-E_1\) 变成 \(-\mu E_1\)。〔解释〕这不影响“指数收敛”的定性结论，但逐式复现必须补 \(\mu\)。旧报告 O15 的方向对；它说 (9)(10)(11) 彼此自洽，我只同意一半：\((A_p/m)\) 项如它所述，压力项还差 \(1/\mu\)。

## 八、优点与借鉴

这篇论文的价值不在“有限时间”标题，而在三件事。第一，扰动分解清楚：非匹配项逐级估计前馈，匹配项在末级用符号项压住，比全塞进一个匹配通道更接近 EHA 结构。第二，实现轻：无神经网络、无自适应、无滤波器，每步是代数运算、符号函数和三个积分器。第三，\(\mu\) 作为瞬态整形有效：早期获得额外 \(1/\mu\) 衰减，只要不把它当预设时间机制，这个技巧可以单独借用。

值得借鉴的场合：相对阶链完整、阀芯位移可测、扰动导数有界、输入有裕度、目标只是 FTUB。不值得直接照搬：严格预设时间、强饱和、只有位置与两腔压力可测、对象是三阶。

## 九、对本项目的有条件启发

项目目标是 ISA Transactions；当前四状态仿真不等于已核验的三阶模型；合同是位置与两腔压力可测、速度估计。L03 是五阶对象，且额外要求 \(v_e\) 可测，这是硬差异，不能悄悄改项目条件。

- 若保留“位置 + 两腔压力”量测，L03 的反步链不能直接移植；要么加阀芯位移传感器，要么另设计 \(x_4\) 观测器，论文没有给后者。
- 若借用 DOB，必须把 §4 的漂移项纳入证明；只写 \(-\alpha\operatorname{sgn}(s)\) 的有限时间，不构成闭环跟踪的有限时间。
- 若借用 \(\mu\)，只当瞬态整形；不要从 \(|E|\) 的指数界和 \(1/\mu\) 的指数增长直接宣布“有限时间”或“预设时间”。
- 若借用定理 2 的鲁棒项，先检查最坏符号下 \(\bar\Theta_i\) 是否要覆盖 \(2|\Delta_i|\)；若答案是“要”，就等于重新引入扰动上界。

这些是阅读后的有条件启发，不构成创新声明，也不替代本项目自己的模型核验与证明。

## 十、自测四问

**问 1：\(\mu=(e^{t/\tau}+1)/2\) 是否给出预设时间？**  
答：不。有限 \(t\) 时 \(\mu\) 有限，只在 \(t\to\infty\) 发散；没有终端 \(T\)，只给指数收敛。

**问 2：观测器的有限时间性来自哪里？**  
答：来自 (16) 滑模面里的 \(-\alpha_i\operatorname{sgn}(s_i)\)。但 (20) 把 \(\dot e_i\) 的漂移项置零后才得到这个形式，该步没有被 (17) 保证。

**问 3：为什么 (35) 不能界 \(e_i\)？**  
答：它界的是 \(\dot e_i\)，且第一个等号已假设零漂移；\(|\dot e_i|\le|s_i|\) 也不普遍成立。由 \(|s|\le r\) 能推出的是 \(|e_i|\le(r/\beta)^{p/q}\)。

**问 4：\(\bar\Theta_i>\alpha_i^{-1}(\sigma_i)\) 就够吗？**  
答：不够。最坏符号 \(\tilde x_i<0,\ \Delta_i=\hat\Delta_i=-D<0\) 下残差是 \(2D-\bar\Theta_i\)，需要 \(\bar\Theta_i>2|\Delta_i|\)，依赖扰动本身的上界。

---

**一手来源**：https://doi.org/10.1016/j.ejcon.2022.100659  
**出版版**：European Journal of Control 67 (2022) 100659, pp. 1–11.  
**访问日期**：2026-11-01.  
**说明**：公式核对以 MinerU 缓存全文与 PDF 第 3–7 页原图为准；作者仿真数值仅作原文事实转述，未在本项目复现。机械格式校验由审核者执行。
