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
u := 20;

def punkt(expr x, y) =
	(x * u, (4 - y) * u)
enddef;

def feld(expr x, y, c, d) =
	fill punkt(x, y)--punkt(x,y+1)--punkt(x+1,y+1)--cycle withcolor c;
	fill punkt(x, y)--punkt(x+1,y+1)--punkt(x+1,y)--cycle withcolor d;
enddef;

def symfeld(expr x, y, c, d) =
	feld(x, y, c, d);
	feld(y, x, d, c);
enddef;

def vollfeld(expr x, y, c) =
	feld(x, y, c, c);
enddef;


beginfig(1)

pickup pencircle scaled 1pt;

vollfeld(0, 0, black);
vollfeld(1, 1, black);
vollfeld(2, 2, black);
vollfeld(3, 3, black);
vollfeld(0, 3, black);
vollfeld(3, 0, black);

for x = 0 step 1 until 4:
	draw punkt(0, x)--punkt(4, x);
	draw punkt(x, 0)--punkt(x, 4);
endfor

endfig;

beginfig(2)

pickup pencircle scaled 1pt;

vollfeld(0, 0, black);
vollfeld(1, 1, black);
vollfeld(2, 2, black);
vollfeld(3, 3, black);
vollfeld(0, 3, black);
vollfeld(3, 0, black);

color	gruen, rot, blau;
gruen := (      0, 204/255, 0);
rot   := (204/255,       0, 0);
blau  := ( 51/255, 153/255, 1);

symfeld(0, 1, blau, gruen);
symfeld(0, 2, rot, gruen);
symfeld(1, 2, rot, blau);
symfeld(1, 3, gruen, blau);
symfeld(2, 3, gruen, rot);

vollfeld(0, -1, gruen);
vollfeld(1, -1, blau);
vollfeld(2, -1, rot);
vollfeld(3, -1, gruen);

vollfeld(-1, 0, gruen);
vollfeld(-1, 1, blau);
vollfeld(-1, 2, rot);
vollfeld(-1, 3, gruen);

for x = 0 step 1 until 4:
	draw punkt(0, x)--punkt(4, x);
	draw punkt(x, 0)--punkt(x, 4);
endfor

endfig;

end

