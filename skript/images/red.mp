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

pickup pencircle scaled 0.5pt;
draw (50,130){right}..{right}(220,120);
draw (50,30){right}..{right}(200,20);
fill (50,130){right}..{right}(220,120)--(200,20){left}..{left}(50,30)--cycle withcolor (0.95,0.95,0.95);

pickup pencircle scaled 1pt;

% rectangles
draw (0,0)--(100,0)--(100,160)--(0,160)--cycle;
label.llft(btex $\Sigma^*$ etex, (100,160));
draw (150,0)--(250,0)--(250,160)--(150,160)--cycle;
label.llft(btex $\Sigma^*$ etex, (250,160));

path a;
a = (25,80)..(50,30)..(75,80)..(50,130)..cycle;
fill a withcolor(0.8,0.8,0.8);
draw a;

label(btex $A$ etex, (50,80));

path b;
b = (180,30)..{right}(200,20)..(230,100)..{left}(220,120)..(200,50)..(190,40)..cycle;
fill b withcolor(0.8,0.8,0.8);
draw b;
label(btex $B$ etex, (215,80));

%fill (45,80)..(50,75)..(55,80)..(50,85)..cycle withcolor(1,1,1);

label(btex $f$ etex, (125,70));

% points w and f(w)
pickup pencircle scaled 3pt;
draw (50,50);
label.top(btex $w$ etex, (50,50));
draw (210,30);
label.top(btex $f(w)$ etex, (210,30));

% Arrow w -> f(w)
pickup pencircle scaled 0.5pt;
draw (55,50){right}..{right}(205,30);
fill (203,30)--(202,28)--(205,30)--(202,32)--cycle;

endfig;

end
