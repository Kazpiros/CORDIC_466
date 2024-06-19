#include <math.h>
#include <stdio.h>

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
int zitable[16];

void CORDIC_Vectoring(int* x, int* y, int* z) {
	int i = 0;
	int x1 = *x; int y1 = *y; int z1 = 0;
	int x2; int y2;

	while (i < 16) {
		// also like check the size of int on the architecture, straight up might be ok to condense this
		int sign = (y1 >> (sizeof(int) * 15 - 1)) | 1;//16 may be 8 
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
	int x_i, y_i, z_i; /* integer (fixed-point) variables */
	x_d = 0.85;
	y_d = 1;
	z_d = atan(y_d / x_d); /* call std-C math routines */
	x_i = (int)(x_d * (1 << 15)); /* convert the x_d, y_d, z_d */
	y_i = (int)(y_d * (1 << 15)); /* floats to integers with a */
	z_i = (int)(z_d * (1 << 15)); /* precision of 16 bits */

	for (int i = 0; i < 15; i++) {
		zitable[i] = (int)(zftable[i] * (1 << 15));
	} // generates fixed point table for z integers

	CORDIC_Vectoring(&x_i, &y_i, &z_i);
	printf("z_i = %d\n", z_i);;
	printf("z_d ( vectoring ) = %f\n", ((double)z_i / (double)(1 << 15)));
	printf("z_d ( atan ) = %f\n", z_d * 57.295);

	return 0;
}