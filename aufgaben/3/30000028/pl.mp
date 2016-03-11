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
width = 8 * u;
b = 2.5 * u;

z0 = (0,0);
z10 = (0,u);

z1 = (width,0);
z11 = z1 shifted z10;

z2 = z1 shifted z1;
z12 = z2 shifted z10;

z3 = z2 shifted (b,0);
z13 = z3 shifted z10;

pickup pencircle scaled 1pt;
draw z0--z3--z13--z10--cycle;
draw z1--z11;
pickup pencircle scaled 0.3pt;
draw z2--z12;

z5 = 0.5[z0,z1];
z6 = 0.5[z1,z3];

label(btex \texttt{0} etex, z5 shifted (0,0.5*u));
label(btex \texttt{1} etex, z6 shifted (0,0.5*u));
label.top(btex $N$ etex, z11);
label.top(btex $2N$ etex, z12);
label.top(btex $2N+b$ etex, z13);

numeric v;
v := 2.5 * u;

z20 = z0 shifted (0,-v);
z21 = z1 shifted (0,-v);
z22 = z2 shifted (0,-v);
z23 = z3 shifted (0,-v);
z24 = z0 shifted (2 * u,-v);
z25 = z0 shifted (5 * u,-v);
z30 = z20 shifted z10;
z31 = z21 shifted z10;
z32 = z22 shifted z10;
z33 = z23 shifted z10;
z34 = z24 shifted z10;
z35 = z25 shifted z10;

fill z20--z24--z34--z30--cycle withcolor (0.8,1,0.8);
fill z24--z25--z35--z34--cycle withcolor (1,0.7,0.7);
fill z25--z23--z33--z35--cycle withcolor (0.9,0.975,1);

label(btex $u$ etex, 0.5[z20,z24] shifted (0,0.5*u)) withcolor green;
label(btex $v$ etex, 0.5[z24,z25] shifted (0,0.5*u)) withcolor red;
label(btex $w$ etex, 0.5[z25,z23] shifted (0,0.5*u)) withcolor blue;

label(btex \texttt{0} etex, 0.5[z20,z21] shifted (0,0.5*u)) withcolor 0.5;
label(btex \texttt{1} etex, 0.5[z21,z23] shifted (0,0.5*u)) withcolor 0.5;

pickup pencircle scaled 1pt;
draw z20--z23--z33--z30--cycle;
draw z21--z31;
pickup pencircle scaled 0.3pt;
draw z22--z32;

z40 = z20 shifted (0,-v);
z41 = z40 shifted (2 * u, 0);
z42 = z41 shifted (3 * u, 0);
z43 = z42 shifted (3 * u, 0);
z44 = z21 shifted (3 * u,-v);
z45 = z22 shifted (3 * u,-v);
z46 = z23 shifted (3 * u,-v);

z50 = z40 shifted (0,u);
z51 = z41 shifted (0,u);
z52 = z42 shifted (0,u);
z53 = z43 shifted (0,u);
z54 = z44 shifted (0,u);
z55 = z45 shifted (0,u);
z56 = z46 shifted (0,u);

fill z40--z41--z51--z50--cycle withcolor (0.8,1,0.8);
fill z41--z43--z53--z51--cycle withcolor (1,0.7,0.7);
fill z43--z46--z56--z53--cycle withcolor (0.9,0.975,1);

%label.top(btex $N+|v|$ etex, z54);
label(btex $u$ etex, 0.5[z40,z41] shifted (0,0.5*u)) withcolor green;
label(btex $v$ etex, 0.5[z41,z42] shifted (0,0.5*u)) withcolor red;
label(btex $v$ etex, 0.5[z42,z43] shifted (0,0.5*u)) withcolor red;
label(btex $w$ etex, 0.5[z43,z46] shifted (0,0.5*u)) withcolor blue;

label(btex \texttt{0} etex, 0.5[z40,z44] shifted (0,0.5*u)) withcolor 0.5;
label(btex \texttt{1} etex, 0.5[z44,z46] shifted (0,0.5*u)) withcolor 0.5;

z60 = z44 shifted (0,-u);
z62 = z46 shifted (0,-u);
z61 = 0.5[z60,z62];
z63 = z40 shifted (0,-u);
z64 = 0.5[z63,z60];

pickup pencircle scaled 0.5pt;
draw z44--z60 shifted (0,-5);
draw z46--z62 shifted (0,-5);
draw z40--z63 shifted (0,-5);
drawarrow z61--z62;
drawarrow z61--z60;
drawarrow z64--z63;
drawarrow z64--z60;
label.top(btex $N+b$ etex, z61);
label.top(btex $N+|v|$ etex, z64);

pickup pencircle scaled 1pt;
draw z40--z46--z56--z50--cycle;
draw z44--z54;
pickup pencircle scaled 0.3pt;
draw z45--z55;

%fill z10--z17--(z17 shifted (0,u))--(z10 shifted (0,u))--cycle
%	withcolor (0.8,1,0.8);
%fill z17--z18--(z18 shifted (0,u))--(z17 shifted (0,u))--cycle
%	withcolor (1,0.7,0.7);
%fill z18--z16--(z16 shifted (0,u))--(z18 shifted (0,u))--cycle
%	withcolor (0.9,0.975,1);


%label(btex \texttt{1} etex, 0.5[z10,z12] shifted (0,0.5*u)) withcolor 0.9;
%label(btex \texttt{0} etex, 0.5[z12,z13] shifted (0,0.5*u)) withcolor 0.9;
%label(btex \texttt{=} etex, 0.5[z13,z14] shifted (0,0.5*u)) withcolor 0.9;
%label(btex \texttt{1} etex, 0.5[z14,z15] shifted (0,0.5*u)) withcolor 0.9;
%label(btex \texttt{0} etex, 0.5[z15,z16] shifted (0,0.5*u)) withcolor 0.9;
%
%label(btex $x\mathstrut$ etex, 0.5[z10,z17] shifted (0,0.5*u)) withcolor green;
%label(btex $y\mathstrut$ etex, 0.5[z17,z18] shifted (0,0.5*u)) withcolor red;
%label(btex $z\mathstrut$ etex, 0.5[z18,z16] shifted (0,0.5*u)) withcolor blue;

endfig;

end
