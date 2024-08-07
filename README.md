A couple of reaction-diffusion systems are numerically solved using finite-differnece schemes. Time evolution of the solutions show some beautiful patterns being formed.

Reaction-diffsuions systems are partial differential equations used to model many chemical, physical and biological systems. The general form of a reaction-diffusion system is 

$$
\begin{aligned}
\frac{\partial u}{\partial t}=\alpha_{1}\left(\frac{\partial^{2} u}{\partial \mathrm{x}^{2}}+\frac{\partial^{2} u}{\partial y^{2}}\right)+f(u,v) \\
\frac{\partial v}{\partial t}=\alpha_{2}\left(\frac{\partial^{2} v}{\partial \mathrm{x}^{2}}+\frac{\partial^{2} v}{\partial y^{2}}\right)+g(u,v)
\end{aligned}
$$

The numerical schemes used here are alternating direction implicit (ADI) method and Hopscotch method

* [Peaceman, D.W. and Rachford, H.H., (1955),”The Numerical Solution of Parabolic and Elliptic Different Equations”, SIAM J., 3, p.28.](https://www.jstor.org/stable/pdf/2098834.pdf?casa_token=OoHYC6dCykgAAAAA:ph1E8fPus7BCsyhC3f4jfLymE-LABY-pGYPkm2AYxPEN4tZRJ4uyBCBJLVqIA7EEwSG40U2UFnDZfu3bxVfRmp_5PbkZhIpuryggGvHlK-brRUrgrEs)

* [Gourlay, A.R. ,(1970),”Hopscotch : a Fast Second-Order Partial Differential Equation Solver”, J. Inst. Math. App., 6,375-390.](https://academic.oup.com/imamat/article-abstract/6/4/375/681092?redirectedFrom=PDF&casa_token=MAVtwLmlXh8AAAAA:_63sDpPCAZ7rYzR0nNxmUEaQ_6jW0yFNJ8wZOYS417TMGMjF_YhPI4X-6s3BZ3CbjcWWodgYst3Yxw)

## Gray-Scott Model

Describes a chemical reaction where chemical *U* is consumed to produce chemical *V*.

$$
\begin{aligned}
\mathrm{U}+2 \mathrm{~V} & \rightarrow 3 \mathrm{~V}
\end{aligned}
$$

Reaction is maintained by feeding *U* at a rate *F* (feed rate) to the system and removing *V* at a rate *k* (kill rate).

$$
\begin{aligned}
\frac{\partial u}{\partial t}=\alpha_{1}\left(\frac{\partial^{2} u}{\partial \mathrm{x}^{2}}+\frac{\partial^{2} u}{\partial y^{2}}\right)-u v^{2}+\mathrm{F}(1-u) \\
\frac{\partial v}{\partial t}=\alpha_{2}\left(\frac{\partial^{2} v}{\partial \mathrm{x}^{2}}+\frac{\partial^{2} v}{\partial y^{2}}\right)+u v^{2}-\mathrm{(F+k)}v
\end{aligned}
$$
