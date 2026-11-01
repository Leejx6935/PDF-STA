# L13 证明重构与独立核对

**对象**：Niu et al., “Command filter and neural network-based fixed-time backstepping control of electro-hydraulic system with uncertainties”, Applied Mathematical Modelling 157 (2026) 116848, DOI 10.1016/j.apm.2026.116848.

**材料**：MinerU 标准解析 `doc:8f7be38/tier:standard`，20 页，SHA256 与任务给定值一致。以下页码均指 PDF 页码；式号沿用原文。

**核对等级说明**：

- “文本核对”指解析文本内部自洽、可由前后式互推；
- “待原图”指解析文本存在 OCR 损坏或与前后式冲突，本轮无法调取页面图像（`asset=null`），不把猜测当原文；
- 所有独立推导均从原误差方程出发，不沿用论文的“类似可得”。

---

## 1. 模型推导与 p2 符号

### 1.1 由 Newton 方程到速度通道

式 (1)：

    P1*A1 - P2*A2 = m*x2_dot + b*x2 + k*x1 + F_L + Delta_F.

令 alpha=A2/A1，bar_x3=x3-alpha*x4，则

    P1*A1 - P2*A2 = A1*(x3 - alpha*x4) = A1*bar_x3.

所以

    x2_dot = (A1/m)*bar_x3 - (k/m)*x1 - (b/m)*x2 - F_L/m - Delta_F/m
           = (A1/m)*bar_x3 + f2 + d2,

其中 f2=(-k*x1-b_n*x2-F_L)/m，d2=(-(b-b_n)*x2-Delta_F)/m。这与式 (6) 的 +A1*bar_x3 一致。

### 1.2 冲突

式 (8) 的解析文本写 p2=-A1/m。若照此写入式 (7)，则

    x2_dot = -(A1/m)*bar_x3 + f2 + d2,

与式 (1)/(6) 的 +A1/m 相反。物理上，正负载压力 A1*bar_x3 应使 x2_dot 增大，而不是减小；因此按式 (1) 必须取 p2=+A1/m。若原文确为负号，则不是“符号约定”问题，而是式 (7) 与式 (1) 不能同时成立；式 (25) 的 -p2*bar_x3 前馈也会随之反号。

**判定**：内部不一致成立；正确符号应为 +A1/m。是否原文印刷为负，待原图 O1。

### 1.3 压力通道

由式 (3)：

    x3_dot/beta_e = h1*(k_q*k_u*g1*u - A1*x2 + Delta_Q10),
    x4_dot/beta_e = h2*(-k_q*k_u*g2*u + A2*x2 + Delta_Q20).

bar_x3_dot = x3_dot - alpha*x4_dot：

    bar_x3_dot/beta_e = k_q*k_u*(h1*g1+alpha*h2*g2)*u
                        - (A1*h1+alpha*A2*h2)*x2
                        + h1*Delta_Q10 - alpha*h2*Delta_Q20.

与式 (6) 一致。d3 的量纲是 1/s（因为左边是 bar_x3_dot/beta_e），不是 MPa/s；仿真段的“MPa/s”标签有误。

### 1.4 降阶的第四个状态

变换 (x1,x2,x3,x4) -> (x1,x2,bar_x3) 不可逆。p3 中的 g1 依赖 x3、g2 依赖 x4，h1,h2 依赖 x1；仅知 bar_x3 不能恢复 x3、x4。因此式 (7) 不是 (x1,x2,bar_x3) 三个状态的自治 ODE，原第四阶 x4 的动态仍然存在，只是没有写进式 (7)。控制实现时 x3、x4 可测，p3 可算；但闭环分析中 x4 的有界性、0<x3,x4<Ps 的正向不变性没有证明。这是模型层面的未闭合点，不是排版问题。

---

## 2. 第 1 步独立推导

z1=x1-x_d，z2=x2-alpha_1：

    z1_dot = x2 - x_d_dot = z2 + alpha_1 - x_d_dot.

V1=z1^2/2：

    V1_dot = z1*(z2 + alpha_1 - x_d_dot).

代入 alpha_1=-k1*z1-k_gamma1*psi(z1)-k_lambda1*|z1|^lambda*sgn(z1)+x_d_hat_dot：

    V1_dot = -k1*z1^2 - k_gamma1*z1*psi(z1) - k_lambda1*|z1|^(lambda+1)
             + z1*(x_d_hat_dot - x_d_dot) + z1*z2.

令 epsilon_1=x_d_hat_dot-x_d_dot，即式 (19)。这一步无省略；注意 epsilon_1 的符号与式 (22) 的 epsilon_2=z2_dot-z2_hat_dot 相反，但因后续只用 epsilon_i^2，符号不影响界。

---

## 3. 第 2 步独立推导（非匹配重构）

    z2 = x2 - alpha_1,
    z2_dot = p2*bar_x3 + f2 + d2 - alpha_1_dot.        (20)

由式 (20)：

    d2 - alpha_1_dot = z2_dot - p2*bar_x3 - f2.        (21)

用滤波器得到 z2_hat_dot，定义 epsilon_2=z2_dot-z2_hat_dot：

    d2 - alpha_1_dot = z2_hat_dot - p2*bar_x3 - f2 + epsilon_2.   (23)

V2=z2^2/2：

    V2_dot = z2*z2_dot
           = z2*(p2*bar_x3 + f2 + d2 - alpha_1_dot)
           = z2*(z2_hat_dot + epsilon_2).              (A)

式 (24) 写的是

    V2_dot = z2*(p2*alpha_2 + z2_hat_dot - p2*bar_x3 + epsilon_2) + p2*z2*z3.

用 bar_x3=z3+alpha_2 代入：

    p2*alpha_2 - p2*bar_x3 + p2*z3 = p2*alpha_2 - p2*(z3+alpha_2) + p2*z3 = 0.

所以式 (24) 等于 (A)，两者一致；这不是漏项，也不是多乘。

代入式 (25)：

    alpha_2 = -(1/p2)*( k2*z2 + k_gamma2*psi(z2) + k_lambda2*|z2|^lambda*sgn(z2)
                        + z2_hat_dot - p2*bar_x3 + z1 ).

则

    p2*alpha_2 = -(k2*z2 + k_gamma2*psi(z2) + k_lambda2*|z2|^lambda*sgn(z2)
                   + z2_hat_dot - p2*bar_x3 + z1).

代回 (A) 的等价形式 V2_dot=z2*(p2*alpha_2+p2*z3+z2_hat_dot+epsilon_2)：

    V2_dot = -k2*z2^2 - k_gamma2*z2*psi(z2) - k_lambda2*|z2|^(lambda+1)
             + z2*epsilon_2 - z1*z2 + p2*z2*z3.

与式 (26) 一致。第 2 步的代数链闭合。

**但**：这一步的“精确重构”依赖 p2、f2 与 bar_x3 已知。若 m 或 A1 有误差，式 (23) 的右端会多出 (p2_true-p2_nominal)*bar_x3；该项不被第 3 步的 NN 补偿（NN 只逼近 d3-alpha_2_dot/beta_e）。论文假设 m、A1 已知，Assumption 3 只给 b、beta_e 的界，因此这是隐含假设。

---

## 4. 第 3 步与权重自适应

    z3 = bar_x3 - alpha_2,
    z3_dot/beta_e = p3*u + f3 + d3 - alpha_2_dot/beta_e.   (27)
    V3 = z3^2/(2*beta_e),
    V3_dot = z3*(p3*u + f3 + d3 - alpha_2_dot/beta_e).     (28)

NN：

    d3 - alpha_2_dot/beta_e = w*^T*s(x) + epsilon_3,   |epsilon_3|<=epsilon_3*.   (31)

u 取式 (33)：

    u = -(1/p3)*( k3*z3 + k_gamma3*psi(z3) + k_lambda3*|z3|^lambda*sgn(z3)
                  + f3 + w^T*s + p2*z2 ).

代入 (28)：

    V3_dot = -k3*z3^2 - k_gamma3*z3*psi(z3) - k_lambda3*|z3|^(lambda+1)
             + (w*^T-w^T)*s*z3 + z3*epsilon_3 - p2*z2*z3
           = -k3*z3^2 - k_gamma3*z3*psi(z3) - k_lambda3*|z3|^(lambda+1)
             + w_tilde^T*s*z3 + z3*epsilon_3 - p2*z2*z3.      (34)

权重：V_w=w_tilde^T*w_tilde/(2*tau)，w_tilde=w*-w，w_tilde_dot=-w_dot。

    w_dot = tau*s*z3 - delta*w.                              (35)

    V_w_dot = (1/tau)*w_tilde^T*(-w_dot)
            = -w_tilde^T*s*z3 + (delta/tau)*w_tilde^T*w.

与 (34) 的 +w_tilde^T*s*z3 相加，NN 交叉项精确抵消，得到式 (36) 的 (delta/tau)*w_tilde^T*w。这一步正确。

---

## 5. psi 的正则性

### 5.1 正确次数

解析文本式 (16) 的多项式段写 c1*z+c2*z^2；但：

- Remark 4 写 c_1i*z+c_2i*z^3；
- Case 2 的放缩写 -k_gamma_i*(c_i1*z_i^2+c_i2*z_i^4)，对应 z*psi=c1*z^2+c2*z^4，即 psi 必须是三次。

因此正确形式：

    psi(z)=|z|^gamma*sgn(z),        |z|>=xi;
    psi(z)=c1*z+c2*z^3,             |z|<xi;
    c1=((3-gamma)/2)*xi^(gamma-1),
    c2=((gamma-1)/2)*xi^(gamma-3).

验证：

- z=xi：c1*xi+c2*xi^3 = ((3-gamma)/2)*xi^gamma + ((gamma-1)/2)*xi^gamma = xi^gamma；
- z=-xi：-c1*xi-c2*xi^3 = -xi^gamma（奇函数）；
- 导数：c1+3*c2*xi^2 = ((3-gamma)/2)*xi^(gamma-1) + (3(gamma-1)/2)*xi^(gamma-1) = gamma*xi^(gamma-1)，与幂函数段在 xi 处的导数 gamma*xi^(gamma-1) 相接；
- z=0：psi'(0)=c1>0，有限。

所以 psi 是 C1、奇函数。若照 z^2 实现，psi(-xi)=(gamma-2)*xi^gamma != -xi^gamma，负侧不连续，且 z*psi 不含 z^4 项，与 Case 2 冲突。结论：文本的 z^2 是 OCR/印刷问题，原文应为三次；待原图 O2。

### 5.2 c1+c2>0 的隐含条件

    c1+c2 = [(3-gamma)*xi^2 + (gamma-1)]/(2*xi^(3-gamma)).

0<xi<=1 时分母为正，故

    c1+c2>0  <=>  xi^2 > (1-gamma)/(3-gamma).

对 gamma=1/3：xi^2>1/4，即 xi>0.5。论文只写 0<xi<=1，并称 c1+c2>0；没有给出这个下界。Remark 4 又说“选足够小的 xi”使幂函数项占主导，这与 c1+c2>0 的要求方向相反。若 xi 过小，Case 2/3 中 -k_gamma*(c1+c2)*z^2 变为正项，放缩方向错误。仿真参数里没有 xi 的数值，无法核对其是否满足。

**判定**：psi 的 C1 性成立（三次读法下）；c1+c2>0 不是自动成立，缺少 xi 的可行域。这是证明层面的参数条件缺口，不是 OCR 问题。

---

## 6. Lyapunov 组合的逐项核对

### 6.1 总 V

    V = V1+V2+V3+w_tilde^T*w_tilde/(2*tau).

由 (19)(26)(34)(35)：

    V_dot = sum_i[-k_i*z_i^2 - k_gamma_i*z_i*psi(z_i) - k_lambda_i*|z_i|^(lambda+1) + z_i*epsilon_i]
            + (delta/tau)*w_tilde^T*w.                       (36)

注意 z2 通道的 -z1*z2 与 z1 通道的 +z1*z2 抵消；z3 通道的 -p2*z2*z3 与 z2 通道的 +p2*z2*z3 抵消。这一步正确。

### 6.2 Case 1（全部 |z_i|>=xi_i）

    -k_gamma_i*z_i*psi(z_i) = -k_gamma_i*|z_i|^(gamma+1).

    |z_i|^(gamma+1) = (2*V_i)^Gamma,  i=1,2;
    |z_3|^(gamma+1) = (2*beta_e*V_3)^Gamma.

所以

    sum = -2^Gamma*[k_gamma1*V1^Gamma + k_gamma2*V2^Gamma + k_gamma3*beta_e^Gamma*V3^Gamma]
        <= -r1*(V1+V2+V3)^Gamma,

    r1 = min{2^Gamma*k_gamma1, 2^Gamma*k_gamma2, (2*beta_emin)^Gamma*k_gamma3}.

论文写 2^Gamma*beta_emin^Gamma*k_gamma3，等于 (2*beta_emin)^Gamma*k_gamma3，正确。

### 6.3 Case 2（部分 |z_i|<xi_i）

对 i in A-B（多项式段）：

    -k_gamma_i*z_i*psi(z_i) = -k_gamma_i*(c1*z_i^2+c2*z_i^4).

因 c2<0、|z_i|<xi_i<=1，有 z_i^4<=z_i^2，故 c2*z_i^4 >= c2*z_i^2，于是

    c1*z_i^2+c2*z_i^4 >= (c1+c2)*z_i^2,

    -k_gamma_i*(c1*z_i^2+c2*z_i^4) <= -k_gamma_i*(c1+c2)*z_i^2.

要用这个负二次项，必须有 c1+c2>0；否则右边是正项，不能作为上界。论文写 c1+c2>0，但没有给 xi 条件（§5.2）。

接着把 sum_B 写成 -r1*(sum_all)^Gamma + r1*[(sum_all)^Gamma-(sum_B)^Gamma]，并用

    (x+y)^Gamma <= x^Gamma+y^Gamma,  0<Gamma<1

把差界为 r1*(sum_{A-B} V_i)^Gamma。再用

    y^Gamma <= y + (1-Gamma)*Gamma^(Gamma/(1-Gamma)),  y>=0

（这是论文所用 Young 不等式的等价形式；我验证：g(y)=y-y^Gamma+(1-Gamma)*Gamma^(Gamma/(1-Gamma)) 在 y=Gamma^(1/(1-Gamma)) 取极小，值为 0，故不等式成立），得到

    r1*(sum_{A-B}V_i)^Gamma <= r1*(sum_{A-B}V_i) + r1*(1-Gamma)*Gamma^(Gamma/(1-Gamma)).

于是式 (37)：

    sum_i -k_gamma_i*z_i*psi(z_i)
    <= -r1*(sum_i V_i)^Gamma + r1*(1-Gamma)*Gamma^(Gamma/(1-Gamma)) + r1*sum_i V_i.

这一步的常数项正确；把 -k_gamma_i*(c1+c2)*z_i^2 丢掉是允许的，因为它是负项（在 c1+c2>0 前提下）。Case 3 同理。

### 6.4 二次项与 r2

    z_i*epsilon_i <= z_i^2/2 + epsilon_i*^2/2.                 (38)

    -k1*z1^2 + z1^2/2 = -(2*k1-1)*V1;
    -k2*z2^2 + z2^2/2 = -(2*k2-1)*V2;
    -k3*z3^2 + z3^2/2 = -(2*beta_e*k3-beta_e)*V3 = -beta_e*(2*k3-1)*V3.

加上式 (37) 的 +r1*sum V_i：

    r2 = min{2*k1-1-r1, 2*k2-1-r1, beta_emin*(2*k3-1)-r1}.

论文的 r2 写法正确，但**没有在定理中列出 r2>0 的条件**。要 r2>0，至少需要

    2*k1 > 1+r1,  2*k2 > 1+r1,  beta_emin*(2*k3-1) > r1.

这是一组可先验检查的增益条件，论文遗漏。

### 6.5 幂次项与 r3

    -k_lambda_i*|z_i|^(lambda+1) = -k_lambda_i*(2*V_i)^Lambda,  i=1,2;
    -k_lambda3*|z3|^(lambda+1) = -k_lambda3*(2*beta_e*V3)^Lambda.

所以

    r3 = min{2^Lambda*k_lambda1, 2^Lambda*k_lambda2, (2*beta_emin)^Lambda*k_lambda3}.

论文解析文本写 2^3*k_lambda1、2^3*k_lambda2、2^3*beta_emin^Lambda*k_lambda3，其中“2^3”与 Lambda=(lambda+1)/2=1.3 不符。若原文确为 2^3，则把 2.462 放大成 8，r3 被高估 3.25 倍，式 (40) 的负项不成立。此项列为待原图 O4；按数学结构应为 2^Lambda。

### 6.6 权重项

    w_tilde^T*w = w_tilde^T*w* - w_tilde^T*w_tilde
                <= -||w_tilde||^2/2 + ||w*||^2/2.              (39)

    (delta/tau)*w_tilde^T*w <= -(delta/(2*tau))*||w_tilde||^2 + (delta/(2*tau))*||w*||^2.

正确。

### 6.7 式 (40)

合并：

    V_dot <= -r2*sum V_i - r1*(sum V_i)^Gamma - r3*(sum V_i)^Lambda
             - (delta/(2*tau))*||w_tilde||^2 + pi1.            (40)

pi1 应包含：

    pi1 = r1*(1-Gamma)*Gamma^(Gamma/(1-Gamma))
          + sum_i epsilon_i*^2/2
          + (delta/(2*tau))*||w*||^2.

解析文本在 pi1 处出现 “r1 = r1(1-Gamma)... + sum r1^Lambda2/2 + ... Gamma^2 Gamma^2 ...” 的长串重复，明显 OCR 损坏；上述三项是与前后式一致的唯一合理读法，但须原图 O4 确认。

---

## 7. 权重误差的 Gamma/Lambda 分解与 W 的循环

式 (41) 是恒等式：

    -m = -(theta*m)^Gamma - (theta*m)^Lambda
         + [(theta*m)^Gamma - theta^Gamma*m]
         + [(theta*m)^Lambda - theta^Lambda*m]
         - theta^Gamma*m - (1-theta^Gamma)*m,

其中 m=w_tilde^T*w_tilde，theta=1-theta^Gamma（0<theta<1 唯一）。

第一括号：

    theta^Gamma*(m^Gamma-m) <= theta^Gamma*pi2,  pi2=Gamma^(1/(1-Gamma))-Gamma^(Gamma/(1-Gamma)),

因为 f(x)=x^Gamma-x 在 x=Gamma^(1/(1-Gamma)) 取最大；m>=1 时 <=0，m<1 时 <=pi2。

第二括号：

    theta^Lambda*m^Lambda - theta*m.

若 m<=W^2<1/theta，则 theta*m<1，Lambda>1，故 (theta*m)^Lambda<=theta*m，第二括号<=0。

若 W>=sqrt(1/theta)，论文用 (theta*W^2)^Lambda-theta*W^2 作界；由于 g(m)=theta^Lambda*m^Lambda-theta*m 在 [0,W^2] 上凸，最大值在端点，g(0)=0，g(W^2)>=0（因 theta*W^2>=1），所以该界成立。

于是

    -m <= -(theta*m)^Gamma - (theta*m)^Lambda + pi3,

    pi3 = theta^Gamma*pi2,                          W<sqrt(1/theta);
    pi3 = theta^Gamma*pi2 + (theta*W^2)^Lambda - theta*W^2,   W>=sqrt(1/theta).

这一步在“m<=W^2”前提下成立。

**循环点**：W 是 ||w_tilde|| 的界，论文在式 (34) 后直接“assuming ||w_tilde||<=W”。但：

- 自适应律 (35) 没有投影，不能保证 w 在任意初值下停在某个先验 W 内；
- 若用 Lyapunov 子level集 V<=V(0) 推出 ||w_tilde||<=sqrt(2*tau*V(0))，则 W 依赖初值，pi3、pi4、c、T_max 全部依赖初值；
- 若坚持 W 是与初值无关的常数，则需要独立证明（例如投影或饱和自适应），论文没有。

因此“T_max 与初值无关”在权重通道上没有被证明：要么 W 依赖 x0，要么 W 是先验假设但未保证。这是全文 fixed-time 主张最实质的未闭合点之一。

---

## 8. 式 (44) 的组合与 Lemma 1 映射

### 8.1 组合

令 Wv=||w_tilde||^2/(2*tau)=m/(2*tau)。

    -(delta*varrho/(2*tau))*(theta*m)^Gamma
      = -delta*varrho*theta^Gamma*(2*tau)^(Gamma-1)*Wv^Gamma;

    -(delta*varrho/(2*tau))*(theta*m)^Lambda
      = -delta*varrho*theta^Lambda*(2*tau)^(Lambda-1)*Wv^Lambda;

    -(delta*(1-varrho)/(2*tau))*m = -delta*(1-varrho)*Wv.

用 x^Gamma+y^Gamma >= (x+y)^Gamma、x^Lambda+y^Lambda >= (x+y)^Lambda：

    V_dot <= -r4*V - r5*V^Gamma - r6*V^Lambda + pi4,

    r4 = min{r2, delta*(1-varrho)},
    r5 = min{r1, delta*varrho*theta^Gamma*(2*tau)^(Gamma-1)},
    r6 = min{r3, delta*varrho*theta^Lambda*(2*tau)^(Lambda-1)},
    pi4 = pi1 + (delta*varrho/(2*tau))*pi3.

结构正确。

### 8.2 映射错误

Lemma 1 的形式是

    V_dot <= -a1*V^b1 - a2*V^b2 - a3*V + c,   0<b1<1, b2>1.

对照式 (44)：

- V^Gamma 的系数是 r5，Gamma<1 → a1=r5, b1=Gamma；
- V^Lambda 的系数是 r6，Lambda>1 → a2=r6, b2=Lambda；
- 线性 V 的系数是 r4 → a3=r4。

论文写 “let a1=r4, a2=r5, a3=r6, b1=Gamma, b2=Lambda”。这把线性系数 r4 当成 a1、把 Gamma 系数 r5 当成 a2、把 Lambda 系数 r6 当成 a3，三项全部错位。

后果：

- 正确的 T_max 应为

      T_max = 1/(r4*(1-Gamma))*ln(1+r4/r5)
              + 1/(r4*(Lambda-1))*ln(1+r4/r6).

- 按论文的错位映射会得到

      1/(r6*(1-Gamma))*ln(1+r6/r4)
      + 1/(r6*(Lambda-1))*ln(1+r6/r5),

  两者数值和结构都不同。残差集 (10) 的三个阈值也会随之错位。

这是实质性公式错误，不是 OCR 小瑕疵；除非原文式 (44) 的系数排列与解析稿不同（待原图 O5）。按解析稿，定理 1 的 T_max 与残差界不能由式 (44) 直接得到。

### 8.3 Lemma 1 本身的两段积分核对

我独立复算 Lemma 1 的式 (11)，确认其结构：

**阶段 A（V 从大降到 1）**：忽略 a1 项（V>=1 时 -a1*V^b1<=0，可 dropped）：

    V_dot <= -a2*V^b2 - a3*V.

令 u=V^(b2-1)，du/dt=-(b2-1)*(a2*u^2+a3*u)。从 u=∞ 到 1：

    T_A = 1/((b2-1)*a3)*ln(1+a3/a2).

**阶段 B（V 从 1 降到 0）**：

    V_dot <= -a1*V^b1 - a3*V.

令 u=V^(1-b1)，du/dt=-(1-b1)*(a1+a3*u)。从 u=1 到 0：

    T_B = 1/((1-b1)*a3)*ln(1+a3/a1).

相加即式 (11)。所以式 (11) 是 c=0 时的精确两段积分，结构正确。

**但 c>0 时**：+c 只会减慢下降；把 c=0 的积分直接当作 c>0 的上界，需要额外的区域/比较论证。论文把 Lemma 1 归引于 [42]，本篇没有给证明；式 (11) 中也不含 theta（残差集却含 theta）。因此：

- 若 [42] 已证明 c>0 的版本，则 T_max 可引用，但本篇未复述；
- 若没有，则 T_max 的“上界”性质在 c>0 时未被证明，只能确定 c=0 的到达时间。

这一条与 8.2 的映射错误独立；两者叠加，使定理 1 的定量时间结论目前不可用。

---

## 9. T_max 的依赖结构与数值

### 9.1 形式依赖

    T_max = F(r4, r5, r6)

    r4 = min{r2, delta*(1-varrho)},
    r5 = min{r1, delta*varrho*theta^Gamma*(2*tau)^(Gamma-1)},
    r6 = min{r3, delta*varrho*theta^Lambda*(2*tau)^(Lambda-1)},

    r1 = min{2^Gamma*k_gamma1, 2^Gamma*k_gamma2, (2*beta_emin)^Gamma*k_gamma3},
    r2 = min{2*k1-1-r1, 2*k2-1-r1, beta_emin*(2*k3-1)-r1},
    r3 = min{2^Lambda*k_lambda1, 2^Lambda*k_lambda2, (2*beta_emin)^Lambda*k_lambda3}.

所以 T_max 依赖：增益、beta_emin、tau、delta、varrho、theta（由 Gamma 定），以及 c=pi4（通过残差阈值，不进入 T_max 公式本身）。T_max 不显含 V(0)，这是 fixed-time 的形式特征；但如 §7，W 可能把 x0 依赖带入 pi3/pi4，而滤波器误差界 epsilon_i* 依赖 Delta（轨迹的高阶导数），所以“从 t=0 起的完整时间与 x0 无关”没有被证明。

### 9.2 按论文增益的数值核对

解析稿增益（该行有重复下标，数值待原图 O3）：

    k1=1000, k2=0.1, k3=12000;
    k_gamma1=0.2, k_gamma2=0.015, k_gamma3=12;
    k_lambda1=1000, k_lambda2=0.1, k_lambda3=1000;
    gamma=1/3, lambda=8/5, tau=30, delta=4.

    Gamma=2/3, Lambda=1.3, 2^Gamma=1.587, 2^Lambda=2.462.

    r1 = min{1.587*0.2=0.3174, 1.587*0.015=0.0238, (2*beta_emin)^(2/3)*12}
       = 0.0238  （第三项对任何合理的 beta_emin>=1e6 Pa 都是极大的正数）.

    r2 = min{2*1000-1-0.0238=1998.98,
             2*0.1-1-0.0238=-0.8238,
             beta_emin*(2*12000-1)-0.0238}
       = -0.8238.

第二项即使 r1=0 也是 -0.8。故 r2<0，r4=min{r2,delta*(1-varrho)}<0。Lemma 1 要求 a3=r4>0，不满足；式 (11) 的对数内可能出现负值。按这组增益，定理 1 的 Lyapunov 不等式 (44) 不能成立。

**注意**：这是“按解析稿数值”的结论。若原图 k2 不是 0.1（例如 10），则 r2 可能为正，需重算；因此该结论与 O3 绑定。

### 9.3 T_max 量级

即便把 r2 修正为正值、取 r4=2（例如 delta*(1-varrho)=2），按正确映射：

    r5=0.0238, r6=0.246,

    T_max ≈ 1/(2*(1/3))*ln(1+2/0.0238)
            + 1/(2*0.3)*ln(1+2/0.246)
          ≈ 1.5*4.443 + 1.667*2.212
          ≈ 6.66 + 3.69 = 10.35 s.

论文仿真声称 C1 在 0.1 s 内收敛。上界 10 s 与仿真 0.1 s 不矛盾（上界保守），但说明：

- T_max 不是 0.1 s 的设计时间；
- 不能用 T_max 反推“用户指定 T”；
- 若按论文错位映射，T_max 会变成约 33 s，进一步说明映射错误有实际影响。

---

## 10. 量纲一致性

    V1=z1^2/2                  [m^2]
    V2=z2^2/2                  [(m/s)^2]
    V3=z3^2/(2*beta_e)         [Pa]（因为 z3 是 Pa，beta_e 是 Pa）

三者直接相加，V 没有统一的量纲。由此：

- V^Gamma、V^Lambda 的幂运算在量纲上不合法；
- r1、r2、r3 的量纲不一致，r2=min{...} 的比较没有统一单位；
- |z1|<=sqrt(2*V_res) 把 V_res 当成 m^2 使用，但 V_res 含 (m/s)^2 与 Pa；
- 仿真增益 1000、0.1、12000 的数量级差异，正反映它们带不同单位。

严格的 Lyapunov 证明需要先对每个通道做无量纲化（例如定义 V1=z1^2/(2*z1_scale^2)，V2=z2^2/(2*z2_scale^2)，V3=z3^2/(2*beta_e*z3_scale^2)），再重新推导所有常数。论文没有做。因此定理 1 的“残差界”只能作为形式结论，不能直接当米制精度使用。这是“真实位置误差”不能落地的另一个原因。

---

## 11. 控制 u 的适定性与 p3

    u = -(1/p3)*B,
    B = k3*z3 + k_gamma3*psi(z3) + k_lambda3*|z3|^lambda*sgn(z3) + f3 + w^T*s + p2*z2,
    p3 = k_q*k_u*(h1*g1+alpha*h2*g2).

- 在物理域 0<x3<Ps、0<x4<Ps、V1,V2>0 内，g1,g2>0，故 p3>0；u 的符号由 -B 决定。
- p3 通过 H(u) 依赖 u 的符号：B<0 时取 u>0 分支（g1=sqrt(Ps-x3), g2=sqrt(x4)）；B>0 时取 u<0 分支（g1=sqrt(x3), g2=sqrt(Ps-x4)）。因此可按 sign(B) 选分支，B!=0 时解存在；这不是一个需要求解的隐式方程。
- 但 p3 在 x3->Ps、x4->0（或 x4->Ps、x3->0）时趋于 0，u 可能无界；论文没有给 p3 的正下界，也没有给 u 的饱和/可行性条件。
- B=0 时 u=0，p3 的分支未定义（H(0)），控制律在切换面上不连续；论文没有讨论 Filippov 解或切换面的正则性。这是实现层面的适定性问题，不是 T 附近的奇异性。
- 论文的定理没有把 u 的有界性作为结论，也没有输入饱和；因此“控制量可实现”不是定理的一部分。

---

## 12. 命令滤波器的幂次索引

解析文本：

    v_i_dot = -kappa_i*phi_i(v1-Xi_input) + v_{i+1},  i=1..n-1;
    v_n_dot = -kappa_n*phi_n(v1-Xi_input);
    phi_i = l_i o ... o l_1;
    l_i(z) = |z|^(r_0,i+1/r_0,i) + |z|^(r_inf,i+1/r_inf,i);
    r_0,i = 1-(n-i)*d0,  d0=-1;
    r_inf,i = 1-(n-i)*d_inf,  0<d_inf<1/(n-1).

对 n=2：

    r_0,1=2, r_0,2=1, r_0,3=0.

l_2 的指数 r_0,3/r_0,2=0，出现零指数（|z|^0=sgn(z) 或 0^0），不是常规固定时间微分器的设计。若改为从 r_0,n+1=1 递推（r_0,i=1-(n+1-i)d0），则 r_0,1=3, r_0,2=2, r_0,3=1，指数为 2/3、1/2，均为 (0,1)，才是合理的。

r_inf 若用 r_inf,i=1-(n-i)d_inf，则 n=2 时 r_inf,1=1-d_inf, r_inf,2=1, r_inf,3=1+d_inf，指数 1/(1-d_inf)>1、1+d_inf>1，合理；但 d_inf<1/(n-1)=1 与 r_inf,1>0 一致。r_0 与 r_inf 的索引偏移不同，说明解析稿至少有一处 OCR/排版错误。

**判定**：式 (17) 不能按解析稿直接实现；n=2 的零指数是硬问题。该滤波器是全文核心（两个滤波器都用它），因此“可实现性”目前不成立，须对照原图或 [49] 恢复 O6。

---

## 13. 仿真物理一致性

表 1：V10=V20=5e-6 m^3，A2=1.65e-3 m^2，x1(0)=0.32 m，参考 0.25±0.02 m。

    V2 = V20 - A2*x1 = 5e-6 - 1.65e-3*0.32 = 5e-6 - 5.28e-4 = -5.23e-4 m^3 < 0.

V2>0 仅当 x1 < V20/A2 = 5e-6/1.65e-3 ≈ 3.03e-3 m。也就是说，按表 1 的 V20，活塞只能移动约 3 mm，而仿真初值在 0.32 m、参考在 0.25 m。整个工作区间 V2<0，h2<0，sqrt(P2) 等项失去物理意义。

这不是 OCR 小问题：即使把 5e-6 读成 5e-5，仍然 V2<0（5e-5-5.28e-4<0）；要 V2>0 至少需要 V20>5.28e-4 m^3（约 0.5 L）。表 1 的 5e-6 m^3（5 mL）与 0.5 m 行程、1.96e-3 m^2 活塞面积不相容。合理解释是原文为 5e-3 m^3（5 L）或类似值，OCR 丢了指数；须原图 O7。

此外，表 1 没有 k_u、k、F_L；没有 xi_i、theta、varrho、W、epsilon_i*；没有仿真步长/求解器/噪声设置。因此 p3、f2、psi、T_max 均不能按论文数值复算。

---

## 14. 未闭合步骤清单

| 编号 | 位置 | 问题 | 严重度 | 是否可用初等补证 |
|---|---|---|---|---|
| G1 | 式 (8) | p2 符号与式 (1)/(6) 冲突；按物理应为 +A1/m | 高 | 是，但需确认原文 |
| G2 | 式 (16) | 多项式段次数：文本 z^2，逻辑要求 z^3 | 高 | 是（C1/奇函数/z*psi 三项互证） |
| G3 | 式 (40) | r3 的 “2^3” 与 Lambda=1.3 不符；pi1 表达式 OCR 损坏 | 高 | 部分；需原图 |
| G4 | 式 (44)→Lemma 1 | a1/a2/a3 与 r4/r5/r6 全部错位 | 高 | 是，按系数对应改正 |
| G5 | 式 (37) | c1+c2>0 需要 xi^2>(1-gamma)/(3-gamma)，论文未列；仿真未给 xi | 高 | 是，补条件 |
| G6 | 式 (34) 后 | ||w_tilde||<=W 是假设，无投影；W 可能依赖 x0，破坏 fixed-time 的初值无关性 | 高 | 否，需新增投影/饱和自适应或独立证明 |
| G7 | 式 (17) | n=2 时 r_0,3=0，零指数；滤波器不可按文本实现 | 高 | 需原图/[49] |
| G8 | 式 (11) | c>0 时 T_max 的上界性未在本篇证明；式 (11) 对应 c=0 积分 | 中高 | 需引 [42] 或补区域论证 |
| G9 | V 的定义 | V1,V2,V3 量纲不同，直接相加不合法；残差界的米制解释不成立 | 中高 | 需无量纲化重做 |
| G10 | 式 (7) | 降阶丢失 x4，p3 依赖 x3,x4；0<x3,x4<Ps 的正向不变性未证 | 中高 | 需补第四阶方程与压力域分析 |
| G11 | 式 (33) | p3 可趋于 0，u 无界；B=0 切换面未讨论；无饱和 | 中 | 需假设 p3 下界并处理切换 |
| G12 | 式 (31)/(33) | NN 输入 3 个 vs 5 个信号不一致；压力单位 MPa vs Pa | 中 | 需统一 |
| G13 | 仿真 | V20=5e-6 与 x1=0.32 不相容；缺 k_u,k,F_L,xi 等 | 高（复现） | 需原表/代码 |
| G14 | 仿真增益 | 按解析稿 k2=0.1 使 r2<0，定理条件不满足 | 高（若数值确认） | 需原图 O3 |

---

## 15. 结论性判断

1. **模型与第 1/2 步的代数链是自洽的**（在 p2 取 +A1/m、f2/d2 定义正确的前提下）；非匹配项 d2-alpha_1_dot 的滤波重构是本文最扎实的部分。
2. **psi 的 C1 性在三次多项式读法下成立**；但 c1+c2>0 的 xi 可行域缺失，论文的“任意 0<xi<=1”不成立。
3. **Lyapunov 组合的 Case 1/2/3 与 Young 常数基本正确**；r2>0 的增益条件遗漏，仿真增益按解析稿违反该条件。
4. **式 (44) 到 Lemma 1 的映射错误是实质性的**，导致 T_max 与残差界不能按论文写法使用；Lemma 1 本身的两段积分结构正确，但 c>0 的上界性本篇未证。
5. **fixed-time 的初值无关性未被完整建立**：W 的循环、滤波器误差界的 Delta 依赖、c 的未知常数，使“从 t=0 起 T_max 与 x0 无关”只能是形式声明。
6. **不是预设时间**：T 不是设计输入，不能由用户指定；没有终端奇异项，但有 p3 的全程奇异风险和切换面问题。
7. **真实位置误差**只有 sqrt(2*V_res) 的形式界，且 V 量纲不统一；不能当作米制精度保证。
8. **仿真不可按印刷参数复现**：V2<0、缺 k_u/k/F_L/xi、增益行 OCR 损坏；因此论文的实验结果只能作为作者自报，不作为本项目复现结论。

以上 1–8 均只针对 L13 单篇；不扩展论文检索，不设计新控制器，不改变项目量测合同。
