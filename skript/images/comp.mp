
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% complexity chapter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beginfig(1)
verbatimtex
\documentclass{book}
\usepackage{times}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsfonts}
\usepackage{txfonts}
\begin{document}
etex;

z1 = (100,0);
z2 = z1 rotated 60;
z3 = z2 rotated 60;
z4 = z3 rotated 60;
z5 = z4 rotated 60;
z6 = z5 rotated 60;

pickup pencircle scaled 1pt;

def node(expr z) =
	fill (z shifted (-10,0))
		..(z shifted (0,-10))
		..(z shifted (10,0))
		..(z shifted (0,10))..cycle withcolor white;
	draw (z shifted (-10,0))
		..(z shifted (0,-10))
		..(z shifted (10,0))
		..(z shifted (0,10))..cycle;
enddef;

draw z1--z2;
draw z1--z3;
draw z1--z4;
draw z2--z4;
draw z2--z5;
draw z3--z4;
draw z4--z5;
draw z4--z6;
draw z5--z6;

node(z1);
node(z2);
node(z3);
node(z4);
node(z5);
node(z6);

endfig;

beginfig(2)

z1 = (100,0);
z2 = z1 rotated 60;
z3 = z2 rotated 60;
z4 = z3 rotated 60;
z5 = z4 rotated 60;
z6 = z5 rotated 60;

pickup pencircle scaled 1pt;

def node(expr z, c) =
	if c > 0:
		fill (z shifted (-10,0))
			..(z shifted (0,-10))
			..(z shifted (10,0))
			..(z shifted (0,10))..cycle withcolor (1,0.8,0.8);
	else:
		fill (z shifted (-10,0))
			..(z shifted (0,-10))
			..(z shifted (10,0))
			..(z shifted (0,10))..cycle withcolor white;
	fi
	draw (z shifted (-10,0))
		..(z shifted (0,-10))
		..(z shifted (10,0))
		..(z shifted (0,10))..cycle;
enddef;

draw z1--z2 withcolor(1,0,0);
draw z1--z3;
draw z1--z4 withcolor(1,0,0);
draw z2--z4 withcolor(1,0,0);
draw z2--z5;
draw z3--z4;
draw z4--z5;
draw z4--z6;
draw z5--z6;

node(z1, 1);
node(z2, 1);
node(z3, 0);
node(z4, 1);
node(z5, 0);
node(z6, 0);

endfig;

beginfig(3)

z1 = (100,0);
z2 = z1 rotated 60;
z3 = z2 rotated 60;
z4 = z3 rotated 60;
z5 = z4 rotated 60;
z6 = z5 rotated 60;

pickup pencircle scaled 1pt;

def node(expr z, c) =
	if c > 0:
		fill (z shifted (-10,0))
			..(z shifted (0,-10))
			..(z shifted (10,0))
			..(z shifted (0,10))..cycle withcolor (1,0.8,0.8);
	else:
		fill (z shifted (-10,0))
			..(z shifted (0,-10))
			..(z shifted (10,0))
			..(z shifted (0,10))..cycle withcolor white;
	fi
	draw (z shifted (-10,0))
		..(z shifted (0,-10))
		..(z shifted (10,0))
		..(z shifted (0,10))..cycle;
enddef;

draw z1--z2;
draw z1--z3 withcolor(1,0,0);
draw z1--z4 withcolor(1,0,0);
draw z2--z4;
draw z2--z5;
draw z3--z4 withcolor(1,0,0);
draw z4--z5;
draw z4--z6;
draw z5--z6;

node(z1, 1);
node(z2, 0);
node(z3, 1);
node(z4, 1);
node(z5, 0);
node(z6, 0);

endfig;

beginfig(4)

z1 = (100,0);
z2 = z1 rotated 60;
z3 = z2 rotated 60;
z4 = z3 rotated 60;
z5 = z4 rotated 60;
z6 = z5 rotated 60;

pickup pencircle scaled 1pt;

def node(expr z, c) =
	if c > 0:
		fill (z shifted (-10,0))
			..(z shifted (0,-10))
			..(z shifted (10,0))
			..(z shifted (0,10))..cycle withcolor (1,0.8,0.8);
	else:
		fill (z shifted (-10,0))
			..(z shifted (0,-10))
			..(z shifted (10,0))
			..(z shifted (0,10))..cycle withcolor white;
	fi
	draw (z shifted (-10,0))
		..(z shifted (0,-10))
		..(z shifted (10,0))
		..(z shifted (0,10))..cycle;
enddef;

draw z1--z2;
draw z1--z3;
draw z1--z4;
draw z2--z4 withcolor (1,0,0);
draw z2--z5 withcolor (1,0,0);
draw z3--z4;
draw z4--z5 withcolor (1,0,0);
draw z4--z6;
draw z5--z6;

node(z1, 0);
node(z2, 1);
node(z3, 0);
node(z4, 1);
node(z5, 1);
node(z6, 0);

endfig;

beginfig(5)

z1 = (100,0);
z2 = z1 rotated 60;
z3 = z2 rotated 60;
z4 = z3 rotated 60;
z5 = z4 rotated 60;
z6 = z5 rotated 60;

pickup pencircle scaled 1pt;

def node(expr z, c) =
	if c > 0:
		fill (z shifted (-10,0))
			..(z shifted (0,-10))
			..(z shifted (10,0))
			..(z shifted (0,10))..cycle withcolor (1,0.8,0.8);
	else:
		fill (z shifted (-10,0))
			..(z shifted (0,-10))
			..(z shifted (10,0))
			..(z shifted (0,10))..cycle withcolor white;
	fi
	draw (z shifted (-10,0))
		..(z shifted (0,-10))
		..(z shifted (10,0))
		..(z shifted (0,10))..cycle;
enddef;

draw z1--z2;
draw z1--z3;
draw z1--z4;
draw z2--z4;
draw z2--z5;
draw z3--z4;
draw z4--z5 withcolor (1,0,0);
draw z4--z6 withcolor (1,0,0);
draw z5--z6 withcolor (1,0,0);

node(z1, 0);
node(z2, 0);
node(z3, 0);
node(z4, 1);
node(z5, 1);
node(z6, 1);

endfig;

beginfig(6)

z1 = (0,0);
z2 = (100,0);
z3 = (100,100);
z4 = (0,100);

def node(expr z, c) =
	pickup pencircle scaled 1pt;
	fill (z shifted (-10,0))
		..(z shifted (0,-10))
		..(z shifted (10,0))
		..(z shifted (0,10))..cycle withcolor c;
	draw (z shifted (-10,0))
		..(z shifted (0,-10))
		..(z shifted (10,0))
		..(z shifted (0,10))..cycle;
enddef;

pickup pencircle scaled 1pt;

draw z1--z2;
draw z2--z3;
draw z3--z4;
draw z1--z4;
draw z1--z3;

node(z1, (204/255,0,0));
node(z2, (0,204/255,0));
node(z3, (51/255,153/255,1));
node(z4, (0,204/255,0));

endfig;

beginfig(7)

z1 = (0,0);
z2 = (100,0);
z3 = (100,100);
z4 = (0,100);

def node(expr z, c) =
	pickup pencircle scaled 1pt;
	fill (z shifted (-10,0))
		..(z shifted (0,-10))
		..(z shifted (10,0))
		..(z shifted (0,10))..cycle withcolor c;
	draw (z shifted (-10,0))
		..(z shifted (0,-10))
		..(z shifted (10,0))
		..(z shifted (0,10))..cycle;
enddef;

pickup pencircle scaled 1pt;

draw z1--z2;
draw z2--z3;
draw z3--z4;
draw z1--z4;
draw z1--z3;
draw z2--z4;

node(z1, (204/255,0,0));
node(z2, (0,204/255,0));
node(z3, (51/255,153/255,1));
node(z4, (1,204/255,0));

endfig;

end
