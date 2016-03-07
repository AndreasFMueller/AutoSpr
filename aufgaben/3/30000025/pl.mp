verbatimtex
\documentclass[12pt]{book}
\usepackage{times}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsfonts}
\usepackage{txfonts}
\usepackage{color}
\begin{document}
etex;

beginfig(1)

numeric u;
u = 20;
numeric height;
height = u;
numeric width;
width = 6 * u;

z0 = (0,0);
z1 = (0,u);
z2 = (u,0);
z3 = z2 shifted (width, 0);
z4 = z3 shifted (u, 0);
z5 = z4 shifted (u, 0);
z6 = z5 shifted (width, 0);

z10 = z0 shifted (0,-1.5 * u);
z12 = z2 shifted (0,-1.5 * u);
z13 = z3 shifted (0,-1.5 * u);
z14 = z4 shifted (0,-1.5 * u);
z15 = z5 shifted (0,-1.5 * u);
z16 = z6 shifted (0,-1.5 * u);

z20 = z0 shifted (6 * u, 0);
z21 = z20 shifted (0, 1.5 * u);
z22 = z20 shifted (0, -2 * u);

pickup pencircle scaled 0.7pt;

draw z21--z22;
label.top(btex $N$ etex, z21);

pickup pencircle scaled 1pt;

fill z0--z6--(z6 shifted z1)--(z0 shifted z1)--cycle withcolor white;

draw z2--(z2 shifted z1);
draw z3--(z3 shifted z1);
draw z4--(z4 shifted z1);
draw z5--(z5 shifted z1);
draw z0--z6--(z6 shifted z1)--(z0 shifted z1)--cycle;

label(btex \texttt{1} etex, 0.5[z0,z2] shifted (0,0.5*u));
label(btex \texttt{0} etex, 0.5[z2,z3] shifted (0,0.5*u));
label(btex \texttt{=} etex, 0.5[z3,z4] shifted (0,0.5*u));
label(btex \texttt{1} etex, 0.5[z4,z5] shifted (0,0.5*u));
label(btex \texttt{0} etex, 0.5[z5,z6] shifted (0,0.5*u));

label.lft(btex $w =\mathstrut$ etex, z0 shifted (0,0.5*u));

%
% unterteiltes Wort
%

label.lft(btex ${\color{green}x}{\color{red}y}{\color{blue}z} =\mathstrut$ etex,
	z0 shifted (0,-1.0*u));

z17 = z12 shifted (2.5 * u, 0);
z18 = z12 shifted (4.5 * u, 0);

fill z10--z17--(z17 shifted (0,u))--(z10 shifted (0,u))--cycle
	withcolor (0.8,1,0.8);
fill z17--z18--(z18 shifted (0,u))--(z17 shifted (0,u))--cycle
	withcolor (1,0.7,0.7);
fill z18--z16--(z16 shifted (0,u))--(z18 shifted (0,u))--cycle
	withcolor (0.9,0.975,1);

draw z12--(z12 shifted z1) withcolor 0.9;
draw z13--(z13 shifted z1) withcolor 0.9;
draw z14--(z14 shifted z1) withcolor 0.9;
draw z15--(z15 shifted z1) withcolor 0.9;
draw z10--z16--(z16 shifted z1)--(z10 shifted z1)--cycle;

label(btex \texttt{1} etex, 0.5[z10,z12] shifted (0,0.5*u)) withcolor 0.9;
label(btex \texttt{0} etex, 0.5[z12,z13] shifted (0,0.5*u)) withcolor 0.9;
label(btex \texttt{=} etex, 0.5[z13,z14] shifted (0,0.5*u)) withcolor 0.9;
label(btex \texttt{1} etex, 0.5[z14,z15] shifted (0,0.5*u)) withcolor 0.9;
label(btex \texttt{0} etex, 0.5[z15,z16] shifted (0,0.5*u)) withcolor 0.9;

label(btex $x\mathstrut$ etex, 0.5[z10,z17] shifted (0,0.5*u)) withcolor green;
label(btex $y\mathstrut$ etex, 0.5[z17,z18] shifted (0,0.5*u)) withcolor red;
label(btex $z\mathstrut$ etex, 0.5[z18,z16] shifted (0,0.5*u)) withcolor blue;

endfig;

end
