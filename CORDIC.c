#include <stdio.h>

#define FIXED_POINT_SCALE 32768. // convert float to int by 1 << 15 (2^15)
#define A_ 1.64676025806 // prod_{i=0}^{n} (sqrt{1+2^{-2i}})
static float NAN = 0.0 / 0.0;
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
float z_table[16] = {
					1474560, 870483, 459939, 
					233472, 117189, 58651, 
					29333, 14667, 7333, 
					3666, 1833, 916, 
					458, 229, 114, 57
};

//Rotation mode calculates sin and cosine of a vector given an angle
static void CORDIC_Rotating(int* x, int* y, int* theta) {
	register int i = 0;
	register int x1 = *x; register int y1 = *y; register int theta1 = *theta;
	register int x2; register int y2; register int next_z;

	next_z = z_table[0];
	while (i < 16) {
		int sign = (!!theta1) | (theta1 >> 31); //extract sign of theta1

		x2 = x1 - (sign * (y1 >> i));
		y2 = y1 + (sign * (x1 >> i));
		theta1 = theta1 - (sign * next_z);
		x1 = x2;
		y1 = y2;
		i++;
		next_z = z_table[i];
	}
	*x = x1;
	*y = y1;
	*theta = theta1;
}

//Vectoring mode calculates the angle of a vector given sin and cosine, which is equivalent to calculating arctan(y/x)
static void CORDIC_Vectoring(int* x, int* y, int* z) {
	register int i = 0;
	register int x1 = *x; register int y1 = *y; register int z1 = 0;
	register int x2; register int y2; register int next_z;

	next_z = z_table[0];
	while (i < 16) {
		int sign = (!!y1) | (y1 >> 31); //extract sign of theta1
		
		x2 = x1 + (sign * (y1 >> i));
		y2 = y1 - (sign * (x1 >> i));
		z1 = z1 + (sign * next_z);
		x1 = x2;
		y1 = y2;
		i++;
		next_z = z_table[i];
	}
	*x = x1;
	*y = y1;
	*z = z1;
}

//Acts as current testbench
int main() {
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
	z_d = 0.;
	

	/* Promote 32-bit floating-point numbers to 16-bit precision integers */
	x_i = (int)((x_d * (FIXED_POINT_SCALE)) + 0.5); // add 0.5 to round to the nearest integer
	y_i = (int)((y_d * (FIXED_POINT_SCALE)) + 0.5); // add 0.5 to round to the nearest integer
	z_i = (int)((z_d * (FIXED_POINT_SCALE)) + 0.5); // add 0.5 to round to the nearest integer

	printf("Debug prints:\n\n");
	printf("64-bit float x_d = %f\t\t\t16-bit int x_i = %i\n", x_d, x_i);
	printf("64-bit float y_d = %f\t\t\t16-bit int y_i = %i\n", y_d, y_i);
	printf("64-bit float z_d = %f\t\t\t16-bit int z_i = %i\n", z_d, z_i);

	float x_out = ((x_i == 0.) ? (float)NAN : (float)x_i / 19898.4641751); // this constant is (FIXED_POINT_SCALE)) / (A_)
	
	/* Rotation Mode */
	/*
	CORDIC_Rotating(&x_i, &y_i, &z_i);
	
	printf("\n\nResults of CORDIC_Rotation:\n\n");
	printf("Cosine result x_i = %.12f\n", ((float)x_i / (FIXED_POINT_SCALE)) / (A_)); // A_ is used to transcribe from accumulated angle component to plain component
	printf("Sine result y_i = %.12f\n", ((float)y_i / (FIXED_POINT_SCALE)) / (A_)); 
	*/
	
	/* Vectoring Mode */
	CORDIC_Vectoring(&x_i, &y_i, &z_i);

	printf("\n\nResults of CORDIC_Vectoring:\n\n");
	printf("Scaled magnitude result x_i = %.12f\n", ((double)x_out / (double)(FIXED_POINT_SCALE)) / (A_)); // A_ is used to transcribe from accumulated angle component to plain component
	printf("Angle of vector result z_i = %.12f\n", ((double)z_i / (double)(FIXED_POINT_SCALE)));
	

	return 0;
}
