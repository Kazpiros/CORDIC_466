#include <stdio.h>

#define FIXED_POINT_SCALE 32768. // convert float to int by 1 << 15 (2^15)
#define A_ 1.64676025806 // prod_{i=0}^{n} (sqrt{1+2^{-2i}})

/* BARR-C Standards Followed:
	- Surrounding logical OR operands with parantheses
	- Using const keyword for variables that are not modified
	- Using static keyword for functions that are not used outside of the file
	- Using // for single-line comments
	- Using /* for multi-line comments
	- Using a whitespace before and after assignment operators, binary operators, pointer operators, and keywords
	- Using a whitespace after commas, semicolons, and parentheses
	- Omitting a whitespace before and after parentheses surrounding expressions, function calls, and type casts
*/

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

//Rotation mode calculates sin and cosine of a vector given an angle
static void CORDIC_Rotating(int* x, int* y, int* theta, int ztable[16]) {
	register int i = 0;
	register int x1 = *x; register int y1 = *y; register int theta1 = *theta;
	register int x2; register int y2; register int next_z;

	next_z = ztable[0];
	while (i < 16) {
		int sign = (!!theta1) | (theta1 >> 31); //extract sign of theta1

		x2 = x1 - (sign * (y1 >> i));
		y2 = y1 + (sign * (x1 >> i));
		theta1 = theta1 - (sign * next_z);
		x1 = x2;
		y1 = y2;
		i++;
		next_z = ztable[i];
	}
	*x = x1;
	*y = y1;
	*theta = theta1;
}

//Vectoring mode calculates the angle of a vector given sin and cosine, which is equivalent to calculating arctan(y/x)
static void CORDIC_Vectoring(int* x, int* y, int* z, int ztable[16]) {
	register int i = 0;
	register int x1 = *x; register int y1 = *y; register int z1 = 0;
	register int x2; register int y2; register int next_z;

	next_z = ztable[0];
	while (i < 16) {
		int sign = (!!y1) | (y1 >> 31); //extract sign of theta1
		
		x2 = x1 + (sign * (y1 >> i));
		y2 = y1 - (sign * (x1 >> i));
		z1 = z1 + (sign * next_z);
		x1 = x2;
		y1 = y2;
		i++;
		next_z = ztable[i];
	}
	*x = x1;
	*y = y1;
	*z = z1;
}

//Acts as current testbench
int main() {
	int zitable[16];
	float x_d, y_d, z_d; //32-bit floating-point variables for the input vector
	volatile int x_i, y_i, z_i; //32-bit signed integers used to rep 16 bit fixed-point values of the input vector

	/* Vectoring Mode testbenches */

	//test undefined behavior
	/*
	x_d = 0.;
	y_d = 0.;
	z_d = 0;
	*/

	//test slides example
	/*
	x_d = 0.85;
	y_d = 0.76;
	z_d = 0.0;
	*/

	/* Rotation Mode testbenches */

	//test
	/*
	x_d = 1.;  
	y_d = 0.; 
	z_d = -20.335; 
	*/

	//test rounding (20.45*32768 = 670105.6)
	x_d = 1.;  
	y_d = 0.; 
	z_d = 20.45; 
	

	/* Promote 32-bit floating-point numbers to 16-bit precision integers */
	x_i = (int)((x_d * (FIXED_POINT_SCALE)) + 0.5); // add 0.5 to round to the nearest integer
	y_i = (int)((y_d * (FIXED_POINT_SCALE)) + 0.5); // add 0.5 to round to the nearest integer
	z_i = (int)((z_d * (FIXED_POINT_SCALE)) + 0.5); // add 0.5 to round to the nearest integer

	printf("Debug prints:\n\n");
	printf("64-bit float x_d = %f\t\t\t16-bit int x_i = %i\n", x_d, x_i);
	printf("64-bit float y_d = %f\t\t\t16-bit int y_i = %i\n", y_d, y_i);
	printf("64-bit float z_d = %f\t\t\t16-bit int z_i = %i\n", z_d, z_i);

	/* Generate a fixed-point version of the global zftable of floating-point angles */
	register int i;
	for (i = 0; i < 16; i++) {
		zitable[i] = (int)(zftable[i] * (FIXED_POINT_SCALE));
	}

	//float x_out = ((x_i == 0.) ? NAN : (float)x_i / 19898.4641751); // this constant is (FIXED_POINT_SCALE)) / (A_)
	
	/* Rotation Mode */
	CORDIC_Rotating(&x_i, &y_i, &z_i, zitable);

	printf("\n\nResults of CORDIC_Rotation:\n\n");
	printf("Cosine result x_i = %f\n", ((float)x_i / (FIXED_POINT_SCALE)) / (A_)); // A_ is used to transcribe from accumulated angle component to plain component
	printf("Sine result y_i = %f\n", ((float)y_i / (FIXED_POINT_SCALE)) / (A_)); 

	/* Vectoring Mode */
	/*CORDIC_Vectoring(&x_i, &y_i, &z_i, zitable);

	printf("\n\nResults of CORDIC_Vectoring:\n\n");
	printf("Scaled magnitude result x_i = %f\n", ((double)x_i / (double)(FIXED_POINT_SCALE)) / (A_)); // A_ is used to transcribe from accumulated angle component to plain component
	printf("Angle of vector result z_i = %f\n", ((double)z_i / (double)(FIXED_POINT_SCALE)));
	*/

	return 0;
}
