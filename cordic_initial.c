#include <math.h>
#include <stdio.h>

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

// Rotation mode calculates sin and cosine of a vector given an angle
void CORDIC_Rotating(int* x, int* y, int* theta, int ztable[16]) {
	int i = 0;
	int x1 = *x; int y1 = *y; int theta1 = *theta;
	int x2; int y2;

	while (i < 16) {
		if(theta1 >= 0){
			x2 = x1 - (y1 >> i);
			y2 = y1 + (x1 >> i);
			theta1 = theta1 - ztable[i];
		} else {
			x2 = x1 + (y1 >> i);
			y2 = y1 - (x1 >> i);
			theta1 = theta1 + ztable[i];
		}
		x1 = x2;
		y1 = y2;
		i++;
	}
	*x = x1;
	*y = y1;

	*theta = theta1;
}

// Vectoring mode calculates the angle of a vector given sin and cosine, which is equivalent to calculating arctan(y/x)
void CORDIC_Vectoring(int* x, int* y, int* z, int ztable[16]) {
	int i = 0;
	int x1 = *x; int y1 = *y; int z1 = 0;
	int x2; int y2;

	while (i < 16) {
		if (y1 >= 0) {
            x2 = x1 + (y1 >> i);
            y2 = y1 - (x1 >> i);
            z1 = z1 + ztable[i];
        } else {
            x2 = x1 - (y1 >> i);
            y2 = y1 + (x1 >> i);
            z1 = z1 - ztable[i];
        }
		x1 = x2;
		y1 = y2;
		i++;
	}
	*x = x1;
	*y = y1;

	//update intial angle parameter with the calculated angle
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
	printf("cordic0!\n");
	int zitable[16];
	double x_d, y_d, z_d; // 64-bit floating-point variables 
	int x_i, y_i, z_i;  // integer fixed-point variables

	// uncomment these variables for Vectoring Mode testbench
	x_d = 0.85;  
	y_d = 0.76;
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
	printf( "64-bit float x_d = %f\t\t\t16-bit int x_i = %i\n", x_d, x_i); 
	printf( "64-bit float y_d = %f\t\t\t16-bit int y_i = %i\n", y_d, y_i); 
	printf( "64-bit float z_d = %f\t\t\t16-bit int z_i = %i\n", z_d, z_i);

	//generate a fixed-point version of the global zftable of floating-point angles
	int i;
	for (i = 0; i < 16; i++) {
		zitable[i] = (int)(zftable[i] * (FIXED_POINT_SCALE));
	} 

	/* Rotation Mode */
	/*
	CORDIC_Rotating(&x_i, &y_i, &z_i, zitable);
	
	printf("\n\nResults of CORDIC_Rotation:\n\n");
	printf("Cosine result x_i = %.12f\n", ((float)x_i / (FIXED_POINT_SCALE)) / (A_)); // A_ is used to transcribe from accumulated angle component to plain component
	printf("Sine result y_i = %.12f\n", ((float)y_i / (FIXED_POINT_SCALE)) / (A_)); 
	*/
	
	/* Vectoring Mode */
	
	CORDIC_Vectoring(&x_i, &y_i, &z_i, zitable);

	printf("\n\nResults of CORDIC_Vectoring:\n\n");
	printf("Scaled magnitude result x_i = %.12f\n", ((double)x_i / (double)(FIXED_POINT_SCALE)) / (A_)); // A_ is used to transcribe from accumulated angle component to plain component
	printf("Angle of vector result z_i = %.12f\n", ((double)z_i / (double)(FIXED_POINT_SCALE)));


	return 0;
}
