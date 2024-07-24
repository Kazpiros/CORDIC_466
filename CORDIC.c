#include <math.h>
#include <stdio.h>
//neon supports vectors inside of registers so it may be useful (probably not) 


//maths visualized on desmos links:
// https://www.desmos.com/calculator/go3wqxm0hu <- Rotation Mode
/*
	TODO:
		- Do a SIMD approach to the shifts, may need to utilize neon's "vectorization", whether it be embedded asm, changing manually in the .s file or specifying the --vectorize in compilation
			-> id imagine we'd change our registers from "r1 = 0xAB r2 = 0xCD" to "r3 = 0xABCD" and do our calculations on r3, then port them back to r1 and r2.
		- n issue slot machine? check it out..
		- change int size for addition and subtraction, if we lower it, these operations will be faster.
*/

#define FIXED_POINT_SCALE 32768. // 1 << 15 float
#define A_ 1.64676025806 // read slides 12, 13 and look at desmos calculations to understand referenced value.
#define M_PI 3.14159265359

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

// Rotation mode calculates sin and cosine of a vector given an angle
void CORDIC_Rotating(int* x, int* y, int* theta, int ztable[16]) {
	register int i = 0;
	register int x1 = *x; register int y1 = *y; register int theta1 = *theta;
	register int x2; register int y2; register int next_z;

	next_z = ztable[0];
	while (i < 16) {
		int sign = (!!theta1) | (theta1 >> 31);

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

// Vectoring mode calculates the angle of a vector given sin and cosine, which is equivalent to calculating arctan(y/x)
void CORDIC_Vectoring(int* x, int* y, int* z, int ztable[16]) {
	register int i = 0;
	register int x1 = *x; register int y1 = *y; register int z1 = 0;
	register int x2; register int y2; register int next_z;

	next_z = ztable[0];
	while (i < 16) {
		int sign = (!!y1) | (y1 >> 31); 
		
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
	float x_d, y_d, z_d; // 64-bit floating-point variables 
	volatile int x_i, y_i, z_i;  // integer fixed-point variables

	// uncomment these variables for Vectoring Mode testbench
	x_d = 0.;
	y_d = 0.;
	z_d = 0;

	// uncomment these variables for Rotation Mode testbench
	//x_d = 1.;  
	//y_d = 0.; 
	//z_d = 33; /* call math.h routines */


	//promote 64-bit floating-point numbers to 16-bit precision integers
	x_i = (int)(x_d * (FIXED_POINT_SCALE));
	y_i = (int)(y_d * (FIXED_POINT_SCALE));
	z_i = (int)(z_d * (FIXED_POINT_SCALE));

	printf("Debug prints:\n\n");
	printf("64-bit float x_d = %f\t\t\t16-bit int x_i = %i\n", x_d, x_i);
	printf("64-bit float y_d = %f\t\t\t16-bit int y_i = %i\n", y_d, y_i);
	printf("64-bit float z_d = %f\t\t\t16-bit int z_i = %i\n", z_d, z_i);

	//generate a fixed-point version of the global zftable of floating-point angles
	register int i;
	for (i = 0; i < 16; i++) {
		zitable[i] = (int)(zftable[i] * (FIXED_POINT_SCALE));
	}

	//CORDIC_Rotating(&x_i, &y_i, &z_i, zitable);
	CORDIC_Vectoring(&x_i, &y_i, &z_i, zitable);


	float x_out = ((x_i == 0.) ? NAN : (float)x_i / 19898.4641751); // this constant is (FIXED_POINT_SCALE)) / (A_)


	printf("z_i parameter= %d\n", z_i); // prints the fixed-point integer value of the z parameter
	printf("z_d parameter= %f\n", ((float)z_i / (float)(FIXED_POINT_SCALE))); // prints the floating-point value of the z parameter

	//uncomment for Rotation Mode testbench
	//printf("\n\nResults of CORDIC_Rotation:\n\n");
	//printf("Cosine result x_i = %f\n", ((float)x_i / (FIXED_POINT_SCALE)) / (A_)); // A_ is used to transcribe from accumulated angle component to plain component
	//printf("Sine result y_i = %f\n", ((float)y_i / (FIXED_POINT_SCALE)) / (A_)); 
	//printf("Angle z_d = %f\n", ((float)z_i / (FIXED_POINT_SCALE)));
	//printf("Actual cosine of given angle = %f\n", cos(z_d * M_PI / 180)); // compare with math.h cos function
	//printf("Actual sine of given angle = %f\n", sin(z_d * M_PI / 180)); // compare with math.h sin function

	//uncomment for Vectoring Mode testbench
	printf("\n\nResults of CORDIC_Vectoring:\n\n");
	printf("Scaled magnitude result x_i = %f\n", ((double)x_i / (double)(FIXED_POINT_SCALE)) / (A_)); // A_ is used to transcribe from accumulated angle component to plain component
	printf("y_i  = %f\n", ((double)y_i / (double)(FIXED_POINT_SCALE)) / (A_)); 
	printf("Angle of vector result z_i = %f\n", ((double)z_i / (double)(FIXED_POINT_SCALE)));
	//printf("Actual angle of vector = %f\n", atan2(y_d, x_d) * 180 / M_PI); // compare with math.h atan2 function

	return 0;
}
