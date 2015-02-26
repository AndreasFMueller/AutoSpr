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

pickup pencircle scaled 1pt;

drawarrow (-10,0)--(210,0);

pickup pencircle scaled 3pt;

draw (0,0);	label.bot(btex $p$ etex, (0,0));
draw (200,0);	label.bot(btex $q$ etex, (200,0));

pickup pencircle scaled 0.5pt;

draw (0,0)--(30,30)--(40,20)--(50,30)--(80,0)--(100,20)--(110,10)--(150,50)--(200,0);

pickup pencircle scaled 1pt;
drawarrow (0,20)--(0,50);
label.rt(btex Stack etex, (0,50));

label.urt(btex $b,?\to\varepsilon$ etex, (195,5)) withcolor(1,1,1);
label.ulft(btex $a,\varepsilon\to ?$ etex, (5,5)) withcolor(1,1,1);

pickup pencircle scaled 3pt;
draw (80,0) withcolor(1,0,0);	label.bot(btex $r$ etex, (80,0)) withcolor(1,0,0);

endfig;

%
% Stack nie leer
%
beginfig(2)

pickup pencircle scaled 1pt;

drawarrow (-10,0)--(210,0);

pickup pencircle scaled 3pt;

draw (0,0);	label.bot(btex $p$ etex, (0,0));
draw (10,0);	label.bot(btex $r$ etex, (10,0));
draw (190,0);	label.bot(btex $s$ etex, (190,0));
draw (200,0);	label.bot(btex $q$ etex, (200,0));

pickup pencircle scaled 0.5pt;

draw (10,10)--(30,30)--(40,20)--(80,60)--(100,40)--(110,50)--(140,20)--(160,40)--(190,10);

pickup pencircle scaled 1pt;

drawarrow (0,0)--(10,10) withcolor(1,0,0);
label.ulft(btex $a,\varepsilon\to ?$ etex, (5,5)) withcolor(1,0,0);
drawarrow (190,10)--(200,0) withcolor(1,0,0);
label.urt(btex $b,?\to\varepsilon$ etex, (195,5)) withcolor(1,0,0);

drawarrow (10,10)--(190,10) withcolor(1,0,0);
label.top(btex $A_{rs}$ etex, (100,10)) withcolor(1,0,0);

pickup pencircle scaled 1pt;
drawarrow (0,20)--(0,60);
label.rt(btex Stack etex, (0,60));

endfig;

end
