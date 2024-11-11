// Autor: Pozos Flores Norberto
// Fecha: 11/11/2024
// Descripción: Programa en ensamblador que implementa un algoritmo de ordenamiento de burbuja

/*
using System;
class Program {
    static void Main() {
        Console.Write("Ingrese el tamaño del array (max 100): ");
        int n = int.Parse(Console.ReadLine());
        
        int[] array = new int[n];
        
        for (int i = 0; i < n; i++) {
            Console.Write($"Ingrese el número {i + 1}: ");
            array[i] = int.Parse(Console.ReadLine());
        }

        Console.Write("\nArray antes: ");
        PrintArray(array);

        BubbleSort(array);

        Console.Write("\nArray después: ");
        PrintArray(array);
    }

    static void PrintArray(int[] array) {
        foreach (var num in array) {
            Console.Write(num + " ");
        }
        Console.WriteLine();
    }

    static void BubbleSort(int[] array) {
        int n = array.Length;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - 1 - i; j++) {
                if (array[j] > array[j + 1]) {
                    // Intercambiar
                    int temp = array[j];
                    array[j] = array[j + 1];
                    array[j + 1] = temp;
                }
            }
        }
    }
}
*/

.data
    array:       .space 400           // Espacio para 100 números (100 * 4 bytes)
    n:           .word  0             // Variable para almacenar el tamaño del array
    msg_tam:     .string "Ingrese el tamaño del array (max 100): "
    msg_num:     .string "Ingrese el número %d: "
    msg_antes:   .string "\nArray antes:  "
    msg_desp:    .string "\nArray después: "
    formato:     .string "%d "        // Formato para printf
    formato_in:  .string "%d"         // Formato para scanf
    newline:     .string "\n"

.text
.global main
main:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

    // Pedir tamaño del array
    adr     x0, msg_tam
    bl      printf

    // Leer tamaño
    adr     x0, formato_in
    adr     x1, n
    bl      scanf

    // Leer los números
    adr     x19, array            // Base del array
    ldr     w20, n               // Tamaño del array
    mov     w21, 1               // Contador iniciando en 1
input_loop:
    cmp     w21, w20
    bgt     input_done

    // Imprimir mensaje "Ingrese el número X:"
    adr     x0, msg_num
    mov     w1, w21
    bl      printf

    // Leer el número
    adr     x0, formato_in
    sub     w22, w21, #1         // Índice para el array (contador-1)
    add     x1, x19, w22, SXTW 2 // Calcular dirección del elemento
    bl      scanf

    add     w21, w21, 1
    b       input_loop
input_done:

    // Imprimir mensaje "Array antes:"
    adr     x0, msg_antes
    bl      printf

    // Imprimir array original
    mov     w21, 0               // Reiniciar contador
print_loop1:
    cmp     w21, w20
    bge     print_done1
    
    adr     x0, formato
    ldr     w1, [x19, w21, SXTW 2]
    bl      printf
    
    add     w21, w21, 1
    b       print_loop1
print_done1:
    
    // Imprimir nueva línea
    adr     x0, newline
    bl      printf

    // Llamar a ordenamiento_burbuja
    mov     x0, x19              // Dirección del array
    mov     w1, w20              // Tamaño del array
    bl      ordenamiento_burbuja

    // Imprimir mensaje "Array después:"
    adr     x0, msg_desp
    bl      printf

    // Imprimir array ordenado
    mov     w21, 0               // Reiniciar contador
print_loop2:
    cmp     w21, w20
    bge     print_done2
    
    adr     x0, formato
    ldr     w1, [x19, w21, SXTW 2]
    bl      printf
    
    add     w21, w21, 1
    b       print_loop2
print_done2:
    // Imprimir nueva línea final
    adr     x0, newline
    bl      printf

    mov     w0, 0
    ldp     x29, x30, [sp], 16
    ret

.global ordenamiento_burbuja
ordenamiento_burbuja:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    
    stp     x19, x20, [sp, -16]!
    stp     x21, x22, [sp, -16]!
    
    mov     x19, x0
    sub     x20, x1, #1
    
bucle_externo:
    cbz     x20, fin
    mov     x21, xzr
    mov     x22, xzr
    
bucle_interno:
    cmp     x21, x20
    bge     fin_interno
    
    lsl     x9, x21, #2
    add     x10, x9, #4
    ldr     w2, [x19, x9]
    ldr     w3, [x19, x10]
    
    cmp     w2, w3
    ble     no_swap
    
    str     w3, [x19, x9]
    str     w2, [x19, x10]
    mov     x22, #1
    
no_swap:
    add     x21, x21, #1
    b       bucle_interno
    
fin_interno:
    cbz     x22, fin
    sub     x20, x20, #1
    b       bucle_externo
    
fin:
    ldp     x21, x22, [sp], 16
    ldp     x19, x20, [sp], 16
    ldp     x29, x30, [sp], 16
    ret