# Matrix-Operations

Description
The Matrix Operations in Assembly project implements a set of matrix manipulation functions using the x86-64 Assembly language. The project provides the following matrix operations:

Matrix Addition: Adds two matrices and returns the resulting matrix.
Matrix Dot Product: Computes the dot product of two matrices.
Scalar Multiplication: Multiplies each element of a matrix by a scalar value.
These operations are implemented in assembly language, utilizing low-level memory management, loops, and floating-point operations for matrix handling. The operations demonstrate efficient matrix processing with minimal abstraction, focusing on pointer arithmetic and direct memory manipulation.

Operations Implemented

addMatrices:
This function adds two matrices and returns the resulting matrix. It dynamically allocates memory for the result matrix and ensures proper memory management through the malloc and free system calls. It also checks for edge cases where the matrices have zero rows or columns.

calculateMatrixDotProduct:
Computes the dot product between two matrices. It iterates over rows and columns of the input matrices, multiplying corresponding elements and accumulating the result.

multiplyScalarToMatrix:
Multiplies each elemenT of a matrix by a scalar. This function handles matrix dimensions dynamically and performs the scalar multiplication operation by iterating through each matrix element.

Key Features
Efficient Memory Allocation: Uses malloc and free for dynamic memory management to store and manipulate matrices.
Low-Level Operations: Operates directly on memory addresses and registers, leveraging assembly language's ability to interact with the hardware at a low level.
Floating-Point Operations: Uses xmm registers for handling floating-point arithmetic, ensuring high precision for matrix calculations.

Assembly Code Structure
Matrix Addition (addMatrices):
Checks the dimensions of the matrices (rows and columns).
Allocates memory for the result matrix.
Iterates over each element to add corresponding values from the two matrices.

Matrix Dot Product (calculateMatrixDotProduct):
Verifies the input dimensions.
Accumulates the dot product by multiplying corresponding elements from the rows of the two matrices.

Scalar Multiplication (multiplyScalarToMatrix):
Iterates through each matrix element and multiplies it by the given scalar value.
Optimized for floating-point operations using movss and mulss instructions.

Compilation Commands for All Files:
nasm -f elf64 -o add_matrices.o add_matrices.asm
nasm -f elf64 -o calculate_matrix_dot_product.o calculate_matrix_dot_product.asm
nasm -f elf64 -o multiply_scalar_to_matrix.o multiply_scalar_to_matrix.asm

Linking Command for All Files:
gcc -nostartfiles -o matrix_operations add_matrices.o calculate_matrix_dot_product.o multiply_scal
