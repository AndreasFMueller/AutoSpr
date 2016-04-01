verbatimtex
\documentclass[12pt]{book}
\usepackage{times}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsfonts}
\usepackage{txfonts}
\begin{document}
etex;

numeric u;
u := 16;

beginfig(1)

z0 = ( 0    , 0);
z1 = ( 4 * u, 0);
z2 = ( 7 * u, 0);
z3 = (12 * u, 0);
z10 = z0 shifted (0,-u);
z11 = z1 shifted (0,-u);
z12 = z2 shifted (0,-u);
z13 = z3 shifted (0,-u);

z4 = 0.5[z0,z1] shifted (0,-0.5 * u);
z5 = 0.5[z1,z2] shifted (0,-0.5 * u);
z6 = 0.5[z2,z3] shifted (0,-0.5 * u);
z7 = z3 shifted ( 0.5 * u, -0.5 * u);
z8 = z0 shifted (-0.5 * u, -0.5 * u);

numeric v;
v := 1.5 * u;

numeric dshift,eshift,fshift;
dshift = 3 * v + 0.5 * u;
eshift = 2 * v + 0.5 * u;
fshift = 1 * v + 0.5 * u;

fill z0--z1--z11--z10--cycle withcolor (0.8,1,0.8);
fill (z0--z1--z11--z10--cycle) shifted (0,dshift) withcolor (0.8,1,0.8);

fill z1--z2--z12--z11--cycle withcolor (1,0.7,0.7);
fill (z1--z2--z12--z11--cycle) shifted (0,eshift) withcolor (1,0.7,0.7);

fill z2--z3--z13--z12--cycle withcolor (0.9,0.975,1);
fill (z2--z3--z13--z12--cycle) shifted (0,fshift) withcolor (0.9,0.975,1);

pickup pencircle scaled 1pt;

draw z0--z3--z13--z10--cycle;
draw z1--z11;
draw z2--z12;

draw (z0--z3--z13--z10--cycle) shifted (0,dshift);
draw (z1--z11) shifted (0,dshift);
draw (z1--z3--z13--z11--cycle) shifted (0,eshift);
draw (z2--z12) shifted (0,eshift);
draw (z2--z3--z13--z12--cycle) shifted (0,fshift);

label(btex $x\mathstrut$ etex, z4) withcolor green;
label(btex $x\mathstrut$ etex, z4 shifted (0,dshift)) withcolor green;
label(btex $y\mathstrut$ etex, z5) withcolor red;
label(btex $y\mathstrut$ etex, z5 shifted (0,eshift)) withcolor red;
label(btex $z\mathstrut$ etex, z6) withcolor blue;
label(btex $z\mathstrut$ etex, z6 shifted (0,fshift)) withcolor blue;
label.rt(btex $=p\mathstrut$ etex, z7);
label.rt(btex $=d\mathstrut$ etex, z7 shifted (0,dshift));
label.rt(btex $=e\mathstrut$ etex, z7 shifted (0,eshift));
label.rt(btex $=f\mathstrut$ etex, z7 shifted (0,fshift));
label.lft(btex $+$ etex, z8 shifted (0,eshift));
label.lft(btex $+$ etex, z8 shifted (0,fshift));
pickup pencircle scaled 1.5pt;
draw (z0 shifted (-u, 0.5*u))--(z3 shifted (1.5*u,0.5*u));
label.lft(btex $=$ etex, z8);
label(btex \texttt{0} etex, 0.5[z1,z3] shifted (0,dshift-0.5*u));
label(btex \texttt{0} etex, z6 shifted (0,eshift));

endfig;

beginfig(2)

z0 = ( 0    , 0);
z1 = ( 4 * u, 0);
z2 = ( 7 * u, 0);
z20 = ( 9 * u, 0);
z3 = (12 * u, 0);
z4 = (15 * u, 0);
z5 = (20 * u, 0);
z10 = z0 shifted (0,-u);
z11 = z1 shifted (0,-u);
z12 = z2 shifted (0,-u);
z22 = z20 shifted (0,-u);
z13 = z3 shifted (0,-u);
z14 = z4 shifted (0,-u);
z15 = z5 shifted (0,-u);
z6 = z5 shifted (0.5*u,-0.5*u);
z7 = z0 shifted (-0.5*u,-0.5*u);

numeric v;
v := 1.5 * u;

numeric dshift,eshift,fshift;
dshift = 3 * v + 0.5 * u;
eshift = 2 * v + 0.5 * u;
fshift = 1 * v + 0.5 * u;

fill z0--z1--z11--z10--cycle withcolor (0.8,1,0.8);
fill (z0--z1--z11--z10--cycle) shifted (0,dshift) withcolor (0.8,1,0.8);

fill z1--z4--z14--z11--cycle withcolor (1,0.7,0.7);
fill (z1--z4--z14--z11--cycle) shifted (0,eshift) withcolor (1,0.7,0.7);

fill z4--z5--z15--z14--cycle withcolor (0.9,0.975,1);
fill (z4--z5--z15--z14--cycle) shifted (0,fshift) withcolor (0.9,0.975,1);

pickup pencircle scaled 1pt;

draw z0--z5--z15--z10--cycle;
draw z0--z5--z15--z10--cycle shifted (0,dshift);
draw z1--z11;
draw (z1--z11) shifted (0,dshift);
draw z1--z5--z15--z11--cycle shifted (0,eshift);
draw z2--z12;
draw (z2--z12) shifted (0,eshift);
draw z20--z22;
draw (z20--z22) shifted (0,eshift);
draw z3--z13;
draw (z3--z13) shifted (0,eshift);
draw z4--z14;
draw (z4--z14) shifted (0,eshift);
draw z4--z5--z15--z14--cycle shifted (0,fshift);

label(btex $x\mathstrut$ etex, 0.5[z0,z1] shifted (0,-0.5 * u)) withcolor green;
label(btex $x\mathstrut$ etex, 0.5[z0,z1] shifted (0,dshift-0.5 * u)) withcolor green;

label(btex $y\mathstrut$ etex, 0.5[z1,z2] shifted (0,-0.5 * u)) withcolor red;
label(btex $y\mathstrut$ etex, 0.5[z1,z2] shifted (0,eshift-0.5 * u)) withcolor red;
label(btex $\dots\mathstrut$ etex, 0.5[z2,z20] shifted (0,-0.5*u)) withcolor red;
label(btex $\dots\mathstrut$ etex, 0.5[z2,z20] shifted (0,eshift-0.5*u)) withcolor red;
label(btex $y\mathstrut$ etex, 0.5[z20,z3] shifted (0,-0.5 * u)) withcolor red;
label(btex $y\mathstrut$ etex, 0.5[z20,z3] shifted (0,eshift-0.5 * u)) withcolor red;
label(btex $y\mathstrut$ etex, 0.5[z3,z4] shifted (0,eshift-0.5 * u)) withcolor red;
label(btex $y\mathstrut$ etex, 0.5[z3,z4] shifted (0,-0.5 * u)) withcolor red;


label(btex $z\mathstrut$ etex, 0.5[z4,z5] shifted (0,-0.5 * u)) withcolor blue;
label(btex $z\mathstrut$ etex, 0.5[z4,z5] shifted (0,fshift-0.5 * u)) withcolor blue;

label.rt(btex $=v_b(w_k)\mathstrut$ etex, z6);
label.rt(btex $=ds^{k-1}\mathstrut$ etex, z6 shifted (0,dshift));
label.rt(btex $=es^{k-1}+\dots+es+e\mathstrut$ etex, z6 shifted (0,eshift));
label.rt(btex $=f\mathstrut$ etex, z6 shifted (0,fshift));

label(btex \texttt{0} etex, 0.5[z1,z5] shifted (0,dshift-0.5*u));
label(btex \texttt{0} etex, 0.5[z4,z5] shifted (0,eshift-0.5*u));

label.lft(btex $=$ etex, z7);
label.lft(btex $+$ etex, z7 shifted (0,eshift));
label.lft(btex $+$ etex, z7 shifted (0,fshift));

pickup pencircle scaled 1.5pt;

draw (z0 shifted (-u,0.5*u))--(z5 shifted (7 * u, 0.5 * u));

endfig;

end
