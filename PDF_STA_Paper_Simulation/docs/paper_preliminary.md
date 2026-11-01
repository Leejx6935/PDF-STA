<!-- page 1 of 16 -->

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 71, NO. 3, MARCH 2026

1813

![Formula block](doc:8e0334e/tier:flash/page:1/block:3)

# Prescribed-Time Control via Periodic Delayed Feedback-Based Super-Twisting Sliding Mode Algorithm

Yi Ding , Bin Zhou , Senior Member, IEEE, and Yang Shi , Fellow, IEEE

**Abstract—This article investigates the problem of prescribed-time control via continuous sliding mode control laws. First, within the framework of the periodic delayed feedback approach, two novel super-twisting algorithms are proposed, whose settling times are bounded by a constant independent of the initial conditions and can be arbitrarily prescribed. Next, for a class of high-order uncertain nonlinear systems, a novel disturbance observer and a prescribed-time continuous sliding mode control law are designed based on the first super-twisting algorithm. Furthermore, for a class of perturbed double integrator systems, a novel state observer and a prescribed-time continuous sliding mode control law by output feedback are designed based on the second super-twisting algorithm. Unlike the widely used time-varying high-gain feedback approach in the literature, the control laws designed in this article ensure that the system output converges to zero with the settling time being exactly equal to the prescribed time, even in the presence of both matched and mismatched disturbances, while mitigating sensitivity to measurement noise and avoiding the singularity issues caused by infinite gain. Finally, the effectiveness of the proposed approaches is demonstrated through simulations.**

**Index Terms—Output feedback, periodic delayed feedback (PDF), prescribed-time control, sliding mode control, super-twisting algorithm (STA).**

## I. INTRODUCTION

T HE sliding mode control method has gained widespread application due to its notable advantages, including robustness to matched uncertainties, reduced-order system characteristics, and straightforward implementation of controllers [47], [54]. However, sliding mode control also has some limitations,

Received 29 March 2025; revised 24 July 2025; accepted 1 October 2025. Date of publication 7 October 2025; date of current version 2

## March 2026. This work was supported in part by the National Natural Science Foundation of China for Distinguished Young Scholars under Grant 62125303, in part by the Natural Science Foundation of China - “Qisun Ye” Science Foundation under Grant U2441243, and in part by the National Natural Science Foundation of China under Grant 62573165, Grant 62173111, and Grant 62188101. Recommended by

Associate Editor D. Efimov. (Corresponding author: Bin Zhou.)

Yi Ding and Bin Zhou are with the Center for Control Theory and Guidance Technology, Harbin Institute of Technology, Harbin 150001, China, and also with the National Key Laboratory of Complex System Control and Intelligent Agent Cooperation, Harbin 150001, China (e-mail: [24B304023@stu.hit.edu.cn](mailto:24B304023@stu.hit.edu.cn); [binzhou@hit.edu.cn](mailto:binzhou@hit.edu.cn)).

Yang Shi is with the Department of Mechanical Engineering, University of Victoria, Victoria, BC V8W 2Y2, Canada (e-mail: [yshi@uvic.ca](mailto:yshi@uvic.ca)).

Digital Object Identifier 10.1109/TAC.2025.3618707

including the necessity for the system’s relative order with respect to the sliding mode surface to be 1, and the occurrence of detrimental chattering phenomena during the control process [6], [50].

To address the aforementioned issues, the high-order sliding mode (HOSM) algorithm has been developed and widely applied. It retains the advantages of traditional sliding mode control while overcoming its shortcomings[14], [26]. One of the most popular HOSM algorithms is the STA, which is introduced in [27]. The classic STA has the following form:

![Formula block](doc:8e0334e/tier:flash/page:1/block:18)

where x =<sup>[x</sup>1<sup>,x</sup>2<sup>]T</sup> ∈ R<sup>2</sup> is the state, x(0) = x<sub>0</sub>, and k<sub>i</sub>,i = 1, 2 are two constants. Since the right-hand side of (1) is discontinuous, its solutions are understood in the sense of Filippov [15].

In the early stages, the finite-time convergence and robustness of (1) lacked Lyapunov-based proofs, and the settling time of (1) was difficult to estimate (see, for example, [27] and [28]). With the development of STA, some scholars have proposed proof methods based on strict Lyapunov functions and provided corresponding methods for estimating the settling time (see [37], [43], and [45]). Among them, the method proposed in [37]is particularly well-regarded and has inspired numerous subsequent works (see, for example, [1], [12], [13], [17], [19], [23], [38], and references therein). However, this method has an inherent drawback: The estimated settling time of system (1) given by this method cannot be made arbitrarily small, which is proven in Section II.

Some scholars have improved the classical STA by adding linear terms (see, for example, [18] and [35]). These works further enhance the convergence speed of STA. By collectively adjusting the gains of these linear terms, the settling time can be arbitrarily adjusted within (0,∞), thus addressing the aforementioned limitation. However, the settling time estimated in these works is always related to the initial value of the system. Because of the unavailability of the initial value, it is still impossible to adjust the settling time to the expected value, which limits the practical application of these methods.

It is worth mentioning that some fixed-time STAs allow for arbitrary tuning of the settling time, which is independent of the initial values (see [7] and [39]). However, these fixed-time STAs have not been rigorously proven using the Lyapunov method. In addition, while the aforementioned fixed-time STA algorithms ensure that the settling time is independent of the initial values, it still has complex functional relationships with

1558-2523 © 2025 IEEE. All rights reserved, including rights for text and data mining, and training of artificial intelligence and similar technologies. Personal use is permitted, but republication/redistribution requires IEEE permission. See https://www.ieee.org/publications/rights/index.htmlfor more information.

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

<!-- page 2 of 16 -->

1814

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 71, NO. 3, MARCH 2026

numerous controller parameters, making it difficult to design the settling time as an arbitrary desired value.

Recently, the prescribed-time control method based on timevarying high-gain feedback (THF) has attracted significant attention from researchers, and has yielded many interesting results (see, for example, [20], [25], [29], [49], and the references therein). Some novel STAs based on the THF are proposed in [48] and [55], which ensure that the (estimated) settling time can be predetermined to any value in (0,∞), with rigorous Lyapunov-based proofs. However, the THF has an inherent drawback: the gain keeps increasing over time and becomes infinite at a prescribed time, thereby leading to the lack of a well-defined controller at the prescribed time. Moreover, an excessively high control gain increases the control systems’ sensitivity to the measurement noise.

Of particular relevance to this article, a periodic delayed feedback (PDF) framework proposed in [56] can achieve control effects similar to those of the THF, and can avoid its inherent singularity problem. Drawing inspiration from [56], some interesting results have emerged over the past few years (see, for example, [11], [57], and [58]). Leveraging the advantages of the PDF, there is potential to propose a novel STA within the PDF framework, aiming to address the shortcomings of existing STAs mentioned above. Briefly, the major contributions of this article can be stated as follows.

1) Two novel STAs based on PDF are proposed, offering the following notable properties: i) The (estimated) settling time is independent of the initial value. ii) The proposed STA directly incorporates the settling time as a controller parameter. iii) The (estimated) settling time can be arbitrarily prescribed within the interval (0,∞). iv) Lyapunov-based proofs are provided.

2) Based on the first STA proposed in this article, a novel disturbance observer is designed for a class of high-order uncertain nonlinear systems. This disturbance observer can effectively address both matched and mismatched disturbances, and ensure that the observation error converges to zero within an arbitrarily prescribed time.

3) This article introduces a novel continuous prescribedtime sliding mode control law, which is designed through the aforementioned disturbance observer. The proposed control law can ensure that the system output converges to 0 with the settling time being exactly equal to the prescribed time. Furthermore, the proposed control law is continuous, thereby mitigating the chattering problem.

4) Based on the second STA proposed in this article, a novel state observer is designed for a class of perturbed double integrator systems. Subsequently, a novel continuous prescribed-time sliding mode control law by output feedback is designed. The state observer and the sliding mode control law use only the output information of the system, and the advantages mentioned in 2) and 3) are still retained.

The rest of this article is organized as follows. The problem formulation and the motivation are proposed in Section II. Two novel STAs are then, respectively, established in SectionsIII and IV. A novel continuous prescribed-time sliding mode control law for a class of high-order uncertain nonlinear systems is proposed in Section V. A novel continuous prescribed-time

sliding mode control law by output feedback for a class of perturbed double integrator systems is proposed in Section VI. Finally, Section VII concludes this article.

Notations: For any x ∈ R<sup>n</sup>, we denote <sup>x</sup>[a,b] = x(s + b),s ∈ [−b + a, 0], C<sup>h</sup><sub>n</sub> is the set of continuous functions ψ :[−h, 0] → R<sup>n</sup> with h> 0. For a symmetric matrix P, we use λ<sub>max</sub>(P) and λ<sub>min</sub>(P) to denote, respectively, its maximal and minimal eigenvalues, and use the symbol ∗ to indicate a symmetric element. Moreover,P ()0 refers to thatP is positive definite (semidefinite). Let I<sub>n</sub> denote the nth order identity matrix. The combinatorial number formed by nonnegative integers n ≥ m is denoted by C<sup>m</sup><sub>n</sub> .

## II. MOTIVATION AND PROBLEM STATEMENT

We begin by presenting some representative STAs and then analyze the shortcomings of the existing methods. For the proof of finite time convergence and stability of system (1), a widely used approach is proposed in [37], which utilizes the strict Lyapunov function V (η)= η<sup>T</sup>Pη, where η = [|x1|1/2sign(x<sub>1</sub>),x<sub>2</sub>]<sup>T</sup>, and

![Formula block](doc:8e0334e/tier:flash/page:2/block:15)

is a positive definite matrix, in which a> 0,c> 0,b< 0, ac > b<sup>2</sup>. We know that the system (1) is finite-time stable if (see [37, Thm. 1])

![Formula block](doc:8e0334e/tier:flash/page:2/block:17)

and the settling time is bounded by T(x<sub>0</sub>)=2V 1/2(η(0))/

σ, σ = λ1/2

min (P)λ<sub>m</sub>in(Q)/λmax(P).

However, there is a limitation in the above method: the estimated settling time T(x<sub>0</sub>) cannot be adjusted arbitrarily in (0,∞) by adjusting the control gains k<sub>1</sub> and k<sub>2</sub>. A brief proof is given below.

It can be seen that

![Formula block](doc:8e0334e/tier:flash/page:2/block:23)

which implies 0 < λ<sub>min</sub>(Q) ≤−b. Besides, it is obtained from ac > b<sup>2</sup> that(a + c)2 >a<sup>2</sup> + c<sup>2</sup> +2b<sup>2</sup> > 2b<sup>2</sup>, namely, a + c> −√2b. Thus, we get

2λ<sub>max</sub>(P) λ<sub>min</sub>(Q) (η<sup>T</sup>(0)η(0))1/2

T(x<sub>0</sub>) ≥

## a + c + √a<sup>2</sup> − 2ac +4b<sup>2</sup> + c<sup>2</sup>

−b

(η<sup>T</sup>(0)η(0))1/2

≥

≥ √2(η<sup>T</sup>(0)η(0))1/2

which implies that T(x0) can be adjusted at most in the interval [√2(η<sup>T</sup>(0)η(0))1/2,∞).

Remark 1: It is important to note that T(x<sub>0</sub>) here represents the estimated settling time rather than the actual settling time. Intuitively, increasing the control gains k<sub>1</sub> and k<sub>2</sub> can indeed accelerate convergence and may even make the actual settling time arbitrarily small. However, within the framework of this method, the improvement in the convergence rate cannot be precisely quantified. Therefore, while the estimated settling time T(x<sub>0</sub>) is more practically meaningful, it cannot be made arbitrarily small, as mentioned earlier.

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

<!-- page 3 of 16 -->

DING et al.: PRESCRIBED-TIME CONTROL VIA PERIODIC DELAYED FEEDBACK-BASED SUPER-TWISTING SLIDING MODE ALGORITHM

1815

A variable-gain STA was proposed in [18], based on the criterion V˙ (η) ≤−σ1V 1/2(η) − σ<sub>2</sub>V (η). The corresponding settling time can be estimated as

![Formula block](doc:8e0334e/tier:flash/page:3/block:4)

It is evident that although the settling time can be made arbitrarily small by increasing the coefficient σ<sub>2</sub>, T(x<sub>0</sub>) is still influenced by the initial conditions in this STA.

As for the fixed-time STAs in [7] and [39], there is no stability proof method based on Lyapunov functions. For the prescribedtime STAs proposed in [48] and [55], as mentioned earlier, they suffer from the singularity issue and the drawback of sensitivity to the measurement noise due to the infinite gain. Given the aforementioned analysis, the primary objective of this article is to propose novel STAs that are capable of overcoming all the mentioned drawbacks. Subsequently, we will apply the proposed STAs to the design of sliding mode control laws. To this end, some preparatory work is required.

Consider the following nonlinear time-delay system:

![Formula block](doc:8e0334e/tier:flash/page:3/block:8)

where x ∈ Rn is the state and f : [0,∞) × C<sup>h</sup><sub>n</sub> → Rn is a measurable and locally essentially bounded function.

Definition 1 (See [9]): The function x(t) defined on a nondegenerate interval I ⊆ [−h,∞) is called a Filippov solution for system (4), if it is absolutely continuous (AC) on any subinterval [t<sub>1</sub>,t<sub>2</sub>] of I, and for almost everywhere t ∈ I

![Formula block](doc:8e0334e/tier:flash/page:3/block:11)

where μ(N) is the Lebesgue measure of set N, intersection is taken over all sets N of measure zero and over all ρ> 0, B(x<sub>[t−h,t]</sub>,ρ)

![Formula block](doc:8e0334e/tier:flash/page:3/block:13)

n|sup<sub>t</sub>−<sub>h</sub>≤s≤t z(s) −

x(s)≤ ρ}, co¯ [E] is the closure of the convex hull of some set E. The initial value is given as x[−h,0] = φ<sub>[−h,0]</sub>,φ<sub>[−h,0]</sub> ∈ C<sup>h</sup><sub>n</sub>.

Remark 2: Since f is measurable and locally essentially bounded, the set-valued map F is upper semicontinuous and takes nonempty, convex and compact values (see [3, Prop. 1, p. 102]), that is, F satisfies the basic assumptions. Then, according to [24, Thm. 4.1, p. 123], there exists a constant tφ ∈ (0,∞] such that the system (4) has at least one solution defined on [0,tφ). Any solution of the differential inclusion (5) diverges to infinity in finite time or is defined on [−h,∞) (see [33, Remark 1]). Furthermore, the differential inclusion (5) is forward complete if, for all φ ∈ C<sup>h</sup> n, all solutions are defined for all t ∈ [−h,∞) [36].

Lemma 1 (See [22]): Let F satisfy the basic assumptions. The system (4) is forward complete if there exist Lebesgue integrable functions M(t) and N(t) such that the linear growth condition

![Formula block](doc:8e0334e/tier:flash/page:3/block:18)

holds for a.e. t ∈ [0,∞).

Moreover, as shown in [2], [32, Thm. III.1] and [40, Thm. 10], the forward completeness can be analyzed by using Lyapunov functions. Accordingly, this article also employs Lyapunovbased methods to verify the forward completeness of systems that satisfy the basic assumptions but do not fulfill the linear growth condition (6).

Let the origin be an equilibrium of system (4), i.e., 0 ∈ F(t, 0). The system (4) may have nonunique solutions and may admit both weak and strong stability (see [15]). This article deals only with the strong stability, which asks for stable behavior of all solutions of the system (4).

Lemma 2 (See [5]): Let F satisfy the basic assumptions. The system (4) is globally stable if there exists a continuous, positive definite, and radially unbounded function V : [0,∞) × R<sup>n</sup> → R such that for each solution x(t) and for all t<sub>1</sub>,t<sub>2</sub> ∈ [0,∞), it holds that V (t<sub>1</sub>,x(t<sub>1</sub>)) ≤ V (t<sub>2</sub>,x(t<sub>2</sub>)) when t<sub>2</sub> ≤ t<sub>1</sub>.

Building upon the fixed-time stability definition proposed in [41] and [42], the following definition for system (4) is presented.

Definition 2: System (4) is fixed-time stable (FxTS) with the settling time T< ∞ if it is globally stable and T<sub>0</sub>(φ) ≤ T, where T<sub>0</sub>(φ) = inf{T∗ ≥ 0: x(t)=0,x<sub>[−h,0]</sub> = φ, ∀t ≥ T∗} is the settling time of (4) with initial condition φ, in which x(t) is an arbitrary Filippov solution.

Then some results are given for later use.

Definition 3 (See [56]): Let m ≥ 0 be an integer and l> 0 be a constant. A function H<sub>l</sub>(·): R → R is termed an S(<sup>m</sup>)(l) function if

1) H<sub>l</sub>(·) is 2l-periodic and H<sub>l</sub>(t)=0 for all t within [0,l], 2) for allt within [l, 2l], H<sub>l</sub>(t)remains non-negative, and there exists an l∗ ∈ (l, 2 l), such that H<sub>l</sub>(t) > 0, ∀t ∈ [l∗, 2 l), and

3) Hl ∈ Cm, which implies H(i) l (l)= H(i) l (2 l)=0,i = 0, 1, . . . , m.

Lemma 3 (See [56]): Consider the following scalar system:

![Formula block](doc:8e0334e/tier:flash/page:3/block:30)

where x ∈ R is the state, φ ∈ C<sup>h</sup><sub>1</sub> represents the initial condition, k, h > 0 are two constants, and K(k,h)(t) is a 2h-periodic

![Formula block](doc:8e0334e/tier:flash/page:3/block:32)

in which W = W<sup>−1</sup> c (a, h) is defined by

![Formula block](doc:8e0334e/tier:flash/page:3/block:34)

with R<sub>h</sub>(t) ∈ S(<sup>r</sup>)(h), r ≥ 0 is an integer. Then, the system (7) is FxTS with the settling time 2h.

Lemma 4 (See [11]): Let F satisfy the basic assumptions. If there exists a positive definite and radially unbounded function V (t, x(t)), as an AC function of t on each compact subinterval of [0,∞), such that

![Formula block](doc:8e0334e/tier:flash/page:3/block:37)

for a.e. t ≥ 0, where k, h>0 and τ ∈(0, 1) are some constants, and K(k,h)(t) is defined in (8) and (9). Then, the system (4) is FxTS with the settling time less than or equal to 2h.

Proof: Since V (t, x(t)) is an AC function of t on each compact subinterval of [0,∞) and V˙ (t, x(t)) ≤ 0, a.e.t ≥ 0, V (t, x(t)) is a monotonically nonincreasing function [4]. It follows from Lemma 2 that the system (4) is globally stable. Moreover, since an AC function is the integral of its derivative, it follows from (10) and [11, Thm. 1] that V (t, x(t)) = 0 for all

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

<!-- page 4 of 16 -->

1816

IEEE TRANSACTIONS ON AUTOMATIC CONTROL, VOL. 71, NO. 3, MARCH 2026

t ≥ 2h, which further implies that x(t)=0 for all t ≥ 2h. The proof is finished.

Lemma 5: Consider the following time-delay scalar system:

x˙ = −kx − K(k,h)(t)x(t − h)+ Δ(t),x<sub>[−h,0]</sub> ∈ φ where x ∈ R is the state, φ ∈ C<sup>h</sup><sub>1</sub> is the initial condition, k, h > 0 are two constants, K(k,h)(t) is defined in (8) and (9), and Δ(t) is a time-varying function satisfying |Δ(t)|≤ Δ¯ , in which Δ¯ > 0 is an unknown constant. Then, x(t) is bounded for all t ∈ [0,∞), and |x(t)|≤ Ω, ∀t ≥ 2h, where Ω > 0 is a constant dependent on Δ¯ but independent of the initial values.

The proof of Lemma 5 is shown in the Appendix.

Lemma 6: Let F satisfy the basic assumptions. If there exists a positive definite and radially unbounded function V (t, x(t)), as an AC function oft on each compact subinterval of [0,∞), satisfying (10) when V (t, x(t))≥Γ, where Γ >0 is a constant, then the system (4) is forward complete and V (t, x(t)) ≤ Γ, ∀t ≥ 2h.

Proof: We first prove the forward completeness of system (4). As shown in Remark 2, since F satisfies the basic assumptions, the local existence of the solutions for system (4) can be guaranteed. Suppose that there exists at least one solution xφ(t) that diverges to infinity as t tends to t<sub>1</sub>, where t<sub>1</sub> ∈ (0,∞) is a constant. It follows that V (t, xφ(t)) diverges to infinity asttends to t<sub>1</sub>. Since xφ(t) is continuous, there must exist t<sub>2</sub> ∈ (0,t<sub>1</sub>) such that V (t, xφ(t)) ≥ L, ∀t ∈ [t<sub>2</sub>,t<sub>1</sub>). Thus, we know that V˙ (t, xφ(t)) < 0, a.e.t ∈ [t<sub>2</sub>,t<sub>1</sub>), which implies V (t, xφ(t)) is bounded for all t ∈ [t<sub>2</sub>,t<sub>1</sub>). This contradicts the assumption. Therefore, the solutions of system (4) cannot diverge to infinity in finite time, which implies that the system (4) is forward complete.

Next, we prove that V (t, x(t)) ≤ Γ, ∀t ≥ 2h. Suppose that V (t, x(t)) > Γ, ∀t ∈ [0, 2h]. Given that (10) holds for a.e. t ∈ [0, 2h], it follows from Lemma 4 that V (2h, x(2h)) = 0, which contradicts with the assumption. Thus, there exists a constant t<sub>1</sub> ∈ [0, 2h] such that V (t<sub>1</sub>,x(t<sub>1</sub>)) ≤ Γ. Furthermore, noting that V˙ (t, x(t)) < 0, ∀V (t, x(t)) ≥ Γ, we can conclude that V (t, x(t)) ≤ Γ, ∀t ≥ t<sub>1</sub>, which implies V (t, x(t)) ≤ Γ, ∀t ≥ 2h. The proof is finished.

Lemma 7: Let F satisfy the basic assumptions. If there exists a positive definite and radially unbounded function V (t, x(t)), as an AC function of t on each compact subinterval of [0,∞), satisfying V˙ (t, x(t)) ≤−σ1V 1/2(t, x(t)) − σ<sub>2</sub>V (t, x(t)) when V (t, x(t)) ≥ Γ, where Γ > 0,σ<sub>i</sub> > 0,i = 1, 2 are some constants, then the system (4) is forward complete and V (t, x(t)) ≤ Γ, ∀t ≥ T(x<sub>0</sub>), in which T(x<sub>0</sub>) is defined in (3).

Lemma 7 can be proved directly from [46, Lemma 2] by following the proof of Lemma 6. It is omitted.

Based on the above preparations, for an arbitrary prescribed constant T∈ (0,∞), this article first proposes two novel STAs by PDF, both of which possess the following form:

![Formula block](doc:8e0334e/tier:flash/page:4/block:13)

where x =<sup>[x</sup>1<sup>,x</sup>2<sup>]T</sup> ∈ R<sup>2</sup> is the state vector, i(t) ∈ R,i = 1, 2 are two unknown nonlinear functions satisfying Assumption 1, and φ<sub>i</sub>(t, <sup>x</sup>[t−T ,t]) ∈ R,i =1, 2 are two functions to be designed such that x<sub>1</sub>(t)=0 and x<sub>2</sub>(t)+ 1(t)=0, ∀t ∈ [T ,∞).

Assumption 1: The unknown nonlinear functions i(t),i = 1, 2 satisfy |1(t)|≤ δ<sub>1</sub>, |˙1(t)|≤ δ<sub>2</sub>, |2(t)|≤ δ<sub>3</sub>, where δ<sub>i</sub> ≥ 0,i =1, 2, 3 are three known constants.

Next, consider the following nonlinear system [16]:

![Formula block](doc:8e0334e/tier:flash/page:4/block:17)

where ξ =[ξ<sub>1</sub>,ξ<sub>2</sub>,...,ξ<sub>n</sub>]<sup>T</sup> ∈ R<sup>n</sup> is the state, u ∈ R is the control, y ∈ R is the output, f(t, ξ) : [0,∞) × R<sup>n</sup> → R and g(t, ξ)(= 0) : [0,∞) × R<sup>n</sup> → R are known functions, and d<sub>i</sub>(t, ξ) : [0,∞) × R<sup>n</sup> → R,i =1, 2,...,n are unknown functions satisfying Assumption 2.

Assumption 2: The unknown nonlinear functions d<sub>i</sub>(t, ξ), i =1, 2,...,n in (12) satisfy |djdi(t, ξ)/dtj |≤ Di,j , where D<sub>i</sub>,j ,j =0, 1,...,n − i +1 are some known constants.

We will use the proposed STAs to design continuous sliding mode control laws for (12) such that y(t)= 0, ∀t ≥ T, where T ∈ (0,∞) is an arbitrary prescribed constant.

## III. STA BY PDF: THE FIRST METHOD

In this section, we restrict the functions φ<sub>1</sub>(t, <sup>x</sup>[t−T ,t]) and φ<sub>2</sub>(t, <sup>x</sup>[t−T ,t]) to the following forms:

φ<sub>1</sub>(·)= − k<sub>1</sub>(t, <sup>x</sup>[t−T <sub>,t]</sub>)|x1|1/2sign(x<sub>1</sub>) − k<sub>2</sub>(t, <sup>x</sup>[t−T ,t])x<sub>1</sub> φ<sub>2</sub>(·)= − k<sub>3</sub>(t, <sup>x</sup>[t−T <sub>,t]</sub>)sign(x<sub>1</sub>) − k<sub>4</sub>(t, <sup>x</sup>[t−T ,t])x<sub>2</sub> where k<sub>i</sub>(t, <sup>x</sup>[t−T ,t]) ∈ R,i =1, 2, 3, 4 are some functions to be designed. Then, the system (11) can be rewritten as

![Formula block](doc:8e0334e/tier:flash/page:4/block:24)

## A. Design of STA

We begin by defining the following functions for later use:

![Formula block](doc:8e0334e/tier:flash/page:4/block:27)

where P is defined in (2), and

![Formula block](doc:8e0334e/tier:flash/page:4/block:29)

are some constants with a, b, and c defined in (2), in which v¯ = l<sub>4</sub>δ<sub>1</sub> + δ<sub>2</sub> + δ<sub>3</sub>.

The time-varying functions k<sub>i</sub>(t, <sup>x</sup>[t−T <sub>,t]</sub>),i =1, 2, 3, 4 are designed as

![Formula block](doc:8e0334e/tier:flash/page:4/block:32)

where Δ(t)= |k<sub>4</sub>(·)|δ<sub>1</sub> + δ<sub>2</sub> + δ<sub>3</sub>, γ<sub>0</sub> = −bλ1/2

min (P)/(2λ<sub>max</sub>

![Formula block](doc:8e0334e/tier:flash/page:4/block:35)

Here, W<sub>1</sub>(x) and W<sub>2</sub>(x) are defined in (14), K(l<sub>4</sub>,h)(t)is defined in (8) and (9) with k = l<sub>4</sub> and R(t) ∈ S(<sup>1</sup>)(h).

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

<!-- page 5 of 16 -->

DING et al.: PRESCRIBED-TIME CONTROL VIA PERIODIC DELAYED FEEDBACK-BASED SUPER-TWISTING SLIDING MODE ALGORITHM

1817

min (P)

Theorem 1: Let T > 0 be a prescribed time. Consider the nonlinear system (13) under Assumption 1, where k<sub>i</sub>(t, <sup>x</sup>[t−T <sub>,t]</sub>),i =1, 2, 3, 4 are designed as (15) with h = T /2. Then, x<sub>1</sub>(t)=0,x<sub>2</sub>(t)+ 1(t)=0, ∀t ∈ [T ,∞).

for all t∈[(2j+1)h, 2(j+1)h), where γ(·) is defined by

Proof: Define z<sub>1</sub>(t)= x<sub>1</sub>(t),z<sub>2</sub>(t)= x<sub>2</sub>(t)+ 1(t). Then, the nonlinear system (13) can be rewritten as

![Formula block](doc:8e0334e/tier:flash/page:5/block:7)

![Formula block](doc:8e0334e/tier:flash/page:5/block:8)

and

Q˜1(t)= − (A˜<sup>T</sup>

1 (t)P + PA˜1(t))

![Formula block](doc:8e0334e/tier:flash/page:5/block:12)

The proof is divided into two cases, namely, t ∈ [2jh,(2j +

![Formula block](doc:8e0334e/tier:flash/page:5/block:14)

0, ∀t ∈ [2jh,(2j + 1)h), we deduce that

![Formula block](doc:8e0334e/tier:flash/page:5/block:16)

Then, it is obtained from (15) and |v˜(t)|≤ Δ(t) that

Q˜1(t)+(b/2)I<sub>2</sub>

k<sub>1</sub>(·)= l<sub>1</sub>,k<sub>2</sub>(·)= l<sub>2</sub>,k<sub>3</sub>(·)= l<sub>3</sub>,k<sub>4</sub>(·)= l<sub>4</sub>. Next, denote η =[η1,η2]T [|z1|1/2sign(z<sub>1</sub>),z<sub>2</sub>]<sup>T</sup>. The non-linear system (17) can be rewritten as η˙ = A1(t)η/|η1| + A<sub>2</sub>η, t ∈ [2jh,(2j + 1)h), where

![Formula block](doc:8e0334e/tier:flash/page:5/block:20)

(l<sub>4</sub>1(t)+ ˙1(t)+ 2(t))sign(z<sub>1</sub>). The time

in which v(t) derivative of the function V<sub>1</sub>(η)= η<sup>T</sup>Pη satisfies

![Formula block](doc:8e0334e/tier:flash/page:5/block:23)

and

![Formula block](doc:8e0334e/tier:flash/page:5/block:25)

It can be seen from (14) that

1 +(x<sub>2</sub> + 1(t))<sup>2</sup> + 1))1/2

W<sub>1</sub>(x) ≥ (λ<sub>max</sub>(P)(x<sup>2</sup>

![Formula block](doc:8e0334e/tier:flash/page:5/block:29)

Substituting (24)–(26) into (22) and combining it with (16), we

![Formula block](doc:8e0334e/tier:flash/page:5/block:31)

where

Q<sub>1</sub>(t)= − (A<sup>T</sup>

## 1 (t)P + PA<sub>1</sub>(t))

![Formula block](doc:8e0334e/tier:flash/page:5/block:35)

![Formula block](doc:8e0334e/tier:flash/page:5/block:36)

![Formula block](doc:8e0334e/tier:flash/page:5/block:37)

2λ<sub>min</sub>(Q˜1(t)) V 1/2 (t, η) ≤−2l<sub>4</sub>V<sub>2</sub>(t, η)+(K(t)+ γ<sub>0</sub>) 2 b

By combining (18) and |v(t)|≤ l<sub>4</sub>δ<sub>1</sub> + δ<sub>2</sub> + δ<sub>3</sub>, we know that Q<sub>1</sub>(t) is a positive definite matrix. Thus, it holds that V˙ 1(η) ≤−2l<sub>4</sub>V<sub>1</sub>(η),t ∈ [2jh,(2j + 1)h). For t ∈ [(2j + 1)h, 2(j + 1)h), the nonlinear system (13) can be rewritten as

≤−2l<sub>4</sub>V<sub>2</sub>(t, η) − (K(t)+ γ0)V 1/2(t, η) 2

≤−2l<sub>4</sub>V<sub>2</sub>(t, η) − 2K(l<sub>4</sub>,h)(t)W<sub>1</sub>(x(t − h))V 1/2(t, η) 2

![Formula block](doc:8e0334e/tier:flash/page:5/block:42)

≤−2l<sub>4</sub>V<sub>2</sub>(t, η)−2K(l<sub>4</sub>,h)(t)V 1/2(η(t − h))V 1/2(t, η). (27) 1 2

Notice that γ(t, <sup>x</sup>[t−T ,t]) is differentiable and γ(t, <sup>x</sup>[t−T ,t])= 1, ∀t ∈ [2jh,(2j + 1)h), which implies V<sub>1</sub>(η)= V<sub>2</sub>(t, η),t ∈ [2jh,(2j + 1)h). It is obtained from (27) and K(l<sub>4</sub>,h)(t)=

![Formula block](doc:8e0334e/tier:flash/page:5/block:45)

![Formula block](doc:8e0334e/tier:flash/page:5/block:46)

A˜1(t)=

2

−k<sub>3</sub>(·)+˜v(t)0

−k<sub>4</sub>(·)

in which v˜(t) (k<sub>4</sub>(t, <sup>x</sup>[t−T <sub>,t]</sub>)1(t)+ ˙1(t)+ 2(t)) sign(z<sub>1</sub>). The time derivative of the candidate Lyapunov function V<sub>2</sub>(t, η)= γ(t, <sup>x</sup>[t−T <sub>,t]</sub>)η<sup>T</sup>Pη satisfies V˙ 2(t, η)= ˙γ(·)η<sup>T</sup>Pη − γ(·) η<sup>T</sup>Q˜1(t)η − γ(·)η<sup>T</sup>Q˜2(t)η |η1|

and V˙

2(t, η)≤−2l<sub>4</sub>V<sub>2</sub>(t, η)

![Formula block](doc:8e0334e/tier:flash/page:5/block:54)

Following [37], we show that V<sub>2</sub>(t, η) is an AC function of t on each compact subinterval. V<sub>2</sub>(t, η) can be rewritten as V<sub>2</sub> = γ(·)(a|z1|+2bz2|z1|1/2sign(z1)+cz2 2). It can be seen from(13), (14), (16), and (23) that γ(t)= γ(t, <sup>x</sup>[t−T <sub>,t]</sub>)is AC as a function of time on each compact subinterval of [0,∞). Thus, the problematic term to assure that V<sub>2</sub>(t, η) is AC is |z1|1/2sign(z<sub>1</sub>). It can be seen that z<sub>1</sub>(t)is AC as a function of time, |z1|1/2sign(z<sub>1</sub>) is AC as a function of z<sub>1</sub> but not Lipschitz at z<sub>1</sub> =0. Thus, we know that |z1|1/2sign(z<sub>1</sub>) is AC as a function of time if z<sub>1</sub>(t) is monotone when it goes through z<sub>1</sub>(t)=0 [8]. Suppose that z<sub>1</sub> reaches z<sub>1</sub>(t)=0 at t=τ , namely, z<sub>1</sub>(τ )=0. If z<sub>2</sub>(τ )=0, then according to (17), it follows that the Filippov solution z<sub>1</sub>(t) for (17) will be monotonically increasing or decreasing during an

≤ γ˙(·)η<sup>T</sup>Pη − <u>λ</u><u><sub>min</sub></u><u>(Q˜1(t))V</u><u><sub>2</sub></u><u>(t, η)</u> |η<sub>1</sub>|λ<sub>max</sub>(P)

− γ(·)η<sup>T</sup>Q˜2(t)η

![Formula block](doc:8e0334e/tier:flash/page:5/block:58)

≤ γ˙(·)η<sup>T</sup>Pη − γ(·)η<sup>T</sup>Q˜2(t)η

![Formula block](doc:8e0334e/tier:flash/page:5/block:60)

Authorized licensed use limited to: NANJING UNIVERSITY OF SCIENCE AND TECHNOLOGY. Downloaded on September 29,2026 at 10:57:01 UTC from IEEE Xplore. Restrictions apply.

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