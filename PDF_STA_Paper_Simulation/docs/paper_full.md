<!-- page 6 of 16 -->

1818

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 71, NO. 3, MARCH 2026

interval containing $\tau . \operatorname { I f } z _ { 2 } ( \tau )   =   0$ , then $z _ { 1 } ( t )$ will remain at zero. In both cases $| z _ { 1 } | ^ { 1 / 2 } { \operatorname { s i g n } } ( \widehat { z _ { 1 } } )$ is AC as a function of time.

Besides, according to (29) and Lemma 4, it follows that the system (28) is FxTS and $\eta ( t ) = 0 , \forall t \in [ \mathcal { T } , \infty )$ , which implies the system (13) is forward complete and $z ( t ) = 0 , \forall t \in [ \mathcal { T } , \infty )$ The proof is finished. 

Remark 3: In practical applications, when the state completes convergence within one period, the other periods of the periodic function $K _ { ( l _ { 4 } , h ) } ( t )$ in (16) can be set to zero. In this case, the control gains $\widetilde { k _ { i } } ( t , x _ { [ t - \mathcal { T } , t ] } ) = l _ { i } , i = 1 , 2 , 3 , 4$ become constants. Furthermore, since $\dot { K _ { ( l _ { 4 } , h ) } } ( j h ) = 0 , j = 0 , 1 , \ldots$ , this treatment does not affect the continuity of the control gains.

## B. Case With Measurement Noise

In this section, following [34] and [44], the sensitivity of the proposed method to the measurement noise is analyzed. In practical applications, $x _ { 1 }$ often represents the sliding mode variable, while $x _ { 2 }$ is an artificially introduced variable. Therefore, only the case where $x _ { 1 }$ is affected by the measurement noise is considered here (see [44]). The system (13) can be written as

$$
\left\{ \begin{array}{l} \dot {x} _ {1} = - k _ {1} (t, x _ {\mathrm{m} [ t - \mathcal {T}, t ]}) | x _ {\mathrm{m} 1} | ^ {1 / 2} \text {sign} (x _ {\mathrm{m} 1}) \\ \quad - k _ {2} (t, x _ {\mathrm{m} [ t - \mathcal {T}, t ]}) x _ {\mathrm{m} 1} + x _ {2} + \varrho_ {1} (t) \\ \dot {x} _ {2} = - k _ {3} (t, x _ {\mathrm{m} [ t - \mathcal {T}, t ]}) \text {sign} (x _ {\mathrm{m} 1}) \\ \quad - k _ {4} (t, x _ {\mathrm{m} [ t - \mathcal {T}, t ]}) x _ {2} + \varrho_ {2} (t) \end{array} \right.\tag{30}
$$

where $x_{ m } = [x_{ m 1}, x_{2}]^{ T } = [x_{1} + m(t), x_{2}]^{ T }$ The functions $k _ { i } : [ 0 , \infty ) \times \dot { \mathbf { C } } _ { 2 } ^ { \mathcal { T } } \stackrel { \sim } { \rightarrow } \dot { \mathbf { R } } , i = \dot { 1 } , 2 , 3 , 4$ are defined in (15), and $K _ { ( l _ { 4 } , h ) } ( t )$ in (16) is set to 0 when $t \geq 2 h$ (as shown in Remark 3). The unknown functions $\varrho _ { j } ( t ) , j = 1 , 2$ satisfy Assumption 1, and the measurement noise $m ( t )$ satisfies the following assumption.

Assumption $3 ;$ The measurement noise $m ( t )$ is uniformly bounded, satisfying $| m ( t ) | \leq \varepsilon _ { 0 }$ , where $\varepsilon _ { 0 }$ is a constant.

Corollary 1: Consider the nonlinear system (30) under Assumptions 1 and 3. Then, $| x _ { 1 } ( t ) | \leq \varOmega _ { 1 } , | x _ { 2 } ( t ) + \varrho _ { 1 } ( t ) | \leq$ $\varOmega _ { 1 } ^ { 1 / 2 } , \forall t \in [ T _ { \operatorname { m } 1 } , \infty )$ , where $T _ { \mathrm { m 1 } } > 0$ is a finite time, and $\mathcal { Q } _ { 1 } \geq$ 0 is a constant independent of initial values.

The proof of Corollary 1 is shown in Appendix.

## C. Numerical Examples

Case 1—Absence of measurement noise: Consider the system (13) with $\varrho _ { 1 } ( t ) \doteq 0 . 2 \operatorname { s i n } ( 2 t ) , \varrho _ { 2 } ( t ) = 0$ , where $k _ { i } ( \cdot ) , i =$ $1 , 2 , 3 , 4$ are defined in (15) with $\mathcal{T} = 3, a = 2, b = - \hat{1}, c =$ $1 , l _ { 4 } = 0 . 0 5 , \delta _ { 1 } = 0 . 5 , \delta _ { 2 } = 1 , \delta _ { 3 } = 0 ,$ , and $K _ { ( l _ { 4 } , h ) } ( t )$ is given by (8) and (9) with (we only consider $t \in [ 0 , 2 \dot { h } ] \dot { ) }$

$$
R _ {h} (t) = \left\{ \begin{array}{l l} 0, & t \in [ 0, h) \\ \sin^ {2} (\pi t / h), & t \in [ h, 2 h ]. \end{array} \right.\tag{31}
$$

For simulation, the initial values are set as $x_{1}(0)=25,x_{2}(0)=$ 15. The simulation results are shown in Fig. 1 with $z =$ $\begin{aligned}[z_{1},z_{2}]^{\mathrm{T}} = [x_{1},x_{2} + \varrho_{1}(t)]^{\mathrm{T}}\end{aligned}$ , from which we can see that the state z converges to 0 within the prescribed time $\mathcal { T } = 3 \mathrm { ~ s ~ }$

Case 2—Presence of measurement noise: Consider the system (30). The system parameters and initial values are the same as those in Case 1, and the measurement noise is chosen as the band-limited white noise. For comparison, consider the THF-based algorithm proposed in [48], which can be described as (11) with

$$
\phi_ {1} (\cdot) = \left\{ \begin{array}{l l} \eta x _ {1} / (\mathcal {T} - t), & t \in [ 0, \mathcal {T}) \\ \kappa_ {1} | x _ {1} | ^ {\frac {1}{2}} \operatorname{sign} (x _ {1}), & t \in [ \mathcal {T}, \infty). \end{array} \right. \phi_ {2} (\cdot) = - \kappa_ {2} \operatorname{sign} (x _ {1})
$$

![Chart block](doc:8e0334e/tier:standard/page:6/block:19)

Fig. 1. State z for the system (13)

![Chart block](doc:8e0334e/tier:standard/page:6/block:21)

Fig. 2. State z for the system (30) in the presence of measurement noise.

For simulation, the prescribed time, the initial values and the external disturbances $\varrho _ { i } , i = 1 , 2$ are the same as those in Case 1, with parameters chosen as $\kappa _ { 1 } = 1 , \kappa _ { 2 } = 8$ , and $\eta = 5$ . The simulation results are shown in Fig. 2. It follows that, in the presence of the measurement noise, the THF-based algorithm deviates significantly from the equilibrium at the prescribed time $\mathcal { T } = 3 \mathrm { ~ s } ,$ while the algorithm designed in Section III-A can still maintain satisfying performance.

## IV. STA BY PDF: THE SECOND METHOD

## A. Design of STA

In this section, we will propose another STA, and restrict the function $\phi _ { 2 } ( t , x _ { [ t - \mathcal { T } , t ] } )$ to be dependent only on t and $x _ { 1 }$

Let $\mathcal { T } > 0$ be an arbitrary prescribed constant and Assumption 1 be satisfied. Then, the functions $\phi _ { 1 } ( t , x _ { [ t - \mathcal { T } , t ] } )$ and $\phi _ { 2 } ( t , x _ { [ t - \mathcal { T } , t ] } )$ can be designed as

$$
\begin{array}{l} \phi_ {1} (\cdot) = - k _ {4} (t, x _ {1 [ t - \mathcal {T}, t ]}) | x _ {1} | ^ {1 / 2} \text {sign} (x _ {1}) - k _ {1} k _ {3} x _ {1} \\ \phi_ {2} (\cdot) = - k _ {2} (t) \left(\frac {1}{2} \text {sign} (x _ {1}) + \frac {3}{2} k _ {3} | x _ {1} | ^ {1 / 2} \text {sign} (x _ {1}) + k _ {3} ^ {2} x _ {1}\right) \end{array}
$$

where

$$
k _ {4} (\cdot) = k _ {1} + 2 K _ {\mathrm{sta}} (t) | x _ {1} (t - h) | ^ {1 / 2}, h = \mathcal {T} / 4\tag{32}
$$

$$
k _ {2} (t) = \left\{ \begin{array}{c c} 0, & t \in [ 0, 2 h ] \\ \mu \triangleq \beta + 4 \varepsilon^ {2} + 2 \varepsilon k _ {1}, & t \in (2 h, \infty) \end{array} \right.
$$

$$
k _ {3} = \varDelta_ {1} k _ {1} ^ {2 / 3}, k _ {1} = v ^ {3 / 2} + (\alpha (\delta_ {2} + \delta_ {3}) ^ {2} / \varepsilon + 4 \varepsilon (\delta_ {2} + \delta_ {3})) / \beta + \varDelta_ {2}
$$

$$
v \geq \max \left\{\frac {\Pi}{\varDelta_ {1}} - \frac {\lambda_ {\max} (P)}{\varDelta_ {1} h \varepsilon}, \iota \right\}, \varDelta_ {2} = \varepsilon (1 + 2 \beta + 8 \varepsilon^ {2}) / \beta
$$

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

<!-- page 7 of 16 -->

DING et al.: PRESCRIBED-TIME CONTROL VIA PERIODIC DELAYED FEEDBACK-BASED SUPER-TWISTING SLIDING MODE ALGORITHM

1819

$$
\Pi = \frac {\lambda_ {\max} ^ {5 / 2} (P) \Delta_ {3} ^ {1 / 2}}{\varepsilon^ {2} h ^ {2} \lambda_ {\min} ^ {1 / 2} (P)}, \quad D = (\Theta + \delta_ {1} + 2 h \delta_ {3}) ^ {2} / (2 r)
$$

$$
\Delta_ {3} = \left(\frac {D ^ {1 / 3}}{\Delta_ {2} ^ {1 / 3}} + D ^ {2 / 3} \Delta_ {1}\right) ^ {2} + (\Theta + \delta_ {1} + 2 h \delta_ {3}) ^ {2}\tag{33}
$$

in which $\delta _ { i } , i = 1 , 2 , 3$ are defined in Assumption 1

$$
P = \left[ \begin{array}{c c} \beta + 4 \varepsilon^ {2} & - 2 \varepsilon \\ - 2 \varepsilon & 1 \end{array} \right]\tag{34}
$$

$$
K _ {\mathrm{sta}} (t) = \left\{ \begin{array}{l l} K _ {(k, h)} (t), & t \in [ 0, 2 h ] \\ 0, & t \in (2 h, \infty) \end{array} \right.\tag{35}
$$

where $\varDelta _ { 1 } \textgreater 0 , \varTheta \textgreater 0 , \alpha > 0 , \beta > 0 , \upsilon > 0 , \varepsilon > 0 , \iota > 0$ , and $0 < r < 2 \varDelta _ { 1 } \varDelta _ { 2 } \iota$ are some constants, and $K _ { ( k , h ) } ( t )$ is defined in (8) and (9) with $k = k _ { 1 } k _ { 3 } / 2 - r / 4$

In such case, the system (11) can be rewritten as

$$
\left\{ \begin{array}{l} \dot {x} _ {1} = - k _ {4} (\cdot) | x _ {1} | ^ {1 / 2} \mathrm{sign} (x _ {1}) - k _ {1} k _ {3} x _ {1} + x _ {2} + \varrho_ {1} (t) \\ \dot {x} _ {2} = - k _ {2} (t) \left(\frac {1}{2} \mathrm{sign} (x _ {1}) + \frac {3}{2} k _ {3} | x _ {1} | ^ {1 / 2} \mathrm{sign} (x _ {1}) \right. \\ \qquad \left. + k _ {3} ^ {2} x _ {1}\right) + \varrho_ {2} (t). \end{array} \right.\tag{36}
$$

Theorem 2: Let $\mathcal { T } > 0$ be a prescribed time. Consider the nonlinear system (36) under Assumption 1 with $| x _ { 2 } ( 0 ) | \leq \theta$ Then, $x _ { 1 } ( t ) = 0 , x _ { 2 } ( t ) + \varrho _ { 1 } ( t ) = 0 , \forall t \in [ \mathcal { T } , \infty )$

Proof: It is not difficult to verify that $| \dot { \phi } _ { 1 } ( \cdot ) | \leq ( k _ { 1 } + 2 K _ { \operatorname { s t a } }$ $( t ) { + } k _ { 1 } k _ { 3 } ) ( | x _ { 1 } ( t - h ) | + | x _ { 1 } ( t ) | + 1 )$ and $\left| \phi _ { 2 } ( \cdot ) \right| { \leq } \left( \mu + 3 \mu k _ { 3 } \right.$ $+ \mu k_{3}^{2})(|\widehat{x_{1}(t)}| + 1)$ , which implies that the system (36) satisfies linear growth condition (6). Thus, according to Lemma 1, the forward completeness can be guaranteed.

For $t \in [ 0 , 2 h ]$ , consider the Lyapunov function $V _ { 1 } ( x _ { 1 } ) =$ $x _ { 1 } ^ { 2 } / 2$ . Then, by using $(36), \left| x_{2}(0) \right| \leq \theta$ and the Young’s inequality, its time-derivative can be calculated as

$$
\begin{array}{r l} \dot {V} _ {1} (x _ {1} (t)) \leq & - 2 k _ {1} k _ {3} V _ {1} (x _ {1} (t)) - 2 ^ {3 / 4} k _ {1} V _ {1} ^ {3 / 4} (x _ {1} (t)) \\ & - 4 K _ {(k, h)} (t) V _ {1} ^ {1 / 4} (x _ {1} (t - h)) V _ {1} ^ {3 / 4} (x _ {1} (t)) \\ & + | x _ {1} | (2 h \delta_ {3} + \delta_ {1} + \Theta) \\ \leq & - (2 k _ {1} k _ {3} - r) V _ {1} (x _ {1} (t)) - 2 ^ {3 / 4} k _ {1} V _ {1} ^ {3 / 4} (x _ {1} (t)) \\ & - 4 K _ {(k, h)} (t) V _ {1} ^ {1 / 4} (x _ {1} (t - h)) V _ {1} ^ {3 / 4} (x _ {1} (t)) + D \end{array}
$$

where $t \in [ 0 , 2 h ]$ . According to Lemma 6, we know that $V _ { 1 } ( x _ { 1 } ( 2 h ) ) \leq D ^ { 4 / 3 } / ( 2 \thinspace k _ { 1 } ^ { 4 / 3 } )$ , which implies

$$
| x _ {1} (2 h) | \leq D ^ {2 / 3} / k _ {1} ^ {2 / 3}.\tag{37}
$$

For $t \in [ 2 h , \infty )$ , define $z _ { 1 } = x _ { 1 } , z _ { 2 } = x _ { 2 } + \varrho _ { 1 } ( t )$ . Then, (36) can be rewritten as

$$
\dot {z} _ {1} = - k _ {1} | z _ {1} | ^ {1 / 2} \mathrm{sign} (z _ {1}) - k _ {1} k _ {3} z _ {1} + z _ {2}
$$

$$
\begin{array}{l} \dot {z} _ {2} = - \mu \left(\frac {1}{2} \mathrm{sign} (z _ {1}) + \frac {3}{2} k _ {3} | z _ {1} | ^ {1 / 2} \mathrm{sign} (z _ {1}) + k _ {3} ^ {2} z _ {1}\right) \\ \qquad + \dot {\varrho} _ {1} (t) + \varrho_ {2} (t) \quad \forall t \in [ 2 h, \infty). \end{array}\tag{38}
$$

Consider the Lyapunov function $V _ { 2 } ( \eta ) = \eta ^ { \mathrm { T } } P \eta ,$ with $\eta =$ $[ | z _ { 1 } | ^ { 1 / 2 } \mathrm { s i g n } ( z _ { 1 } ) + k _ { 3 } z _ { 1 } , z _ { 2 } ] ^ { \mathrm { T } }$ . According to [18, Thm. 1], we know that $\dot { V } _ { 2 } | _ { ( 3 8 ) } \leq - \sigma _ { 1 } V _ { 2 } ^ { 1 / 2 } ( \eta ) - \sigma _ { 2 } V _ { 2 } ( \eta ) , t \in [ 2 \: h , \infty )$

where $\sigma _ { 1 } = \varepsilon \lambda _ { \operatorname* { m i n } } ^ { 1 / 2 } ( P ) / \lambda _ { \operatorname* { m a x } } ( P ) , \sigma _ { 2 } = 2 \varepsilon k _ { 3 } / \lambda _ { \operatorname* { m a x } } ( P )$ . Therefore, the settling time is bounded by

$$
T _ {0} (z (0)) \leq 2 h + \frac {2}{\sigma_ {2}} \ln \left(\frac {\sigma_ {2}}{\sigma_ {1}} V _ {2} ^ {1 / 2} (\eta (2 h)) + 1\right).\tag{39}
$$

Besides, it is obtained from (37) that

$$
V _ {2} (\eta (2 h)) \leq \lambda_ {\max} (P) \Delta_ {3}.\tag{40}
$$

Combining (33) and (40), we have

$$
\mathrm{e} ^ {h \sigma_ {2}} - 1 \geq h \sigma_ {2} + h ^ {2} \sigma_ {2} ^ {2} / 2
$$

$$
\geq h \sigma_ {2} \frac {\lambda_ {\max} (P)}{\varepsilon h \lambda_ {\min} ^ {1 / 2} (P)} \lambda_ {\max} ^ {1 / 2} (P) \Delta_ {3} ^ {1 / 2} \geq \frac {\sigma_ {2}}{\sigma_ {1}} V _ {2} ^ {1 / 2} (\eta (2 h)).\tag{41}
$$

Substituting (41) into (39), we know that $T _ { 0 } ( z ( 0 ) ) \leq 4 h = \mathcal { T }$ which implies $\eta ( t ) = 0 , \forall t \geq \mathcal { T }$ , that is, $x _ { 1 } ( t ) = 0 , x _ { 2 } ( t ) +$ $\varrho _ { 1 } ( t ) = 0 , \forall t \geq \mathcal { \dot { T } }$

Similar to Theorem 1, although the function $V _ { 2 } ( \eta )$ is not differentiable on the set $\{ ( \eta _ { 1 } , \eta _ { 2 } )   \in   \mathbf { R } ^ { 2 } | \eta _ { 1 }   =   0 \} ,   V _ { 2 } ( \eta )$ can still be used as a Lyapunov function. The proof is finished. 

## B. Case With Measurement Noise

In this section, similar to Section III-B, the sensitivity of the proposed method to the measurement noise is analyzed. In the presence of the measurement noise, the system (36) can be written as

$$
\left\{ \begin{array}{l} \dot {x} _ {1} = - k _ {4} (t, x _ {\mathrm{m1} [ t - \mathcal {T}, t ]}) | x _ {\mathrm{m1}} | ^ {\frac {1}{2}} \text {sign} (x _ {\mathrm{m1}}) \\ \quad - k _ {1} k _ {3} x _ {\mathrm{m1}} + x _ {2} + \varrho_ {1} (t) \\ \dot {x} _ {2} = - k _ {2} (t) \Big (\frac {1}{2} \text {sign} (x _ {\mathrm{m1}}) + \frac {3}{2} k _ {3} | x _ {\mathrm{m1}} | ^ {\frac {1}{2}} \text {sign} (x _ {\mathrm{m1}}) \\ \quad + k _ {3} ^ {2} x _ {\mathrm{m1}} \Big) + \varrho_ {2} (t) \end{array} \right.\tag{42}
$$

where $x_{\mathrm{m}} = [x_{\mathrm{m}1}, x_{2}]^{\mathrm{T}} = [x_{1} + m(t), x_{2}]^{\mathrm{T}}, m(t)$ is an unknown function representing the measurement noise satisfying Assumption 3, the constants $k _ { 1 }$ and $k _ { 3 }$ , the function $k _ { 2 } :$ $\bar { [ 0 , \infty ) } \rightarrow \bar { \bf R } ,$ and the function $k _ { 4 } : [ 0 , \infty ) \times \mathbf { C } _ { 2 } ^ { \mathcal { T } } \to \mathbf { R }$ are the same as (36), and the unknown functions $\dot { \varrho } _ { j } ( t ) , j = 1 , 2$ satisfy Assumption 1.

Similar to Corollary 1, the following corollary is given.

Corollary 2: Consider the nonlinear system (42) under Assumptions 1 and 3. Then, $| x _ { 1 } ( t ) | \leq \varOmega _ { 2 } , | x _ { 2 } ( t ) + \varrho _ { 1 } ( t ) | \leq$ $\varOmega _ { 2 } ^ { 1 / 2 } , \forall t \in [ T _ { \operatorname { m } 2 } , \infty )$ , where $T _ { \mathrm { m 2 } } > 0$ is a finite time, and $\varOmega _ { 2 } \geq$ 0 is a constant independent of initial values.

The proof of Corollary 2 is shown in Appendix.

## C. Numerical Examples

Case 1—Absence of measurement noise: Consider the nonlinear system (36) where $\varrho _ { 1 } ( t ) = 0 . 2 \sin ( 2 t ) , \varrho _ { 2 } ( t ) =$ 0, and $k _ { 1 } , k _ { 2 } ( t ) , k _ { 3 } , k _ { 4 } ( t , x _ { 1 [ t - \mathcal { T } , t ] } )$ are defined in Theorem 2 with $\mathcal{T}=3,\theta=0,\varDelta_{1}=16,\varepsilon=0.28,\beta=0.8,\alpha=$ $0 . 0 0 1 , \iota = 1 . 2 , \delta _ { 1 } = 0 . 2 , \delta _ { 2 } = 0 . 2 , \delta _ { 3 } = 0$ , and $K _ { \mathrm { s t a } } ( t )$ is defined in $( 8 ) , ( 9 ) , ( 3 1 )$ , and (35).

For simulation, the initial values are set as $x_{1}(0)=1,x_{2}(0)=$ 0. The simulation results are shown in Fig. 3 with $z =$ $\begin{aligned}[z_{1},z_{2}]^{\mathrm{T}} = [x_{1},x_{2} + 0.2\sin(t)]^{\mathrm{T}}\end{aligned}$ , from which we can see that the state z converges to 0 within the prescribed time $\mathcal { T } = 3$ s.

Case 2—Presence of measurement noise: Consider system (42). The system parameters, the initial values and the measurement noise are the same as those in Case 1. We still compare with the THF-based algorithm mentioned in Section III-C. The simulation results are shown in Fig. 4, from which we can see that the algorithm designed in Section IV-A outperforms the

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

<!-- page 8 of 16 -->

1820

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 71, NO. 3, MARCH 2026

![Chart block](doc:8e0334e/tier:standard/page:8/block:3)

Fig. 3. State z for the system (36).

![Chart block](doc:8e0334e/tier:standard/page:8/block:5)

Fig. 4. State z for the system (42) in the presence of measurement noise.

THF-based algorithm in terms of tolerance to the measurement noise.

## V. PRESCRIBED-TIME CONTROL BY STATE FEEDBACK

In this section, a continuous prescribed-time sliding mode control law is designed for the system (12) under Assumption 2.

Denote

$$
z _ {1} = \xi_ {1}, \quad z _ {m} = \xi_ {m} + \sum_ {j = 1} ^ {m - 1} \frac {\mathrm{d} ^ {m - j - 1}}{\mathrm{d} t ^ {m - j - 1}} d _ {j} (t, \xi)\tag{43}
$$

where $m = 2 , 3 , \ldots , n$ . Similar to [52], the system (12) can be rewritten as the following nonlinear system with matched disturbances:

$$
\begin{array}{l} \hline \left\{ \begin{array}{l} \dot {z} _ {j} = z _ {j + 1}, \quad j = 1, 2, \dots , n - 1 \\ \dot {z} _ {n} = f (t, \xi) + g (t, \xi) u + \sum_ {j = 1} ^ {n} \frac {\mathrm{d} ^ {n - j}}{\mathrm{d} t ^ {n - j}} d _ {j} (t, \xi). \end{array} \right. \end{array}\tag{44}
$$

However, due to $d _ { i } ( t , \xi ) ,   z _ { i }$ cannot be obtained directly from $\xi _ { i } , i = 2 , 3 , \ldots , n$ . Therefore, we will first design a disturbance observer for the system (44) to obtain the information of $z _ { i }$

## A. Design of Disturbance Observer

In this section, a disturbance observer for (44) is designed by using Theorem 1. For the sake of convenience in subsequent statements, denote the comprehensive disturbance $\vartheta _ { i } ( t )$ as $\begin{array} { r } { \vartheta _ { i } ( t ) = \sum _ { j = 1 } ^ { i } \mathrm { d } ^ { i - j } d _ { j } ( t , \xi ) / \mathrm { d } t ^ { i - j } , i = 1 , 2 , \ldots , n . } \end{array}$ It can be easily deduced from Assumption 2 that $| \vartheta _ { i } ( t ) | \leq \varTheta _ { i 1 } \triangleq$ $\textstyle \sum _ { j = 1 } ^ { i } D _ { j , i - j } , | \dot { \vartheta } _ { i } ( t ) | \leq \varTheta _ { i 2 } \triangleq \sum _ { j = 1 } ^ { i } D _ { j , i - j + 1 } .$

The observer design process is divided into n steps.

Step 1: Let $T _ { \mathrm { o b } } > 0$ be a prescribed time. For $z _ { 1 } ,$ , denote $\bar { z } _ { 1 } =$ $\xi _ { 1 }$ . Then, the disturbance observer can be designed as

$$
\left\{ \begin{array}{l} \dot {\hat {z}} _ {1} = k _ {1 1} (t) | \bar {z} _ {1} - \hat {z} _ {1} | ^ {1 / 2} \text {sign} (\bar {z} _ {1} - \hat {z} _ {1}) \\ \qquad + k _ {2 1} (t) (\bar {z} _ {1} - \hat {z} _ {1}) + \xi_ {2} - \hat {D} _ {1} \\ \dot {\hat {D}} _ {1} = - k _ {3 1} (t) \text {sign} (\bar {z} _ {1} - \hat {z} _ {1}) - k _ {4 1} (t) \hat {D} _ {1} \end{array} \right.\tag{45}
$$

where $k _ { m 1 } ( t ) = k _ { m } ( t ) , m = 1 , 2 , 3 ,$ 4 are defined in (15) with $h = T _ { \mathsf { o b } } / ( 2 \overset { \frown } { n } ) , \delta _ { 1 } = \overset { \frown } { \theta _ { 1 1 } } , \delta _ { 2 } = \overset { \frown } { \theta _ { 1 2 } } , \delta _ { 3 } = 0 , x _ { 1 } = \bar { z } _ { 1 } - \hat { z } _ { 1 } , x _ { 2 }$ $= \hat { D } _ { 1 } ,$ , and $K _ { ( l _ { 4 } , h ) } ( t )$ is set to 0 for all $t \geq 2 h$ (done as Remark 3).

Step $i , i = 2 , 3 , \ldots , n \cdot$ For $z _ { i } ,$ denote $\bar { z } _ { i } = \xi _ { i } - \hat { D } _ { i - 1 }$ . Then, the disturbance observer can be designed as

$$
\left\{ \begin{array}{l} \dot {\hat {z}} _ {i} = k _ {1 i} (t) | \bar {z} _ {i} - \hat {z} _ {i} | ^ {1 / 2} \text {sign} (\bar {z} _ {i} - \hat {z} _ {i}) \\ \quad + k _ {2 i} (t) (\bar {z} _ {i} - \hat {z} _ {i}) + w _ {i} - \hat {D} _ {i} \\ \dot {\hat {D}} _ {i} = - k _ {3 i} (t) \text {sign} (\bar {z} _ {i} - \hat {z} _ {i}) - k _ {4 i} (t) \hat {D} _ {i} \end{array} \right.\tag{46}
$$

where $w _ { j } = \xi _ { j + 1 } , w _ { n } = f ( t , \xi ) + g ( t , \xi ) u , j = 2 , \ldots , n - 1$ and $k _ { m i } ( \tilde { t } ) = \tilde { k } _ { m } ( t )$ are defined in (15) with $h = T _ { \mathrm { o b } } / ( 2 n )$ $\delta _ { 1 } = \theta _ { i 1 } , \delta _ { 2 } = \theta _ { i 2 } , \delta _ { 3 } = 0 , x _ { 1 } = \bar { z } _ { i } - \hat { z } _ { i } , x _ { 2 } = \hat { D } _ { i }$ , and $m =$ $1 , 2 , 3 , 4 ,$ , and $K _ { ( l _ { 4 } , h ) } ( t )$ is set to 0 for all $t \geq 2 i h$

Based on the developments above, the following result can be drawn.

Theorem 3: Let Assumption 2 be satisfied. Consider observers (45) and (46). Then, $z _ { i } ( t ) = \hat { z } _ { i } ( t ) , \hat { D } _ { i } ( t ) = - \vartheta _ { i } ( t )$ $\forall t \geq T _ { \mathsf { o b } } , i = 1 , 2 , \ldots , n$

Proof: Similar to the design process, we also divide the proof into n steps.

Step 1: Denote $\tilde { z } _ { 1 } = \bar { z } _ { 1 } - \hat { z } _ { 1 } = z _ { 1 } - \hat { z } _ { 1 }$ . Then, it is obtained from (43) to (45) that

$$
\left\{ \begin{array}{l} \dot {\tilde {z}} _ {1} = - k _ {1 1} (t) | \tilde {z} _ {1} | ^ {1 / 2} \mathrm{sign} (\tilde {z} _ {1}) - k _ {2 1} (t) \tilde {z} _ {1} + \hat {D} _ {1} + \vartheta_ {1} (t) \\ \dot {\hat {D}} _ {1} = - k _ {3 1} (t) \mathrm{sign} (\bar {z} _ {1} - \hat {z} _ {1}) - k _ {4 1} (t) \hat {D} _ {1} \quad \forall t \geq 0. \end{array} \right.
$$

According to Theorem 1, we know that $\tilde { z } _ { 1 } ( t )$ and $\hat { D } _ { 1 } ( t )$ are bounded for all $t \in [ 0 , \infty )$ , and $\hat { z } _ { 1 } ( t ) = z _ { 1 } ( t ) , \hat { D } _ { 1 } ( t ) = - \vartheta _ { 1 } ( t )$ $\forall t \geq 2 h$

**Step** $i , i = 2 , 3 , \ldots , n \mathbf { : }$ Suppose that

$\hat { z } _ { i - 1 } ( t ) = z _ { i - 1 } ( t ) , \; \hat { D } _ { i - 1 } = - \vartheta _ { i - 1 } ( t ) , \; t \geq 2 ( i - 1 ) h .$ (47) Denote $\tilde { z } _ { i } = z _ { i } - \hat { z } _ { i }$ . From (43) and (47), we know that $\bar { z } _ { i } ( t ) =$ $z _ { i } ( t ) , \forall t \geq 2 ( i - 1 ) h$ , which implies $\tilde { z } _ { i } = \bar { z } _ { i } - \hat { z } _ { i } , \forall t \geq \widetilde { 2 } ( \widetilde { i } -$ $1 ) \dot { h } .$ Then, it is obtained from (43) to (45) that

$$
\left\{ \begin{array}{l} \dot {\tilde {z}} _ {i} = - k _ {1 i} (t) | \tilde {z} _ {i} | ^ {1 / 2} \mathrm{sign} (\tilde {z} _ {i}) - k _ {2 i} (t) \tilde {z} _ {i} + \hat {D} _ {i} + \vartheta_ {i} (t) \\ \dot {\hat {D}} _ {i} = - k _ {3 i} (t) \mathrm{sign} (\tilde {z} _ {i}) - k _ {4 i} (t) \hat {D} _ {i}, \quad \forall t \geq 2 (i - 1) h. \end{array} \right.
$$

According to Theorem 1, we know that $\tilde { z } _ { i } ( t )$ and $\hat { D } _ { i } ( t )$ are bounded for all $t \in [ 0 , \infty )$ , and $\hat { z } _ { i } ( t ) = z _ { i } ( t ) , \; \hat { D } _ { i } = - \vartheta _ { i } ( t )$ $\forall t \geq 2 i h$

Observing from Step 1, it becomes evident that (47) holds with $i = 2$ . By induction, we can conclude that $z _ { i } ( t ) = \hat { z } _ { i } ( t ) , \forall t \geq$ $T _ { \mathrm { o b } } , i = 1 , 2 , \ldots , n .$ The proof is finished. 

## B. Design of Sliding Mode Control Law by Disturbance Observer-Based Feedback

In this section, a continuous prescribed-time sliding mode control law is designed for (12).

Let $T > 0$ be a prescribed time, and $T _ { \mathrm { o b } } \in ( 0 , T )$ be the prescribed time for the disturbance observer. Then some hierarchical sliding variables can be designed as [57]

$$
s _ {0} = z _ {1}, \quad s _ {i} = \dot {s} _ {i - 1} + a s _ {i - 1} + K _ {\mathrm{s}} (t) s _ {i - 1} (t - h _ {1})\tag{48}
$$

where $a \geq 0$ is a constant, $i = 1 , 2 , \ldots , n - 1$

$$
K _ {\mathrm{s}} (t) = \left\{ \begin{array}{l l} 0, & t \in [ 0, T _ {\mathrm{ob}}) \\ K _ {(a, h _ {1})} (t - T _ {\mathrm{ob}}), & t \in [ T _ {\mathrm{ob}}, \infty) \end{array} \right.
$$

in which $h _ { 1 } = ( T - T _ { \mathrm { o b } } ) / ( 2 n )$ , and $K _ { ( a , h _ { 1 } ) } ( t )$ is defined in (8) and (9) with $\begin{array} { l } { h = h _ { 1 } , R _ { h _ { 1 } } \in \mathbf { S } ^ { ( n ) } ( h _ { 1 } ) } \\ \end{array}$ . Since $s _ { i } , i = 0 , 1$ ,

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

<!-- page 9 of 16 -->

DING et al.: PRESCRIBED-TIME CONTROL VIA PERIODIC DELAYED FEEDBACK-BASED SUPER-TWISTING SLIDING MODE ALGORITHM

1821

$\cdots , n - 1$ are not available, their observations are given as follows:

$$
\hat {s} _ {0, m _ {0}} = \hat {z} _ {m _ {0} + 1}, \quad m _ {0} = 0, 1, \ldots , n - 1\tag{49}
$$

$$
\hat {s} _ {i, m _ {i}} = \hat {s} _ {i - 1, m _ {i} + 1} + a \hat {s} _ {i - 1, m _ {i}}
$$

$$
+ \sum_ {r = 0} ^ {m _ {i}} C _ {m _ {i}} ^ {r} K _ {s} ^ {(r)} (t) \hat {s} _ {i - 1, m _ {i} - r} (t - h _ {1})\tag{50}
$$

where $\hat { z } _ { m _ { 0 } + 1 }$ is defined in (45) and (46), $i = 1 , 2 , \ldots , n - 1$ and $m _ { i } = \dot { 0 } , 1 , \ldots , n - i - 1$

Based on (49) and (50), a continuous prescribed-time sliding mode control law can be designed as

$$
u = g ^ {- 1} (\cdot) \left(- K _ {\mathrm{s}} (t) \hat {s} _ {n - 1, 0} (t - h _ {1}) - a \hat {s} _ {n - 1, 0} - f (\cdot) + \hat {D} _ {n} \right.
$$

$$
\left. - \sum_ {i = 1} ^ {n - 1} \left(a \hat {s} _ {i - 1, n - i} + \sum_ {r = 0} ^ {n - i} C _ {n - i} ^ {r} K _ {s} ^ {(r)} (t) \hat {s} _ {i - 1, n - i - r} (t - h _ {1})\right)\right)\tag{51}
$$

where $\hat { D } _ { n }$ is defined in (46). Based on the developments above, the following result can be drawn.

Theorem 4: Let $T > 0$ be a prescribed time, and Assumption 2 be satisfied. Then, the closed-loop system consisting of (12) and (51) satisfies $y ( t ) = 0 , \forall t \geq T$

Proof: According to Theorem 3, we know that $z _ { i } ( t ) =$ $\hat { z } _ { i } ( t ) , \hat { D } _ { i } ( t ) = - \vartheta _ { i } ( t ) , \forall t \geq T _ { \mathsf { o b } } , i = 1 , 2 , \ldots , n$ . Thus, it is obtained from (48) to (50) that $s _ { i } ^ { ( m _ { i } ) } ( t ) = \hat { s } _ { i , m _ { i } } ( t ) , \forall t \geq T _ { \mathsf { o b } } , i =$ $0 , 1 , \ldots , n - 1 , m _ { i } = 0 , 1 \ldots \stackrel { \circ } { , n - i - 1 }$

Step 1: The convergence of $s _ { n - 1 }$ . It follows from (48) and (51) that for all $t \in [ 0 , \infty )$

$$
\dot {s} _ {n - 1} = - a \hat {s} _ {n - 1, 0} - K _ {\mathrm{s}} (t) \hat {s} _ {n - 1, 0} (t - h _ {1}) + \hat {D} _ {n} + \vartheta_ {n},\tag{52}
$$

(52) According to Theorem $\mathfrak { I } , \tilde { \vartheta } _ { n } ( t ) { \triangleq } \hat { D } _ { n } ( t ) { + } \vartheta _ { n } ( t )$ and $\tilde { s } _ { n - 1 } ( t )   \triangleq$ $s _ { n - 1 } ( t )   -   \hat { s } _ { n - 1 , 0 } ( t )$ are bounded. Thus, we know that $\dot { s } _ { \mathit { n } - 1 }   =   - a s _ { \mathit { n } - 1 }   -   K _ { \mathit { s } } ( t ) s _ { \mathit { n } - 1 } ( t   -   h _ { 1 } )   +   \varDelta ( t , \tilde { s } _ { \mathit { n } - 1 [ \mathit { t } - \mathit { h } _ { 1 } , \mathit { t } ] } , \tilde { \vartheta } _ { \mathit { n } [ \mathit { t } - \mathit { h } _ { 1 } , \mathit { t } ] } )$ where $\varDelta ( t , \tilde { s } _ { n - 1 [ t - h _ { 1 } , t ] } , \tilde { \vartheta } _ { n [ t - h _ { 1 } , t ] } ) \triangleq \tilde { \vartheta } _ { n } ( t ) + a \tilde { s } _ { n - 1 } ( t ) + K _ { s }$ $( t ) \tilde { s } _ { n - 1 } ( t - h _ { 1 } )$ . There exists a nonnegative bounded function $\bar { \varDelta } ( \tilde { \vartheta } _ { n } ( 0 ) , \tilde { s } _ { n - 1 } ( 0 ) )$ such that $| \varDelta ( t ,   \tilde { s } _ { n - 1 [ t - h _ { 1 } , t ] } , \tilde { \vartheta } _ { n [ t - h _ { 1 } , t ] } ) | \leq$ $\bar { \varDelta } ( \tilde { \vartheta } _ { n } ( 0 ) , \tilde { s } _ { n - 1 } ( 0 ) ) , \forall t \in [ 0 , \infty )$ . Similar to the proof of Lemma $5 , s _ { n - 1 } ( t )$ is bounded. Thus, the system (52) is forward complete.

Furthermore, based on (52), $K _ { s } ( t ) = 0 , \forall t \in [ T _ { \mathsf { o b } } , T _ { \mathsf { o b } } + h _ { 1 } ]$ and $s _ { n - 1 } = \hat { s } _ { n - 1 , 0 } , \hat { D } _ { n } = - \vartheta _ { n } , \forall t \geq T _ { \mathrm { o b } }$ , we have $\dot { s } _ { n - 1 } ( t ) = - a s _ { n - 1 } ( t ) - K _ { \operatorname { s } } ( t ) s _ { n - 1 } ( t - h _ { 1 } ) \quad \forall t \geq T _ { \operatorname { o b } } .$ (53)

According to Lemma 3, we have $s _ { n - 1 } ( t ) = 0 , \forall t \geq T _ { \mathsf { o b } } + 2 h _ { 1 }$ Step $i , i = 2 , 3 , \ldots ,$ n: Suppose that

$$
s _ {n - i + 1} (t) = 0 \forall t \geq T _ {\mathrm{ob}} + 2 (i - 1) h _ {1}.\tag{54}
$$

It can be deduced from (48) that $\dot { s } _ { n - i } = - a s _ { n - i } - K _ { \operatorname { s } } ( t ) s _ { n - i }$ $( t - h _ { 1 } ) , \forall t \geq T _ { \mathsf { o b } } + 2 ( \widetilde { i - 1 } ) h _ { 1 }$ . Similar to Step 1, we have $s _ { n - i } ( t )$ is bounded and $\dot { [ } s _ { n - i } \dot { ( } t ) = 0 , \forall t \geq T _ { \mathsf { o b } } + 2 i h _ { 1 }$

Observing from Step 1, it becomes evident that (54) holds with $i = 2 .$ . Therefore, by induction, we can conclude that $s _ { n - i } ( t )$ are bounded, and $s _ { n - i } ( t ) = 0 , \forall t \geq T _ { \mathsf { o b } } + 2 i h _ { 1 } , i =$ $1 , 2 , \ldots , n - 1$ . Thus, according to (48), we know the solutions of the closed-loop system consisting of (12) and (51) are bounded, which ensures the forward completeness. Besides, $y ( t ) = \xi _ { 1 } ( t ) = s _ { 0 } ( t ) = 0 , \forall t \geq T _ { \mathsf { o b } } + 2 n \dot { h _ { 1 } = T }$ . The proof is finished. 

Remark 4: We provide some explanations on the settling time being exactly T of the closed-loop system consisting of (12) and (51). From (53), (54), and Lemma 3, the trajectory of the sliding variable s<sub>i</sub> with $t \in [ T _ { \mathsf { o b } } + 2 ( i - 1 ) h _ { 1 } , \dot { T _ { \mathsf { o b } } } + \dot { 2 } i h _ { 1 } ]$ is given by $\omega_{n - i + 1}(\lambda_{n - i + 1}) = \mathrm{e}^{- a \lambda_{n - i + 1}} \omega_{n - i + 1}(0), \forall \lambda_{n - i + 1} \in [0, h_1]$ and

$$
\omega_ {n - i + 1} (\lambda_ {n - i + 1}) = \mathrm{e} ^ {- a \lambda_ {n - i + 1}} \left(1 - \int_ {h _ {1}} ^ {\lambda_ {n - i + 1}} \mathrm{e} ^ {2 a s} R _ {h _ {1}} (s) \mathrm{d} s W\right)
$$

$$
\times \omega_ {n - i + 1} (0) \quad \forall \lambda_ {n - i + 1} \in [ h _ {1}, 2 h _ {1} ]
$$

where $\lambda _ { n - i + 1 } = t - T _ { \mathsf { o b } } - 2 ( i - 1 ) h _ { 1 } ,  \omega _ { n - i + 1 } ( \lambda _ { n - i + 1 } ) =$ $\omega _ { n - i + 1 } ( t - T _ { \mathsf { o b } } - 2 ( i - 1 ) h _ { 1 } ) = s _ { n - i + 1 } ( t )$ and $i = 1 , 2 , \ldots ,$ n. It follows that $s_{n - i + 1}(t) \neq 0, \forall t \in [T_{\mathsf{ob}} + 2(i - 1)h_1, T_{\mathsf{ob}}$ $+   2 i h _ { 1 } )$ if and only if $\omega _ { n - i + 1 } ( 0 ) \neq 0 ,$ namely, $s _ { n - i + 1 } ( T _ { \mathrm { o b } } +$ $2(i - 1\dot{)}h) \neq 0$

Remark 5: Here, the proposed method is compared with other methods for mismatched disturbances. In contrast to asymptotic, finite- and fixed-time control methods (see [16], [30], [52], and the references therein), the proposed method ensures that the system output converges to zero with the settling time being exactly equal to the prescribed time. In comparison to the $\mathrm { T H F } \mathord { \left/ { \vphantom { \mathrm { T H F } } } \right. \kern - delimiterspace }$ based method [21], the control gains required by the proposed method are bounded.

Remark 6: The approaches presented in this article introduce artificial delay terms, which may appear to require state values prior to $t = 0 .$ However, it is crucial to emphasize that all delay terms in both the disturbance observer and the control law take the form ${ } ^ { \backprime \backprime } K _ { \bar { h } } ( t ) \zeta ( t - \bar { h } ) ,$ ” where ζ is a variable related to ξ, h¯ is a constant related to the prescribed time and the periodic function $K _ { \bar { h } } ( t )$ represents the time-varying functions calculated based on Definition 3. Notably, it holds that $K _ { \bar { h } } ( t )   =   0 , \forall t \in [ 0 , \bar { h } )$ Therefore, $\zeta ( v ) , v \in [ - \tilde { h } , 0 )$ has no impact on the conclusion of Theorem 4, that is, the solutions depend only on the initial value ξ(0).

## C. Case With Measurement Noise

In this section, the sensitivity of the proposed method to the measurement noise is analyzed, that is, replace ξ in (45), (46), and (51) with $\xi _ { \operatorname { m } } = [ \xi _ { \operatorname { m } 1 } , \xi _ { \operatorname { m } 2 } , \ldots , \xi _ { \operatorname { m } n } ] ^ { \vec { \operatorname { T } } }$ , where $\xi _ { \mathrm { m } i } = \xi _ { i } +$ $m _ { i } ( t ) , i = 1 , 2 , \ldots , n ,$ and $m _ { i } ( t )$ are some unknown functions representing the measurement noise.

Assumption 4: The measurement noise $m _ { i } ( t )$ is uniformly bounded, and $| m _ { i } ( t ) | \leq \varepsilon _ { 0 } ,  i = 1 , 2 , \ldots , n$ , where $\varepsilon _ { 0 }$ is an unknown constant.

Corollary 3: Let Assumption 4 be satisfied. The closedloop system consisting of the system (12) with $f ( t , \xi ) = 0$ and $g ( t , \xi ) = 1$ , the disturbance observer (45) and (46), and the sliding mode control law (51), satisfies that $| y ( t ) | \leq \varOmega _ { 3 } , \forall t \in$ $[ T _ { \mathrm { m 3 } } , \infty )$ , where $T _ { \mathrm { m 3 } } > 0 ~ \mathrm { i s }$ a finite time, and $\varOmega _ { 3 } \geq 0$ is a constant independent of initial values.

The proof of Corollary 3 is shown in Appendix.

## D. Simulation Example

Consider the trajectory tracking control of a one-link manipulator actuated by a brush dc motor [10], whose dynamics can be written as

$$
\begin{array}{c} M \ddot {q} + B \dot {q} + N \sin (q) = I + \Delta_ {I} \\ L \dot {I} + R I + K _ {B} \dot {q} = u, \quad y = q \end{array}\tag{55}
$$

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

<!-- page 10 of 16 -->

1822

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 71, NO. 3, MARCH 2026

![Chart block](doc:8e0334e/tier:standard/page:10/block:3)

Fig. 5. State $\xi ,$ observation error z˜, and control input u for the system (56).

where $q$ is the angular motor position, I is the motor armature current, u is the control input used to represent the motor torque, $\varDelta _ { I }$ represents the torque disturbance, and $M , B , N , L , R ,$ and $K _ { B }$ are some constants represent the system parameters. Denote the smooth desired reference signal as $y _ { \mathrm { d } } ( t ) = ( \pi / 2 ) \sin ( t ) ( 1 -$ $\mathrm { e } ^ { - 0 . 1 t ^ { 2 } } ) \: [ 3 1 ]$

$\widetilde{\mathrm{Denote} \xi = [\xi_1, \xi_2, \xi_3]^{\mathrm{T}}} = [y - y_{\mathrm{d}}(t), \dot{q} - \dot{y}_{\mathrm{d}}(t), -B\dot{q}/M - N$ $\sin(q)/M + I/M - \hat{y}_{\mathrm{d}}(t)]^{\mathrm{T}}$ . Then, (55) can be rewritten as

$$
\begin{array}{l} \hline \left\{ \begin{array}{l} \dot {\xi} _ {1} = \xi_ {2}, \quad \dot {\xi} _ {2} = \xi_ {3} + \frac {1}{M} \Delta_ {I} \\ \dot {\xi} _ {3} = F (t, q, \dot {q}, I) + \frac {1}{L M} u - \frac {B}{M ^ {2}} \Delta_ {I}, \quad y = \xi_ {1} \end{array} \right. \end{array}\tag{56}
$$

where $F ( t , q , \dot { q } , I ) = - N \operatorname { c o s } ( q ) \dot { q } / M - R I / ( L M ) - K _ { B } \dot { q } /$ $( L M ) - \overset{...} { y } _ { \mathrm { d } } ( \dot { t } ) + \dot { B } ^ { 2 } \dot { q } / M ^ { 2 } + \dot { B } \overset{...} { N } \sin ( q ) / M ^ { 2 } - \dot { B } \dot { I } / M ^ { 2 }$ Notice that (56) has the same form as (12) with $d _ { 1 } ( t , \xi ) = 0 , d _ { 2 }$ $(t,\xi)=\varDelta_{I}/M,d_{3}(t,\xi)=-B\varDelta_{I}/M^{2},f(t,\xi)=F(t,q,\dot{q},I)$ and $g ( t , \xi ) = 1 / ( L M )$

For simulation, following [31], the system parameters are chosen as $M = 1 , B = 1 , \widetilde { N = 1 0 } , L = \widetilde { 0 . 0 5 } , \widetilde { R = 0 . 5 }$ and $K _ { B } = 1 0$ . The torque disturbance and the initial conditions are chosen as $\tilde { \varDelta } _ { I } = 0 . 3 \sin ( t )$ and $q(0)=-0.5,\dot{q}(0)=$ $- 1 , I ( 0 ) = 0 . 4 .$ According to Theorem 4, the prescribed time and the observer parameters for $z _ { i } , i = 1 , 2 , 3$ [defined in (43)] are set as $T=15\;  s , T_{\mathrm{ob}}=3\;  s , a=2, b=-1, c=1, l_{4}=$ $0 . 5 , \delta _ { 1 } = 0 . 6 , \delta _ { 2 } = 0 . 6 , \hat { z } _ { 1 } ( 0 ) = 0 , \hat { z } _ { 2 } ( 0 ) = 0 , \hat { z } _ { 3 } ( 0 ) = 0 ,$ and $K _ { ( l _ { 4 } , h ) } ( t )$ is defined in (8), (9), and (31). The controller parameters are set as $a = 0 . 4$ and $K _ { \mathrm { s } } ( t )$ is defined in (8) and (9) with (we only consider $t \in [ 0 , 2 h ] )$

$$
R _ {h} (t) = \left\{ \begin{array}{l l} 0, & t \in [ 0, h) \\ (t - h) ^ {4} (t - 2 h) ^ {4}, & t \in [ h, 2 h ]. \end{array} \right.
$$

The state $\xi ,$ observation error $\tilde { z }$ and control u of the system (56) without measurement noise are shown in Fig. 5. It can be seen from Fig. 5 that the output $y = \xi _ { 1 }$ can track the reference signal $y _ { \mathrm { d } }$ at the prescribed time $T = 1 5 ~ \mathrm { s } .$ , while the observation error z˜ of the disturbance observer can converge to 0 within $T _ { \mathrm { o b } } = 3 \; \mathrm { s } .$ In order to test the sensitivity of the proposed method to the measurement noise, we replace q, q˙ and I with $q _ { \mathrm { m } } = q + m ( t )$ $\dot { q } _ { \mathrm { m } } = \dot { q } + m ( t )$ and $I _ { \mathrm { m } } = I + m ( t )$ , where $m ( t )$ is the bandlimited white noise. The simulation results are shown in Fig. 6,

![Chart block](doc:8e0334e/tier:standard/page:10/block:12)

Fig. 6. State ξ for the system (56) in the presence of the measurement noise m.

from which we can see that the system output y can still converge to a small area around the equilibrium.

## VI. PRESCRIBED-TIME CONTROL BY OUTPUT FEEDBACK

In this section, a continuous prescribed-time sliding mode control law is designed via output feedback for the system (12) with $\bar{n = 2, f(t, \xi) = 0}    and   \bar{g(t, \xi) = 1}$ . In this case, the system (12) can be rewritten in the form of the following perturbed double integrator system

$$
\dot {\xi} _ {1} = \xi_ {2} + d _ {1} (t, \xi), \quad \dot {\xi} _ {2} = u + d _ {2} (t, \xi), \quad y = \xi_ {1}\tag{57}
$$

where $\xi = [\xi_{1}, \xi_{2}]^{\mathrm{T}} \in \mathbf{R}^{2}$ is the state vector, $u \in \mathbf { R }$ is the control input, $y \in \mathbf { R }$ is the output, and $d _ { i } ( t , \xi ) : [ 0 , \infty ) \times \mathbf { R } ^ { 2 } \rightarrow$ $\mathbf { R } , i = 1 , 2$ are unknown functions satisfying Assumption 2.

Similar to (43), we denote $z _ { 1 } = \xi _ { 1 } , z _ { 2 } = \xi _ { 2 } + d _ { 1 } ( t , \xi )$ . Then, (57) can be rewritten as

$$
\dot {z} _ {1} = z _ {2}, \quad \dot {z} _ {2} = u + \dot {d} _ {1} (t, \xi) + d _ {2} (t, \xi), \quad y = z _ {1}.\tag{58}
$$

## A. Design of State Observer

Let $T _ { \mathrm { o b } } > 0$ be a prescribed time. The observer can be designed as

$$
\boxed { \begin{array}{l} \dot {\hat {z}} _ {1} = k _ {6} (t, \tilde {z} _ {1 [ t - T _ {\mathrm{ob}}, t ]}) | \tilde {z} _ {1} | ^ {1 / 2} \mathrm{sign} (\tilde {z} _ {1}) + k _ {1} k _ {3} \tilde {z} _ {1} + \hat {z} _ {2} \\ \dot {\alpha} = k _ {7} (t) \left(\frac {1}{2} \mathrm{sign} (\tilde {z} _ {1}) + \frac {3}{2} k _ {3} | \tilde {z} _ {1} | ^ {1 / 2} \mathrm{sign} (\tilde {z} _ {1}) + k _ {3} ^ {2} \tilde {z} _ {1}\right) + u \\ \hat {z} _ {2} = \alpha + \omega , \quad \alpha (0) = 0, \quad \tilde {z} _ {1} = y - \hat {z} _ {1} \end{array} }\tag{59}
$$

where $\tilde { z } = z _ { 1 } - \hat { z } _ { 1 } , \omega { = } \left( y ( t ) { - } \theta ( t ) \right) / l { - } k _ { 5 } ( t ) ( y ( t { - } l ) - \theta ( t { - }$ $l ) ) / l , \ddot { \theta } { = } u , \theta ( 0 ) { = } \dot { \theta } ( 0 ) { = } 0 , k _ { 6 } ( \cdot ) { = } k _ { 1 } { + } 2 K _ { \mathsf { o b } } ( t ) | \tilde { z } _ { 1 } ( t { - } h ) | ^ { 1 / 2 }$

$$
k _ {5} (t) = \left\{ \begin{array}{l l} 0, & t \in [ 0, l ] \\ (t - l) ^ {2} / l ^ {2}, & t \in (l, 2 l) \\ 1, & t \in [ 2 l, \infty) \end{array} \right.
$$

$$
K _ {\mathrm{ob}} (t) = \left\{ \begin{array}{l l} 0, & t \in [ 0, 2 l ] \\ K _ {\mathrm{sta}} (t - 2 l), & t \in (2 l, \infty) \end{array} \right.
$$

$$
k _ {7} (t) = \left\{ \begin{array}{l l} 0, & t \in [ 0, 2 l ] \\ k _ {2} (t - 2 l), & t \in (2 l, \infty) \end{array} \right.
$$

in which $0 < l < T _ { \mathrm { o b } } / 2$ and $\mathcal { T } = T _ { \mathrm { o b } } - 2 l$ are two constants, h, $k _ { 1 } , k _ { 2 } ( t ) , k _ { 3 }$ , and $K _ { \mathrm { s t a } } ( t )$ are defined in Theorem 2 with $\delta _ { 1 } =$ $2 D _ { 1 , 0 } \overset { \frown } { + } ( 3 l + 4 h ) D _ { 2 , 0 } / 2 , \delta _ { 2 } = 2 D _ { 1 , 0 } / l + D _ { 2 , 0 } , \delta _ { 3 } = D _ { 1 , 1 } +$ $D _ { 2 , 0 } \dot { , } \varTheta = 2 l ( D _ { 1 , 1 } + \widetilde { D } _ { 2 , 0 } )$

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

<!-- page 11 of 16 -->

DING et al.: PRESCRIBED-TIME CONTROL VIA PERIODIC DELAYED FEEDBACK-BASED SUPER-TWISTING SLIDING MODE ALGORITHM

1823

Theorem 5: Let Assumption 2 be satisfied and $T _ { \mathrm { o b } } > 0$ be a prescribed time. Consider the system (58) and the observer (59). Then, $\hat { z } _ { 1 } ( t ) = y ( t ) , \hat { z } _ { 2 } ( t ) = \dot { z _ { 2 } ( t ) } , \forall t \in [ T _ { \mathsf { o b } } , \infty )$

Proof: It is obtained from (58) and (59) that

$$
\begin{array}{l} y (t) = z _ {1} (0) + z _ {2} (0) t + \theta (t) \\ \qquad + \int_ {0} ^ {t} \int_ {0} ^ {s} (\dot {d} _ {1} (\sigma , \xi (\sigma)) + d _ {2} (\sigma , \xi (\sigma))) \mathrm{d} \sigma \mathrm{d} s \end{array}
$$

from which we know that

$$
\begin{array}{c} z _ {2} (0) = \omega - \frac {1}{l} \int_ {t - l} ^ {t} (d _ {1} (s, \xi (s)) - d _ {1} (0, \xi (0))) \mathrm{d} s \\ \qquad - \frac {1}{l} \int_ {t - l} ^ {t} \int_ {0} ^ {s} d _ {2} (\sigma) \mathrm{d} \sigma \mathrm{d} s \quad \forall t \in [ 2 l, \infty). \end{array}\tag{60}
$$

It is obtained from (60) and Assumption 2 that

$$
| z _ {2} (0) - \omega (t) | \leq 2 D _ {1, 0} + D _ {2, 0} (2 t - l) / 2\tag{61}
$$

$$
| - \dot {\omega} (t) | \leq 2 D _ {1, 0} / l + D _ {2, 0} \quad \forall t \in [ 2 l, \infty).\tag{62}
$$

According to (58)–(60), we have

$$
\left\{ \begin{array}{l} \dot {\tilde {z}} _ {1} = - k _ {6} (t, \tilde {z} _ {1 [ t - T _ {\mathrm{ob}}, t ]}) | \tilde {z} _ {1} | ^ {1 / 2} \text {sign} (\tilde {z} _ {1}) - k _ {1} k _ {3} \tilde {z} _ {1} \\ \quad + \varphi (t) + p _ {1} (t) \\ \dot {\varphi} = - k _ {7} (t) \left(\frac {1}{2} \text {sign} (\tilde {z} _ {1}) + \frac {3}{2} k _ {3} | \tilde {z} _ {1} | ^ {1 / 2} \text {sign} (\tilde {z} _ {1}) \right. \\ \quad \left. + k _ {3} ^ {2} \tilde {z} _ {1}\right) + p _ {2} (t) \quad \forall t \in [ 0, \infty) \end{array} \right.\tag{63}
$$

where $\varphi = z _ { 2 } - z _ { 2 } ( 0 ) - \alpha , p _ { 1 } ( t ) = z _ { 2 } ( 0 ) - \omega$ and $p _ { 2 } ( t ) = \dot { d } _ { 1 }$ $( t , \xi ) + d _ { 2 } ( t , \xi )$ . Similar to the proof of Theorem 2, the linear growth condition (6) still holds for the system (63), and thus the forward completeness can be guaranteed by using Lemma 1.

It can be seen from $\alpha ( 0 ) = 0$ that $\varphi ( 0 ) = 0$ , and it follows from $k _ { 7 } ( t ) = 0 , \forall t \in [ 0 , \dot { 2 } \dot { l } ]$ that

$$
| \varphi (2 l) | \leq 2 l (D _ {1, 1} + D _ {2, 0}).\tag{64}
$$

For $t \in [ 2 l , \infty ) , \mathrm { g i v e n }   ( 6 1 )$ and (62), we have $| \dot { p } _ { 1 } ( t ) | \leq 2 D _ { 1 , 0 } /$ $\vec { l } + \vec { D _ { 2 , 0 } } , \vec { | p _ { 2 } ( t ) | } \leq D _ { 1 , 1 } + D _ { 2 , 0 } , \forall t \in [ 2 l , \infty )$ and $| p _ { 1 } ( t ) | \leq$ $2 D _ { 1 , 0 } + ( 3 l + 4 h ) D _ { 2 , 0 } / 2 , \forall t \in [ 2 l , 2 l + 2 h ]$ Thus, according to (64) and Theorem 2, it follows that $\tilde { z } _ { 1 } ( t ) = 0 , \varphi ( t ) =$ $- p _ { 1 } ( t ) , \forall t \geq T _ { \mathsf { o b } } ,$ , that is, $\hat { z } _ { 1 } ( t ) = y ( t ) , \hat { z } _ { 2 } ( t ) = \overset{...} { \alpha } ( t ) + \omega ( \overset{...} { t } ) =$ $z _ { 2 } ( t ) , \forall t \geq T _ { \operatorname { o b } } .$ The proof is finished.

Remark 7: Compared with the fixed-time observers designed in [51] and [53], Theorem 5 has some remarkable advantages: i) Theorem 5 clearly gives an upper bound on the settling time, ii) this upper bound can be arbitrarily prescribed, and iii) Theorem 5 can maintain its fixed time stability even when both matched and mismatched disturbances are present.

## B. Design of Sliding Mode Control Law by State Observer-Based Feedback

Let $T > 0$ be a prescribed time and $T _ { \mathrm { s } } \in ( 0 , T / 2 )$ be the prescribed time for super-twisting observer. Then, a sliding mode surface can be designed as [57]

$$
s = z _ {2} + k _ {\mathrm{s}} z _ {1} + K _ {\mathrm{s}} (t) z _ {1} \left(t - h _ {1}\right)\tag{65}
$$

where $k _ { \mathrm { s } } > 0$ and $h _ { 1 } = ( T - 2 T _ { \mathrm { s } } ) / 2$ are two constants, and

$$
K _ {\mathrm{s}} (t) = \left\{ \begin{array}{l l} 0, & t \in [ 0, 2 T _ {\mathrm{s}}) \\ K _ {(k _ {\mathrm{s}}, h _ {1})} (t - 2 T _ {\mathrm{s}}), & t \in [ 2 T _ {\mathrm{s}}, \infty). \end{array} \right.\tag{66}
$$

Since s is not available, its observation is defined as

$$
\hat {s} = \hat {z} _ {2} + k _ {\mathrm{s}} \hat {z} _ {1} + K _ {\mathrm{s}} (t) \hat {z} _ {1} (t - h _ {1})\tag{67}
$$

where $\hat { z } _ { 1 }$ and $\hat { z } _ { 2 }$ are defined in (59) with $T _ { \mathrm { o b } } = T _ { \mathrm { s } }$

Based on (67), a continuous prescribed-time sliding mode control law can be designed as

$$
\begin{array}{r l} u = & - k _ {\mathrm{s}} \hat {z} _ {2} - K _ {\mathrm{s}} (t) \hat {z} _ {2} (t - h _ {1}) - \dot {K} _ {\mathrm{s}} (t) \hat {z} _ {1} (t - h _ {1}) \\ & - k _ {\mathrm{s} 1} (t, \hat {s} _ {[ t - 2 h _ {1}, t ]}, \hat {d} _ {[ t - 2 h _ {1}, t ]}) | \hat {s} | ^ {1 / 2} \mathrm{sign} (\hat {s}) \\ & - k _ {\mathrm{s} 2} (t, \hat {s} _ {[ t - 2 h _ {1}, t ]}, \hat {d} _ {[ t - 2 h _ {1}, t ]}) \hat {s} + \hat {d} \\ \dot {\hat {d}} = & - k _ {\mathrm{s} 3} (t, \hat {s} _ {[ t - 2 h _ {1}, t ]}, \hat {d} _ {[ t - 2 h _ {1}, t ]}) \mathrm{sign} (\hat {s}) \\ & - k _ {\mathrm{s} 4} (t, \hat {s} _ {[ t - 2 h _ {1}, t ]}, \hat {d} _ {[ t - 2 h _ {1}, t ]}) \hat {d} \end{array}\tag{68}
$$

where $k _ { \mathrm { s } i } ( \cdot ) , i = 1 , 2 , 3 ,$ 4 are defined in (15) with $\mathcal { T } = 2 h _ { 1 }$ $x _ { 1 } { = } \hat { s } , x _ { 2 } { = } \hat { d } , \delta _ { 1 } { = } D _ { 1 , 1 } + D _ { 2 , 0 } , \delta _ { 2 } { = } D _ { 1 , 2 } + D _ { 2 , 1 }$ , and $\delta _ { 3 }   =   0$ Theorem 6: Let $\dot { T > 0 }$ be a prescribed time, and Assumption 2 be satisfied. Then, the closed-loop system consisting of (57) and (68) satisfies $y ( t ) = 0 , \forall t \geq T$

Proof: From Theorem 5, we can see that the observation error $\tilde { z } ( t ) \triangleq z ( t ) - \hat { z } ( t )$ is bounded. Similar to the proof of Theorem 4, we know that the closed-loop system consisting of (57) and (68) is forward complete.

Next, we prove that y(t) converges to 0 within the prescribed time. We divide the proof into two steps.

Step 1: The convergence of the sliding variable $s ( t )$ . Considering (58), (65), and (68), we have

$$
\left| \begin{array}{c} \dot {s} = \dot {d} _ {1} (t, \xi) + d _ {2} (t, \xi) + k _ {\mathrm{s}} z _ {2} - k _ {\mathrm{s}} \hat {z} _ {2} + K _ {\mathrm{s}} (t) z _ {2} (t - h _ {1}) \\ - K _ {\mathrm{s}} (t) \hat {z} _ {2} (t - h _ {1}) + \dot {K} _ {\mathrm{s}} (t) z _ {1} (t - h _ {1}) - \dot {K} _ {\mathrm{s}} (t) \hat {z} _ {1} (t - h _ {1}) \\ - k _ {\mathrm{s} 1} (\cdot) | \hat {s} | ^ {1 / 2} \text {sign} (\hat {s}) - k _ {\mathrm{s} 2} (\cdot) \hat {s} + \hat {d}. \end{array} \right|
$$

It is obtained from Theorem 5 and $K _ { \mathrm { s } } ( t ) = \dot { K } _ { \mathrm { s } } ( t ) = 0 ,$ ∀t ∈ $[ T _ { \mathrm { s } } , T _ { \mathrm { s } } + h _ { 1 } ]$ that

$$
\dot {s} = - k _ {\mathrm{s1}} (\cdot) | s | ^ {1 / 2} \text {sign} (s) - k _ {\mathrm{s2}} (\cdot) s + \hat {d} + \dot {d} _ {1} (t, \xi) + d _ {2} (t, \xi)
$$

$$
\hat {\dot {d}} = - k _ {\mathrm{s3}} (\cdot) \mathrm{sign} (s) - k _ {\mathrm{s4}} (\cdot) \hat {d} \quad \forall t \in [ T _ {\mathrm{s}}, \infty).
$$

According to Theorem 1, we know that $s ( t )   =   0 , \forall t   \in   [ 2 T _ { \mathrm { s } } , \infty )$ Step 2: The convergence of $z _ { 1 } ( t )$ . It is obtained from (58), (65), and $s ( t ) = 0 , \forall t \in [ 2 T _ { \mathrm { s } } , \infty )$ that

$$
\dot {z} _ {1} = - k _ {\mathrm{s}} z _ {1} - K _ {(k _ {\mathrm{s}}, h _ {1})} (t) z _ {1} (t - h _ {1}), \quad t \in [ 2 T _ {\mathrm{s}}, \infty)\tag{69}
$$

the system (69) can be rewritten as $\dot { \omega } _ { 1 } ( \lambda ) = - k _ { \mathrm { s } } \omega _ { 1 } ( \lambda ) -$ $K _ { ( k _ { \operatorname { s } } , h _ { 1 } ) } ( \lambda ) \omega _ { 1 } ( \lambda - h _ { 1 } ) , \lambda \geq 0 ,$ by noting $\lambda = t - 2T_{ s }, \omega_{1}(\lambda) =$ $\omega _ { 1 } ( t - 2 T _ { \mathrm { s } } ) = z _ { 1 } ( t )$ Then, by using Lemma 3, we know that $\omega _ { 1 } ( \lambda ) = 0 , \forall \lambda \geq 2 h _ { 1 }$ , namely, $y ( t ) = 0 , \forall t \geq 2 T _ { \mathrm { s } } + 2 h _ { 1 } = T .$ The proof is finished. 

Remark 8: Similar to Remark 4, the settling time of the closed-loop system consisting of (57) and (68) is exactly T when $z ( 2 T _ { \mathrm { s } } ) \neq \bar { 0 }$

## C. Case With Measurement Noise

In this section, the sensitivity of the proposed method to the measurement noise is analyzed, namely, the output measurement is $y _ { \mathrm { m } } = \xi _ { 1 } + m _ { y } ( t )$ , where $m _ { y } ( t )$ is an unknown function representing the measurement noise satisfying.

Assumption 5: The measurement noise $m _ { y } ( t )$ is uniformly bounded, and $| m _ { y } ( t ) | \leq \varepsilon _ { 0 }$ , where $\varepsilon _ { 0 } \geq 0$ is a constant.

Corollary 4: Let Assumption 5 be satisfied. The closed-loop system consisting of the system (57), the disturbance observer (59), and the sliding mode control law (68), satisfies that $\left| y ( t ) \right| \leq$ $\varOmega _ { 4 } , \forall t   \in   [ T _ { \mathrm { m } 4 } , \infty )$ , where $T _ { \mathrm { m 4 } }   >   0$ is a finite time, and $\varOmega _ { 4 }   \geq   0$ is a constant independent of initial values.

The proof of Corollary 4 is shown in Appendix.

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

<!-- page 12 of 16 -->

1824

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 71, NO. 3, MARCH 2026

![Chart block](doc:8e0334e/tier:standard/page:12/block:3)

Fig. 7. State $\xi ,$ observation error $\tilde { z } ,$ and control input u for the system (70).

![Chart block](doc:8e0334e/tier:standard/page:12/block:5)

Fig. 8. State ξ for the system (70) in the presence of the measurement noise.

## D. Simulation Example

Consider the following system:

$$
\dot {\xi} _ {1} = \xi_ {2} + 0. 5 \sin (0. 5 t), \dot {\xi} _ {2} = u + 0. 1 5 \sin (0. 5 t), y = \xi_ {1},\tag{70}
$$

For simulation, the initial conditions are set as $\xi ( 0 ) = [ 1 0 , 5 ] ^ { \mathrm { T } }$ The prescribed time is chosen as $T = 3 0 \; \mathrm { s } .$ According to Theorem 5, the observer parameters are selected as $T _ { s } = 1 0 \; \mathrm { s } ,$ $\varDelta _ { 1 } = 1 6 , \varepsilon = 0 . 2 8 , \beta = \mathring { 0 } . 8 , \alpha = 0 . 0 0 1 , v = 1 . 2 , \iota = 1 . 2 , l =$ $1 , \hat { z } _ { 1 } ( 0 ) = 0 , \hat { z } _ { 2 } ( 0 ) = 0 ,$ , and $K _ { \mathrm { s t a } } ( t )$ is defined in $( 8 ) , ( 9 ) , ( 3 1 )$ and (35). According to Theorem 6, the controller parameters are selected as $a = 2 , b = - 1 , c = 1 , l _ { 4 } = 0 . 1 , k _ { s } = 0 . 1$ , and $K _ { s } ( t )$ is defined in (8), (9), (31), and (66).

The state $\xi ,$ observation error $\tilde { z } = z - \hat { z }$ and control input u for (70) are shown in Fig. 7. It can be seen from Fig. 7 that the $\operatorname { o u t p u t } y = \xi _ { 1 }$ can converge to 0 at the prescribed time $T = 3 0 \; \mathrm { s } ,$ while the observation error z˜ of the disturbance observer can converge to 0 within $T _ { \mathrm { s } } = 1 0 \; \mathrm { s }$ . In order to verify Corollary 4, we replace y with $y _ { \mathrm { m } } = y + m ( t )$ , where $m ( t )$ is the same as Section V-D. The simulation results are shown in Fig. 8, from which we can see that the system output y can still converge to a small region around the equilibrium.

## VII. CONCLUSION

The problem of prescribed-time control has been investigated by utilizing continuous sliding mode control laws. As the basis for the work in this article, two novel STA were proposed based on PDF. Both algorithms exhibit an estimated settling time that remains unaffected by the initial conditions and can be arbitrarily prescribed. Based on the first STA, we designed a disturbance

observer and a prescribed-time continuous sliding mode control law by state feedback, thereby achieving prescribed-time stabilization of a class of high-order nonlinear systems with both matched and mismatched disturbances. Based on the second STA, we designed a state observer and a prescribed-time continuous sliding mode control law by output feedback, thereby achieving prescribed-time stabilization of a class of perturbed double integrator systems. We provided some simulation results to demonstrate the effectiveness of the proposed approaches.

## APPENDIX

## A. Proof of Lemma 5

For $t \in [ 2 i h , ( 2 i + 1 ) h ] , i = 0 , 1 , 2 , . . . ,$ it is obtained from $K _ { ( k , h ) } ( t ) = 0 \quad \mathrm { t h a t } \quad \dot { x } = - k x + \varDelta ( t ) , \forall t \in [ 2 i h , ( 2 i + 1 ) h ]$ Thus, for $t \in [ 2 i h , ( 2 i + 1 ) h ]$ , we have

$$
x (t) = \mathrm{e} ^ {- k (t - 2 i h)} x (2 i h) + \int_ {2 i h} ^ {t} \mathrm{e} ^ {- k (t - s)} \varDelta (s) \mathrm{d} s.\tag{71}
$$

For $t \in [ ( 2 i + 1 ) h , 2 ( i + 1 ) h ]$ , we have

$$
\begin{array}{l} x (t) = \mathrm{e} ^ {- k (t - (2 i + 1) h)} x ((2 i + 1) h) + \int_ {(2 i + 1) h} ^ {t} \mathrm{e} ^ {- k (t - s)} \Delta (s) \mathrm{d} s \\ \quad - \int_ {(2 i + 1) h} ^ {t} \mathrm{e} ^ {- k (t - s)} K _ {(k, h)} (s) x (s - h) \mathrm{d} s. \end{array} \tag {72}
$$

Substituting (71) into (72), we can get

$$
\begin{array}{l} x (t) = \mathrm{e} ^ {- k (t - 2 i h)} x (2 i h) \left(1 - \int_ {(2 i + 1) h} ^ {t} \mathrm{e} ^ {k h} K _ {(k, h)} (s) \mathrm{d} s\right) \\ \quad - \mathrm{e} ^ {- k t} \int_ {(2 i + 1) h} ^ {t} \mathrm{e} ^ {k h} K _ {(k, h)} (s) \int_ {2 i h} ^ {s - h} \mathrm{e} ^ {k \sigma} \Delta (\sigma) \mathrm{d} \sigma \mathrm{d} s \\ \quad + \int_ {2 i h} ^ {t} \mathrm{e} ^ {- k (t - s)} \Delta (s) \mathrm{d} s. \end{array} \tag {73}\tag{73}
$$

Thus, it is obtained from (8), (9), and (73) that

$$
x (2 (i + 1) h) = \mathrm{e} ^ {- 2 k h} x (2 i h) (1 - W _ {c} (k, h) W) + \Pi = \Pi
$$

where $W _ { \mathrm { c } } ( k , h )$ and W are defined in Lemma 3

$$
\begin{array}{l} \Pi \triangleq - \mathrm{e} ^ {- k (2 i + 1) h} \int_ {(2 i + 1) h} ^ {2 (i + 1) h} K _ {(k, h)} (s) \int_ {2 i h} ^ {s - h} \mathrm{e} ^ {k \sigma} \varDelta (\sigma) \mathrm{d} \sigma \mathrm{d} s \\ \qquad + \int_ {2 i h} ^ {2 (i + 1) h} \mathrm{e} ^ {- k (2 (i + 1) h - s)} \varDelta (s) \mathrm{d} s. \end{array}
$$

It follows that $| \varPi | \leq \bar{\varPi}, \bar{\varPi} \triangleq (1 - \mathrm{e}^{-2kh})\bar{\varDelta}/k + (1 - (1 +$ $(hk)\mathrm{e}^{-kh})\bar{K}\bar{\varDelta}/\dot{k^2},$ where $\bar { K } \geq 0$ is a constant satisfying $| K ( t ) | \leq \bar { K } , \forall t \in [ h , 2 h ]$ . Then, we know that $| x ( 2 ( i + 1 ) h ) | \leq$ $\varPi , i = 0 , 1 , 2 , \ldots .$ It can be deduced from (71) and (73) that $\begin{array} { l } { \left| x ( t ) \right| { \leq } \: \bar { \varPi } + ( 1 - { \operatorname { e } } ^ { - k h } ) \bar { \varDelta } / k { \triangleq } \: \varPi _ { 1 } , \forall t { \in } \: [ 2 i h , ( 2 i + 1 ) h ] , \left| x ( t ) \right| } \\ \end{array}$ $\leq 2 \bar { \mathit { \Pi } } \triangleq \mathit { \Pi } _ { 2 } , \forall t \in [ ( 2 i + 1 ) h , 2 ( i + 1 ) h ]$ . Thus, Lemma 5 holds with $\varOmega = \operatorname* { m a x } \{ \varPi _ { 1 } , \varPi _ { 2 } \}$

## B. Proof of Corollary 1

Following Theorem 1, define $\eta = [ \eta _ { 1 } , \eta _ { 2 } ] ^ { \mathrm { T } } \triangleq [ | z _ { 1 } | ^ { 1 / 2 } \mathrm { s i g n }$ $\begin{aligned}(z_{1}), z_{2}]^{\mathrm{T}}, z_{1} = x_{1}, z_{2} = x_{2} + \varrho_{1}(t)\end{aligned}$ . Then, the system (30) can be written as

$$
\dot {\eta} = \frac {1}{\left| \eta_ {1} \right|} \tilde {A} _ {1} (t) \eta + \tilde {A} _ {2} (t) \eta + \frac {1}{\left| \eta_ {1} \right|} \xi\tag{74}
$$

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

<!-- page 13 of 16 -->

DING et al.: PRESCRIBED-TIME CONTROL VIA PERIODIC DELAYED FEEDBACK-BASED SUPER-TWISTING SLIDING MODE ALGORITHM

1825

where $\xi   =   [ \xi _ { 1 } , \xi _ { 2 } ] ^ { \mathrm { T } } , \; \xi _ { 1 }   =   - k _ { 1 } ( \cdot ) ( | x _ { \mathrm { m } 1 } | ^ { \frac { 1 } { 2 } } \mathrm { s i g n } ( x _ { \mathrm { m } 1 } )   -   | x _ { 1 } | ^ { \frac { 1 } { 2 } } \mathrm { s i g n }$ $( x _ { 1 } ) ) / 2 - k _ { 2 } ( \cdot ) m ( t ) / 2 , \xi _ { 2 } = - k _ { 3 } ( \cdot ) ( | x _ { 1 } | ^ { \frac { 1 } { 2 } } \mathsf { s i g n } ( x _ { \operatorname { m } 1 } ) - | x _ { 1 } | ^ { \frac { 1 } { 2 } }$ $\operatorname { s i g n } ( x _ { 1 } ) )$ and $\tilde { A } _ { 1 } ( t )$ and $\tilde { A } _ { 2 } ( t )$ are defined in (21).

$$
x _ {\mathrm{m} 1} x _ {1} \geq 0
$$

$$
| \xi_ {1} | \leq \frac {| k _ {1} (\cdot) |}{2} (| x _ {1} | ^ {1 / 2} + | m (t) | ^ {1 / 2} - | x _ {1} | ^ {1 / 2}) + \frac {| k _ {2} (\cdot) |}{2} | m (t) |
$$

$$
\leq \frac {\left| k _ {1} (\cdot) \right|}{2} \varepsilon_ {0} ^ {1 / 2} + \frac {\left| k _ {2} (\cdot) \right|}{2} \varepsilon_ {0}, \quad \xi_ {2} = 0.\tag{75}
$$

When $x _ { \operatorname { m 1 } } x _ { 1 } < 0 ,$ , it holds that $| x _ { 1 } | \leq | m ( t ) |$ , which implies

$$
| \xi_ {1} | \leq \frac {\sqrt {2} + 1}{2} | k _ {1} (\cdot) | \varepsilon_ {0} ^ {1 / 2} + \frac {| k _ {2} (\cdot) |}{2} \varepsilon_ {0}, | \xi_ {2} | \leq 2 | k _ {3} (\cdot) | \varepsilon_ {0} ^ {1 / 2}.\tag{76}
$$

Thus, given $K _ { ( l _ { 4 } , h ) } ( t ) = \dot { K } _ { ( l _ { 4 } , h ) } ( t ) = 0 , \forall t \in [ 0 , h ]$ , we know that, for $t \in [ 0 , \dot { h } ]$

$$
\xi^ {\mathrm{T}} \xi \leq \Xi , \Xi \triangleq \left((\sqrt {2} + 1) | l _ {1} | \varepsilon_ {0} ^ {1 / 2} / 2 + l _ {2} \varepsilon_ {0} / 2\right) ^ {2} + 4 l _ {3} ^ {2} \varepsilon_ {0}.\tag{77}
$$

For $t \in [ 0 , h ]$ , the time derivative of the Lyapunov function $V ( \eta ) = \eta ^ { \mathrm { T } } P \eta$ with P defined in (2) satisfies

$$
\begin{array}{l} \dot {V} (\eta) \leq - \frac {1}{| \eta_ {1} |} \lambda_ {\min} (Q _ {1} (t)) \eta^ {\mathrm{T}} \eta - \eta^ {\mathrm{T}} Q _ {2} \eta \\ \qquad + \frac {k _ {0} \lambda_ {\max} (P)}{| \eta_ {1} |} \xi^ {\mathrm{T}} \xi + \frac {\lambda_ {\max} (P)}{k _ {0} | \eta_ {1} |} \eta^ {\mathrm{T}} \eta \quad \forall t \in [ 0, h ] \end{array}
$$

where $k _ { 0 } > 0$ is a constant, $Q _ { 1 } ( t )$ and $Q _ { 2 }$ are defined in (19) and (20). By letting $k _ { 0 } = - 4 \lambda _ { \mathrm { m a x } } ( P ) / b$ and noting $\lambda _ { \operatorname* { m i n } } ( Q _ { 1 } ( t ) ) \geq$ $- b / 2 , Q _ { 2 } = l _ { 2 } P$ , we have

$$
\dot {V} (\eta) \leq \frac {b}{4 | \eta_ {1} |} \eta^ {\mathrm{T}} \eta - l _ {2} \eta^ {\mathrm{T}} P \eta + \frac {4 \lambda_ {\max} ^ {2} (P)}{- b | \eta_ {1} |} \xi^ {\mathrm{T}} \xi .\tag{78}
$$

When $V \geq 3 2 \varXi \lambda _ { \operatorname* { m a x } } ^ { 3 } ( P ) / b ^ { 2 }$ , which implies $\eta ^ { \mathrm { T } } \eta \geq 3 2 \varXi \lambda _ { \mathrm { m a x } } ^ { 2 }$ $( P ) / b ^ { 2 }$ , we get

$$
\dot {V} (\eta) \leq \frac {b \lambda_ {\min} ^ {1 / 2} (P)}{8 \lambda_ {\max} (P)} V ^ {1 / 2} (\eta) - l _ {2} V (\eta)\tag{79}
$$

where we have used $1 / | \eta _ { 1 } | \geq \lambda _ { \operatorname* { m i n } } ^ { 1 / 2 } ( P ) / V ^ { 1 / 2 }$ . According to Lemma 7, we know that $\eta ( t )$ is bounded in $[ 0 , h ]$ , namely, the functions $W _ { 1 } ( x _ { m } ( t - h ) )$ and $W _ { 2 } ( x _ { m } ( t - h ) )$ defined in (14) with $x _ { 1 } = x _ { \mathrm { m 1 } }$ are bounded in $t \in [ h , 2 h ]$ . It can be seen from (8) and (9) that $K _ { ( l _ { 4 } , h ) } ( t )$ and $\dot { K } _ { ( l _ { 4 } , h ) } ( t )$ are bounded for all $t \in$ $[ h , 2 h ]$ . Combining with (15), we know that $k _ { i } ( t , x _ { \operatorname { m } [ t - \mathcal { T } , t ] } ) , i =$ $1 , 2 , 3 ,$ 4 are bounded in $[ h , 2 h ]$ , namely, there are some constants $\bar { k } _ { i } > 0 , i = 1 , 2 , 3 , \bar { 4 }$ such that $| k _ { i } ( t , x _ { \operatorname { m } [ t - \mathcal { T } , t ] } ) | < \bar { k } _ { i }$ . For $t \in [ h , 2 h ]$ , repeating the analysis from (74) to (79) with $l _ { i } =$ $\bar { k } _ { i } , i = 1 , 2 , 3 , 4$ , we know that $x ( 2 h )$ is also bounded. For $t \in$ $[ 2 h , \infty )$ , since $k _ { i } ( t , x _ { \operatorname { m } [ t - \mathcal { T } , t ] } ) = l _ { i } , i = 1 , 2 , 3 , 4 , \; ( 7 9 )$ holds when $V \geq 3 2 \varXi \lambda _ { \operatorname* { m a x } } ^ { 3 } ( P ) / b ^ { 2 } . \mathrm { \AA { \tt ~ A p p l y i n g ~ L e m m a ~ 7 } }$ again, we know that the system (30) is forward complete and $V ( \eta ) \leq$ $3 2 \varXi \lambda _ { \operatorname* { m a x } } ^ { 3 } ( P ) / \dot { b ^ { 2 } } , \forall t \geq [ 2 h + T ( x ( 2   h ) ) , \infty \big )$ , where $T ( \dot { x ( 2 h ) } )$ is defined in (3). Thus, it can be deduced that Corollary 1 is established with $\varOmega _ { 1 } = 3 2 \varXi \lambda _ { \operatorname* { m a x } } ^ { 3 } ( P ) / ( b ^ { 2 } \lambda _ { \operatorname* { m i n } } ( P ) )$ and $T _ { \mathrm { m 1 } } =$ $2 h + T ( x ( 2 h ) )$

## C. Proof of Corollary 2

It is noted that, compared with Theorem 2, the only difference in Corollary 2 is the inclusion of the measurement error $m ( t )$ Since m(t) is bounded, its effect can be readily absorbed into

the functions $M ( t )$ and $N ( t )$ in condition (6). In other words, the linear growth condition (6) still holds. Thus, according to Lemma 1, its forward completeness can be guaranteed.

For $t \in [ 0 , 2 h ]$ , the time-derivative of the Lyapunov function $V _ { 1 } ( x _ { 1 } ) = \dot { x _ { 1 } ^ { 2 } } / 2$ can be calculated as

$$
\dot {V} _ {1} (x _ {1}) = - k _ {4} (t, x _ {\mathrm{m1} [ t - \mathcal {T}, t ]}) | x _ {1} | ^ {3 / 2} - k _ {1} k _ {3} x _ {1} ^ {2} + \xi_ {0} x _ {1}
$$

$$
\leq - 2 ^ {3 / 4} k _ {4} (\cdot) V _ {1} ^ {3 / 4} - 2 k _ {1} k _ {3} V _ {1} + \frac {k _ {0}}{2} \xi_ {0} ^ {2} + \frac {1}{2 k _ {0}} x _ {1} ^ {2}\tag{80}
$$

$$
k _ {0} > 0
$$

$$
\xi_ {0} = k _ {4} (t, x _ {\mathrm{m1} [ t - \mathcal {T}, t ]}) \left(| x _ {1} | ^ {1 / 2} \right.
$$

$$
\operatorname{sign} \left(x _ {1} - \left| x _ {\mathrm{m} 1} \right| ^ {1 / 2} \operatorname{sign} \left(x _ {\mathrm{m} 1}\right)\right) - k _ {1} k _ {3} m (t) + \varrho_ {1} (t) + x _ {2}
$$

Similar to (75) and (76), we know that $\xi _ { 0 } ^ { 2 } \leq ( | k _ { 4 } ( t ,$ $\begin{aligned} { x _ { \operatorname { m } 1 [ t - \mathcal { T } , t ] } ) | ( \sqrt { 2 } + 1 ) \varepsilon _ { 0 } + k _ { 1 } k _ { 3 } \varepsilon _ { 0 } + \delta _ { 1 } + | x _ { 2 } | ) ^ { 2 } } \\ \end{aligned}$ . For $t \in [ 0 ,$ $2 h ]$ , it holds that $\xi _ { 0 } ^ { 2 } \leq \varXi _ { 0 } \triangleq ( k _ { 1 } ( \sqrt { 2 } + 1 ) \varepsilon _ { 0 } + k _ { 1 } k _ { 3 } \varepsilon _ { 0 } + \delta _ { 1 } +$ $\dot { \theta + 2 h \delta _ { 3 } ) ^ { 2 } }$ . Let $k _ { 0 } = 1 / ( k _ { 1 } k _ { 3 } )$ . Then, for $t \in [ 0 , h ]$ , (80) can be rewritten as

$\dot { V } _ { 1 } ( x _ { 1 } ) \leq - 2 ^ { 3 / 4 } k _ { 1 } V _ { 1 } ^ { 3 / 4 } - k _ { 1 } k _ { 3 } V _ { 1 } + \varXi _ { 0 } / ( 2 k _ { 1 } k _ { 3 } ) .$ (81) When $V _ { 1 } \geq \varXi _ { 0 } / ( k _ { 1 } ^ { 2 } k _ { 3 } ^ { 2 } )$ , it follows from (81) that $\dot { V } _ { 1 } \leq$ $- 2 ^ { 3 / 4 } k _ { 1 } V _ { 1 } ^ { 3 / 4 } - ( k _ { 1 } k _ { 3 } / 2 ) V _ { 1 }$ . According to Lemma 7, we know that $x _ { 1 } ( t - h )$ is bounded in $t \in [ h , 2 h ]$ . Thus, it can be seen from (32) that $k _ { 4 } ( t , x _ { \operatorname { m 1 } [ t - \mathcal { T } , t ] } )$ is bounded for all $t \in [ h , 2 h ]$ , namely, there exists a constant $\bar { k } _ { 4 } \geq 0$ such that $| k _ { 4 } ( t , x _ { \operatorname { m } 1 [ t - \mathcal { T } , t ] } ) | \leq \bar { k } _ { 4 }$ . Thus, for $t \in [ h , 2 h ]$ , repeating the analysis from (80) to (81) with $\varXi _ { 0 } = ( \bar { k } _ { 4 } ( \sqrt { 2 } +$ $\begin{aligned} { 1 ) \varepsilon _ { 0 } + k _ { 1 } k _ { 3 } \varepsilon _ { 0 } + \delta _ { 1 } + \mathit { \Theta } + 2 h \delta _ { 3 } ) ^ { 2 } } \\ \end{aligned}$ , we know that $x _ { 1 } ( 2 h )$ is bounded. Besides, it is obtained from $k_{2}(t)=0,\forall t\in \widehat{[0,2h]}$ and $| \varrho _ { 2 } ( t ) | \leq \delta _ { 2 }$ that $x _ { 2 } ( 2 h )$ is also bounded.

For $t \in [ 2 h , \infty )$ , define $\eta = [ | z _ { 1 } | ^ { 1 / 2 } \mathrm { s i g n } ( z _ { 1 } ) + k _ { 3 } z _ { 1 } , z _ { 2 } ] ^ { \mathrm { T } }$ $z _ { 1 } = x _ { 1 } , z _ { 2 } = x _ { 2 } + \varrho _ { 1 } ( t )$ . Then, (42) can be rewritten as

$$
\dot {\eta} = \left(\frac {1}{2 | z _ {1} | ^ {1 / 2}} + k _ {3}\right) (A (t) \eta + \xi), A (t) = \left[ \begin{array}{c c} - k _ {1} & 1 \\ \mu - \alpha (t, x) & 0 \end{array} \right]
$$

where $\alpha ( t , x )$ is a nonlinear function that can be found in [18], and $\boldsymbol{\xi} = \dot{[} \xi_{1}, \dot{\xi}_{2} ]^{\mathrm{T}}$

$$
\xi_ {1} = - k _ {1} \left[ x _ {\mathrm{m} 1} \right] ^ {1 / 2} \operatorname{sign} \left(x _ {\mathrm{m} 1}\right) + k _ {1} \left| x _ {1} \right. ^ {1 / 2} \operatorname{sign} \left(x _ {1}\right) - k _ {1} k _ {3} m (t)
$$

$$
\xi_ {2} = \mu
$$

$$
\frac {(1 + 3 k _ {3} | x _ {1} | ^ {\frac {1}{2}}) \mathrm{sign} (x _ {1}) - (1 + 3 k _ {3} | x _ {\mathrm{m} 1} | ^ {\frac {1}{2}}) \mathrm{sign} (x _ {\mathrm{m} 1}) - 2 k _ {3} ^ {2} m (t)}{\frac {1}{| z _ {1} | ^ {1 / 2}} + 2 k _ {3}}
$$

Similar to $( 7 5 )  –  ( 7 7 )$ , we know that $\xi ^ { \mathrm { T } } \xi \leq \Xi _ { 1 }$ , where $\Xi _ { 1 }$ is a constant independent of initial values. Choose the Lyapunov function as $\bar { V _ { 2 } } = \eta ^ { \mathrm { T } } P \eta$ with P defined in (34). Notice that $\lambda_{\min}(Q) \geq 2\varepsilon, Q = -(A^{\mathrm{T}}(t)P + PA(t))$ , we have

$$
\left| \dot {V} _ {2} (\eta) \leq \left(\frac {1}{2 \left| z _ {1} \right| ^ {\frac {1}{2}}} + k _ {3}\right) \left(- 2 \varepsilon \eta^ {\mathrm{T}} \eta + 2 \eta^ {\mathrm{T}} P \xi\right) \right|
$$

$$
\left| \leq \left(\frac {1}{2 \left| z _ {1} \right| ^ {\frac {1}{2}}} + k _ {3}\right) \left(- 2 \varepsilon \eta^ {\mathrm{T}} \eta + \lambda_ {\max} (P) \left(l \eta^ {\mathrm{T}} \eta + \frac {\Xi_ {1}}{l}\right)\right) \right|
$$

where $l > 0$ is a constant. Let $l = \varepsilon / \lambda_{\max}(P)$ . Given $| z _ { 1 } | ^ { 1 / 2 } \leq V _ { 2 } ^ { 1 / 2 } / \lambda _ { \operatorname* { m i n } } ^ { 1 / 2 } ( P )$ , we know that, for $V _ { 2 } \geq 2 \lambda _ { \operatorname* { m a x } } ^ { 3 }$ $( P ) \varXi _ { 1 } / \varepsilon ^ { 2 }$ , it holds that $\dot { V } _ { 2 } \leq - \varepsilon \lambda _ { \operatorname* { m i n } } ^ { 1 / 2 } ( P ) V _ { 2 } ^ { 1 / 2 } / ( 4 \lambda _ { \operatorname* { m a x } } ( P ) ) -$ $\varepsilon k _ { 3 } V _ { 2 } / ( 2 \lambda _ { \operatorname* { m a x } } ( P ) )$ . According to Lemma 7, we know that $V _ { 2 } \leq$ $2 \lambda _ { \operatorname* { m a x } } ^ { 3 } ( \overset { \frown } { P } ) \varXi _ { 1 } / \overset { \frown } { \varepsilon ^ { 2 } } , \overset { \frown } { \forall t } \geq [ 2 h + \overset { \frown } { T } ( x ( 2   h ) ) )$ , where $T ( x ( 2 h ) )$ is defined in (3). Thus, it can be deduced that Corollary 2 is

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

<!-- page 14 of 16 -->

1826

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 71, NO. 3, MARCH 2026

established with $\varOmega _ { 2 } = 2 \lambda _ { \operatorname* { m a x } } ^ { 3 } ( P ) \varXi _ { 1 } / ( \varepsilon ^ { 2 } \lambda _ { \operatorname* { m i n } } ( P ) )$ and $T _ { \mathrm { m 2 } } =$ $2 h + T ( x ( 2 h ) )$ .

## D. Proof of Corollary 3

First, we analyze the observation error.

Step 1: In the presence of the measurement noise, $\tilde { z } _ { 1 }$ in (45) is replaced by $\tilde { z } _ { 1 }   +   m _ { 1 } ( t )$ According to Corollary 1, we know that $\left| \bar { z } _ { 1 }   -   \hat { z } _ { 1 } \right|$ and $| \hat { D } _ { 1 }   +   \vartheta _ { 1 } |$ are bounded for $t \in [ 0 , \infty )$ and $\left| \bar { z } _ { 1 } - \right.$ $\left| \hat { z } _ { 1 } \right| \leq \mathit { \Omega } _ { 1 , 1 } , \left| \hat { D } _ { 1 } + \vartheta _ { 1 } \right| \leq \mathit { \Omega } _ { 1 , 1 } ^ { 1 / 2 } , \forall t \geq T _ { 1 }$ , where $\mathcal { Q } _ { 1 , 1 }$ and $T _ { 1 }$ are the same as $\mathcal { Q } _ { 1 }$ and $T _ { \mathrm { m 1 } }$ in Corollary 1.

Step $i , i = 2 , 3 , \ldots , n ;$ Suppose that $\left| \bar { z } _ { i - 1 } - \hat { z } _ { i - 1 } \right| \leq$ $\varOmega _ { i - 1 , 1 } , | \hat { D } _ { i - 1 } + \vartheta _ { i - 1 } | \leq \varOmega _ { i - 1 , 1 } ^ { 1 / 2 } , \forall t \geq T _ { i - 1 } ,$ , where $T _ { i - 1 } > 0$ is a finite time, $\varOmega _ { i - 1 , 1 } \geq 0$ is a constant independent of initial values. Then, similar to Step 1, we know that $\left| \bar { z } _ { i }   -   \hat { z } _ { i } \right|$ and $| \hat { D } _ { i }   +   \vartheta _ { i } |$ are bounded for $t \in [ 0 , \infty )$ and $\left| \bar { z } _ { i } { - } \hat { z } _ { i } \right| \leq \mathit { \Omega } _ { i , 1 } , \left| \hat { D } _ { i } { + } \vartheta _ { i } \right| \leq \mathit { \Omega } _ { i , 1 } ^ { 1 / 2 } , \forall t \geq T _ { i }$ , where $T _ { i } > T _ { i - 1 }$ is a finite time, where $\varOmega _ { i , 1 } \geq 0$ is a constant.

By induction, we can conclude that $| \bar { z } _ { j } - \hat { z } _ { j } |$ and $| \hat { D } _ { j } + \vartheta _ { j } |$ are bounded for $t \in [ 0 , \infty )$ and $| \bar { z } _ { j } - \hat { z } _ { j } | \leq$ $\varOmega _ { j , 1 } , | \hat { D } _ { j } + \vartheta _ { j } | \leq \varOmega _ { j , 1 } ^ { 1 / 2 } , \forall t \geq T _ { j } , j = 1 , 2 , \ldots , n$ Besides, given $\bar { z } _ { 1 } = z _ { 1 } , \bar { z } _ { i } = \xi _ { i } - \hat { D } _ { i - 1 } , i = 2 , 3 , \ldots , n ,$ we know that $| z _ { 1 } - \hat { z } _ { 1 } | \leq \mathit { \Omega } _ { i , 1 } , \qquad | z _ { i } - \hat { z } _ { i } | \leq | \bar { z } _ { i } - \hat { z } _ { i } | + | \hat { D } _ { i - 1 } + \vartheta _ { i - 1 } | \leq$ $\varOmega _ { i , 1 }   +   \varOmega _ { i - 1 , 1 } ^ { 1 / 2 } , \forall t \geq T _ { n }$

Next, we analyze the system state. It is noted that the observation error has already been shown to be bounded. Similar to the proof of Theorem 4, it can be shown that the state ξ(t) is bounded and can be extended to $t \rightarrow \infty$ . Therefore, the closed-loop system is forward complete.

Step 1: From the above analysis, we can see that $\dot { s } _ { n - 1 } =$ $- a s _ { n - 1 } - K _ { \operatorname { s } } ( t ) s _ { n - 1 } ( t - h _ { 1 } ) + \varDelta _ { n - 1 } ( t ) , \forall t \geq 2 k _ { \operatorname { o b } } h _ { 1 }$ , where $k _ { \mathrm { o b } }$ is a constant such that $2 k _ { \mathsf { o b } } h _ { 1 } \geq T _ { n } , \: \varDelta _ { n - 1 } ( t ) \leq \bar { \varDelta } _ { n - 1 }$ , in which $\bar { \varDelta } _ { n - 1 } \geq 0$ is a constant associated with the measurement noise and the observation error but independent of the initial values. By using Lemma 5, we have $| s _ { n - 1 } | \leq \varOmega _ { n - 1 , 3 } , \forall t \geq$ $2 ( k _ { \mathrm { o b } } + 1 ) h _ { 1 }$

Step $i , i = 2 , 3 , \ldots , n ;$ Suppose that $| s _ { n - i + 1 } | \leq \varOmega _ { n - i + 1 , 3 } ,$ where $\varOmega _ { n - i + 1 , 3 } \geq 0$ is a constant independent of the initial values. It can be seen from (48) that $\dot { s } _ { n - i } = - a s _ { n - i } -$ $K _ { \operatorname { s } } ( t ) s _ { n - i } ( t - h _ { 1 } ) + \varDelta _ { n - i } ( t ) , \forall t \geq 2 ( k _ { \operatorname { o b } } + i - 1 ) h _ { 1 }$ According to Lemma 5, it is obtained that $| s _ { n - i } | \leq \varOmega _ { n - i , 3 } , \forall t \geq$ $2 ( k _ { \mathrm { o b } } + i ) h _ { 1 }$

By induction, we can conclude that $| y | = | s _ { 0 } | \leq \varOmega _ { 0 , 3 } , \forall t \geq$ $2 ( k _ { \mathrm { o b } } + n ) h _ { 1 }$ , namely, Corollary 3 holds with $\varOmega _ { 3 } = \varOmega _ { 0 , 3 }$ and $T _ { \mathrm { m 3 } } = 2 ( k _ { \mathrm { o b } } + n ) h _ { 1 }$

## E. Proof of Corollary 4

Similar to the proof of Corollaries 1 and 2, the forward completeness of the closed-loop system consisting of the system (57), the disturbance observer (59), and the sliding mode control law (68) can be guaranteed.

In the presence of the measurement noise, (59) can be written as

$$
\left\{ \begin{array}{l} \dot {\hat {z}} _ {1} = k _ {6} (t, \tilde {z} _ {\mathrm{m1} [ t - T _ {\mathrm{ob}}, t ]}) | \tilde {z} _ {\mathrm{m1}} | ^ {1 / 2} \text {sign} (\tilde {z} _ {\mathrm{m1}}) + k _ {1} k _ {3} \tilde {z} _ {\mathrm{m1}} + \hat {z} _ {2} \\ \dot {\alpha} = \frac {k _ {7} (t)}{2} \left(\left(1 + 3 k _ {3} | \tilde {z} _ {\mathrm{m1}} | ^ {\frac {1}{2}}\right) \text {sign} (\tilde {z} _ {\mathrm{m1}}) + 2 k _ {3} ^ {2} \tilde {z} _ {\mathrm{m1}}\right) + u \\ \hat {z} _ {2} = \alpha + \omega_ {\mathrm{m}}, \quad \alpha (0) = 0, \quad \tilde {z} _ {\mathrm{m1}} = y _ {\mathrm{m}} - \hat {z} _ {1} \end{array} \right.
$$

where $\omega _ { \operatorname { m } } = \omega + m _ { y } ( t ) / l - k _ { 5 } ( t ) m _ { y } ( t - l ) / l$ , in which $k _ { 1 }$ and $k _ { 3 }$ , the variable ω, the time-varying function $k _ { 7 } ( t )$ , and the function $k _ { 6 } : [ 0 , \infty ) \times \mathbf { C } _ { 2 } ^ { T _ { \mathsf { o b } } } \to \mathbf { \bar { R } }$ are the same as (59).

Let $\varphi = z _ { 2 } - z _ { 2 } ( 0 ) - \alpha , \: \tilde { z } _ { 1 } = z _ { 1 } - \hat { z } _ { 1 } , \: p _ { 1 } ( t ) = z _ { 2 } ( 0 ) - \omega ,$ and $p _ { 2 } ( t ) = \dot { d } _ { 1 } ( t , \xi ) + d _ { 2 } ( t , \xi )$ . We have

$$
\left\{ \begin{array}{l} \dot {\tilde {z}} _ {1} = - k _ {6} (t, \tilde {z} _ {\mathrm{m1} [ t - T _ {\mathrm{ob}}, t ]}) | \tilde {z} _ {\mathrm{m1}} | ^ {1 / 2} \mathrm{sign} (\tilde {z} _ {\mathrm{m1}}) - k _ {1} k _ {3} \tilde {z} _ {\mathrm{m1}} \\ \qquad + \varphi (t) + \omega - \omega_ {\mathrm{m}} + p _ {1} (t) \\ \dot {\varphi} = - \frac {k _ {7} (t)}{2} \left(\left(1 + 3 k _ {3} | \tilde {z} _ {\mathrm{m1}} | ^ {\frac {1}{2}}\right) \mathrm{sign} (\tilde {z} _ {\mathrm{m1}}) + 2 k _ {3} ^ {2} \tilde {z} _ {\mathrm{m1}}\right) \\ \qquad + p _ {2} (t), \quad t \in [ 0, \infty). \end{array} \right.
$$

Notice that (61), (62), and (64) still hold. It follows from $| \omega - \omega _ { \mathrm { m } } | \leq 2 \varepsilon _ { 0 } / l$ and Corollary 2 that $| z _ { 1 } ( t ) - \hat { z } _ { 1 } ( t ) | \leq$ $\varOmega _ { 2 } , | \varphi ( t ) + p _ { 1 } ( t ) | \leq \varOmega _ { 2 } ^ { 1 / 2 } , \forall t \in [ 2 l + T _ { \operatorname { m } 2 } , \infty )$ , where $T _ { \mathrm { m 2 } } >$ 0 is a finite time, and $\mathcal { Q } _ { 2 }$ and $T _ { \mathrm { m 2 } }$ are two constants. Thus, we know that $\left| z _ { 1 } ( t ) - \hat { z } _ { 1 } ( t ) \right| \leq \varOmega _ { 2 } , \left| z _ { 2 } ( t ) - \hat { z } _ { 2 } ( t ) \right| \leq \left| \varphi ( t ) \right. +$ $| p _ { 1 } ( t ) | + | \omega ( t ) - \omega _ { \operatorname { m } } ( t ) | \leq \varOmega _ { 2 } ^ { 1 / 2 } + 2 \varepsilon _ { 0 } / l , \forall t \in [ 2 l + T _ { \operatorname { m } 2 } , \infty )$ As $K _ { \mathrm { s } } ( t )$ is uniformly bounded and $K _ { \mathrm { s } } ( t ) = 0 , \forall t \in [ 0 , T _ { \mathrm { s } } +$ $h _ { 1 } ]$ , we know that $\hat { s } ( t ) = s ( t ) + m _ { \mathrm { s } } ( t )$ , where $m _ { \mathrm { s } } ( t )$ is a function satisfying $| m _ { \operatorname { s } } ( t ) | \leq \varDelta _ { \operatorname { s } } , \varDelta _ { \operatorname { s } } \triangleq \varOmega _ { 2 } ^ { 1 / 2 } + 2 \varepsilon _ { 0 } / l + ( k _ { \operatorname { s } } +$ $\bar { K } ) \mathit { \Omega } _ { 2 } , \forall t \geq T _ { \operatorname { s } } + 2 k _ { \operatorname { o b } } h _ { 1 }$ , in which $k _ { \mathrm { o b } } \geq 0$ is a constant satisfying $T _ { \operatorname * { s } } + 2 k _ { \operatorname * { o b } } h _ { 1 } \geq T _ { \operatorname * { m 2 } }$ . According to Corollary 1, we have

$$
| s (t) | \leq \Omega_ {1}, \quad t \geq T _ {\mathrm{s}} + 2 k _ {\mathrm{ob}} h _ {1} + T _ {\mathrm{m1}}\tag{82}
$$

where $\mathcal { Q } _ { 1 }$ and $T _ { \mathrm { m 1 } }$ are defined in Corollary 1. By using $( 6 5 ) ,$ (82), and Lemma 5, we know that $| y ( t ) | = | z _ { 1 } ( t ) | \leq \varOmega _ { 4 } , \forall t \geq$ $T _ { \mathrm { m } 4 } \triangleq T _ { \mathrm { s } } + 2 ( k _ { \mathrm { o b } } + 2 ) h _ { 1 } + T _ { \mathrm { m } 1 }$ , where $\mathcal { Q } _ { 4 }$ is defined by Ω in Lemma 5.

## REFERENCES

[1] H. Alwi and C. Edwards, “An adaptive sliding mode differentiator for actuator oscillatory failure case reconstruction,” Automatica, vol. 49, no. 2, pp. 642–651, 2013.

[2] D. Angeli and E. D. Sontag, “Forward completeness, unboundedness observability, and their Lyapunov characterizations,” Syst. Control Lett., vol. 38, no. 4–5, pp. 209–217, 1999.

[3] J. P. Aubin and A. Cellina, Differential Inclusions. Berlin, Germany: Sprigner-Verlag, 1984.

[4] A. Baccioti and L. Rosier, Lyapunov Functions and Stability in Control Theory, 2nd ed. New York, NY, USA: Springer-Verlag, 2005.

[5] A. Bacciotti and F. Ceragioli, “Stability and stabilization of discontinuous systems and nonsmooth Lyapunov functions,” ESAIM: Control, Optimisation Calculus Variations, vol. 4, pp. 361–376, 1999.

[6] G. Bartolini, A. Pisano, E. Punta, and E. Usai, “A survey of applications of second-order sliding mode control to mechanical systems,” Int. J. Control, vol. 76, no. 9–10, pp. 875–892, 2003.

[7] M. Basin, C. Bharath Panathula, and Y. Shtessel, “Multivariable continuous fixed-time second-order sliding mode control: Design and convergence time estimation,” IET Control Theory Appl., vol. 11, no. 8, pp. 1104–1111, 2017.

[8] V. I. Bogachev, Measure Theory, vol. I. Berlin, Germany: Springer-Verlag, 2007.

[9] Z. Cai, L. Huang, Z. Guo, L. Zhang, and X. Wan, “Periodic synchronization control of discontinuous delayed networks by using extended Filippovframework,” Neural Netw., vol. 68, pp. 96–110, 2015.

[10] D. M. Dawson, J. J. Carroll, and M. Schneider, “Integrator backstepping control of a brush DC motor turning a robotic load,” IEEE Trans. Control Syst. Technol., vol. 2, no. 3, pp. 233–244, Mar. 1994.

[11] Y. Ding, B. Zhou, K. K. Zhang, and W. Michiels, “Strong prescribed-time stabilization of uncertain nonlinear systems by periodic delayed feedback,” IEEE Trans. Autom. Control, vol. 69, no. 6, pp. 4072–4079, Jun. 2024.

[12] Q. Dong, Q. Zong, B. Tian, and F. Wang, “Adaptive-gain multivariable super-twisting sliding mode control for reentry RLV with torque perturbation,” Int. J. Robust Nonlinear Control, vol. 27, no. 4, pp. 620–638, 2017.

[13] W. Dou, S. Ding, J. H. Park, and K. Mei, “An adaptive generalized supertwisting algorithm via event-triggered control,” IEEE Trans. Automat. Sci. Eng., vol. 22, pp. 393–406, 2025, doi: [10.1109/TASE.2024.3351122.](https://dx.doi.org/10.1109/TASE.2024.3351122)

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

<!-- page 15 of 16 -->

DING et al.: PRESCRIBED-TIME CONTROL VIA PERIODIC DELAYED FEEDBACK-BASED SUPER-TWISTING SLIDING MODE ALGORITHM

1827

[14] C. Edwards and Y. B. Shtessel, “Adaptive continuous higher order sliding mode control,” Automatica, vol. 65, pp. 183–190, 2016.

[15] A. F. Filippov, Differential Equations With Discontinuous Right-Hand Side. Dordrecht, The Netherlands: Kluwer, 1988.

[16] D. Ginoya, P. D. Shendge, and S. B. Phadke, “Sliding mode control for mismatched uncertain systems using an extended disturbance observer,” IEEE Trans. Ind. Electron., vol. 61, no. 4, pp. 1983–1992, Apr. 2013.

[17] M. A. Golkani, S. Koch, M. Reichhartinger, and M. Horn, “A novel saturated super-twisting algorithm,” Syst. Control Lett., vol. 119, pp. 52–56, 2018.

[18] T. Gonzalez, J. A. Moreno, and L. Fridman, “Variable gain super-twisting sliding mode control,” IEEE Trans. Autom. Control, vol. 57, no. 8, pp. 2100–2105, Aug. 2011.

[19] H. Haimovich and H. De Battista, “Disturbance-tailored super-twisting algorithms: Properties and design framework,” Automatica, vol. 101, pp. 318–329, 2019.

[20] J. Holloway and M. Krstic, “Prescribed-time output feedback for linear systems in controllable canonical form,” Automatica, vol. 107, pp. 77–85, 2019.

[21] Y. Hu, X. Cai, J. Peng, and S. Shi, “Prescribed-time output stabilization for mismatched uncertain systems using state-feedback control based on extended disturbance observer,” Automatica, vol. 157, 2023, Art. no. 111244.

[22] L. H. Huang, Z. Y. Guo, and J. F. Wang, Theory and Applications of Differential Equations With Discontinuous Right-Hand Sides (in Chinese). Beijing, China: Science Press, 2011.

[23] Y. Kali, M. Saad, K. Benjelloun, and C. Khairallah, “Super-twisting algorithm with time delay estimation for uncertain robot manipulators,” Nonlinear Dyn., vol. 93, pp. 557–569, 2018.

[24] V. Kolmanovskii and A. Myshkis, Introduction to the Theory and Applications of Functional Differential Equations. Dordrecht, The Netherlands: Kluwer, 1999.

[25] P. Krishnamurthy, F. Khorrami, and M. Krstic, “A dynamic high-gain design for prescribed-time regulation of nonlinear systems,” Automatica, vol. 115, 2020, Art. no. 108860.

[26] S. Laghrouche, F. Plestan, and A. Glumineau, “Higher order sliding mode control based on integral sliding mode,” Automatica, vol. 43, no. 3, pp. 531–537, 2007.

[27] A. Levant, “Sliding order and sliding accuracy in sliding mode control,” Int. J. Control, vol. 58, no. 6, pp. 1247–1263, 1993.

[28] A. Levant, “Principles of 2-sliding mode design,” Automatica, no. 43, pp. 576–586, 2007.

[29] W. Li and M. Krstic, “Prescribed-time output-feedback control of stochastic nonlinear systems,” IEEE Trans. Autom. Control, vol. 68, no. 3, pp. 1431–1446, Mar. 2023.

[30] S. Li, H. Sun, J. Yang, and X. Yu, “Continuous finite-time output regulation for disturbed systems under mismatching condition,” IEEE Trans. Autom. Control, vol. 60, no. 1, pp. 277–282, Jan. 2015.

[31] T. -S. Li, D. Wang, G. Feng, and S. -C. Tong, “A DSC approach to robust adaptive NN tracking control for strict-feedback nonlinear systems,” IEEE Trans. Syst., Man, Cybernet., Part B (Cybernet.), vol. 40, no. 3, pp. 915–927, Mar. 2009.

[32] Y. Lin, Z. Lin, Z. Sun, and B. D. O. Anderson, “A unified approach for finite-time global stabilization of affine, rigid, and translational formation,” IEEE Trans. Autom. Control, vol. 67, no. 4, pp. 1869–1881, Apr. 2022.

[33] K. Z. Liu, X. M. Sun, J. Liu, and A. R. Teel, “Stability theorems for delay differential inclusions,” IEEE Trans. Autom. Control, vol. 61, no. 10, pp. 3215–3220, Oct. 2016.

[34] F. Lopez-Ramirez, A. Polyakov, D. Efimov, and W. Perruquetti, “Finitetime and fixed-time observer design: Implicit Lyapunov function approach,” Automatica, vol. 87, pp. 52–60, 2018.

[35] K. Lu and Y. Xia, “Finite-time attitude control for rigid spacecraft-based on adaptive super-twisting algorithm,” IET Control Theory Appl., vol. 8, no. 15, pp. 1465–1477, 2014.

[36] C. G. Mayhew and A. R. Teel, “On the topological structure of attraction basins for differential inclusions,” Syst. Control Lett., vol. 60, no. 12, pp. 1045–1050, 2011.

[37] J. A. Moreno and M. Osorio, “Strict Lyapunov functions for the super-twisting algorithm,” IEEE Trans. Autom. Control, vol. 57, no. 4, pp. 1035–1040, Apr. 2012.

[38] I. Nagesh and C. Edwards, “A multivariable super-twisting sliding mode approach,” Automatica, vol. 50, no. 3, pp. 984–988, 2014.

[39] C. B. Panathula, A. Rosales, Y. Shtessel, and M. Basin, “Chattering analysis of uniform fixed-time convergent sliding mode control,” J. Franklin Inst., vol. 354, no. 4, pp. 1907–1921, 2017.

[40] A. Polyakov, “Finite-dimensional Filippov method for infinitedimensional SMC system,” in Proc. CDC 2025-IEEE Conf. Decis. Control, 2025, pp. 508–516.

[41] A. Polyakov, “Nonlinear feedback design for fixed-time stabilization of linear control systems,” IEEE Trans. Autom. Control, vol. 57, no. 8, pp. 2106–2110, Aug. 2012.

[42] A. Polyakov, D. Efimov, and W. Perruquetti, “Finite-time and fixedtime stabilization: Implicit Lyapunov function approach,” Automatica, 51, pp. 332–340, 2015.

[43] A. Polyakov and A. Poznyak, “Reaching time estimation for ‘supertwisting’ second order sliding mode controller via Lyapunov function designing,” IEEE Trans. Autom. Control, vol. 54, no. 8, pp. 1951–1955, Aug. 2009.

[44] R. Seeber, “Worst-case error bounds for the super-twisting differentiator in presence of measurement noise,” Automatica, vol. 152, Art. no.110983, 2023.

[45] R. Seeber, M. Horn, and L. Fridman, “A novel method to estimate the reaching time of the super-twisting algorithm,” IEEE Trans. Autom. Control, vol. 63, no. 12, pp. 4301–4308, Dec. 2018.

[46] Y. Shen and Y. Huang, “Uniformly observable and globally Lipschitzian nonlinear systems admit global finite-time observers,” IEEE Trans. Autom. Control, vol. 54, no. 11, pp. 2621–2625, Nov. 2009.

[47] Y. Shtessel, C. Edwards, L. Fridman, and A. Levant, Sliding Mode Control and Observation. New York, NY, USA: Birkhauser, 2014.

[48] J. F. Silva and D. A. Santos, “Attitude determination for multirotor aerial vehicles using a prescribed-time super-twisting algorithm,” Int. J. Robust Nonlinear Control, vol. 35, no. 1, pp. 62–81, 2025.

[49] Y. Song, Y. Wang, J. Holloway, and M. Krstic, “Time-varying feedback for regulation of normal-form nonlinear systems in prescribed finite time,” Automatica, vol. 83, pp. 243–251, 2017.

[50] S. K. Spurgeon, “Sliding mode observers: A survey,” Int. J. Syst. Sci., vol. 39, no. 8, pp. 751–764, 2008.

[51] Y. Su and C. Zheng, “Global fixed-time output feedback stabilization for a class of double integrator systems,” IEEE Trans. Circuits Syst II: Express Briefs, vol. 67, no. 10, pp. 1954–1958, Oct. 2019.

[52] B. Tian, H. Lu, Z. Zuo, and H. Wang, “Fixed-time stabilization of highorder integrator systems with mismatched disturbances,” Nonlinear Dyn., vol. 94, pp. 2889–2899, 2018.

[53] B. Tian, Z. Zuo, X. Yan, and H. Wang, “A fixed-time output feedback control scheme for double integrator systems,” Automatica, vol. 80, pp. 17–24, 2017.

[54] V. Utkin, “Variable structure systems with sliding modes,” IEEE Trans. Autom. control, vol. 22, no. 2, pp. 212–222, Feb. 1977.

[55] X. Xiong, A. K. Pal, Z. Liu, S. Kamal, R. Huang, and Y. Lou, “Discretetime adaptive super-twisting observer with predefined arbitrary convergence time,” IEEE Trans. Circuits Syst. II: Exp. Briefs, vol. 68, no. 6, pp. 2057–2061, Jun. 2020.

[56] B. Zhou, W. Michiels, and J. Chen, “Fixed-time stabilization of linear delay systems by smooth periodic delayed feedback,” IEEE Trans. Autom. Control, vol. 67, no. 2, pp. 557–573, Feb. 2022.

[57] B. Zhou, Y. Ding, K. K. Zhang, and G. R. Duan, “Prescribed time control based on the periodic delayed sliding mode surface without singularities,” Sci. China Inf. Sci., vol. 67, no. 7, pp. 1–15, 2024.

[58] B. Zhou, Z. Zhang, and W. Michiels, “Functional and dual observer based prescribed-time control of linear systems by periodic delayed feedback,” Automatica, vol. 159, 2024, Art. no. 111406.

![Image block](doc:8e0334e/tier:standard/page:15/block:48)

**Yi Ding** received the bachelor’s degree in detection, guidance and control technology in 2022 from the Harbin Institute of Technology, Harbin, China, where he is currently working toward the Ph.D. degree in control science and engineering with the Department of Control Science and Engineering.

His research interests include nonlinear systems and control, sliding mode control, and finite-time control.

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

<!-- page 16 of 16 -->

1828

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 71, NO. 3, MARCH 2026

![Image block](doc:8e0334e/tier:standard/page:16/block:3)

**Bin Zhou** (Senior Member, IEEE) received the bachelor’s, master’s, and Ph.D. degrees from the Department of Control Science and Engineering with the Harbin Insitute of Technology, Harbin, China, in 2004, 2006, and 2010, respectively.

He is a Professor with the Department of Control Science and Engineering, Harbin Institute of Technology, Harbin, China. His current research interests include time-delay systems, time-varying systems, nonlinear control,

and control applications in astronautic engineering.

Dr. Zhou is a Reviewer for American Mathematical Review and is an Active Reviewer for many journals. He was the recipient of the National Excellent Doctoral Dissertation Award in 2012 from the Academic Degrees Committee of the State Council and the Ministry of Education of P.R. China, and was granted the China National Funds for Distinguished Young Scientists on 2021. He is a Member of the IFAC Technical Committees on Linear Control Systems, Nonlinear Control Systems, and Aerospace. He is currently an Associate Editor for Automatica, IEEE TRANSACTIONS ON AUTOMATIC CONTROL, Systems and Control Letters, IEEE TRANSACTIONS ON AEROSPACE AND ELECTRONIC SYSTEMS, IEEE TRANSACTIONS ON SYSTEMS, MAN AND CYBERNETICS: SYSTEMS, International Journal of Robust and Nonlinear Control, European Journal of Control, IET Control Theory and Applications, and Asian Journal of Control.

![Image block](doc:8e0334e/tier:standard/page:16/block:8)

**Yang Shi** (Fellow, IEEE) received the Ph.D. degree in electrical and computer engineering from the University of Alberta, Edmonton, AB, Canada, in 2005.

From 2005 to 2009, he was an Assistant Professor and an Associate Professor with the Department of Mechanical Engineering, University of Saskatchewan, Saskatoon, SK, Canada. In 2009, he joined the University of Victoria, Victoria, BC, Canada, where he is currently a Professor with the Department of Mechanical

Engineering. His current research interests include networked and distributed systems, model predictive control, cyber-physical systems, robotics and mechatronics, navigation and control of autonomous systems, and energy system applications.

Dr. Shi was the recipient of the University of Saskatchewan Student Union Teaching Excellence Award in 2007, the Faculty of Engineering Teaching Excellence Award in 2012 at the University of Victoria, the JSPS Invitation Fellowship (short-term) in 2013, the UVic Craigdarroch Silver Medal for Excellence in Research in 2015, the 2016 IEEE Transactions on Fuzzy Systems Outstanding Paper Award, and the Humboldt Research Fellowship for Experienced Researchers in 2018. He is Vice-President on Conference Activities of IEEE Industrial Electronics Society, and Chair of IES Technical Committee of Industrial Cyber-Physical Systems (ICPS). He is currently the Editor-in-Chief for IEEE TRANSACTIONS ON INDUSTRIAL ELECTRONICS; he is also an Associate Editor for Automatica, IEEE TRANSACTIONS ON AUTOMATIC CONTROL, IEEE TRANSACTIONS ON CYBERNETICS, etc. He is General Chair of the 2019 International Symposium on Industrial Electronics and the 2021 International Conference on ICPS. He is a Fellow of ASME, Engineering Institute of Canada, and Canadian Society for Mechanical Engineering, and a registered Professional Engineer in British Columbia, Canada.

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.