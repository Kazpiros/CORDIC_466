#include <math.h>
#include <stdio.h>
#include "arm_neon.h" // delete if it causes errors when compiling. 
//neon supports vectors inside of registers so it may be useful (probably not) 

/*
	TODO:
		- On lines 82-85, check if that percision is only limited to 16 bits on the CORDIC.pdf
		 because the registers hes simulating are 16 bits or if its just an arbitrary number he picked for accuracy
		 	-> If arbitrary, leave the "1 << 15"s alone, else, change to 63
		- Check CORDIC_Rotating, did not have time to compile this program yet
		- Create some structs for the test bench to test for multiple x, y, z and theta variables
		- Check if zftable is accurate enough 

*/
//table of precalculated atan(2^-i) up to 16 iterations.. may want to increase if we figure out the mysterious " 15's " point #1 of the todo.
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

//blank array to store the fixed point conversion of the zftable
int zitable[16]; 

void CORDIC_Rotating(int* x, int* y, int* theta) {
	int i = 0;
	int x1 = *x; int y1 = *y; int z1 = *theta;
	int x2; int y2;
	
	while (i < 16) {
		int sign = (!!z1) | (z1 >> 63); 
		// im making the sigma operator reverse its intended output
		x2 = x1 - (sign * (y1 >> i)); 
		y2 = y1 + (sign * (x1 >> i));
		z1 = z1 - (sign * zitable[i]);
		x1 = x2;
		y1 = y2;
		i++;
	}
	*x = x1;
	*y = y1;
	*theta = z1;
}

void CORDIC_Vectoring(int* x, int* y, int* z) {
	int i = 0;
	int x1 = *x; int y1 = *y; int z1 = 0;
	int x2; int y2;

	while (i < 16) {
		int sign = 1 | (y1 >> 63); //assuming 64 bit registers.. 
		//make sure they span the few that actually have 64 bits, some have 32 or less..
		x2 = x1 + (sign * (y1 >> i));
		y2 = y1 - (sign * (x1 >> i));
		z1 = z1 + (sign * zitable[i]);
		x1 = x2;
		y1 = y2;
		i++;
	}
	*x = x1;
	*y = y1;
	*z = z1;
}

int main() {
	double x_d, y_d, z_d; /* 64-bit floating-point variables */
	double angle;
	int x_i, y_i, z_i; /* integer (fixed-point) variables */
	int angle_i;

	x_d = 0.85; 
	y_d = 0.95; // set to 1 for atan(x) mode. 
	z_d = atan(y_d / x_d); /* call std-C math routines */
	x_i = (int)(x_d * (1 << 15)); /* convert the x_d, y_d, z_d */
	y_i = (int)(y_d * (1 << 15)); /* floats to integers with a */
	z_i = (int)(z_d * (1 << 15)); /* precision of 16 bits */
	angle_i = (int)(angle * (1 << 15)); /* precision of 16 bits */ 
	
	int i; // NEEDED I DONT KNOW WHY BUT ITS NEEDED TO BE DECLARED OUTSIDE OF THE LOOP
	for (i = 0; i < 15; i++) {
		zitable[i] = (int)(zftable[i] * (1 << 15));
	} // generates fixed point table for z integers

	CORDIC_Vectoring(&x_i, &y_i, &z_i);
	printf("z_i = %d\n", z_i);;
	printf("z_d ( vectoring ) = %f\n", ((double)z_i / (double)(1 << 15)));
	printf("z_d ( atan ) = %f\n", z_d * 57.295);

	return 0;
}