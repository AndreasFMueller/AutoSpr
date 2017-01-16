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
% Floodit
%
beginfig(1)

z70 = (0,0);

numeric h;
h = 10;

color rot, blau, gruen;
rot := (1, 0.5, 0.5);
blau := (0.5, 0.5, 1);
gruen := (0.5, 1, 0.5);

numeric o;
o := 0;
pair offsets[];
for o = 0 step 1 until 4:
	offsets[o] = (8 * o * h, 0);
endfor;
o := 0;

def square(expr z, c) =
	fill (z--(z shifted (h,0))--(z shifted (h,h))--(z shifted (0,h))--cycle)
		shifted offsets[o] withcolor c;
enddef;

def netz(expr z) =
	pickup pencircle scaled 0.5pt;
	for x = 0 step 6 until 6:
		draw ((x * h, 0)--(x * h, 6 * h)) shifted z;
	endfor;
	for y = 0 step 6 until 6:
		draw ((0, y * h)--(6 * h, y * h)) shifted z;
	endfor;
enddef;

def pfeil =
	pickup pencircle scaled 1pt;
	drawarrow ((z74 shifted (0.25 * h, 0))--(z74 shifted (1.75 * h,0))) shifted offsets[o];
enddef;

z11 = (0,0) * h;
z12 = (0,1) * h;
z13 = (0,2) * h;
z14 = (0,3) * h;
z15 = (0,4) * h;
z16 = (0,5) * h;
z17 = (0,6) * h;

z21 = (1,0) * h;
z22 = (1,1) * h;
z23 = (1,2) * h;
z24 = (1,3) * h;
z25 = (1,4) * h;
z26 = (1,5) * h;
z27 = (1,6) * h;

z31 = (2,0) * h;
z32 = (2,1) * h;
z33 = (2,2) * h;
z34 = (2,3) * h;
z35 = (2,4) * h;
z36 = (2,5) * h;
z37 = (2,6) * h;

z41 = (3,0) * h;
z42 = (3,1) * h;
z43 = (3,2) * h;
z44 = (3,3) * h;
z45 = (3,4) * h;
z46 = (3,5) * h;
z47 = (3,6) * h;

z51 = (4,0) * h;
z52 = (4,1) * h;
z53 = (4,2) * h;
z54 = (4,3) * h;
z55 = (4,4) * h;
z56 = (4,5) * h;
z57 = (4,6) * h;

z61 = (5,0) * h;
z62 = (5,1) * h;
z63 = (5,2) * h;
z64 = (5,3) * h;
z65 = (5,4) * h;
z66 = (5,5) * h;
z67 = (5,6) * h;

z71 = (6,0) * h;
z72 = (6,1) * h;
z73 = (6,2) * h;
z74 = (6,3) * h;
z75 = (6,4) * h;
z76 = (6,5) * h;
z77 = (6,6) * h;


square(z16, rot  ); square(z26, gruen); square(z36, rot  ); square(z46, blau ); square(z56, rot  ); square(z66, gruen);
square(z15, blau ); square(z25, rot  ); square(z35, blau ); square(z45, gruen); square(z55, blau ); square(z65, gruen);
square(z14, blau ); square(z24, blau ); square(z34, gruen); square(z44, blau ); square(z54, blau ); square(z64, blau );
square(z13, blau ); square(z23, gruen); square(z33, rot  ); square(z43, blau ); square(z53, rot  ); square(z63, gruen);
square(z12, blau ); square(z22, gruen); square(z32, rot  ); square(z42, gruen); square(z52, gruen); square(z62, gruen);
square(z11, rot  ); square(z21, blau ); square(z31, rot  ); square(z41, gruen); square(z51, blau ); square(z61, rot  );

netz(offsets[o]);
pfeil;

pickup pencircle scaled 1pt;
draw (z17--z16--z26--z27--cycle) shifted offsets[0];

o := 1;

square(z16, blau ); square(z26, gruen); square(z36, rot  ); square(z46, blau ); square(z56, rot  ); square(z66, gruen);
square(z15, blau ); square(z25, rot  ); square(z35, blau ); square(z45, gruen); square(z55, blau ); square(z65, gruen);
square(z14, blau ); square(z24, blau ); square(z34, gruen); square(z44, blau ); square(z54, blau ); square(z64, blau );
square(z13, blau ); square(z23, gruen); square(z33, rot  ); square(z43, blau ); square(z53, rot  ); square(z63, gruen);
square(z12, blau ); square(z22, gruen); square(z32, rot  ); square(z42, gruen); square(z52, gruen); square(z62, gruen);
square(z11, rot  ); square(z21, blau ); square(z31, rot  ); square(z41, gruen); square(z51, blau ); square(z61, rot  );

netz(offsets[o]);
pfeil;

pickup pencircle scaled 1pt;
draw (z17--z12--z22--z24--z34--z35--z25--z27--cycle) shifted offsets[o];

o := 2;

square(z16, gruen); square(z26, gruen); square(z36, rot  ); square(z46, blau ); square(z56, rot  ); square(z66, gruen);
square(z15, gruen); square(z25, rot  ); square(z35, blau ); square(z45, gruen); square(z55, blau ); square(z65, gruen);
square(z14, gruen); square(z24, gruen); square(z34, gruen); square(z44, blau ); square(z54, blau ); square(z64, blau );
square(z13, gruen); square(z23, gruen); square(z33, rot  ); square(z43, blau ); square(z53, rot  ); square(z63, gruen);
square(z12, gruen); square(z22, gruen); square(z32, rot  ); square(z42, gruen); square(z52, gruen); square(z62, gruen);
square(z11, rot  ); square(z21, blau ); square(z31, rot  ); square(z41, gruen); square(z51, blau ); square(z61, rot  );

netz(offsets[o]);
pfeil;

pickup pencircle scaled 1pt;
draw (z17--z12--z32--z34--z44--z45--z25--z26--z36--z37--cycle) shifted offsets[o];

o := 3;

square(z16, rot  ); square(z26, rot  ); square(z36, rot  ); square(z46, blau ); square(z56, rot  ); square(z66, gruen);
square(z15, rot  ); square(z25, rot  ); square(z35, blau ); square(z45, gruen); square(z55, blau ); square(z65, gruen);
square(z14, rot  ); square(z24, rot  ); square(z34, rot  ); square(z44, blau ); square(z54, blau ); square(z64, blau );
square(z13, rot  ); square(z23, rot  ); square(z33, rot  ); square(z43, blau ); square(z53, rot  ); square(z63, gruen);
square(z12, rot  ); square(z22, rot  ); square(z32, rot  ); square(z42, gruen); square(z52, gruen); square(z62, gruen);
square(z11, rot  ); square(z21, blau ); square(z31, rot  ); square(z41, gruen); square(z51, blau ); square(z61, rot  );

netz(offsets[o]);
pfeil;

pickup pencircle scaled 1pt;
draw (z17--z11--z21--z22--z32--z31--z41--z45--z35--z36--z46--z47--cycle) shifted offsets[o];

o := 4;

square(z16, blau ); square(z26, blau ); square(z36, blau ); square(z46, blau ); square(z56, rot  ); square(z66, gruen);
square(z15, blau ); square(z25, blau ); square(z35, blau ); square(z45, gruen); square(z55, blau ); square(z65, gruen);
square(z14, blau ); square(z24, blau ); square(z34, blau ); square(z44, blau ); square(z54, blau ); square(z64, blau );
square(z13, blau ); square(z23, blau ); square(z33, blau ); square(z43, blau ); square(z53, rot  ); square(z63, gruen);
square(z12, blau ); square(z22, blau ); square(z32, blau ); square(z42, gruen); square(z52, gruen); square(z62, gruen);
square(z11, blau ); square(z21, blau ); square(z31, blau ); square(z41, gruen); square(z51, blau ); square(z61, rot  );

netz(offsets[o]);

pickup pencircle scaled 1pt;
draw (z17--z11--z41--z43--z53--z54--z74--z75--z65--z66--z56--z55--z45--z46--z56--z57--cycle) shifted offsets[o];

endfig;

end
