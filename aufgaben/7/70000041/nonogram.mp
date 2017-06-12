verbatimtex
\documentclass{book}
\usepackage{times}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsfonts}
\usepackage{txfonts}
\begin{document}
etex;

numeric u;
u := 11;

def efeld(expr x, y, c) =
	fill (x*u, y*u)--((x+1)*u,y*u)--((x+1)*u,(y+1)*u)--(x*u,(y+1)*u)--cycle
		withcolor c;
enddef;

def feld(expr x, y, v, c) =
	efeld(x, y, c);
	label(v, (u * (x + 0.5), u * (y + 0.5))) withcolor white;
enddef;

def vorgabe =

color gray;
gray := 0.9 * white;
color rot;
rot = (1, 0.5, 0.5);
color blau;
blau = (0.5, 0.5, 1);

fill (0*u,10*u)--(4*u,10*u)--(4*u,13*u)--(0,13*u)--cycle withcolor gray;

     feld(5, 12, btex $3$ etex, blau);
      feld(6, 12, btex $1$ etex, blau);
           feld(11, 12, btex $1$ etex, blau);
            feld(12, 12, btex $3$ etex, blau);
             feld(13, 12, btex $1$ etex, blau);

    feld(4, 11, btex $1$ etex, blau);
     feld(5, 11, btex $1$ etex, rot);
      feld(6, 11, btex $3$ etex, rot);
           feld(11, 11, btex $5$ etex, rot);
            feld(12, 11, btex $3$ etex, rot);
             feld(13, 11, btex $1$ etex, rot);

    feld(4, 10, btex $1$ etex, blau);
     feld(5, 10, btex $3$ etex, blau);
      feld(6, 10, btex $1$ etex, blau);
       feld(7, 10, btex $5$ etex, rot);
        feld(8, 10, btex $5$ etex, rot);
         feld(9, 10, btex $5$ etex, rot);
          feld(10, 10, btex $5$ etex, rot);
           feld(11, 10, btex $1$ etex, blau);
            feld(12, 10, btex $3$ etex, blau);
             feld(13, 10, btex $1$ etex, blau);

  feld(2, 9, btex $1$ etex, blau);
   feld(3, 9, btex $1$ etex, blau);

  feld(2, 8, btex $3$ etex, blau);
   feld(3, 8, btex $3$ etex, blau);

feld(0, 7, btex $1$ etex, blau);
 feld(1, 7, btex $1$ etex, rot);
  feld(2, 7, btex $1$ etex, rot);
   feld(3, 7, btex $1$ etex, blau);

  feld(2, 6, btex $3$ etex, rot);
   feld(3, 6, btex $3$ etex, rot);

   feld(3, 5, btex $9$ etex, rot);

   feld(3, 4, btex $7$ etex, rot);

  feld(2, 3, btex $5$ etex, rot);
   feld(3, 3, btex $1$ etex, blau);

 feld(1, 2, btex $1$ etex, blau);
  feld(2, 2, btex $3$ etex, rot);
   feld(3, 2, btex $3$ etex, blau);

 feld(1, 1, btex $3$ etex, blau);
  feld(2, 1, btex $1$ etex, rot);
   feld(3, 1, btex $1$ etex, blau);
 
 feld(3, 0, btex $1$ etex, blau);

pickup pencircle scaled 1pt;

for x = 1 step 1 until 3:
	draw (x * u, 0)--(x * u, 10 * u) withcolor gray;
endfor;
for x = 4 step 1 until 13:
	draw (x * u, 0)--(x * u, 13 * u) withcolor gray;
endfor;
for y = 1 step 1 until 10:
	draw (0, y * u)--(14 * u, y * u) withcolor gray;
endfor;
for y = 11 step 1 until 12:
	draw (4 * u, y * u)--(14 * u, y * u) withcolor gray;
endfor;

pickup pencircle scaled 0.2pt;
draw (4 * u, 0)--(4 * u, 13 * u);
draw (0, 10 * u)--(14 * u, 10 * u);

pickup pencircle scaled 1.5pt;
draw (0,0)--(14 * u,0);
draw (14 * u,0)--(14 * u, 13 * u);
draw (0,0)--(0,13*u);
draw (0,13*u)--(14*u,13*u);

enddef;

beginfig(1)

vorgabe;

endfig;

beginfig(2)

color blau;
blau = (0.0,0.0,1);
color rot;
rot = (1,0.0,0.0);

 efeld(5, 9, blau);
        efeld(12, 9, blau);

efeld(4, 8, blau);
 efeld(5, 8, blau);
  efeld(6, 8, blau);
       efeld(11, 8, blau);
        efeld(12, 8, blau);
         efeld(13, 8, blau);

 efeld(5, 7, blau);
   efeld(7, 7, rot);
       efeld(11, 7, rot);
        efeld(12, 7, blau);

  efeld(6, 6, rot);
   efeld(7, 6, rot);
    efeld(8, 6, rot);
      efeld(10, 6, rot);
       efeld(11, 6, rot);
        efeld(12, 6, rot);

 efeld(5, 5, rot);
  efeld(6, 5, rot);
   efeld(7, 5, rot);
    efeld(8, 5, rot);
     efeld(9, 5, rot);
      efeld(10, 5, rot);
       efeld(11, 5, rot);
        efeld(12, 5, rot);
         efeld(13, 5, rot);

  efeld(6, 4, rot);
   efeld(7, 4, rot);
    efeld(8, 4, rot);
     efeld(9, 4, rot);
      efeld(10, 4, rot);
       efeld(11, 4, rot);
        efeld(12, 4, rot);

   efeld(7, 3, rot);
    efeld(8, 3, rot);
     efeld(9, 3, rot);
      efeld(10, 3, rot);
       efeld(11, 3, rot);
        efeld(12, 3, blau);

 efeld(5, 2, blau);
    efeld(8, 2, rot);
     efeld(9, 2, rot);
      efeld(10, 2, rot);
       efeld(11, 2, blau);
        efeld(12, 2, blau);
         efeld(13, 2, blau);

efeld(4, 1, blau);
 efeld(5, 1, blau);
  efeld(6, 1, blau);
     efeld(9, 1, rot);
        efeld(12, 1, blau);

efeld(5, 0, blau);

vorgabe;

endfig;

end
