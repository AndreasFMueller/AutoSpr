verbatimtex
\documentclass[12pt]{book}
\usepackage{times}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsfonts}
\usepackage{txfonts}
\begin{document}
etex;

beginfig(1)

numeric u;
u := 20;

z0 = (0,0);
z1 = (8 * u, 0);
z2 = z1 shifted (u, 0);
z3 = z2 shifted z1;
z10 = z0 shifted (0,u);
z11 = z1 shifted (0,u);
z12 = z2 shifted (0,u);
z13 = z3 shifted (0,u);

z4 = 0.5[z0,z1] shifted (0,0.5*u);
z5 = 0.5[z1,z2] shifted (0,0.5*u);
z6 = 0.5[z2,z3] shifted (0,0.5*u);

pickup pencircle scaled 1pt;
draw z1--z11;
draw z2--z12;
draw z0--z3--z13--z10--cycle;

label.top(btex $N$ etex, z11);
%label.top(btex $N+1$ etex, z12);
label.top(btex $2N+1$ etex, z13);

label(btex \texttt{0} etex, z4);
label(btex \texttt{1} etex, z5);
label(btex \texttt{0} etex, z6);

numeric v;
v = 2.5 * u;

z20 = z0 shifted (0,-v);
z21 = z1 shifted (0,-v);
z22 = z2 shifted (0,-v);
z23 = z3 shifted (0,-v);
z24 = z4 shifted (0,-v);
z25 = z5 shifted (0,-v);
z26 = z6 shifted (0,-v);
z27 = z20 shifted (2 * u, 0);
z28 = z20 shifted (5 * u, 0);

z30 = z20 shifted (0,u);
z31 = z21 shifted (0,u);
z32 = z22 shifted (0,u);
z33 = z23 shifted (0,u);
z37 = z27 shifted (0,u);
z38 = z28 shifted (0,u);

fill z20--z27--z37--z30--cycle withcolor (0.8,1,0.8);
fill z27--z28--z38--z37--cycle withcolor (1,0.7,0.7);
fill z28--z23--z33--z38--cycle withcolor (0.9,0.975,1);

label(btex $x$ etex, 0.5[z20,z27] shifted (0,0.5*u)) withcolor green;
label(btex $y$ etex, 0.5[z27,z28] shifted (0,0.5*u)) withcolor red;
label(btex $z$ etex, 0.5[z28,z23] shifted (0,0.5*u)) withcolor blue;

pickup pencircle scaled 1pt;
draw z20--z23--z33--z30--cycle;
draw z21--z31;
draw z22--z32;

label(btex \texttt{0} etex, z24) withcolor 0.5;
label(btex \texttt{1} etex, z25) withcolor 0.5;
label(btex \texttt{0} etex, z26) withcolor 0.5;

z40 = z20 shifted (0,-v);
z41 = z27 shifted (0,-v);
z42 = z28 shifted (0,-v);
z43 = z42 shifted (3 * u, 0);
z44 = z21 shifted (3 * u, -v);
z45 = z22 shifted (3 * u, -v);
z46 = z23 shifted (3 * u, -v);
z50 = z40 shifted (0,u);
z51 = z41 shifted (0,u);
z52 = z42 shifted (0,u);
z53 = z43 shifted (0,u);
z54 = z44 shifted (0,u);
z55 = z45 shifted (0,u);
z56 = z46 shifted (0,u);

fill z40--z41--z51--z50--cycle withcolor (0.8,1,0.8);
fill z41--z43--z53--z51--cycle withcolor (1,0.7,0.7);
fill z43--z44--z54--z53--cycle withcolor (0.9,0.975,1);

label(btex $x$ etex, 0.5[z40,z41] shifted (0,0.5*u)) withcolor green;
label(btex $y$ etex, 0.5[z41,z42] shifted (0,0.5*u)) withcolor red;
label(btex $y$ etex, 0.5[z42,z43] shifted (0,0.5*u)) withcolor red;
label(btex $z$ etex, 0.5[z43,z46] shifted (0,0.5*u)) withcolor blue;

pickup pencircle scaled 1pt;
draw z40--z46--z56--z50--cycle;
draw z44--z54;
draw z45--z55;

label(btex \texttt{0} etex, 0.5[z40,z44] shifted (0,0.5*u)) withcolor 0.5;
label(btex \texttt{1} etex, 0.5[z44,z45] shifted (0,0.5*u)) withcolor 0.5;
label(btex \texttt{0} etex, 0.5[z45,z46] shifted (0,0.5*u)) withcolor 0.5;

z60 = z40 shifted (0,-u);
z62 = z44 shifted (0,-u);
z61 = 0.5[z60,z62];
z63 = z45 shifted (0,-u);
z65 = z46 shifted (0,-u);
z64 = 0.5[z63,z65];

pickup pencircle scaled 0.5pt;
draw z40--(z60 shifted (0,-5));
draw z44--(z62 shifted (0,-5));
draw z45--(z63 shifted (0,-5));
draw z46--(z65 shifted (0,-5));
pickup pencircle scaled 0.8pt;
drawarrow z61--z60;
drawarrow z61--z62;
drawarrow z64--z63;
drawarrow z64--z65;

label.top(btex $N+|y|$ etex, z61);
label.top(btex $N$ etex, z64);

endfig;

end
