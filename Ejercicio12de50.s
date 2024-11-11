// Autor: Pozos Flores Norberto
// Fecha: 05/11/2024
// Descripción: Programa en ensamblador que encuentra el máximo en un arreglo

/*
using System;
class Program {
    static void Main() {
        int[] array = new int[100];
        int size = 0;
        int input;

        // Entrada de datos
        Console.Write("Ingrese un número (0 para terminar): ");
        while ((input = int.Parse(Console.ReadLine())) != 0) {
            if (size < 100) {
                array[size++] = input;
            }
            Console.Write("Ingrese un número (0 para terminar): ");
        }

        // Calcular el máximo si hay elementos en el arreglo
        if (size > 0) {
            int max = EncontrarMaximo(array, size);
            Console.WriteLine("El máximo es: {0}", max);
        }
    }

    // Función para encontrar el máximo en un arreglo
    static int EncontrarMaximo(int[] array, int size) {
        int max = array[0];
        for (int i = 1; i < size; i++) {
            if (array[i] > max) {
                max = array[i];
            }
        }
        return max;
    }
}
*/

.section .data
    // Mensajes para interactuar con el usuario
    msg_input:    .string "Ingrese un número (0 para terminar): "
    msg_result:   .string "El máximo es: %d\n"
    fmt_input:    .string "%d"
    
    // Arreglo para almacenar números
    .align 4
    array:      .skip 400    // Espacio para 100 números
    size:       .word 0      // Tamaño actual del arreglo

.section .text
.global main
.extern printf
.extern scanf

main:
    // Prólogo
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    // Inicializar variables
    adrp x19, array
    add x19, x19, :lo12:array  // Obtener dirección base del arreglo
    mov x20, #0              // Contador de elementos

input_loop:
    // Imprimir mensaje de entrada
    adrp x0, msg_input
    add x0, x0, :lo12:msg_input
    bl printf

    // Leer número
    sub sp, sp, #16
    mov x1, sp
    adrp x0, fmt_input
    add x0, x0, :lo12:fmt_input
    bl scanf

    // Cargar número ingresado
    ldr w21, [sp]
    add sp, sp, #16

    // Verificar si es 0 (terminar)
    cbz w21, find_max

    // Guardar número en el arreglo
    str w21, [x19, x20, lsl #2]
    add x20, x20, #1
    
    // Continuar si no hemos llegado al límite
    cmp x20, #100
    b.lt input_loop

find_max:
    // Verificar si hay elementos
    cbz x20, end

    // Llamar a encontrar_maximo
    mov x0, x19              // Dirección del arreglo
    mov x1, x20              // Número de elementos
    bl encontrar_maximo

    // Imprimir resultado
    mov x1, x0
    adrp x0, msg_result
    add x0, x0, :lo12:msg_result
    bl printf

end:
    // Epílogo y retorno
    mov x0, #0
    ldp x29, x30, [sp], #16
    ret

// Función para encontrar el máximo en un arreglo
// Parámetros: x0 = puntero al arreglo, x1 = número de elementos
// Retorno: x0 = valor máximo
encontrar_maximo:
    cbz x1, max_fin          // Si no hay elementos, retornar
    
    ldr w2, [x0]            // Primer elemento como máximo inicial
    mov x4, x0              // Guardar puntero
    mov x3, x1              // Copiar contador
    
max_loop:
    ldr w5, [x4, #4]!       // Cargar siguiente elemento
    cmp w5, w2              // Comparar con máximo actual
    csel w2, w5, w2, gt     // Seleccionar el mayor
    
    subs x3, x3, #1         // Decrementar contador
    cbnz x3, max_loop       // Continuar si no terminamos
    
max_fin:
    mov w0, w2              // Retornar máximo
    ret