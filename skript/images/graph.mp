verbatimtex
\documentclass{book}
\usepackage{times}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsfonts}
\usepackage{txfonts}
\usepackage{german}
\begin{document}
etex;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Graph
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
beginfig(1)

numeric d;
d = 100;

z0 = (0,0);
z1 = (d,0);
z2 = (2*d,0);
z3 = (1.5 * d, d/2 * sqrt(3));
z4 = (0.5 * d, d/2 * sqrt(3));
z5 = (0.5 * d,-d/2 * sqrt(3));
z6 = (1.5 * d,-d/2 * sqrt(3));

label.lft(btex $v_0$ etex, z0);
label.top(btex $v_4$ etex, z4);
label.top(btex $v_3$ etex, z3);
label.bot(btex $v_5$ etex, z5);
label.bot(btex $v_6$ etex, z6);
label.rt(btex $v_2$ etex, z2);
label.ulft(btex $v_1$ etex, z1);

pickup pencircle scaled 1pt;
draw z0--z1;
draw z1--z2;
draw z2--z3;
draw z0--z4;
draw z4--z2;
draw z0--z3;
draw z1--z3;
draw z5--z2;
draw z5--z1;
draw z5--z6;
draw z1--z6;

pickup pencircle scaled 5pt;
draw z0;
draw z1;
draw z2;
draw z3;
draw z4;
draw z5;
draw z6;

pickup pencircle scaled 3pt;
draw z0 withcolor (1,1,1);
draw z1 withcolor (1,1,1);
draw z2 withcolor (1,1,1);
draw z3 withcolor (1,1,1);
draw z4 withcolor (1,1,1);
draw z5 withcolor (1,1,1);
draw z6 withcolor (1,1,1);

label.ulft(btex $e_0$ etex, 0.5[z0,z4]);
label.ulft(btex $e_1$ etex, 0.45[z0,z3]);
label.top(btex $e_2$ etex, 0.5[z0,z1]);
label.urt(btex $e_3$ etex, 0.8[z2,z4]);
label.lrt(btex $e_4$ etex, 0.3[z1,z3]);
label.urt(btex $e_5$ etex, 0.5[z2,z3]);
label.top(btex $e_6$ etex, 0.5[z1,z2]);
label.ulft(btex $e_7$ etex, 0.5[z1,z5]);
label.urt(btex $e_8$ etex, 0.3[z1,z6]);
label.lrt(btex $e_9$ etex, 0.3[z2,z5]);
label.bot(btex $e_{10}$ etex, 0.5[z5,z6]);

endfig;

%
% verbotener Graph
%
beginfig(2)

z0 = (0,0);
z1 = d * (cosd(25), sind(25));
z2 = 1.5 * z1;

pickup pencircle scaled 1pt;

draw z0--z1;
draw z1..z2..z1--cycle;

pickup pencircle scaled 5pt;
draw z0;
draw z1;

pickup pencircle scaled 3pt;

draw z0 withcolor (1,1,1);
draw z1 withcolor (1,1,1);

label.ulft(btex $v_0$ etex, z0);
label.urt(btex $v_1$ etex, z1);

pickup pencircle

endfig;

%
% Gerichteter Graph
%
beginfig(3)

numeric d;
d = 100;

z0 = (0,0);
z1 = (d,0);
z2 = (2*d,0);
z3 = (1.5 * d, d/2 * sqrt(3));
z4 = (0.5 * d, d/2 * sqrt(3));
z5 = (0.5 * d,-d/2 * sqrt(3));
z6 = (1.5 * d,-d/2 * sqrt(3));

label.lft(btex $v_0$ etex, z0);
label.top(btex $v_4$ etex, z4);
label.top(btex $v_3$ etex, z3);
label.bot(btex $v_5$ etex, z5);
label.bot(btex $v_6$ etex, z6);
label.rt(btex $v_2$ etex, z2);
label.ulft(btex $v_1$ etex, z1);

pickup pencircle scaled 1pt;
drawarrow z0--(0.98[z0,z1]); % e2
drawarrow z1--(0.98[z1,z2]); % e6
drawarrow z2--(0.98[z2,z3]); % e5
drawarrow z0--(0.98[z0,z4]); % e0
drawarrow z4--(0.99[z4,z2]); % e3
drawarrow z0--(0.99[z0,z3]); % e1
drawarrow z1--(0.98[z1,z3]); % e4
drawarrow z5--(0.99[z5,z2]); % e9
drawarrow z5--(0.98[z5,z1]); % e7
drawarrow z5--(0.98[z5,z6]); % e10
drawarrow z1--(0.98[z1,z6]); % e8

pickup pencircle scaled 5pt;
draw z0;
draw z1;
draw z2;
draw z3;
draw z4;
draw z5;
draw z6;

pickup pencircle scaled 3pt;
draw z0 withcolor (1,1,1);
draw z1 withcolor (1,1,1);
draw z2 withcolor (1,1,1);
draw z3 withcolor (1,1,1);
draw z4 withcolor (1,1,1);
draw z5 withcolor (1,1,1);
draw z6 withcolor (1,1,1);

label.ulft(btex $e_0$ etex, 0.5[z0,z4]);
label.ulft(btex $e_1$ etex, 0.45[z0,z3]);
label.top(btex $e_2$ etex, 0.5[z0,z1]);
label.urt(btex $e_3$ etex, 0.8[z2,z4]);
label.lrt(btex $e_4$ etex, 0.3[z1,z3]);
label.urt(btex $e_5$ etex, 0.5[z2,z3]);
label.top(btex $e_6$ etex, 0.5[z1,z2]);
label.ulft(btex $e_7$ etex, 0.5[z1,z5]);
label.urt(btex $e_8$ etex, 0.3[z1,z6]);
label.lrt(btex $e_9$ etex, 0.3[z2,z5]);
label.bot(btex $e_{10}$ etex, 0.5[z5,z6]);


endfig;

%
%
%
beginfig(4)

numeric d;
d = 100;

z0 = (0,0);
z1 = (d,0);
z2 = (2*d,0);
z3 = (1.5 * d, d/2 * sqrt(3));
z4 = (0.5 * d, d/2 * sqrt(3));
z5 = (0.5 * d,-d/2 * sqrt(3));
z6 = (1.5 * d,-d/2 * sqrt(3));

z10 = (1,0);
z11 = (cosd(30), sind(30));
z12 = (cosd(60), sind(60));
z13 = (cosd(90), sind(90));
z14 = (cosd(120), sind(120));
z15 = (cosd(150), sind(150));
z16 = (-1,0);
z17 = (cosd(210), sind(210));
z18 = (cosd(240), sind(240));
z19 = (cosd(270), sind(270));
z20 = (cosd(300), sind(300));
z21 = (cosd(330), sind(330));

label.lft(btex $v_0$ etex, z0);
label.top(btex $v_4$ etex, z4);
label.top(btex $v_3$ etex, z3);
label.bot(btex $v_5$ etex, z5);
label.bot(btex $v_6$ etex, z6);
label.rt(btex $v_2$ etex, z2);
label.ulft(btex $v_1$ etex, z1);

pickup pencircle scaled 1pt;
drawarrow z0--(0.98[z0,z1]);
drawarrow z1--(0.98[z1,z2]);
drawarrow z2--(0.98[z2,z3]);
drawarrow z0--(0.98[z0,z4]);
drawarrow z1--(0.98[z1,z3]);

drawarrow z0{dir 20}..{dir 40}0.99[z0,z3];
drawarrow z3{dir -160}..{dir -140}0.99[z3,z0];

drawarrow z5{dir 90}..{dir 30}(0.98[z5,z1]);
drawarrow z5{dir 30}..{dir 90}(0.98[z5,z1]);

drawarrow z5--(0.98[z5,z6]);
drawarrow z1--(0.98[z1,z6]);

pickup pencircle scaled 5pt;
draw z0;
draw z1;
draw z2;
draw z3;
draw z4;
draw z5;
draw z6;

pickup pencircle scaled 3pt;
draw z0 withcolor (1,1,1);
draw z1 withcolor (1,1,1);
draw z2 withcolor (1,1,1);
draw z3 withcolor (1,1,1);
draw z4 withcolor (1,1,1);
draw z5 withcolor (1,1,1);
draw z6 withcolor (1,1,1);

label.ulft(btex {\tt NCC 1701-D} etex, 0.5[z0,z4]);
label.ulft(btex {\tt ICE} etex, 0.5[z0,z3] shifted (5 * z14));
label.lrt(btex {\tt ICE} etex, 0.5[z0,z3] shifted (-5 * z14));

label.bot(btex {\tt Fussweg} etex, 0.5[z0,z1]);
label.lrt(btex {\tt S7} etex, 0.5[z1,z3]);
label.urt(btex {\tt S5} etex, 0.5[z2,z3]);
label.top(btex {\tt S5} etex, 0.5[z1,z2]);
label.urt(btex {\tt Taxi} etex, 0.5[z1,z6]);
label.bot(btex {\tt Bus} etex, 0.5[z5,z6]);

label.ulft(btex {\tt S5} etex, (0.5[z1,z5]) shifted (10 * z15));
label.lrt(btex {\tt S7} etex, (0.5[z1,z5]) shifted (10 * z21));

endfig;

end
