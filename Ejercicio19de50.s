// Autor: Pozos Flores Norberto
// Fecha: 11/11/2024
// Descripción: Programa en ensamblador que implementa la suma de dos matrices 3x3

/*
using System;

class Program
{
    static void Main()
    {
        // Definir las matrices 3x3
        int[,] matrix1 = new int[3, 3];
        int[,] matrix2 = new int[3, 3];
        int[,] result = new int[3, 3];

        // Solicitar y leer la primera matriz
        Console.WriteLine("\nIngrese los elementos de la primera matriz 3x3:");
        for (int i = 0; i < 3; i++)
        {
            for (int j = 0; j < 3; j++)
            {
                Console.Write($"Ingrese elemento [{i}][{j}]: ");
                matrix1[i, j] = int.Parse(Console.ReadLine());
            }
        }

        // Solicitar y leer la segunda matriz
        Console.WriteLine("\nIngrese los elementos de la segunda matriz 3x3:");
        for (int i = 0; i < 3; i++)
        {
            for (int j = 0; j < 3; j++)
            {
                Console.Write($"Ingrese elemento [{i}][{j}]: ");
                matrix2[i, j] = int.Parse(Console.ReadLine());
            }
        }

        // Sumar las matrices
        for (int i = 0; i < 3; i++)
        {
            for (int j = 0; j < 3; j++)
            {
                result[i, j] = matrix1[i, j] + matrix2[i, j];
            }
        }

        // Mostrar el resultado
        Console.WriteLine("\nMatriz resultado:");
        for (int i = 0; i < 3; i++)
        {
            for (int j = 0; j < 3; j++)
            {
                Console.Write($"{result[i, j],4} ");  // Formato de 4 espacios
            }
            Console.WriteLine();  // Nueva línea al final de cada fila
        }
    }
}

*/
.data
// Dimensiones de las matrices (3x3)
N: .word 3          // Filas
M: .word 3          // Columnas

// Matrices
matrix1: .zero 36    // 3x3 matriz (4 bytes por elemento)
matrix2: .zero 36    // 3x3 matriz
result: .zero 36     // Matriz resultado

// Mensajes y formatos
msg_matrix1: .asciz "\nIngrese los elementos de la primera matriz 3x3:\n"
msg_matrix2: .asciz "\nIngrese los elementos de la segunda matriz 3x3:\n"
msg_element: .asciz "Ingrese elemento [%d][%d]: "
msg_result: .asciz "\nMatriz resultado:\n"
fmt_input: .asciz "%d"
fmt_output: .asciz "%4d "
new_line: .asciz "\n"

.text
.global main

main:
    // Prólogo
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // Anunciar entrada de primera matriz
    adrp x0, msg_matrix1
    add x0, x0, :lo12:msg_matrix1
    bl printf

    // Leer primera matriz
    adrp x20, matrix1
    add x20, x20, :lo12:matrix1
    mov x19, #0          // i = 0

loop1_i:
    cmp x19, #3
    beq end_loop1_i
    mov x21, #0          // j = 0

loop1_j:
    cmp x21, #3
    beq end_loop1_j

    // Mostrar prompt
    adrp x0, msg_element
    add x0, x0, :lo12:msg_element
    mov x1, x19
    mov x2, x21
    bl printf

    // Leer elemento
    sub sp, sp, #16      // Espacio para el input
    mov x1, sp
    adrp x0, fmt_input
    add x0, x0, :lo12:fmt_input
    bl scanf

    // Calcular posición y guardar
    mov x22, #12         // 3 * 4 (tamaño de fila)
    mul x23, x19, x22    // i * (3 * 4)
    mov x24, #4
    mul x25, x21, x24    // j * 4
    add x23, x23, x25    // offset total
    ldr w24, [sp]
    str w24, [x20, x23]  // guardar en matrix1[i][j]
    add sp, sp, #16      // restaurar sp

    add x21, x21, #1     // j++
    b loop1_j

end_loop1_j:
    add x19, x19, #1     // i++
    b loop1_i

end_loop1_i:
    // Anunciar entrada de segunda matriz
    adrp x0, msg_matrix2
    add x0, x0, :lo12:msg_matrix2
    bl printf

    // Leer segunda matriz
    adrp x20, matrix2
    add x20, x20, :lo12:matrix2
    mov x19, #0          // i = 0

loop2_i:
    cmp x19, #3
    beq end_loop2_i
    mov x21, #0          // j = 0

loop2_j:
    cmp x21, #3
    beq end_loop2_j

    // Mostrar prompt
    adrp x0, msg_element
    add x0, x0, :lo12:msg_element
    mov x1, x19
    mov x2, x21
    bl printf

    // Leer elemento
    sub sp, sp, #16
    mov x1, sp
    adrp x0, fmt_input
    add x0, x0, :lo12:fmt_input
    bl scanf

    // Calcular posición y guardar
    mov x22, #12         // 3 * 4
    mul x23, x19, x22    // i * (3 * 4)
    mov x24, #4
    mul x25, x21, x24    // j * 4
    add x23, x23, x25    // offset total
    ldr w24, [sp]
    str w24, [x20, x23]  // guardar en matrix2[i][j]
    add sp, sp, #16

    add x21, x21, #1     // j++
    b loop2_j

end_loop2_j:
    add x19, x19, #1     // i++
    b loop2_i

end_loop2_i:
    // Realizar la suma
    mov x19, #0          // i = 0

sum_loop_i:
    cmp x19, #3
    beq end_sum_loop_i
    mov x21, #0          // j = 0

sum_loop_j:
    cmp x21, #3
    beq end_sum_loop_j

    // Calcular offset
    mov x22, #12         // 3 * 4
    mul x23, x19, x22    // i * (3 * 4)
    mov x24, #4
    mul x25, x21, x24    // j * 4
    add x23, x23, x25    // offset total

    // Cargar elementos y sumar
    adrp x20, matrix1
    add x20, x20, :lo12:matrix1
    ldr w24, [x20, x23]  // matrix1[i][j]

    adrp x20, matrix2
    add x20, x20, :lo12:matrix2
    ldr w25, [x20, x23]  // matrix2[i][j]

    add w24, w24, w25    // suma

    adrp x20, result
    add x20, x20, :lo12:result
    str w24, [x20, x23]  // guardar resultado

    add x21, x21, #1     // j++
    b sum_loop_j

end_sum_loop_j:
    add x19, x19, #1     // i++
    b sum_loop_i

end_sum_loop_i:
    // Mostrar resultado
    adrp x0, msg_result
    add x0, x0, :lo12:msg_result
    bl printf

    // Imprimir matriz resultado
    mov x19, #0          // i = 0

print_loop_i:
    cmp x19, #3
    beq end_print_loop_i
    mov x21, #0          // j = 0

print_loop_j:
    cmp x21, #3
    beq end_print_loop_j

    // Calcular offset y cargar elemento
    mov x22, #12         // 3 * 4
    mul x23, x19, x22    // i * (3 * 4)
    mov x24, #4
    mul x25, x21, x24    // j * 4
    add x23, x23, x25    // offset total

    adrp x20, result
    add x20, x20, :lo12:result
    ldr w1, [x20, x23]   // cargar resultado[i][j]

    // Imprimir elemento
    adrp x0, fmt_output
    add x0, x0, :lo12:fmt_output
    bl printf

    add x21, x21, #1     // j++
    b print_loop_j

end_print_loop_j:
    // Nueva línea al final de cada fila
    adrp x0, new_line
    add x0, x0, :lo12:new_line
    bl printf

    add x19, x19, #1     // i++
    b print_loop_i

end_print_loop_i:
    // Epílogo
    ldp x29, x30, [sp], 16
    ret