verbatimtex
\documentclass{book}
\usepackage{times}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsfonts}
\usepackage{txfonts}
\begin{document}
etex;

beginfig(1)

numeric u;
u = 30;

def schwarz(expr i, j) =
	fill (i * u, j * u)--((i+1) * u, j * u)--((i+1) * u, (j+1) * u)--(i * u, (j+1) * u)--cycle withcolor 0.8;
enddef;

schwarz(0,2);
schwarz(1,1);
schwarz(2,0);

pickup pencircle scaled 1pt;

for i = 0 step 1 until 3:
	draw (i * u, 0 * u)--(i * u, 3 * u);
	draw (0 * u, i * u)--(3 * u, i * u);
endfor;

endfig;

end
