beginfig(1)
verbatimtex
\documentclass[12pt]{book}
\usepackage{times}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsfonts}
\usepackage{txfonts}
\begin{document}
etex;

z1 = (0,-50);
z2 = z1 rotated 120;
z0 = z2 rotated 120;

draw z0--z1--z2--cycle;
draw z0 shifted (-30,0)--z0;

path	a;
a = (-2,0)--(-3,-2)--(0,0)--(-3,2)--cycle;

fill a shifted z0 shifted (-10,0);
fill a shifted (-10,0) rotated -60 shifted z1;
fill a shifted (-10,0) rotated 60 shifted z2;
fill a shifted (-10,0) rotated 180 shifted z0;
fill a shifted (-10,0) rotated 135 shifted z1;
draw (-10,0) rotated 135 shifted z1 {dir -45}..{dir 45}(-10,0) rotated 45 shifted z1;

label.top(btex {\tt a} etex, (z0 + z2)/2);
label.lrt(btex {\tt a},{\tt b} etex, (z1 + z2)/2);
label.llft(btex {\tt b} etex, (z0+z1)/2);
label.lft(btex {\tt a} etex, z1 shifted (-12,-16));

def	state(expr z, f, s) =
	path	p;
	p = z shifted (-10,0)..z shifted(0,-10)
			..z shifted(10,0)..z shifted(0,10)..cycle;
	if s > 0:
		fill p withcolor (1,0.8,0.8);
	else:
		fill p withcolor (1,1,1);
	fi;
	pickup pencircle scaled 0.5pt;
	draw p;
	if f > 0:
		draw z shifted (-8,0)..z shifted(0,-8)
			..z shifted(8,0)..z shifted(0,8)..cycle;
	
	fi
enddef; 

state(z0, 1, 0);
state(z1, 0, 0);
state(z2, 0, 0);

label(btex $q_0$ etex, z0);
label(btex $q_1$ etex, z1);
label(btex $q_2$ etex, z2);

endfig;

beginfig(2)
z1 = (0,-50);
z2 = z1 rotated 120;
z0 = z2 rotated 120;

draw z0--z1--z2--cycle;
draw z0 shifted (-30,0)--z0;

path	a;
a = (-2,0)--(-3,-2)--(0,0)--(-3,2)--cycle;

fill a shifted z0 shifted (-10,0);
fill a shifted (-10,0) rotated -60 shifted z1;
fill a shifted (-10,0) rotated 60 shifted z2;
fill a shifted (-10,0) rotated 180 shifted z0;
fill a shifted (-10,0) rotated 135 shifted z1;
draw (-10,0) rotated 135 shifted z1 {dir -45}..{dir 45}(-10,0) rotated 45 shifted z1;

label.top(btex {\tt a} etex, (z0 + z2)/2);
label.lrt(btex {\tt a},{\tt b} etex, (z1 + z2)/2);
label.llft(btex {\tt b} etex, (z0+z1)/2);
label.lft(btex {\tt a} etex, z1 shifted (-12,-16));

def	state(expr z, f, s) =
	path	p;
	p = z shifted (-10,0)..z shifted(0,-10)
			..z shifted(10,0)..z shifted(0,10)..cycle;
	if s > 0:
		fill p withcolor (1,0.8,0.8);
	else:
		fill p withcolor (1,1,1);
	fi;
	pickup pencircle scaled 0.5pt;
	draw p;
	if f > 0:
		draw z shifted (-8,0)..z shifted(0,-8)
			..z shifted(8,0)..z shifted(0,8)..cycle;
	
	fi
enddef; 

state(z0, 1, 1);
state(z1, 0, 0);
state(z2, 0, 0);

label(btex $q_0$ etex, z0);
label(btex $q_1$ etex, z1);
label(btex $q_2$ etex, z2);

endfig;

beginfig(3)
z1 = (0,-50);
z2 = z1 rotated 120;
z0 = z2 rotated 120;

draw z0--z1--z2--cycle;
draw z0 shifted (-30,0)--z0;

path	a;
a = (-2,0)--(-3,-2)--(0,0)--(-3,2)--cycle;

fill a shifted z0 shifted (-10,0);
fill a shifted (-10,0) rotated -60 shifted z1;
fill a shifted (-10,0) rotated 60 shifted z2;
fill a shifted (-10,0) rotated 180 shifted z0;
fill a shifted (-10,0) rotated 135 shifted z1;
draw (-10,0) rotated 135 shifted z1 {dir -45}..{dir 45}(-10,0) rotated 45 shifted z1;

label.top(btex {\tt a} etex, (z0 + z2)/2);
label.lrt(btex {\tt a},{\tt b} etex, (z1 + z2)/2);
label.llft(btex {\tt b} etex, (z0+z1)/2);
label.lft(btex {\tt a} etex, z1 shifted (-12,-16));

def	state(expr z, f, s) =
	path	p;
	p = z shifted (-10,0)..z shifted(0,-10)
			..z shifted(10,0)..z shifted(0,10)..cycle;
	if s > 0:
		fill p withcolor (1,0.8,0.8);
	else:
		fill p withcolor (1,1,1);
	fi;
	pickup pencircle scaled 0.5pt;
	draw p;
	if f > 0:
		draw z shifted (-8,0)..z shifted(0,-8)
			..z shifted(8,0)..z shifted(0,8)..cycle;
	
	fi
enddef; 

state(z0, 1, 0);
state(z1, 0, 1);
state(z2, 0, 0);

label(btex $q_0$ etex, z0);
label(btex $q_1$ etex, z1);
label(btex $q_2$ etex, z2);

endfig;

beginfig(4)
z1 = (0,-50);
z2 = z1 rotated 120;
z0 = z2 rotated 120;

draw z0--z1--z2--cycle;
draw z0 shifted (-30,0)--z0;

path	a;
a = (-2,0)--(-3,-2)--(0,0)--(-3,2)--cycle;

fill a shifted z0 shifted (-10,0);
fill a shifted (-10,0) rotated -60 shifted z1;
fill a shifted (-10,0) rotated 60 shifted z2;
fill a shifted (-10,0) rotated 180 shifted z0;
fill a shifted (-10,0) rotated 135 shifted z1;
draw (-10,0) rotated 135 shifted z1 {dir -45}..{dir 45}(-10,0) rotated 45 shifted z1;

label.top(btex {\tt a} etex, (z0 + z2)/2);
label.lrt(btex {\tt a},{\tt b} etex, (z1 + z2)/2);
label.llft(btex {\tt b} etex, (z0+z1)/2);
label.lft(btex {\tt a} etex, z1 shifted (-12,-16));

def	state(expr z, f, s) =
	path	p;
	p = z shifted (-10,0)..z shifted(0,-10)
			..z shifted(10,0)..z shifted(0,10)..cycle;
	if s > 0:
		fill p withcolor (1,0.8,0.8);
	else:
		fill p withcolor (1,1,1);
	fi;
	pickup pencircle scaled 0.5pt;
	draw p;
	if f > 0:
		draw z shifted (-8,0)..z shifted(0,-8)
			..z shifted(8,0)..z shifted(0,8)..cycle;
	
	fi
enddef; 

state(z0, 1, 0);
state(z1, 0, 1);
state(z2, 0, 1);

label(btex $q_0$ etex, z0);
label(btex $q_1$ etex, z1);
label(btex $q_2$ etex, z2);

endfig;

beginfig(5)
z1 = (0,-50);
z2 = z1 rotated 120;
z0 = z2 rotated 120;

draw z0--z1--z2--cycle;
draw z0 shifted (-30,0)--z0;

path	a;
a = (-2,0)--(-3,-2)--(0,0)--(-3,2)--cycle;

fill a shifted z0 shifted (-10,0);
fill a shifted (-10,0) rotated -60 shifted z1;
fill a shifted (-10,0) rotated 60 shifted z2;
fill a shifted (-10,0) rotated 180 shifted z0;
fill a shifted (-10,0) rotated 135 shifted z1;
draw (-10,0) rotated 135 shifted z1 {dir -45}..{dir 45}(-10,0) rotated 45 shifted z1;

label.top(btex {\tt a} etex, (z0 + z2)/2);
label.lrt(btex {\tt a},{\tt b} etex, (z1 + z2)/2);
label.llft(btex {\tt b} etex, (z0+z1)/2);
label.lft(btex {\tt a} etex, z1 shifted (-12,-16));

def	state(expr z, f, s) =
	path	p;
	p = z shifted (-10,0)..z shifted(0,-10)
			..z shifted(10,0)..z shifted(0,10)..cycle;
	if s > 0:
		fill p withcolor (1,0.8,0.8);
	else:
		fill p withcolor (1,1,1);
	fi;
	pickup pencircle scaled 0.5pt;
	draw p;
	if f > 0:
		draw z shifted (-8,0)..z shifted(0,-8)
			..z shifted(8,0)..z shifted(0,8)..cycle;
	
	fi
enddef; 

state(z0, 1, 1);
state(z1, 0, 1);
state(z2, 0, 1);

label(btex $q_0$ etex, z0);
label(btex $q_1$ etex, z1);
label(btex $q_2$ etex, z2);

endfig;

beginfig(6)

z0 = (0,0);
z1 = (260,0);
z2 = (0,180);
z3 = z1 + z2;

pickup pencircle scaled 1pt;

draw z0--z1--z3--z2--cycle;

z10 = (20, 100);
z11 = (40, 100);
draw z10..z11..cycle;

drawarrow (-30,100)--z10;

z20 = (100,140);
z21 = (120,140);
draw z20..z21..cycle;

z30 = (180,100);
z31 = (200,100);

draw z30..z31..cycle;

z40 = (100,40);
z41 = (120,40);

draw z40..z41..cycle;

path p, q, r;
p = z11{dir 0}..{dir 0}z20;
drawarrow p withcolor (0,1,0);
label.ulft(btex $x$ etex, point 0.5 of p) withcolor (0,1,0);

drawarrow z21{dir 0}..{dir -90}(190,110) withcolor (1,0,0);
q = (190,90){dir -90}..{dir -180}z41;
drawarrow (190,90){dir -90}..{dir -180}z41 withcolor (1,0,0);
label.ulft(btex $y$ etex, point 0.5 of q) withcolor (1,0,0);
drawarrow z40{dir 180}..{dir 90}(110,130) withcolor (1,0,0);

r = (110,150){dir 90}..(160,170)..{dir -180}z31;
drawarrow r withcolor (0,0,1);
label.rt(btex $z$ etex, point 1.5 of r) withcolor (0,0,1);
drawarrow z30{dir -180}..{dir -90}(110,50) withcolor (0,0,1);

z50 = (220,60);
z51 = (240,60);
draw z50..z51..cycle;
draw (z50 shifted(2,0))..(z51 shifted (-2,0))..cycle;

drawarrow (110,30){dir -90}..(120,15)..{dir 0}z50 withcolor (0,0,1);

endfig;

end
