# CORDIC

CORDIC is an inexpensive operation that lets the user extract or produce an angle from any two dimensional input vector. 

## Features

- Full ARCTAN Operation
- SIN() and COS() Computation

>>"True love (CORDIC) doesn't happen right away; it's an ever-growing process. It develops after you've gone through many ups and downs, when you've suffered together, cried together, laughed together." -Ricardo Montalban

## Run CORDIC
Compile with:

    gcc CORDIC.c -o cordic -lm 

Execute:

    ./CORDIC

## Run CORDIC on ARM based Machines
Compile with:

    arm-linux-gcc -marm -mfloat-abi=softfp -o CORDIC.c CORDIC.exe

Execute:

    ./CORDIC.exe

## Evaluate Performance

run:

    valgrind --tool=cachegrind cordice.exe
