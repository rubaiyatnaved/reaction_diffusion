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

Patterns are formed when we plot concentration of either of the chemicals depending on the values of *F* and *k*

<p float="left">
  <img src="/images/F=0.055,k=0.062.png" width="300">     &nbsp; &nbsp; &nbsp;
  <img src="/images/F=0.22,k=0.051.png" width="300">
</p>

## A predator-prey interaction model

Models the population densities of prey and predators at a given time. There are different kinetics to describe such models and the kinetics that we work with here was described by [Holling, C. S. (1965)](https://www.cambridge.org/core/journals/memoirs-of-the-entomological-society-of-canada/article/abs/functional-response-of-predators-to-prey-density-and-its-role-in-mimicry-and-population-regulation/3877F76ECB6B1A8E8BF3D8A01FD23AB9) and given by the equations

$$
\begin{aligned}
& u_{t}=\alpha_{1}\left(\frac{\partial^{2} u}{\partial \mathrm{x}^{2}}+\frac{\partial^{2} u}{\partial y^{2}}\right)+u(1-u)-\frac{uv}{u+\alpha} \\
& v_{t}=\alpha_{2}\left(\frac{\partial^{2} v}{\partial \mathrm{x}^{2}}+\frac{\partial^{2} v}{\partial y^{2}}\right)+\frac{\beta uv}{u+\alpha}-\gamma v
\end{aligned}
$$

Below is an example of the patterns formed from solution of these sets of differential equations. Please check the video of this pattern formation, I appologise if it made you feel dizzy :smile: .

<img src="/images/predator-prey.png" width="350">



