//
// Filename: cordic.c
// Purpose : N-address code (NAC) implementation for a fixed-point universal 
//           CORDIC. The arithmetic representation used is signed fixed-point 
//           (Q2.14S). The implementation has been generated by a modified 
//           version of the simple fixed-point CORDIC tools from:
//           http://www.dcs.gla.ac.uk/~jhw/cordic/
// Author  : Nikolaos Kavvadias (C) 2010
// Date    : 31-Oct-2010
// Revision: 0.3.0 (31/10/10)
//           Initial version.
//           0.3.1 (08/11/10)
//           Description of the universal CORDIC algorithm is finalized.
// 
#include <stdio.h>
#include <math.h>

#define ROTATION   0
#define VECTORING  1
#define CIRCULAR   0
#define LINEAR     1
#define HYPERBOLIC 2

typedef short int integer;
//typedef integer int;

//Cordic in 16 bit signed fixed point math
//Function is valid for arguments in range -pi/2 -- pi/2
//for values pi/2--pi: value = half_pi-(theta-half_pi) and similarly for values -pi---pi/2
//
// 1.0 = 16384
// 1/k = 0.6072529350088812561694
// pi = 3.1415926536897932384626
//Constants
#define MY_PI 3.1415926536897932384626
// Q2.14S
#define cordic_1K 9949
#define cordic_1Kp 19783
#define half_pi 25735
#define MUL 16384.000000
#define CORDIC_NTAB 14
integer cordic_tab[3*CORDIC_NTAB] = {
  65535 /* NOT USED */, 8999, 4184, 2058, 1025, 512, 256, 128, 64, 32, 16, 8, 4, 2, /* HYPERBOLIC */
  16384, 8192, 4096, 2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2,                /* LINEAR */
  12867, 7596, 4013, 2037, 1022, 511, 255, 127, 63, 31, 15, 7, 3, 1                 /* CIRCULAR */
};
// for convergence in hyperbolic mode, steps 4 and 13 must be repeated
integer cordic_hyp_steps[] = {
//	1, 2, 3, 4, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28
	1, 2, 3, 4, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 13
};
integer gdirection; // {0: ROTATION, 1: VECTORING}
integer gmode; // {0: CIRCULAR, 1: LINEAR, 2: HYPERBOLIC}

void cordicopt(integer direction, integer mode, integer xin, integer yin, integer zin, integer *xout, integer *yout, integer *zout)
{
  integer k, kk, d, x1, x2, y1, y2, z1, z2;
  integer x, y, z;
  integer kstart, kfinal, xbyk, ybyk, tabval;
  integer offset;

  x = xin;
  y = yin;
  z = zin;
  offset = ((mode == HYPERBOLIC) ? 0 : ((mode == LINEAR) ? 14 : 28));
  kfinal = ((mode != HYPERBOLIC) ? CORDIC_NTAB : CORDIC_NTAB+1);
  for (k = 0; k < kfinal; k++)
  {
    d = ((direction == ROTATION) ? ((z>=0) ? 0 : 1) : ((y<0) ? 0 : 1));
    kk = ((mode != HYPERBOLIC) ? k : cordic_hyp_steps[k]);
    xbyk = (x>>kk);
    ybyk = ((mode == HYPERBOLIC) ? -(y>>kk) : ((mode == LINEAR) ? 0 : (y>>kk)));
    tabval = cordic_tab[kk+offset];
    x1 = x - ybyk;
    x2 = x + ybyk;
    y1 = y + xbyk;
    y2 = y - xbyk;
    z1 = z - tabval;
    z2 = z + tabval;
    x = ((d == 0) ? x1 : x2);
    y = ((d == 0) ? y1 : y2);
    z = ((d == 0) ? z1 : z2);
  }  
  *xout = x;
  *yout = y;
  *zout = z;
}

int main(int argc, char **argv)
{
  double p;
  integer x1, y1, z1, x2, y2, z2, i, temp;   
  integer w1;

  // ROTATION, SIN/COS
#ifndef DATAGEN
  printf("SINE, COSINE\n");
#endif
  gdirection = ROTATION; gmode = CIRCULAR;
  x1 = cordic_1K; y1 = 0;
  for (i = 0; i < 50; i++)
  {
    p = (i/50.0)*MY_PI/2;        
    z1 = (integer)(p * MUL);
    cordic(gdirection, gmode, x1, y1, z1, &x2, &y2, &z2);
#ifdef DATAGEN    
// Use this to generate the "cordic_test_data.txt" reference vectors.
    printf("%04x %04x %04x %04x %04x %04x %04x %04x\n", 
      gdirection, gmode, x1&0xffff, y1&0xffff, z1&0xffff, x2&0xffff, y2&0xffff, z2&0xffff);
#else
// Use this to compare floating-point (math.h) against CORDIC fixed-point
// results.
    printf("%f : cos=%f (%f), sin=%f (%f)\n", p, x2/MUL, cos(p), y2/MUL, sin(p));
#endif    
  }       

  // VECTORING, ATAN
#ifndef DATAGEN
  printf("\nARCTAN\n");
#endif
  gdirection = VECTORING; gmode = CIRCULAR;
  z1 = 0;
  for (x1 = 0; x1 <= 7000; x1+=500)
  {
    for (y1 = 0; y1 <= 7000; y1+=500)
    { 
      cordic(gdirection, gmode, x1, y1, z1, &x2, &y2, &z2);
#ifdef DATAGEN    
// Use this to generate the "cordic_test_data.txt" reference vectors.
    printf("%04x %04x %04x %04x %04x %04x %04x %04x\n", 
      gdirection, gmode, x1&0xffff, y1&0xffff, z1&0xffff, x2&0xffff, y2&0xffff, z2&0xffff);
#else
// Use this to compare floating-point (math.h) against CORDIC fixed-point
// results.
      printf("%d/%d: atan=%f (%f), y2 = %d\n", y1, x1, z2/MUL, atan((double)y1/x1), y2);
#endif
    }
  }       

  // HYPERBOLIC, VECTORING, SQUARE ROOT
#ifndef DATAGEN
  printf("\nSQUARE ROOT\n");
#endif
  gdirection = VECTORING; gmode = HYPERBOLIC;
  z1 = 0;
  for (w1 = 100; w1 <= 7000; w1+=100)
  {
     x1 = w1+(1<<12);
     y1 = w1-(1<<12);
     cordic(gdirection, gmode, x1, y1, z1, &x2, &y2, &z2);
#ifdef DATAGEN    
// Use this to generate the "cordic_test_data.txt" reference vectors.
    printf("%04x %04x %04x %04x %04x %04x %04x %04x\n", 
      gdirection, gmode, x1&0xffff, y1&0xffff, z1&0xffff, x2&0xffff, y2&0xffff, z2&0xffff);
#else
// Use this to compare floating-point (math.h) against CORDIC fixed-point
// results.
    printf("%d: sqrt=%f (%f)\n", w1, (cordic_1Kp/MUL)*x2/MUL, sqrt((double)w1/MUL));
#endif
  } 

  // LINEAR, VECTORING, RECIPROCAL
#ifndef DATAGEN
  printf("\nRECIPROCAL\n");
#endif
  gdirection = VECTORING; gmode = LINEAR;
  z1 = 0;
  y1 = (1<<14);
  for (x1 = 32000; x1 > 8000; x1-=250)
  {
    cordic(gdirection, gmode, x1, y1, z1, &x2, &y2, &z2);
#ifdef DATAGEN    
// Use this to generate the "cordic_test_data.txt" reference vectors.
    printf("%04x %04x %04x %04x %04x %04x %04x %04x\n", 
      gdirection, gmode, x1&0xffff, y1&0xffff, z1&0xffff, x2&0xffff, y2&0xffff, z2&0xffff);
#else
// Use this to compare floating-point (math.h) against CORDIC fixed-point
// results.
    printf("%d: 1/x=%f (%f)\n", x1, z2/MUL, (double)y1/x1);
#endif
  } 

  // HYPERBOLIC, VECTORING, SQUARE ROOT + LINEAR, VECTORING, RECIPROCAL
#ifndef DATAGEN
  printf("\nINVERSE SQUARE ROOT\n");
#endif
  for (w1 = 4000; w1 <= 28600; w1+=200)
  {
    gdirection = VECTORING; gmode = HYPERBOLIC; 
    z1 = 0;
    x1 = w1+(1<<12);
    y1 = w1-(1<<12);
    cordic(gdirection, gmode, x1, y1, z1, &x2, &y2, &z2);
#ifdef DATAGEN    
// Use this to generate the "cordic_test_data.txt" reference vectors.
    printf("%04x %04x %04x %04x %04x %04x %04x %04x\n", 
      gdirection, gmode, x1&0xffff, y1&0xffff, z1&0xffff, x2&0xffff, y2&0xffff, z2&0xffff);
#else
// Use this to compare floating-point (math.h) against CORDIC fixed-point
// results.
    printf("%d: sqrt=%f (%f)\n", w1, (cordic_1Kp/MUL)*x2/MUL, sqrt((double)w1/MUL));
#endif
    gdirection = VECTORING; gmode = LINEAR; 
    z1 = 0; 
    y1 = (1<<14); 
    x1 = (cordic_1Kp/MUL)*x2;
    cordic(gdirection, gmode, x1, y1, z1, &x2, &y2, &z2);
#ifdef DATAGEN    
// Use this to generate the "cordic_test_data.txt" reference vectors.
    printf("%04x %04x %04x %04x %04x %04x %04x %04x\n", 
      gdirection, gmode, x1&0xffff, y1&0xffff, z1&0xffff, x2&0xffff, y2&0xffff, z2&0xffff);
#else
// Use this to compare floating-point (math.h) against CORDIC fixed-point
// results.
    printf("%d: 1/sqrt(x)=%f (%f)\n", w1, z2/MUL, sqrt((double)MUL/w1));
#endif
  } 
  return (0);
}