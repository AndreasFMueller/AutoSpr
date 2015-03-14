verbatimtex
\documentclass[12pt]{book}
\usepackage{times}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsfonts}
\usepackage{txfonts}
\begin{document}
etex;

%
% Stack zwischenzeitlich leer
%
beginfig(1)

numeric h;
h = 15;
numeric i, j;

pickup pencircle scaled 0.5pt;

for i = 0 step 1 until 9:
	draw (0, h * i)--(9 * h, h * i);
	draw (h * i, 0)--(h * i, 9 * h);
endfor

pickup pencircle scaled 1pt;

for i = 0 step 3 until 9:
	draw (0, h * i)--(9 * h, h * i);
	draw (h * i, 0)--(h * i, 9 * h);
endfor

def zeichen(expr u, i, j) =
	label(u, ((i - 0.5) * h, (j - 0.5) * h))
enddef;

zeichen(btex $7$ etex, 1, 9) withcolor (0.8,0.8,0.8);
zeichen(btex $6$ etex, 2, 9);
zeichen(btex $1$ etex, 3, 9) withcolor (0.8,0.8,0.8);
zeichen(btex $3$ etex, 4, 9) withcolor (0.8,0.8,0.8);
zeichen(btex $5$ etex, 5, 9);
zeichen(btex $4$ etex, 6, 9) withcolor (0.8,0.8,0.8);
zeichen(btex $2$ etex, 7, 9);
zeichen(btex $9$ etex, 8, 9) withcolor (0.8,0.8,0.8);
zeichen(btex $8$ etex, 9, 9) withcolor (0.8,0.8,0.8);

zeichen(btex $8$ etex, 1, 8);
zeichen(btex $4$ etex, 2, 8) withcolor (0.8,0.8,0.8);
zeichen(btex $9$ etex, 3, 8);
zeichen(btex $6$ etex, 4, 8) withcolor (0.8,0.8,0.8);
zeichen(btex $1$ etex, 5, 8);
zeichen(btex $2$ etex, 6, 8) withcolor (0.8,0.8,0.8);
zeichen(btex $5$ etex, 7, 8) withcolor (0.8,0.8,0.8);
zeichen(btex $3$ etex, 8, 8);
zeichen(btex $7$ etex, 9, 8) withcolor (0.8,0.8,0.8);

zeichen(btex $2$ etex, 1, 7) withcolor (0.8,0.8,0.8);
zeichen(btex $3$ etex, 2, 7);
zeichen(btex $5$ etex, 3, 7);
zeichen(btex $7$ etex, 4, 7) withcolor (0.8,0.8,0.8);
zeichen(btex $8$ etex, 5, 7) withcolor (0.8,0.8,0.8);
zeichen(btex $9$ etex, 6, 7) withcolor (0.8,0.8,0.8);
zeichen(btex $6$ etex, 7, 7) withcolor (0.8,0.8,0.8);
zeichen(btex $1$ etex, 8, 7) withcolor (0.8,0.8,0.8);
zeichen(btex $4$ etex, 9, 7) withcolor (0.8,0.8,0.8);

zeichen(btex $6$ etex, 1, 6);
zeichen(btex $1$ etex, 2, 6) withcolor (0.8,0.8,0.8);
zeichen(btex $2$ etex, 3, 6);
zeichen(btex $5$ etex, 4, 6);
zeichen(btex $7$ etex, 5, 6) withcolor (0.8,0.8,0.8);
zeichen(btex $3$ etex, 6, 6) withcolor (0.8,0.8,0.8);
zeichen(btex $8$ etex, 7, 6);
zeichen(btex $4$ etex, 8, 6);
zeichen(btex $9$ etex, 9, 6) withcolor (0.8,0.8,0.8);

zeichen(btex $4$ etex, 1, 5) withcolor (0.8,0.8,0.8);
zeichen(btex $8$ etex, 2, 5);
zeichen(btex $3$ etex, 3, 5);
zeichen(btex $2$ etex, 4, 5);
zeichen(btex $9$ etex, 5, 5) withcolor (0.8,0.8,0.8);
zeichen(btex $6$ etex, 6, 5) withcolor (0.8,0.8,0.8);
zeichen(btex $7$ etex, 7, 5);
zeichen(btex $5$ etex, 8, 5) withcolor (0.8,0.8,0.8);
zeichen(btex $1$ etex, 9, 5);

zeichen(btex $9$ etex, 1, 4) withcolor (0.8,0.8,0.8);
zeichen(btex $5$ etex, 2, 4) withcolor (0.8,0.8,0.8);
zeichen(btex $7$ etex, 3, 4) withcolor (0.8,0.8,0.8);
zeichen(btex $8$ etex, 4, 4) withcolor (0.8,0.8,0.8);
zeichen(btex $4$ etex, 5, 4);
zeichen(btex $1$ etex, 6, 4);
zeichen(btex $3$ etex, 7, 4) withcolor (0.8,0.8,0.8);
zeichen(btex $2$ etex, 8, 4) withcolor (0.8,0.8,0.8);
zeichen(btex $6$ etex, 9, 4) withcolor (0.8,0.8,0.8);

zeichen(btex $5$ etex, 1, 3) withcolor (0.8,0.8,0.8);
zeichen(btex $9$ etex, 2, 3);
zeichen(btex $6$ etex, 3, 3) withcolor (0.8,0.8,0.8);
zeichen(btex $1$ etex, 4, 3) withcolor (0.8,0.8,0.8);
zeichen(btex $3$ etex, 5, 3) withcolor (0.8,0.8,0.8);
zeichen(btex $7$ etex, 6, 3);
zeichen(btex $4$ etex, 7, 3);
zeichen(btex $8$ etex, 8, 3) withcolor (0.8,0.8,0.8);
zeichen(btex $2$ etex, 9, 3);

zeichen(btex $3$ etex, 1, 2) withcolor (0.8,0.8,0.8);
zeichen(btex $2$ etex, 2, 2) withcolor (0.8,0.8,0.8);
zeichen(btex $4$ etex, 3, 2);
zeichen(btex $9$ etex, 4, 2) withcolor (0.8,0.8,0.8);
zeichen(btex $6$ etex, 5, 2) withcolor (0.8,0.8,0.8);
zeichen(btex $8$ etex, 6, 2);
zeichen(btex $1$ etex, 7, 2) withcolor (0.8,0.8,0.8);
zeichen(btex $7$ etex, 8, 2);
zeichen(btex $5$ etex, 9, 2) withcolor (0.8,0.8,0.8);

zeichen(btex $1$ etex, 1, 1) withcolor (0.8,0.8,0.8);
zeichen(btex $7$ etex, 2, 1) withcolor (0.8,0.8,0.8);
zeichen(btex $8$ etex, 3, 1) withcolor (0.8,0.8,0.8);
zeichen(btex $4$ etex, 4, 1) withcolor (0.8,0.8,0.8);
zeichen(btex $2$ etex, 5, 1) withcolor (0.8,0.8,0.8);
zeichen(btex $5$ etex, 6, 1) withcolor (0.8,0.8,0.8);
zeichen(btex $9$ etex, 7, 1);
zeichen(btex $6$ etex, 8, 1);
zeichen(btex $3$ etex, 9, 1) withcolor (0.8,0.8,0.8);

endfig;

end
