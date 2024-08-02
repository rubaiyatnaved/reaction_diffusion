A couple of reaction-diffusion systems are numerically solved using finite-differnece schemes. Time evolution of the solutions show some beautiful patterns being formed.

Reaction-diffsuions systems are partial differential equations used to model many chemical, physical and biological systems. The general form of a reaction-diffusion system is 

$$
\left\{\begin{array}{l}
\frac{\partial u}{\partial t}=\alpha_{1}\left(\frac{\partial^{2} u}{\partial \mathrm{x}^{2}}+\frac{\partial^{2} u}{\partial y^{2}}\right)+f(u,v) \\
\frac{\partial v}{\partial t}=\alpha_{2}\left(\frac{\partial^{2} v}{\partial \mathrm{x}^{2}}+\frac{\partial^{2} v}{\partial y^{2}}\right)+g(u,v)
\end{array}\right.
$$

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
