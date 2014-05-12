verbatimtex
\documentclass{book}
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

for i = 0 step 1 until 4:
	draw (0, h * i)--(4 * h, h * i);
	draw (h * i, 0)--(h * i, 4 * h);
endfor

pickup pencircle scaled 1pt;

for i = 0 step 2 until 4:
	draw (0, h * i)--(4 * h, h * i);
	draw (h * i, 0)--(h * i, 4 * h);
endfor

def zeichen(expr u, i, j) =
	label(u, ((i - 0.5) * h, (j - 0.5) * h))
enddef;

zeichen(btex $3$ etex, 1, 4) withcolor (0.8,0.8,0.8);
zeichen(btex $2$ etex, 2, 4) withcolor (0.8,0.8,0.8);
zeichen(btex $1$ etex, 3, 4); % withcolor (0.8,0.8,0.8);
zeichen(btex $4$ etex, 4, 4); % withcolor (0.8,0.8,0.8);

zeichen(btex $4$ etex, 1, 3) withcolor (0.8,0.8,0.8);
zeichen(btex $1$ etex, 2, 3) withcolor (0.8,0.8,0.8);
zeichen(btex $2$ etex, 3, 3) withcolor (0.8,0.8,0.8);
zeichen(btex $3$ etex, 4, 3) withcolor (0.8,0.8,0.8);

zeichen(btex $1$ etex, 1, 2) withcolor (0.8,0.8,0.8);
zeichen(btex $3$ etex, 2, 2) withcolor (0.8,0.8,0.8);
zeichen(btex $4$ etex, 3, 2) withcolor (0.8,0.8,0.8);
zeichen(btex $2$ etex, 4, 2) withcolor (0.8,0.8,0.8);

zeichen(btex $2$ etex, 1, 1); % withcolor (0.8,0.8,0.8);
zeichen(btex $4$ etex, 2, 1); % withcolor (0.8,0.8,0.8);
zeichen(btex $3$ etex, 3, 1) withcolor (0.8,0.8,0.8);
zeichen(btex $1$ etex, 4, 1) withcolor (0.8,0.8,0.8);

endfig;

end
