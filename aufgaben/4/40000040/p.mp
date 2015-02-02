%
% p.mp
%
% (c) 2015 Prof Dr Andreas Mueller, Hochschule Rapperswil
%
verbatimtex
\documentclass{book}
\usepackage{times}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsfonts}
\usepackage{txfonts}
\begin{document}
etex;

numeric u;
u = 15;

beginfig(1)

pickup pencircle scaled 1pt;

fill (0,0)--(11 * u, 0)--(11 * u,u)--(0,u)--cycle withcolor(0.9,1,0.9);
fill (11 * u,0)--(18 * u, 0)--(18 * u,u)--(11 * u,u)--cycle withcolor(1,0.9,0.9);
fill (18 * u, 0)--(20 * u,0)--(20 * u, u)--(18 * u, u)--cycle withcolor(0.9,0.9,1);

path p;
p = (0,0)--(20 * u, 0)--(20 * u, u)--(0, u)--cycle;
draw p;

draw (6*u, 0)--(6*u, u);
draw (7*u, 0)--(7*u, u);
draw (13*u, 0)--(13*u, u);
draw (14*u, 0)--(14*u, u);

label(btex \texttt{x} etex, (0.5*u,0.5*u));
label(btex \dots etex, (3*u,0.5*u));
label(btex \texttt{x} etex, (5.5*u,0.5*u));
label(btex \dots etex, (10*u,0.5*u));
label(btex \dots etex, (17*u,0.5*u));
label(btex \texttt{y} etex, (7.5*u,0.5*u));
label(btex \texttt{y} etex, (12.5*u,0.5*u));
label(btex \texttt{z} etex, (14.5*u,0.5*u));
label(btex \texttt{z} etex, (19.5*u,0.5*u));
label(btex \texttt{+} etex, (6.5*u,0.5*u));
label(btex \texttt{+} etex, (13.5*u,0.5*u));

endfig;

beginfig(2)

pickup pencircle scaled 1pt;

fill (0,0)--(11 * u, 0)--(11 * u,u)--(0,u)--cycle withcolor(0.9,1,0.9);
fill (11 * u,0)--(24 * u, 0)--(24 * u,u)--(11 * u,u)--cycle withcolor(1,0.9,0.9);
draw (18 * u,0)--(18 * u, u) withcolor (1,0,0);
fill (24 * u, 0)--(27 * u,0)--(27 * u, u)--(24 * u, u)--cycle withcolor(0.9,0.9,1);

path p;
p = (0,0)--(27 * u, 0)--(27 * u, u)--(0, u)--cycle;
draw p;

draw (6*u, 0)--(6*u, u);
draw (7*u, 0)--(7*u, u);
draw (13*u, 0)--(13*u, u);
draw (14*u, 0)--(14*u, u);
draw (20*u, 0)--(20*u, u);
draw (21*u, 0)--(21*u, u);

label(btex \texttt{x} etex, (0.5*u,0.5*u));
label(btex \dots etex, (3*u,0.5*u));
label(btex \texttt{x} etex, (5.5*u,0.5*u));
label(btex \dots etex, (10*u,0.5*u));
label(btex \dots etex, (17*u,0.5*u));
label(btex \texttt{y} etex, (7.5*u,0.5*u));
label(btex \texttt{y} etex, (12.5*u,0.5*u));
label(btex \texttt{z} etex, (14.5*u,0.5*u));
label(btex \texttt{y} etex, (19.5*u,0.5*u));

label(btex \texttt{z} etex, (21.5*u,0.5*u));
label(btex \texttt{z} etex, (26.5*u,0.5*u));

label(btex \texttt{+} etex, (6.5*u,0.5*u));
label(btex \texttt{+} etex, (13.5*u,0.5*u));
label(btex \texttt{+} etex, (20.5*u,0.5*u));

endfig;

end
