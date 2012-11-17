
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% complexity chapter
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

verbatimtex
\documentclass{book}
\usepackage{times}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsfonts}
\usepackage{txfonts}
\begin{document}
etex;

def	andgate(expr z) =
	pickup pencircle scaled 1pt;
	draw (z shifted (-30,30))--(z shifted (-30,-30));
	draw (z shifted (-30,30)){right}..z..{left}(z shifted (-30,-30));
	draw z--(z shifted (20,0));
	draw (z shifted (-50,20))--(z shifted (-30,20));
	draw (z shifted (-50,-20))--(z shifted (-30,-20));
enddef;

def	notgate(expr z) =
	pickup pencircle scaled 1pt;
	draw (z shifted (-30, 17.321))--(z shifted (-30,-17.321))--z--cycle;
	draw z--(z shifted (20,0));
	draw (z shifted (-50,0))--(z shifted (-30,0));
	fill (z shifted (-3,0))..(z shifted (0,-3))..(z shifted (3,0))
		..(z shifted(0,3))..cycle withcolor white;
	draw (z shifted (-3,0))..(z shifted (0,-3))..(z shifted (3,0))
		..(z shifted(0,3))..cycle;
enddef;

def	orgate(expr z) =
	pickup pencircle scaled 1pt;
	draw (z shifted (-70,20))--(z shifted (-40,20));
	draw (z shifted (-70,-20))--(z shifted (-40,-20));
	fill (z shifted (-50,30)){right}..{dir -60}z{dir -120}
		..{left}(z shifted (-50,-30)){dir 60}
		..{dir 120}(z shifted (-50,30))--cycle withcolor white;
	draw (z shifted (-50,30)){right}..{dir -60}z{dir -120}
		..{left}(z shifted (-50,-30)){dir 60}
		..{dir 120}(z shifted (-50,30))--cycle;
	draw z--(z shifted (20,0));
enddef;

beginfig(1)

pickup pencircle scaled 1pt;
	z0 = (-50,0);
	andgate(z0 shifted (-110,0));
	label.bot(btex AND etex, z0 shifted (-125,-40));
	orgate(z0 shifted (0,0));
	label.bot(btex OR etex, z0 shifted (-25,-40));
	notgate(z0 shifted (90,0));
	label.bot(btex NOT etex, z0 shifted (75,-40));
endfig;

beginfig(2)
	pickup pencircle scaled 1pt;

	z0 = (0,0);
	z1 = (-90,50);
	z2 = (-90,-50);

	orgate(z0);

	andgate(z1); draw (z1 shifted (20,0))--(z0 shifted (-70,20));
	andgate(z2); draw (z2 shifted (20,0))--(z0 shifted (-70,-20));

	z3 = (-140,30);
	z4 = (-140,-70);

	notgate(z3 shifted (-20,0));
	notgate(z4 shifted (-20,0));

	draw (-120,-30)--(-210,-30)--(-210,30);

	draw (-230,30)--(-210,30); label.lft(btex $x$ etex, (-230,30));
	draw (-230,70)--(-140,70); label.lft(btex $y$ etex, (-230, 70));
	draw (-230,-70)--(-210,-70); label.lft(btex $z$ etex, (-230,-70));

	label.top(btex $\bar x$ etex, (-140,30));
	label.top(btex $y\wedge\bar x$ etex, (-70,50));
	label.bot(btex $x\wedge\bar z$ etex, (-70,-50));
	label.rt(btex $(\bar x\wedge y)\vee(x\wedge \bar z)$ etex,
		z0 shifted (20,0));
endfig;

end
