#include <math.h>
#include <stdio.h>
#include "arm_neon.h" // delete if it causes errors when compiling. 
//neon supports vectors inside of registers so it may be useful (probably not) 


//maths visualized on desmos links:
// https://www.desmos.com/calculator/go3wqxm0hu <- Rotation Mode
// idk ill do vectoring later
/*
	TODO:
		- On lines 82-85, check if that percision is only limited to 16 bits on the CORDIC.pdf
		 because the registers hes simulating are 16 bits or if its just an arbitrary number he picked for accuracy
			-> If arbitrary, leave the "1 << 15"s alone, else, change to 31
		- Check CORDIC_Rotating, did not have time to compile this program yet
		- Create some structs for the test bench to test for multiple x, y, z and theta variables
		- Check if zftable is accurate enough
		- Do a SIMD approach to the shifts, may need to utilize neon's "vectorization", whether it be embedded asm, changing manually in the .s file or specifying the --vectorize in compilation
			-> id imagine we'd change our registers from "r1 = 0xAB r2 = 0xCD" to "r3 = 0xABCD" and do our calculations on r3, then port them back to r1 and r2.
		- n issue slot machine? check it out..
		- change int size for addition and subtraction, if we lower it, these operations will be faster.
*/

#define FIXED_POINT_SCALE 32768. // 1 << 15
#define A_ 1.64676025806 // read slides 12, 13 and look at desmos calculations to understand referenced value.

// so "A_" in our calculations is what i like to call the "fuck you" number. this is because it makes you confused as to whats happening,
// so you spend an hour trying to debug PERFECTLY FINE code, then you realize its the mathematitions made it just to fuck with you. 

//table of precalculated atan(2^-i) up to 16 iterations
float zftable[16] = {
					45.00000000,
					26.56505118,
					14.03624347,
					7.125016349,
					3.576334375,
					1.789910608,
					0.895173710,
					0.447614171,
					0.223810500,
					0.111905677,
					0.055952892,
					0.027976453,
					0.013988227,
					0.006994114,
					0.003497057,
					0.001748528
};

void CORDIC_Rotating(int* x, int* y, int* theta, int ztable[16]) {
	int i = 0;
	register int x1 = *x; register int y1 = *y; register int theta1 = *theta;
	register int x2; register int y2;

	while (i < 16) {
		int sign = (!!theta1) | (theta1 >> 31);
		
		x2 = x1 - (sign * (y1 >> i));
		y2 = y1 + (sign * (x1 >> i));
		theta1 = theta1 - (sign * ztable[i]);
		x1 = x2;
		y1 = y2;
		
		//printf("theta1: %f,  iter: %d \n", ((double)theta1 / FIXED_POINT_SCALE), i); //debug
		i++;
	}
	*x = x1;
	*y = y1;
	*theta = theta1;
}

void CORDIC_Vectoring(int* x, int* y, int* z, int ztable[16]) {
	int i = 0;
	register int x1 = *x; register int y1 = *y; register int z1 = 0;
	register int x2; register int y2;

	while (i < 16) {
		int sign = 1 | (y1 >> 31); // (!!y1) can/should work in place of 1.
		
		x2 = x1 + (sign * (y1 >> i));
		y2 = y1 - (sign * (x1 >> i));
		z1 = z1 + (sign * ztable[i]);
		x1 = x2;
		y1 = y2;
		i++;
	}
	*x = x1;
	*y = y1;
	*z = z1;
}
/* 
PARAMS TO PAY ATTENTION TO      x: "any x input"  y: "any y input"
running in arctan(y/x) mode:    x_d = x, y_d = y, z_d = 0
running in arctan(x) mode:      x_d = 1, y_d = x, z_d = 0
running in cos()|sin() mode:    x_d = 1, y_d = 0, z_d = angle
*/

/*
Expected outputs from inputs:

Rotation mode:
	ins: theta = -25 degrees
		x = cos(-25 deg) = 0.906307787037
		y = sin(-25 deg) = -0.422618261741
Vectoring mode:	
*/

//Acts as current testbench
int main() {
	int zitable[16];
	double x_d, y_d, z_d; /* 64-bit floating-point variables */
	int x_i, y_i, z_i; 


	x_d = 1.;  
	y_d = 0.; 
	//z_d = atan(y_d / x_d); /* call math.h routines */
	z_d = -25;
	x_i = (int)(x_d * (FIXED_POINT_SCALE)); 
	y_i = (int)(y_d * (FIXED_POINT_SCALE)); 
	z_i = (int)(z_d * (FIXED_POINT_SCALE)); 

	int i;
	for (i = 0; i < 16; i++) {
		zitable[i] = (int)(zftable[i] * (FIXED_POINT_SCALE));
	} // generates fixed point table for z integers

	CORDIC_Rotating(&x_i, &y_i, &z_i, zitable);
	printf("z_i = %d\n", z_i);
	printf("z_d = %f\n", ((double)z_i / (double)(FIXED_POINT_SCALE)));
	printf("x_d ( Rotating ) = %f\n", ((double)x_i / (double)(FIXED_POINT_SCALE)) / (A_)); // A_ is used to transcribe from accumilated angle component to plain component
	printf("y_d ( Rotating ) = %f\n", ((double)y_i / (double)(FIXED_POINT_SCALE)) / (A_)); 
	printf("z_d ( angle ) = %f\n", z_d);

	return 0;
}
