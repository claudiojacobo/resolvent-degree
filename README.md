# Resolvent degree of finite groups
---
## 🧭 Main goals
This repository is **living, collaborative record** of the best known upper bounds on the resolvent degree of finite groups. We aim to:
+ **Document progress** across the literature.
+ **Organize a codebase** to verify and reproduce bounds.
+ **Encourage community contributions** to refine or extend results.
+ **Serve as a reference** for ongoing research.
## 🤝 How to contribute
**This repository is a work in progress.** If you have something to share, please consider contributing via pull request or by emailing [Claudio](https://claudiojacobo.com/). We are especially interested in:
+ **Updating the bounds table** with new or refined results.
+ **Improving code consistency and readability** (e.g., style, documentation).
+ **Enhancing results** (e.g., introduce more efficient methods, port to performant languages).
+ **Flagging errors** in bounds, citations, or code.
+ **Highlighting new or significant results** from the literature.
## 📊 Best upper bounds
This GitHub is intended as a living version of Sutherland's excellent summary [Sut2023], which is out of date as of Spring 2025. While we mention several well-studied finite groups, we are primarily interested in finite *simple* groups. There is no loss of generality since, due to [FW2019], the resolvent degree of a finite group is bound by the resolvent degree of the simple factors in its Jordan–Hölder decomposition. In what follows, we mirror the notation from [Wikipedia](https://en.wikipedia.org/wiki/List_of_finite_simple_groups) in the classification of finite simple groups.
### Cyclic groups
$\text{RD}(C_p) = 1$ for all prime $p \geq 2$. Indeed, $\text{RD}(G) = 1$ for any solvable $G$, since any characteristic $0$ field extension with Galois group $G$ is solvable in radicals.
### Alternating groups $A_n$
+ Bounds for low $n$ (COMING SOON)
+ Asymptotic bounds (COMING SOON)
### Classical Chevalley groups
+ $A_n(q) = \text{PSL}(n+1,q)$ for $n \geq 1$
	+ $n=1$ (with $q > 4$ and $q \not = 9$) (COMING SOON)
	+ $n=2$ (COMING SOON)
### Classical Steinberg groups
+ $^2A_n(q^2) = \text{PSU}(n+1,q)$ for $n \geq 2$
	+ Upper bounds for $n = 2$ (COMING SOON)
### Other
+ Sporadic groups (COMING SOON)
+ Weyl groups of type $E_6$, $E_7$, and $E_8$ (COMING SOON)
## 🌱 Overview of RD
Resolvent degree (RD) is a measure of complexity motivated by one of the most fundamental problems in math: 

> "How can we solve algebraic equations in the simplest manner possible?" 

While there are many notions of complexity to associate with, say, solving a generic polynomial (e.g., Smale's branching topological complexity), RD is more analogous to *dimension*—in correspondence to classical problems of eliminating coefficients (e.g., [Tsc1683]). The **resolvent degree** $\text{RD}(n)$, defined independently by Brauer [Bra1975] and Arnold–Shimura [AS1976] and formally named by Farb–Wolfson [FW2019], is the minimal number of *variables* needed to express solutions to the generic degree $n$ polynomial. To make this notion rigorous, one can employ the language of RD for branched covers or, dually, field extensions (see [FW2019, Rei2024, GGSW2024]).

Galois theory offers a particular perspective on this problem in terms of solutions via a particular family of one-variable algebraic functions, i.e., radicals. The tradition which emerged with Klein and Hilbert at Göttingen (see [Kle1884], also [Hel2023] for a perspective on Klein's "hypergalois" program that draws from and situates modern research) challenges us to look beyond this (unfortunately named) solvable/unsolvable dichotomy, regarding ordinary radicals and the [Bring radical](https://en.wikipedia.org/wiki/Bring_radical) ([Bri1786])—both algebraic functions of one variable—as equally complex. Klein's leveraging of geometry, yielding (among other things) his solution of the quintic in terms of his icosahedral cover $\mathcal{I}: \mathbb{P}^1 \to \mathbb{P}^1$ (see [Kle1884, Nas2014]), is fundamental to current work in RD. The **resolvent degree of a finite** (indeed, algebraic) **group** $G$ is defined as the supremum of $\text{RD}(X \dashrightarrow X/G)$ over all primitive, generically free $G$-varieties $X$ (for the experts, we are interested in upper bounds and so take $k = \mathbb{C}$; cf. [Rei2024]). In particular, $\text{RD}(n) = \text{RD}(S_n)$. 

The notion of $\text{RD}(G)$, then, builds on this Kleinian objective: to reduce an algebraic function to a simplest possible “normal form,” conceptualized as an action of its monodromy group on some space of minimal dimension. When $G = C_d$, for example, the $G$-variety $\mathbb{P}^1$ (arising from the branched cover $z \mapsto z^d$, i.e., the algebraic function $\sqrt[d]{-}$) has a universal property: by Kummer theory, any $G$-variety $X$ admits an equivariant dominant rational map $X \dashrightarrow \mathbb{P}^1$ so that the action on $X$ is pulled back from the action on $\mathbb{P}^1$. Crucial to the hypergalois theory of Klein's school is the additional notion of **accessory irrationality**, i.e., the use of auxiliary functions towards solving a given algebraic problem (see [FKW2023]). Indeed, while every $A_5$-variety $X$ does *not* pull back from the icosahedral action $A_5 \circlearrowright \mathbb{P}^1$, Klein's *normalformsatz* guarantees the existence of an $A_5$-variety $Y$ together with a branched covering $Y \dashrightarrow X$  of degree at most $2$ so that $Y$ *does* pull back from $\mathcal{I}$. We say that $C_d \circlearrowright \mathbb{P}^1$ cover is **versal**, while $A_5 \circlearrowright \mathbb{P}^1$ is **solvably versal** (see also [GGSW2024] for more on versality, and [FW2025] for a related invariant which restricts the degree of permitted irrationalities); in general, suitably versal $G$-varieties witness $\text{RD}(G)$.

To date, it is unknown whether $\text{RD}(n) > 1$ for any $n \in \mathbb{Z}^+$. Indeed, identifying *any* finite group $G$ for which $\text{RD}(G) > 1$ is of tremendous interest to the field—equivalent to the spirit of Hilbert's 13th problem. The extensive history behind resolvent degree, which spans many generations of mathematicians and is marked by fragmentation of communities and lengthy periods without progress, is an important motivation for this repository. In the words of Sylvester and Hammond, looking back on the limited progress over 200 years:

> "The theory has been a plant of slow growth.” [SH1887]

For a much more thorough historical overview, see Appendix B of [Wol2021].
## 🧑‍💻 Contributors
Direct contributors to this repo, listed in alphabetical order, include:
+ [Pablo Nicolas Christofferson](https://github.com/Pablo-Christofferson)
+ Akash Ganguly
+ [Claudio Gómez-Gonzáles](https://claudiojacobo.com/)
+ [Ella Kuriyama](https://github.com/ekuriy)
+ [Yihan Carmen Li](https://github.com/Carmen-owl)

In addition, launching this repo was supported in part by NSF Grant DMS-2418943.
## 📑 References
+ [AS1976] V. Arnold and G. Shimura, *Superpositions of algebraic functions*, AMS Proceedings of Symposia in Pure Mathematics 28, 45–46.
+ [Bra1975] R. Brauer, *On the resolvent problem*, Annali di Matematica Pura ed Applicata 102.1, 45–55
+ [Bri1786] E. Bring, *Meletemata quædam mathematica circa transformationem æquationem algebraicarum*, Lund
+ [CGGGKL2025] P. Christofferson, A. Ganguly, C. Gómez-Gonzáles, E. Kuriyama, Y. Li, *On the Resolvent Degree of PSU(3,q)*, arXiv:2509.19237
+ [FKW2023] B. Farb, M. Kisin, and J. Wolfson, *Modular functions and resolvent problems, with an appendix by Nate Harman*, Mathematische Annalen 386: 113–150.
+ [FW2019] B. Farb and J. Wolfson, *Resolvent degree, Hilbert’s 13th problem and geometry*, L’Enseignement Mathématique 65.3, 303–376.
+ [FW2025] B. Farb and J. Wolfson. *Essential dimension relative to branched covers of degree at most n*, arXiv:2510.22786
+ [GG2025] C. Gómez-Gonzáles, *Special points on intersections of hypersurfaces*, arXiv:2510.10272
+ [GGSW2024] C. Gómez-Gonzáles, A. Sutherland, J. Wolfson, *Generalized versality, special points, and resolvent degree for the sporadic groups,* Journal of Algebra 647, 758–793
+ [Ham1836] W. Hamilton, *Inquiry into the Validity of a Method Recently Proposed by George B. Jerrard, Esq., for Transforming and Resolving Equations of Elevated Degrees*, Report of the Sixth Meeting of the British Association for the Advancement of Science, 295–348
+ [HS2023] C. Heberle and A. Sutherland, *Upper bounds on resolvent degree via Sylvester’s obliteration algorithm*, New York Journal of Mathematics 29: 107-146
+ [Hel2023] H. Heller. *Felix Klein's teaching of Galois theory.* Historia mathematica 63, 21–46.
+ [Hil1927] D. Hilbert, *Über die Gleichung neunten Grades*, Mathematische Annalen 97.1, 243–250
+ [HS2023] C. Heberle and A. Sutherland, *Upper bounds on resolvent degree via Sylvester’s obliteration algorithm*, New York Journal of Mathematics 29, 107–146
+ [Kle1884] F. Klein, *Vorlesungen über das Ikosaeder und die Auflösung der Gleichungen vom fünften Grade*, Teubner, Leipzig
+ [Nas2014] O. Nash, *On Klein’s icosahedral solution of the quintic*, Expositiones Mathematicae 32.2, 99–120
+ [Rei2024] R. Reichstein, *Hilbert’s 13th Problem for Algebraic Groups*, L’Enseignement Mathématique 71.1, 139–192
+ [Sut2021] A. Sutherland, *Upper bounds on resolvent degree and its growth rate*, arXiv:2107.08139
+ [Sut2022] A. Sutherland, *Upper Bounds on the Resolvent Degree of General Polynomials and the Families of Alternating and Symmetric Groups*, Ph.D. thesis (University of California, Irvine)
+ [Sut2023] A. Sutherland, *A Summary of Known Bounds on the Essential Dimension and Resolvent Degree of Finite Groups*, arXiv:2312.04430
+ [SH1887] J. Sylvester and J. Hammond, *On Hamilton’s Numbers*, Philosophical Transactions of the Royal Society of London A 178, 285–312
+ [Tsc1683] E. von Tschirnhaus, *Methodus auferendi omnes terminos intermedios ex data aequatione*, Acta Eruditorum, 204-207, 1683
+ [Wim1927] A. Wiman, *Über die Anwendung der Tschirnhausentransformation auf die Reduktion algebraischer Gleichungen*, Almquist & Wiksells
+ [Wol2021] J. Wolfson, *Tschirnhaus transformations after Hilbert*, L’Enseignement Mathématique 66.3, 489–540
