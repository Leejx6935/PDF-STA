<!-- page 6 of 16 -->

1818

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 71, NO. 3, MARCH 2026

interval containing τ . If z<sub>2</sub>(τ )=0, then z<sub>1</sub>(t) will remain at zero. In both cases |z1|1/2sign(z<sub>1</sub>) is AC as a function of time.

Besides, according to (29) and Lemma 4, it follows that the system (28) is FxTS and η(t)=0, ∀t ∈ [T ,∞), which implies the system (13) is forward complete and z(t)=0, ∀t ∈ [T ,∞). The proof is finished.

Remark 3: In practical applications, when the state completes convergence within one period, the other periods of the periodic function K(l<sub>4</sub>,h)(t)in (16) can be set to zero. In this case, the control gains k<sub>i</sub>(t, <sup>x</sup>[t−T ,t])= l<sub>i</sub>,i =1, 2, 3, 4 become constants. Furthermore, since K(l<sub>4</sub>,h)(jh)=0,j =0, 1,..., this treatment does not affect the continuity of the control gains.

## B. Case With Measurement Noise

In this section, following [34] and [44], the sensitivity of the proposed method to the measurement noise is analyzed. In practical applications, x<sub>1</sub> often represents the sliding mode variable, while x<sub>2</sub> is an artificially introduced variable. Therefore, only the case where x<sub>1</sub> is affected by the measurement noise is considered here (see [44]). The system (13) can be written as

![Formula block](doc:8e0334e/tier:flash/page:6/block:8)

where x<sub>m</sub> =<sup>[x</sup>m1<sup>,x</sup>2<sup>]T</sup> =<sup>[x</sup>1 + m(t),x<sub>2</sub>]<sup>T</sup>. The functions ki : [0,∞) × C<sup>T</sup><sub>2</sub> → R,i =1, 2, 3, 4 are defined in (15), and K(l<sub>4</sub>,h)(t)in (16)is set to 0 when t ≥ 2h (as shown in Remark 3). The unknown functions j (t),j =1, 2 satisfy Assumption 1, and the measurement noise m(t)satisfies the following assumption.

Assumption 3: The measurement noise m(t) is uniformly bounded, satisfying |m(t)|≤ ε<sub>0</sub>, where ε<sub>0</sub> is a constant.

Corollary 1: Consider the nonlinear system (30) under Assumptions 1 and 3. Then, |x<sub>1</sub>(t)|≤ Ω<sub>1</sub>, |x<sub>2</sub>(t)+ 1(t)|≤ Ω1/2 1 , ∀t ∈ [T<sub>m1</sub>,∞), where T<sub>m1</sub> > 0 is a finite time, and Ω<sub>1</sub> ≥ 0 is a constant independent of initial values.

The proof of Corollary 1 is shown in Appendix.

## C. Numerical Examples

Case 1—Absence of measurement noise: Consider the system (13) with 1(t)=0.2 sin(2t),2(t)=0, where k<sub>i</sub>(·),i = 1, 2, 3, 4 are defined in (15) with T =3,a =2,b = −1,c = 1,l<sub>4</sub> =0.05,δ<sub>1</sub> =0.5,δ<sub>2</sub> =1,δ<sub>3</sub> =0, and K(l<sub>4</sub>,h)(t) is given

![Formula block](doc:8e0334e/tier:flash/page:6/block:15)

For simulation, the initial values are set as x<sub>1</sub>(0) = 25,x<sub>2</sub>(0) = 15. The simulation results are shown in Fig. 1 with z = <sup>[z</sup>1<sup>,z</sup>2<sup>]T</sup> =<sup>[x</sup>1<sup>,x</sup>2 + <sub>1</sub>(t)]<sup>T</sup>, from which we can see that the state z converges to 0 within the prescribed time T =3s.

Case 2—Presence of measurement noise:Consider the system (30). The system parameters and initial values are the same as those in Case 1, and the measurement noise is chosen as the band-limited white noise. For comparison, consider the THF-based algorithm proposed in [48], which can be described as (11) with

![Formula block](doc:8e0334e/tier:flash/page:6/block:18)

![Image block](doc:8e0334e/tier:flash/page:6/block:19)

## Fig. 1. State z for the system (13).

![Image block](doc:8e0334e/tier:flash/page:6/block:21)

## Fig. 2. State z for the system (30) in the presence of measurement noise.

For simulation, the prescribed time, the initial values and the external disturbances i,i =1, 2 are the same as those in Case 1, with parameters chosen as κ<sub>1</sub> =1,κ<sub>2</sub> =8, and η =5. The simulation results are shown in Fig. 2. It follows that, in the presence of the measurement noise, the THF-based algorithm deviates significantly from the equilibrium at the prescribed time T =3s, while the algorithm designed in Section III-A can still maintain satisfying performance.

## IV. STA BY PDF: THE SECOND METHOD

## A. Design of STA

In this section, we will propose another STA, and restrict the function φ<sub>2</sub>(t, <sup>x</sup>[t−T ,t]) to be dependent only on t and x<sub>1</sub>.

Let T > 0 be an arbitrary prescribed constant and Assumption 1 be satisfied. Then, the functions φ<sub>1</sub>(t, <sup>x</sup>[t−T ,t]) and φ<sub>2</sub>(t, <sup>x</sup>[t−T ,t]) can be designed as φ<sub>1</sub>(·)= − k<sub>4</sub>(t, x<sub>1</sub>[t−T <sub>,t]</sub>)|x1|1/2sign(x<sub>1</sub>) − k<sub>1</sub>k<sub>3</sub>x<sub>1</sub>

1 sign(x<sub>1</sub>)+ 3 k<sub>3</sub>|x1|1/2sign(x<sub>1</sub>)+ k<sup>2</sup> 2 2

φ<sub>2</sub>(·)= − k<sub>2</sub>(t)

3<sup>x1</sup>

where

![Formula block](doc:8e0334e/tier:flash/page:6/block:32)

![Formula block](doc:8e0334e/tier:flash/page:6/block:33)

k<sub>2</sub>(t)=

k3 =Δ1k2/3

1 ,k1=υ3/2+(α(δ<sub>2</sub>+δ<sub>3</sub>)<sup>2</sup>/ε+4ε(δ<sub>2</sub>+δ3))/β+Δ2

![Formula block](doc:8e0334e/tier:flash/page:6/block:37)

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

<!-- page 7 of 16 -->

DING et al.: PRESCRIBED-TIME CONTROL VIA PERIODIC DELAYED FEEDBACK-BASED SUPER-TWISTING SLIDING MODE ALGORITHM

1819

min (P)

![Formula block](doc:8e0334e/tier:flash/page:7/block:4)

![Formula block](doc:8e0334e/tier:flash/page:7/block:5)

in which δ<sub>i</sub>,i =1, 2, 3 are defined in Assumption 1

![Formula block](doc:8e0334e/tier:flash/page:7/block:7)

![Formula block](doc:8e0334e/tier:flash/page:7/block:8)

where Δ<sub>1</sub> > 0, Θ > 0,α> 0,β > 0,υ > 0,ε> 0,ι> 0, and 0 <r< 2Δ<sub>1</sub>Δ<sub>2</sub>ι are some constants, and K(k,h)(t) is defined in (8) and (9) with k = k<sub>1</sub>k<sub>3</sub>/2 − r/4.

In such case, the system (11) can be rewritten as

![Formula block](doc:8e0334e/tier:flash/page:7/block:11)

Theorem 2: Let T > 0 be a prescribed time. Consider the nonlinear system (36) under Assumption 1 with |x<sub>2</sub>(0)|≤ Θ.

Proof: It is not difficult to verify that |φ<sub>1</sub>(·)|≤ (k<sub>1</sub> +2K<sub>sta</sub> (t)+k<sub>1</sub>k<sub>3</sub>)(|x<sub>1</sub>(t − h)| + |x<sub>1</sub>(t)| + 1) and |φ<sub>2</sub>(·)|≤(μ +3μk<sub>3</sub> + μk<sup>2</sup><sub>3</sub>)(|x1(t)| + 1), which implies that the system(36)satisfies linear growth condition (6). Thus, according to Lemma 1, the forward completeness can be guaranteed.

For t ∈ [0, 2h], consider the Lyapunov function V<sub>1</sub>(x<sub>1</sub>)= x<sup>2</sup> 1/2. Then, by using (36), |x<sub>2</sub>(0)|≤ Θ and the Young’s inequality, its time-derivative can be calculated as

![Formula block](doc:8e0334e/tier:flash/page:7/block:15)

![Formula block](doc:8e0334e/tier:flash/page:7/block:16)

\+ |x<sub>1</sub>|(2hδ<sub>3</sub> + δ<sub>1</sub> + Θ)

≤− (2k1k3 − r)V1(x1(t)) − 23/4k1V 3/4(x1(t)) 1

− 4K(k,h)(t)V 1/4(x1(t − h))V 3/4(x1(t)) + D 1 1

where t ∈ [0, 2h]. According to Lemma 6, we know that V<sub>1</sub>(x<sub>1</sub>(2h)) ≤ D4/3/(2 k4/3), which implies 1

![Formula block](doc:8e0334e/tier:flash/page:7/block:21)

For t ∈ [2h,∞), define z<sub>1</sub> = x<sub>1</sub>,z<sub>2</sub> = x<sub>2</sub> + 1(t). Then, (36) can be rewritten as

<sup>z</sup>˙1 = − k<sub>1</sub>|z1|1/2sign(z<sub>1</sub>)−k<sub>1</sub>k<sub>3</sub>z<sub>1</sub>+z<sub>2</sub>

![Formula block](doc:8e0334e/tier:flash/page:7/block:24)

![Formula block](doc:8e0334e/tier:flash/page:7/block:25)

Consider the Lyapunov function V<sub>2</sub>(η)= η<sup>T</sup>Pη, with η = [|z1|1/2sign(z<sub>1</sub>)+ k<sub>3</sub>z<sub>1</sub>,z<sub>2</sub>]<sup>T</sup>. According to [18, Thm. 1], we know that V˙ 2|(38) ≤−σ1V 1/2(η) − σ<sub>2</sub>V<sub>2</sub>(η),t ∈ [2 h,∞), 2

where σ<sub>1</sub> = ελ1/2 min (P)/λ<sub>max</sub>(P),σ<sub>2</sub> =2εk3/λmax(P). Therefore, the settling time is bounded by

![Formula block](doc:8e0334e/tier:flash/page:7/block:28)

Besides, it is obtained from (37) that

![Formula block](doc:8e0334e/tier:flash/page:7/block:30)

e<sup>hσ</sup><sub>2</sub> − 1 ≥ hσ<sub>2</sub> + h<sup>2</sup>σ<sup>2</sup>

2/2

![Formula block](doc:8e0334e/tier:flash/page:7/block:33)

Substituting (41) into (39), we know that T<sub>0</sub>(z(0)) ≤ 4h = T , which implies η(t)=0, ∀t ≥T , that is, x<sub>1</sub>(t)=0,x<sub>2</sub>(t)+ 1(t)=0, ∀t ≥T .

Similar to Theorem 1, although the function V<sub>2</sub>(η) is not differentiable on the set {(η<sub>1</sub>,η<sub>2</sub>)∈R<sup>2</sup>|η<sub>1</sub> =0}, V<sub>2</sub>(η) can still be used as a Lyapunov function. The proof is finished.

## B. Case With Measurement Noise

In this section, similar to Section III-B, the sensitivity of the proposed method to the measurement noise is analyzed. In the presence of the measurement noise, the system (36) can be written as

![Formula block](doc:8e0334e/tier:flash/page:7/block:38)

where x<sub>m</sub> =<sup>[x</sup>m1<sup>,x</sup>2<sup>]T</sup> =<sup>[x</sup>1 + m(t),x<sub>2</sub>]T, m(t) is an unknown function representing the measurement noise satisfying Assumption 3, the constants k<sub>1</sub> and k<sub>3</sub>, the function k<sub>2</sub> : [0,∞) → R, and the function k4 : [0,∞) × C<sup>T</sup><sub>2</sub> → R are the same as (36), and the unknown functions j (t),j =1, 2 satisfy Assumption 1.

Similar to Corollary 1, the following corollary is given.

Corollary 2: Consider the nonlinear system (42) under Assumptions 1 and 3. Then, |x<sub>1</sub>(t)|≤ Ω<sub>2</sub>, |x<sub>2</sub>(t)+ 1(t)|≤ Ω1/2 2 , ∀t ∈ [T<sub>m2</sub>,∞), where T<sub>m2</sub> > 0 is a finite time, and Ω<sub>2</sub> ≥ 0 is a constant independent of initial values.

The proof of Corollary 2 is shown in Appendix.

## C. Numerical Examples

Case 1—Absence of measurement noise: Consider the nonlinear system (36) where 1(t)=0.2 sin(2t),2(t)= 0, and k<sub>1</sub>,k<sub>2</sub>(t),k<sub>3</sub>,k<sub>4</sub>(t, x<sub>1</sub>[t−T ,t]) are defined in Theorem 2 with T =3, Θ =0, Δ<sub>1</sub> = 16,ε =0.28,β =0.8,α = 0.001,ι =1.2,δ<sub>1</sub> =0.2,δ<sub>2</sub> =0.2,δ<sub>3</sub> =0, and K<sub>sta</sub>(t) is defined in (8), (9), (31), and (35).

For simulation, the initial values are set as x<sub>1</sub>(0) = 1,x<sub>2</sub>(0) = 0. The simulation results are shown in Fig. 3 with z = <sup>[z</sup>1<sup>,z</sup>2<sup>]T</sup> =[x<sub>1</sub>,x<sub>2</sub> +0.2 sin(t)]<sup>T</sup>, from which we can see that the state z converges to 0 within the prescribed time T =3s.

Case 2—Presence of measurement noise: Consider system (42). The system parameters, the initial values and the measurement noise are the same as those in Case 1. We still compare with the THF-based algorithm mentioned in Section III-C. The simulation results are shown in Fig. 4, from which we can see that the algorithm designed in Section IV-A outperforms the

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

<!-- page 8 of 16 -->

1820

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 71, NO. 3, MARCH 2026

![Image block](doc:8e0334e/tier:flash/page:8/block:3)

## Fig. 3. State z for the system (36).

![Image block](doc:8e0334e/tier:flash/page:8/block:5)

## Fig. 4. State z for the system (42) in the presence of measurement noise.

THF-based algorithm in terms of tolerance to the measurement noise.

## V. PRESCRIBED-TIME CONTROL BY STATE FEEDBACK

In this section, a continuous prescribed-time sliding mode control law is designed for the system (12) under Assumption 2.

Denote

![Formula block](doc:8e0334e/tier:flash/page:8/block:11)

where m =2, 3,...,n. Similar to [52], the system (12) can be rewritten as the following nonlinear system with matched

![Formula block](doc:8e0334e/tier:flash/page:8/block:13)

However, due to d<sub>i</sub>(t, ξ), z<sub>i</sub> cannot be obtained directly from ξ<sub>i</sub>,i =2, 3,...,n. Therefore, we will first design a disturbance observer for the system (44) to obtain the information of z<sub>i</sub>.

## A. Design of Disturbance Observer

In this section, a disturbance observer for (44) is designed by using Theorem 1. For the sake of convenience in subsequent statements, denote the comprehensive disturbance

ϑ<sub>i</sub>(t) as ϑ<sub>i</sub>(t)= i j=1 di−jdj (t, ξ)/dti−j ,i =1, 2, . . . , n. It can be easily deduced from Assumption 2 that |ϑi(t)|≤ Θi1 The observer design process is divided into n steps.

![Formula block](doc:8e0334e/tier:flash/page:8/block:18)

![Formula block](doc:8e0334e/tier:flash/page:8/block:19)

Step 1: Let T<sub>ob</sub> > 0 be a prescribed time. For z<sub>1</sub>, denote <sup>z</sup>¯1 = ξ<sub>1</sub>. Then, the disturbance observer can be designed as

![Formula block](doc:8e0334e/tier:flash/page:8/block:21)

where k<sub>m1</sub>(t)= k<sub>m</sub>(t),m =1, 2, 3, 4 are defined in (15) with h = T<sub>ob</sub>/(2n),δ<sub>1</sub> = Θ<sub>11</sub>,δ<sub>2</sub> = Θ<sub>12</sub>,δ<sub>3</sub> =0,x<sub>1</sub> =¯z<sub>1</sub> − zˆ<sub>1</sub>,x<sub>2</sub> = Dˆ1, and K(l4,h)(t) is set to 0 for all t ≥ 2h (done as Remark 3).

Step i, i =2, 3,...,n: For zi, denote z¯i = ξi − Dˆi−1. Then, the disturbance observer can be designed as

![Formula block](doc:8e0334e/tier:flash/page:8/block:24)

where w<sub>j</sub> = ξ<sub>j+1</sub>,w<sub>n</sub> = f(t, ξ)+ g(t, ξ)u, j =2,...,n − 1, and k<sub>mi</sub>(t)= k<sub>m</sub>(t) are defined in (15) with h = T<sub>ob</sub>/(2n), δ1 = Θi1,δ2 = Θi2,δ3 =0,x1 =¯zi − zˆi,x2 = Dˆi, and m = 1, 2, 3, 4, and K(l<sub>4</sub>,h)(t) is set to 0 for all t ≥ 2ih.

Based on the developments above, the following result can be drawn.

Theorem 3: Let Assumption 2 be satisfied. Consider observers (45) and (46). Then, zi(t)=ˆzi(t), Dˆi(t)= −ϑi(t), ∀t ≥ T<sub>ob</sub>,i =1, 2,...,n.

Proof: Similar to the design process, we also divide the proof into n steps.

Step 1: Denote <sup>z</sup>˜1 =¯z<sub>1</sub> − zˆ<sub>1</sub> = z<sub>1</sub> − zˆ<sub>1</sub>. Then, it is obtained from (43) to (45) that

![Formula block](doc:8e0334e/tier:flash/page:8/block:30)

According to Theorem 1, we know that z˜1(t) and Dˆ1(t) are bounded for allt ∈ [0,∞), and zˆ1(t)= z1(t), Dˆ1(t)= −ϑ1(t), ∀t ≥ 2h.

**Step** i, i =2, 3,...,n: Suppose that

![Formula block](doc:8e0334e/tier:flash/page:8/block:33)

Denote <sup>z</sup>˜i = z<sub>i</sub> − zˆ<sub>i</sub>. From (43) and (47), we know that z¯i(t)= z<sub>i</sub>(t), ∀t ≥ 2(i − 1)h, which implies <sup>z</sup>˜i =¯z<sub>i</sub> − zˆ<sub>i</sub>, ∀t ≥ 2(i − 1)h. Then, it is obtained from (43) to (45) that

![Formula block](doc:8e0334e/tier:flash/page:8/block:35)

According to Theorem 1, we know that z˜i(t) and Dˆi(t) are bounded for all t ∈ [0,∞), and zˆi(t)= zi(t), Dˆi = −ϑi(t), ∀t ≥ 2ih.

Observing from Step 1, it becomes evident that(47) holds with i =2. By induction, we can conclude that z<sub>i</sub>(t)=ˆz<sub>i</sub>(t), ∀t ≥ T<sub>ob</sub>,i =1, 2,...,n. The proof is finished.

## B. Design of Sliding Mode Control Law by Disturbance Observer-Based Feedback

In this section, a continuous prescribed-time sliding mode control law is designed for (12).

Let T> 0 be a prescribed time, and T<sub>ob</sub> ∈ (0,T) be the prescribed time for the disturbance observer. Then some hierarchical sliding variables can be designed as [57]

![Formula block](doc:8e0334e/tier:flash/page:8/block:41)

where a ≥ 0 is a constant, i =1, 2,...,n − 1

![Formula block](doc:8e0334e/tier:flash/page:8/block:43)

in which h<sub>1</sub> =(T − T<sub>ob</sub>)/(2n), and K(a,h<sub>1</sub>)(t) is defined in (8) and (9) with h = h<sub>1</sub>,R<sub>h1</sub> ∈ S(<sup>n</sup>)(h<sub>1</sub>). Since s<sub>i</sub>,i =0, 1,

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

<!-- page 9 of 16 -->

DING et al.: PRESCRIBED-TIME CONTROL VIA PERIODIC DELAYED FEEDBACK-BASED SUPER-TWISTING SLIDING MODE ALGORITHM

1821

...,n − 1 are not available, their observations are given as follows:

![Formula block](doc:8e0334e/tier:flash/page:9/block:4)

![Formula block](doc:8e0334e/tier:flash/page:9/block:5)

where zˆm0+1 is defined in (45) and (46), i =1, 2,...,n − 1, and m<sub>i</sub> =0, 1,...,n − i − 1.

Based on (49) and (50), a continuous prescribed-time sliding mode control law can be designed as u=g<sup>−1</sup>(·) −Ks(t)ˆsn−1,0(t − h1) − asˆn−1,0 − f(·)+ Dˆn

![Formula block](doc:8e0334e/tier:flash/page:9/block:8)

where Dˆn is defined in (46). Based on the developments above, the following result can be drawn.

Theorem 4: Let T> 0 be a prescribed time, and Assumption 2 be satisfied. Then, the closed-loop system consisting of (12) and (51) satisfies y(t)=0, ∀t ≥ T.

Proof: According to Theorem 3, we know that z<sub>i</sub>(t)= zˆi(t), Dˆi(t)= −ϑi(t), ∀t ≥ Tob,i =1, 2,...,n. Thus, it is obtained from (48) to (50) that si (mi) (t)=ˆsi,mi (t), ∀t ≥ Tob,i = 0, 1,...,n − 1,m<sub>i</sub> =0, 1 ...,n − i − 1.

Step 1: The convergence of s<sub>n−1</sub>. It follows from (48) and (51) that for all t ∈ [0,∞)

s˙n−1 = −asˆn−1,0 − Ks(t)ˆsn−1,0(t − h1)+ Dˆn + ϑn. (52) According to Theorem 3, ϑ˜n(t) Dˆn(t)+ϑn(t) and s˜n−1(t) s<sub>n−1</sub>(t)−sˆ<sub>n−1</sub>,0(t) are bounded. Thus, we know that <sup>s</sup>˙n−1 =−as<sub>n−1</sub>−K<sub>s</sub>(t)s<sub>n−1</sub>(t−h<sub>1</sub>)+Δ(t, <sup>s</sup>˜n−1[t−h<sub>1</sub>,t], ϑ˜n<sub>[t−h1,t]</sub>) where Δ(t, <sup>s</sup>˜n−1[t−h1,t], ϑ˜n[t−h1,t]) ϑ˜n(t)+ as˜n−1(t)+ K<sub>s</sub> (t)˜s<sub>n−1</sub>(t − h<sub>1</sub>). There exists a nonnegative bounded function Δ¯ (ϑ˜n(0), s˜n−1(0)) such that |Δ(t, <sup>s</sup>˜n−1[t−h<sub>1</sub>,t], ϑ˜n<sub>[t−h1,t]</sub>)|≤ Δ¯ (ϑ˜n(0), s˜n−1(0)), ∀t ∈ [0,∞). Similar to the proof of Lemma 5, s<sub>n−1</sub>(t) is bounded. Thus, the system (52) is forward complete.

Furthermore, based on (52), K<sub>s</sub>(t)=0, ∀t ∈ [T<sub>ob</sub>,T<sub>ob</sub> + h<sub>1</sub>] and sn−1 =ˆsn−1,0, Dˆn = −ϑn, ∀t ≥ Tob, we have s˙n−1(t)= −as<sub>n−1</sub>(t) − K<sub>s</sub>(t)s<sub>n−1</sub>(t − h<sub>1</sub>) ∀t ≥ T<sub>ob</sub>. (53) According to Lemma 3, we have s<sub>n−1</sub>(t)=0, ∀t ≥ T<sub>ob</sub> +2h<sub>1</sub>.

**Step** i, i =2, 3,...,n: Suppose that

![Formula block](doc:8e0334e/tier:flash/page:9/block:16)

It can be deduced from (48) that <sup>s</sup>˙n−i = −as<sub>n</sub>−<sub>i</sub> − K<sub>s</sub>(t)s<sub>n</sub>−<sub>i</sub> (t − h<sub>1</sub>), ∀t ≥ T<sub>ob</sub> + 2(i − 1)h<sub>1</sub>. Similar to Step 1, we have s<sub>n</sub>−<sub>i</sub>(t) is bounded and s<sub>n</sub>−<sub>i</sub>(t)=0, ∀t ≥ T<sub>ob</sub> +2ih<sub>1</sub>.

Observing from Step 1, it becomes evident that (54) holds with i =2. Therefore, by induction, we can conclude that s<sub>n</sub>−<sub>i</sub>(t) are bounded, and s<sub>n</sub>−<sub>i</sub>(t)=0, ∀t ≥ T<sub>ob</sub> +2ih<sub>1</sub>,i = 1, 2,...,n − 1. Thus, according to (48), we know the solutions of the closed-loop system consisting of (12) and (51) are bounded, which ensures the forward completeness. Besides, y(t)= ξ<sub>1</sub>(t)= s<sub>0</sub>(t)=0, ∀t ≥ T<sub>ob</sub> +2nh<sub>1</sub> = T. The proof is finished.

Remark 4: We provide some explanations on the settling time being exactly T of the closed-loop system consisting of (12) and (51). From (53), (54), and Lemma 3, the trajectory of the sliding variable s<sub>i</sub> with t ∈ [T<sub>ob</sub> + 2(i − 1)h<sub>1</sub>,T<sub>ob</sub> +2ih<sub>1</sub>] is given by ω<sub>n</sub>−<sub>i+1</sub>(λ<sub>n</sub>−<sub>i+1</sub>)=e−aλ<sup>n</sup>−<sup>i+1</sup> ω<sub>n</sub>−<sub>i+1</sub>(0), ∀λ<sub>n</sub>−<sub>i+1</sub> ∈ [0,h<sub>1</sub>] and ω<sub>n</sub>−<sub>i+1</sub>(λ<sub>n</sub>−<sub>i+1</sub>)= e−aλ<sub>n</sub>−<sub>i+1</sub> 1− e2asRh1 (s)dsW

λ<sub>n</sub>−<sub>i+1</sub> h<sub>1</sub>

× ω<sub>n</sub>−<sub>i+1</sub>(0) ∀λ<sub>n</sub>−<sub>i+1</sub> ∈ [h<sub>1</sub>, 2h<sub>1</sub>]

where λ<sub>n</sub>−<sub>i+1</sub> = t − T<sub>ob</sub> − 2(i − 1)h<sub>1</sub>,ω<sub>n</sub>−<sub>i+1</sub>(λ<sub>n</sub>−<sub>i+1</sub>)= ω<sub>n</sub>−<sub>i+1</sub>(t − T<sub>ob</sub> − 2(i − 1)h<sub>1</sub>)= s<sub>n</sub>−<sub>i+1</sub>(t) and i =1, 2,..., n. It follows that s<sub>n</sub>−<sub>i+1</sub>(t) =0, ∀t ∈ [T<sub>ob</sub> + 2(i − 1)h<sub>1</sub>,T<sub>ob</sub> +2ih<sub>1</sub>) if and only if ω<sub>n</sub>−<sub>i+1</sub>(0) =0, namely, s<sub>n</sub>−<sub>i+1</sub>(T<sub>ob</sub> + 2(i − 1)h) =0.

Remark 5: Here, the proposed method is compared with other methods for mismatched disturbances. In contrast to asymptotic, finite- and fixed-time control methods (see [16], [30], [52], and the references therein), the proposed method ensures that the system output converges to zero with the settling time being exactly equal to the prescribed time. In comparison to the THF-based method [21], the control gains required by the proposed method are bounded.

Remark 6: The approaches presented in this article introduce artificial delay terms, which may appear to require state values prior to t =0. However, it is crucial to emphasize that all delay terms in both the disturbance observer and the control law take the form “K<sub>h</sub>¯ (t)ζ(t − h¯),” where ζ is a variable related to ξ,h¯ is a constant related to the prescribed time and the periodic function K<sub>h</sub>¯ (t) represents the time-varying functions calculated based on Definition 3. Notably, it holds that K<sub>h</sub>¯ (t)=0, ∀t ∈ [0, h¯). Therefore, ζ(v),v ∈ [−h, ¯ 0) has no impact on the conclusion of Theorem 4, that is, the solutions depend only on the initial value ξ(0).

## C. Case With Measurement Noise

In this section, the sensitivity of the proposed method to the measurement noise is analyzed, that is, replace ξ in (45), (46), and (51) with ξ<sub>m</sub> =[ξ<sub>m1</sub>,ξ<sub>m2</sub>,...,ξ<sub>mn</sub>]<sup>T</sup>, where ξ<sub>mi</sub> = ξ<sub>i</sub> + m<sub>i</sub>(t),i =1, 2,...,n, and m<sub>i</sub>(t) are some unknown functions representing the measurement noise.

Assumption 4: The measurement noise m<sub>i</sub>(t) is uniformly bounded, and |m<sub>i</sub>(t)|≤ ε<sub>0</sub>,i =1, 2,...,n, where ε<sub>0</sub> is an unknown constant.

Corollary 3: Let Assumption 4 be satisfied. The closedloop system consisting of the system (12) with f(t, ξ)=0 and g(t, ξ)=1, the disturbance observer (45) and (46), and the sliding mode control law (51), satisfies that |y(t)|≤ Ω<sub>3</sub>, ∀t ∈ [T<sub>m3</sub>,∞), where T<sub>m3</sub> > 0 is a finite time, and Ω<sub>3</sub> ≥ 0 is a constant independent of initial values.

The proof of Corollary 3 is shown in Appendix.

## D. Simulation Example

Consider the trajectory tracking control of a one-link manipulator actuated by a brush dc motor [10], whose dynamics can be written as

Mq¨+ Bq˙ + N sin(q)= I + Δ<sub>I</sub>

![Formula block](doc:8e0334e/tier:flash/page:9/block:33)

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

<!-- page 10 of 16 -->

1822

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 71, NO. 3, MARCH 2026

![Image block](doc:8e0334e/tier:flash/page:10/block:3)

Fig. 5. State ξ, observation error z˜, and control input u for the system (56).

where q is the angular motor position, I is the motor armature current, u is the control input used to represent the motor torque, Δ<sub>I</sub> represents the torque disturbance, and M, B, N, L, R, and K<sub>B</sub> are some constants represent the system parameters. Denote the smooth desired reference signal as y<sub>d</sub>(t)=(π/2) sin(t)(1 −

![Formula block](doc:8e0334e/tier:flash/page:10/block:6)

sin(q)/M + I/M − y¨d(t)]<sup>T</sup>. Then, (55) can be rewritten as

![Formula block](doc:8e0334e/tier:flash/page:10/block:8)

where F(t, q, q, I ˙ )= −N cos(q)˙q/M − RI/(LM) − K<sub>B</sub>q/˙ (LM) − ... y d(t)+ B<sup>2</sup>q/M˙ 2 + BN sin(q)/M<sup>2</sup> − BI/M<sup>2</sup>. Notice that (56) has the same form as (12) with d<sub>1</sub>(t, ξ)=0,d<sub>2</sub> (t, ξ)= ΔI /M, d3(t, ξ)=−BΔI /M2,f(t, ξ)= F(t, q, q, I ˙ ), and g(t, ξ)=1/(LM).

For simulation, following [31], the system parameters are chosen as M =1,B =1,N = 10,L =0.05,R =0.5 and K<sub>B</sub> = 10. The torque disturbance and the initial conditions are chosen as Δ<sub>I</sub> =0.3 sin(t) and q(0) = −0.5, q˙(0) = −1,I(0) = 0.4. According to Theorem 4, the prescribed time and the observer parameters for z<sub>i</sub>,i =1, 2, 3 [defined in (43)] are set as T = 15 s,T<sub>ob</sub> =3s,a =2,b = −1,c =1,l<sub>4</sub> = 0.5,δ<sub>1</sub> =0.6,δ<sub>2</sub> =0.6, zˆ<sub>1</sub>(0) = 0, zˆ<sub>2</sub>(0) = 0, zˆ<sub>3</sub>(0) = 0, and K(l<sub>4</sub>,h)(t) is defined in (8), (9), and (31). The controller parameters are set as a =0.4 and K<sub>s</sub>(t) is defined in (8) and (9) with (we only consider t ∈ [0, 2h])

![Formula block](doc:8e0334e/tier:flash/page:10/block:11)

The state ξ, observation error z˜ and control u of the system (56) without measurement noise are shown in Fig. 5. It can be seen from Fig. 5 that the output y = ξ<sub>1</sub> can track the reference signal y<sub>d</sub> at the prescribed time T = 15 s, while the observation error z˜ of the disturbance observer can converge to 0 within T<sub>ob</sub> =3s. In order to test the sensitivity of the proposed method to the measurement noise, we replace q, q˙ and I with q<sub>m</sub> = q + m(t), q˙m =˙q + m(t) and I<sub>m</sub> = I + m(t), where m(t) is the bandlimited white noise. The simulation results are shown in Fig. 6,

![Image block](doc:8e0334e/tier:flash/page:10/block:13)

Fig. 6. State ξ for the system (56) in the presence of the measurement noise m.

from which we can see that the system output y can still converge to a small area around the equilibrium.

## VI. PRESCRIBED-TIME CONTROL BY OUTPUT FEEDBACK

In this section, a continuous prescribed-time sliding mode control law is designed via output feedback for the system (12) with n =2,f(t, ξ)=0 and g(t, ξ)=1. In this case, the system (12) can be rewritten in the form of the following perturbed double integrator system

![Formula block](doc:8e0334e/tier:flash/page:10/block:18)

where ξ =[ξ<sub>1</sub>,ξ<sub>2</sub>]<sup>T</sup> ∈ R<sup>2</sup> is the state vector, u ∈ R is the control input, y ∈ R is the output, and d<sub>i</sub>(t, ξ) : [0,∞) × R<sup>2</sup> → R,i =1, 2 are unknown functions satisfying Assumption 2.

Similar to (43), we denote z<sub>1</sub> = ξ<sub>1</sub>,z<sub>2</sub> = ξ<sub>2</sub> + d<sub>1</sub>(t, ξ). Then,

![Formula block](doc:8e0334e/tier:flash/page:10/block:21)

## A. Design of State Observer

Let T<sub>ob</sub> > 0 be a prescribed time. The observer can be designed as

![Formula block](doc:8e0334e/tier:flash/page:10/block:24)

where z˜ = z<sub>1</sub> − zˆ<sub>1</sub>,ω=(y(t)−θ(t))/l−k<sub>5</sub>(t)(y(t−l) − θ(t− l))/l, ¨θ=u, θ(0)= ˙ θ(0)= 0,k<sub>6</sub>(·)=k<sub>1</sub>+2K<sub>ob</sub>(t)|z˜1(t−h)|1/2

t ∈ [0,l] ⎧⎨⎩0,0,1,(t − l)2/l2,t ∈ (l, 2l) t ∈ [2l,∞) t ∈ [0, 2l]

k<sub>5</sub>(t)=

K<sub>ob</sub>(t)=

K<sub>sta</sub>(t − 2l),t ∈ (2l,∞)

![Formula block](doc:8e0334e/tier:flash/page:10/block:30)

in which 0 <l<T<sub>ob</sub>/2 and T = T<sub>ob</sub> − 2l are two constants, h, k<sub>1</sub>,k<sub>2</sub>(t),k<sub>3</sub>, and K<sub>sta</sub>(t) are defined in Theorem 2 with δ<sub>1</sub> = 2D<sub>1</sub>,0 + (3l +4h)D2,0/2,δ2 =2D<sub>1</sub>,0/l + D<sub>2</sub>,0,δ<sub>3</sub> = D<sub>1</sub>,1 + D<sub>2</sub>,0, Θ =2l(D<sub>1</sub>,1 + D<sub>2</sub>,0).

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.