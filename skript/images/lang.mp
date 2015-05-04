beginfig(1)
verbatimtex
\documentclass[12pt]{book}
\usepackage{times}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsfonts}
\usepackage{txfonts}
\usepackage{german}
\usepackage{color}
\begin{document}
etex;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% regular languages, contextfree languages
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pickup pencircle scaled 1pt;

label.top(btex regul"are etex, (0,0));
label.bot(btex Sprachen etex, (0,0));

draw (-30,0)..(0,-30)..(30,0)..(0,30)..cycle;
draw (-50,0)..(30,-50)..(110,0)..(30,50)..cycle;

label.top(btex kontextfreie etex, (70,0));
label.bot(btex Sprachen etex, (70,0));

endfig;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% regular languages, contextfree languages, decidable languages
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beginfig(2)

pickup pencircle scaled 1pt;

label.top(btex regul"are etex, (0,0));
label.bot(btex Sprachen etex, (0,0));

draw (-30,0)..(0,-30)..(30,0)..(0,30)..cycle;
draw (-50,0)..(30,-50)..(110,0)..(30,50)..cycle;
draw (-70,0)..(60,-70)..(190,0)..(60,70)..cycle;

label.top(btex kontextfreie etex, (70,0));
label.bot(btex Sprachen etex, (70,0));

label.top(btex entscheidbare etex, (150,0));
label.bot(btex Sprachen etex, (150,0));

endfig;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% regular languages, contextfree languages, decidable languages
% Turing erkennbare Sprachen
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beginfig(3)

pickup pencircle scaled 1pt;

label.top(btex regul"are etex, (0,0));
label.bot(btex Sprachen etex, (0,0));

draw (-30,0)..(0,-30)..(30,0)..(0,30)..cycle;
draw (-50,0)..(30,-50)..(110,0)..(30,50)..cycle;
draw (-70,0)..(60,-70)..(190,0)..(60,70)..cycle;
draw (-90,0)..(90,-90)..(270,0)..(90,90)..cycle;

label.top(btex kontextfreie etex, (70,0));
label.bot(btex Sprachen etex, (70,0));

label(btex $\color{blue}\{\texttt{0}^n\texttt{1}^n\,|\,n\ge 0\}$ etex, (46,-34));

label.top(btex entscheidbare etex, (150,0));
label.bot(btex Sprachen etex, (150,0));

label(btex $\color{blue}\{\texttt{a}^n\texttt{b}^n\texttt{c}^n\,|\,n\ge 0\}$ etex, (123,-44));

label.top(btex Turing etex, (230,3));
label(btex erkennbare etex, (230,0));
label.bot(btex Sprachen etex, (230,-5));

label(btex $\color{blue}\textit{HALT}\varepsilon_{\text{TM}}$ etex, (200,-54));

endfig;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% P and NP
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beginfig(4)

pickup pencircle scaled 0.4pt;

%draw (-15,0)..(0,-15)..(15,0)..(0,15)..cycle;
label(btex P etex, (0,0));

draw (70,20)..(20,32){left}..(-32,0)..{right}(20,-32)..(70,-20);
draw (20,30){left}..(-30,0)..{right}(20,-30)--cycle;
%draw (20,30)..(20,-30);

label(btex NP etex, (45,0));

pickup pencircle scaled 2pt;
draw (70,20)--(70,-20);
label.rt(btex NP-vollst"andig etex, (70,0));

label.top(btex ``leicht'' etex, (-40,40));
label.top(btex ``schwierig'' etex, (80,40));

pickup pencircle scaled 1pt;
draw (-40,40)--(80,40);
fill (80,40)--(79,38)--(82,40)--(79,42)--cycle;

endfig;

beginfig(5)

pickup pencircle scaled 0.4pt;

draw (-32,0)..{right}(20,-32)..(72,0)..(20,32)..cycle;
draw (20,30){left}..(-30,0)..{right}(20,-30)--cycle;

label(btex NP etex, (45,0));
label(btex P etex, (0,0));

draw (-50,40){up}..{right}(-40,50)--(80,50){right}..{down}(90,40)--(90,-40){down}..{left}(80,-50)--(-40,-50){left}..{up}(-50,-40)--cycle;

label.llft(btex entscheidbar etex, (88,48));

endfig;

beginfig(6)

draw (-32,0)..{right}(20,-32)..(72,0)..(20,32)..cycle;
draw (20,30){left}..(-30,0)..{right}(20,-30)--cycle;

label(btex NP etex, (45,0));
label(btex P etex, (0,0));

label.top(btex ``leicht'' etex, (-40,40));
label.top(btex ``schwierig'' etex, (80,40));

pickup pencircle scaled 1pt;
draw (-40,40)--(80,40);
fill (80,40)--(79,38)--(82,40)--(79,42)--cycle;


endfig;

end
