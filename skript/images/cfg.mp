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

pickup pencircle scaled 0.5pt;

fill (-40,0)--(10,125)--(60,0)--(20,0)--(0,50)--(-20,0)--cycle
	withcolor (0.8,0.8,0.8);

draw (-100,0)--(0,250)--(100,0);

draw (-40,0)--(10,125)--(60,0);
draw (-20,0)--(0,50)--(20,0);

label.bot(btex $u$ etex, (-70,0));
label.bot(btex $v$ etex, (-30,0));
label.bot(btex $x$ etex, (0,0));
label.bot(btex $y$ etex, (40,0));
label.bot(btex $z$ etex, (80,0));


fill (5,120)..(15,120)..(15,130)..(5,130)..cycle withcolor (1.0,1.0,1.0);
fill (-5,45)..(5,45)..(5,55)..(-5,55)..cycle withcolor (1.0,1.0,1.0);
fill (-5,245)..(5,245)..(5,255)..(-5,255)..cycle withcolor (1.0,1.0,1.0);

label(btex $S$ etex, (0,250));
label(btex $A$ etex, (10,125));
label(btex $A$ etex, (0,50));

pickup pencircle scaled 1pt;

draw (-100,0)--(100,0);

endfig;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% aufpumpen
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beginfig(2)

pickup pencircle scaled 0.5pt;

fill (-40,0)--(10,125)--(60,0)--(20,0)--(0,50)--(-20,0)--cycle
	withcolor (0.8,0.8,0.8);
fill (-50,-75)--(0,50)--(50,-75)--(10,-75)--(-10,-25)--(-30,-75)--cycle
	withcolor (0.8,0.8,0.8);

draw (-100,0)--(0,250)--(100,0);

draw (-40,0)--(10,125)--(60,0);
draw (-50,-75)--(0,50)--(50,-75);
draw (-30,-75)--(-10,-25)--(10,-75);

label.bot(btex $u$ etex, (-70,0));
label.bot(btex $v$ etex, (-30,0));
label.bot(btex $v$ etex, (-40,-75));
label.bot(btex $x$ etex, (-10,-75));
label.bot(btex $y$ etex, (40,0));
label.bot(btex $y$ etex, (30,-75));
label.bot(btex $z$ etex, (80,0));

fill (5,120)..(15,120)..(15,130)..(5,130)..cycle withcolor (1.0,1.0,1.0);
fill (-5,45)..(5,45)..(5,55)..(-5,55)..cycle withcolor (1.0,1.0,1.0);
fill (-15,-30)..(-5,-30)..(-5,-20)..(-15,-20)..cycle withcolor (1.0,1.0,1.0);
fill (-5,245)..(5,245)..(5,255)..(-5,255)..cycle withcolor (1.0,1.0,1.0);

label(btex $S$ etex, (0,250));
label(btex $A$ etex, (10,125));
label(btex $A$ etex, (0,50));
label(btex $A$ etex, (-10,-25));

pickup pencircle scaled 1pt;

draw (-100,0)--(-20,0);
draw (20,0)--(100,0);
draw (-50,-75)--(50,-75);

endfig;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% abpumpen
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beginfig(3)

pickup pencircle scaled 0.5pt;

draw (-100,0)--(0,250)--(100,0);

draw (-40,0)--(10,125)--(60,0);

label.bot(btex $u$ etex, (-70,0));
label.bot(btex $x$ etex, (10,75));
label.bot(btex $z$ etex, (80,0));
label.bot(btex $y$ etex, (-40,-75)) withcolor (1.0,1.0,1.0);


fill (5,120)..(15,120)..(15,130)..(5,130)..cycle withcolor (1.0,1.0,1.0);
fill (-5,245)..(5,245)..(5,255)..(-5,255)..cycle withcolor (1.0,1.0,1.0);

label(btex $S$ etex, (0,250));
label(btex $A$ etex, (10,125));

pickup pencircle scaled 1pt;

draw (-100,0)--(-40,0);
draw (60,0)--(100,0);
draw (-10,75)--(30,75);

endfig;

end
