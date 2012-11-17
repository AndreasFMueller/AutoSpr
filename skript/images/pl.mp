

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% pumping lemma
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (0.8,0,0); rot
% (0,0.8,0); gruen
% (0.2,0.6,1); blau
% (1,0.8,0); gelb

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

pickup pencircle scaled 1pt;

fill (-100,0)--(-70,0)--(-70,20)--(-100,20)--cycle withcolor (0.8,1,0.8);
fill (-70,0)--(-20,0)--(-20,20)--(-70,20)--cycle withcolor (1,0.7,0.7);
fill (-20,0)--(100,0)--(100,20)--(-20,20)--cycle withcolor (0.9,0.975,1);

draw (-100,0)--(100,0)--(100,20)--(-100,20)--cycle;
draw (0,0)--(0,20);
draw (180,0)--(180,20) withcolor white;

label(btex $x\strut$ etex, (-85,10));% withcolor (0,1,0);
label(btex $y\strut$ etex, (-45,10));% withcolor (0,1,0);
label(btex $z\strut$ etex, (40,10));% withcolor (0,1,0);

label.lft(btex $w=\strut$ etex, (-110, 10));

%label.top(btex $0$ etex, (-100,20));
%label.top(btex $N$ etex, (0,20));
%label.top(btex $2N$ etex, (100,20));

label.rt(btex $\in L$ etex, (160,10));

endfig;

beginfig(2)

pickup pencircle scaled 1pt;

draw (-100,0)--(100,0)--(100,20)--(-100,20)--cycle;
draw (0,0)--(0,20);
draw (180,0)--(180,20) withcolor white;

label(btex $0^N$ etex, (-50,10));
label(btex $1^N$ etex, (50,10));

label.lft(btex $w=\strut$ etex, (-110, 10));

label.top(btex $0$ etex, (-100,20));
label.top(btex $N$ etex, (0,20));
label.top(btex $2N$ etex, (100,20));

label.rt(btex $\in L$ etex, (160,10));

endfig;

beginfig(3)

pickup pencircle scaled 1pt;

fill (-100,0)--(-70,0)--(-70,20)--(-100,20)--cycle withcolor (0.8,1,0.8);
fill (-70,0)--(50,0)--(50,20)--(-70,20)--cycle withcolor (0.9,0.975,1);

label(btex $x\strut$ etex, (-85,10));
label(btex $z\strut$ etex, (15,10));

draw (-100,0)--(50,0)--(50,20)--(-100,20)--cycle;
draw (-50,0)--(-50,20);
draw (180,0)--(180,20) withcolor white;

label.lft(btex $w=\strut$ etex, (-110, 10)) withcolor white;

label.rt(btex $\not \in L$ etex, (160,10));

endfig;

beginfig(4)

pickup pencircle scaled 1pt;

fill (-100,0)--(-70,0)--(-70,20)--(-100,20)--cycle withcolor (0.8,1,0.8);
fill (-70,0)--(30,0)--(30,20)--(-70,20)--cycle withcolor (1,0.7,0.7);
fill (30,0)--(150,0)--(150,20)--(30,20)--cycle withcolor (0.9,0.975,1);

draw (-100,0)--(150,0)--(150,20)--(-100,20)--cycle;
draw (50,0)--(50,20);
draw (180,0)--(180,20) withcolor white;

label(btex $x\strut$ etex, (-85,10));% withcolor (0,1,0);
label(btex $y\strut$ etex, (-45,10));% withcolor (0,1,0);
label(btex $y\strut$ etex, (5,10));% withcolor (0,1,0);
label(btex $z\strut$ etex, (90,10));% withcolor (0,1,0);

label.lft(btex $w=\strut$ etex, (-110, 10)) withcolor white;

label.rt(btex $\not \in L$ etex, (160,10));

endfig;

beginfig(5)

pickup pencircle scaled 1pt;

draw (-100,0)--(200,0)--(200,20)--(-100,20)--cycle;
draw (0,0)--(0,20);
draw (100,0)--(100,20);
label.top(btex $0$ etex, (-100,20));
label.top(btex $N$ etex, (0,20));
label.top(btex $2N$ etex, (100,20));
label.top(btex $3N$ etex, (200,20));

label(btex ${\tt a}^N\strut$ etex, (-50,10));
label(btex ${\tt b}^N\strut$ etex, (50,10));
label(btex ${\tt c}^N\strut$ etex, (150,10));

label.rt(btex $\in L\strut$ etex, (260,10));
label.lft(btex $w =\strut$ etex, (-110,10));

endfig;

beginfig(6)

pickup pencircle scaled 1pt;

fill (-100,0)--(-30,0)--(-30,20)--(-100,20)--cycle withcolor(0.9,0.975,1);
fill (50,0)--(200,0)--(200,20)--(50,20)--cycle withcolor(0.9,0.975,1);

fill (-30,0)--(-10,0)--(-10,20)--(-30,20)--cycle withcolor(1,0.7,0.7);
fill (20,0)--(50,0)--(50,20)--(20,20)--cycle withcolor(1,0.7,0.7);

fill (-10,0)--(20,0)--(20,20)--(-10,20)--cycle withcolor(0.8,1,0.8);

draw (-100,0)--(200,0)--(200,20)--(-100,20)--cycle;
draw (0,0)--(0,20);
draw (100,0)--(100,20);
%label.top(btex $0$ etex, (-100,20));
%label.top(btex $N$ etex, (0,20));
%label.top(btex $2N$ etex, (100,20));
%label.top(btex $3N$ etex, (200,20));

label(btex $u\strut$ etex, (-65,10));
label(btex $v\strut$ etex, (-20,10));
label(btex $x\strut$ etex, (5,10));
label(btex $y\strut$ etex, (35,10));
label(btex $z\strut$ etex, (125,10));

pickup pencircle scaled 0.1pt;
draw (-30,0)--(-30,-20);
draw (50,0)--(50,-20);
pickup pencircle scaled 0.5pt;
draw (-30,-15)--(50,-15);
fill (0,-20)--(20,-20)--(20,-10)--(0,-10)--cycle withcolor(1,1,1);
label(btex $\le N$ etex, (10,-15));
fill (-30,-15)--(-27,-17)--(-28,-15)--(-27,-13)--cycle;
fill (50,-15)--(47,-17)--(48,-15)--(47,-13)--cycle;

label.rt(btex $\in L\strut$ etex, (260,10));
label.lft(btex $w =\strut$ etex, (-110,10));

endfig;

beginfig(7)

pickup pencircle scaled 1pt;

fill (-100,0)--(-30,0)--(-30,20)--(-100,20)--cycle withcolor(0.9,0.975,1);
%fill (-30,0)--(-10,0)--(-10,20)--(-30,20)--cycle withcolor(1,0.7,0.7);
fill (-30,0)--(0,0)--(0,20)--(-30,20)--cycle withcolor(0.8,1,0.8);
%fill (20,0)--(50,0)--(50,20)--(20,20)--cycle withcolor(1,0.7,0.7);
fill (0,0)--(150,0)--(150,20)--(0,20)--cycle withcolor(0.9,0.975,1);


draw (-100,0)--(150,0)--(150,20)--(-100,20)--cycle;
draw (-20,0)--(-20,20);
draw (50,0)--(50,20);
%label.top(btex $0$ etex, (-100,20));
%label.top(btex $N$ etex, (0,20));
%label.top(btex $2N$ etex, (100,20));
%label.top(btex $3N$ etex, (200,20));

label(btex $u\strut$ etex, (-65,10));
label(btex $x\strut$ etex, (-15,10));
label(btex $z\strut$ etex, (75,10));

label.rt(btex $\not\in L\strut$ etex, (260,10));
label.lft(btex $w =\strut$ etex, (-110,10)) withcolor white;

endfig;

beginfig(8)

pickup pencircle scaled 1pt;

fill (-100,0)--(-30,0)--(-30,20)--(-100,20)--cycle withcolor(0.9,0.975,1);
fill (-30,0)--(10,0)--(10,20)--(-30,20)--cycle withcolor(1,0.7,0.7);
fill (10,0)--(40,0)--(40,20)--(10,20)--cycle withcolor(0.8,1,0.8);
fill (40,0)--(100,0)--(100,20)--(40,20)--cycle withcolor(1,0.7,0.7);
fill (100,0)--(250,0)--(250,20)--(100,20)--cycle withcolor(0.9,0.975,1);


draw (-100,0)--(250,0)--(250,20)--(-100,20)--cycle;
draw (20,0)--(20,20);
draw (150,0)--(150,20);
%label.top(btex $0$ etex, (-100,20));
%label.top(btex $N$ etex, (0,20));
%label.top(btex $2N$ etex, (100,20));
%label.top(btex $3N$ etex, (200,20));

label(btex $u\strut$ etex, (-65,10));
label(btex $v\strut$ etex, (-20,10));
label(btex $v\strut$ etex, (0,10));
label(btex $x\strut$ etex, (25,10));
label(btex $y\strut$ etex, (55,10));
label(btex $y\strut$ etex, (85,10));
label(btex $z\strut$ etex, (175,10));

label.rt(btex $\not\in L\strut$ etex, (260,10));
label.lft(btex $w =\strut$ etex, (-110,10)) withcolor white;

endfig;

end
