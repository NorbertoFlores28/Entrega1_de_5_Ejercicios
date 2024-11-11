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
array: .word 12, 45, 7, 23, 67, 89, 34, 56, 90, 14    // Arreglo a ordenar
arr_len: .word 10                                      // Longitud del arreglo
temp_array: .zero 40                                   // Arreglo temporal (10 elementos * 4 bytes)
msg_before: .asciz "Arreglo antes de ordenar:\n"
msg_after: .asciz "Arreglo después de ordenar:\n"
msg_elem: .asciz "%d "                                 // Para imprimir cada elemento
msg_nl: .asciz "\n"                                    // Nueva línea

.text
.global main

// Función principal
main:
    stp x29, x30, [sp, -16]!    // Guardar registros
    mov x29, sp

    // Imprimir mensaje inicial
    adrp x0, msg_before
    add x0, x0, :lo12:msg_before
    bl printf

    // Imprimir arreglo original
    bl print_array

    // Preparar parámetros para merge_sort
    adrp x0, array
    add x0, x0, :lo12:array     // x0 = dirección del arreglo
    mov x1, #0                  // x1 = inicio (0)
    adrp x2, arr_len
    add x2, x2, :lo12:arr_len
    ldr w2, [x2]               
    sub x2, x2, #1              // x2 = fin (n-1)

    // Llamar a merge_sort
    bl merge_sort

    // Imprimir mensaje final
    adrp x0, msg_after
    add x0, x0, :lo12:msg_after
    bl printf

    // Imprimir arreglo ordenado
    bl print_array

    // Restaurar y retornar
    ldp x29, x30, [sp], 16
    ret

// Función merge_sort(arr, inicio, fin)
merge_sort:
    stp x29, x30, [sp, -48]!    // Guardar registros y espacio para variables locales
    mov x29, sp
    
    // Guardar parámetros
    str x0, [x29, 16]           // Guardar dirección del arreglo
    str x1, [x29, 24]           // Guardar inicio
    str x2, [x29, 32]           // Guardar fin

    // Verificar caso base
    cmp x1, x2                  // Si inicio >= fin, retornar
    bge merge_sort_end

    // Calcular punto medio
    add x3, x1, x2              // x3 = inicio + fin
    lsr x3, x3, #1              // x3 = (inicio + fin) / 2

    // Guardar punto medio
    str x3, [x29, 40]

    // Llamada recursiva para primera mitad
    ldr x0, [x29, 16]           // Recuperar dirección del arreglo
    ldr x1, [x29, 24]           // Recuperar inicio
    mov x2, x3                  // fin = medio
    bl merge_sort

    // Llamada recursiva para segunda mitad
    ldr x0, [x29, 16]           // Recuperar dirección del arreglo
    ldr x1, [x29, 40]           // inicio = medio
    add x1, x1, #1              // inicio = medio + 1
    ldr x2, [x29, 32]           // Recuperar fin
    bl merge_sort

    // Mezclar las dos mitades
    ldr x0, [x29, 16]           // Recuperar dirección del arreglo
    ldr x1, [x29, 24]           // Recuperar inicio
    ldr x2, [x29, 40]           // Recuperar medio
    ldr x3, [x29, 32]           // Recuperar fin
    bl merge

merge_sort_end:
    ldp x29, x30, [sp], 48
    ret

// Función merge(arr, inicio, medio, fin)
merge:
    stp x29, x30, [sp, -64]!    // Guardar registros y espacio para variables
    mov x29, sp

    // Guardar parámetros
    str x0, [x29, 16]           // Dirección del arreglo
    str x1, [x29, 24]           // Inicio
    str x2, [x29, 32]           // Medio
    str x3, [x29, 40]           // Fin

    // Copiar elementos al arreglo temporal
    mov x4, x1                  // i = inicio
    adrp x5, temp_array
    add x5, x5, :lo12:temp_array

copy_loop:
    cmp x4, x3
    bgt copy_end
    ldr w6, [x0, x4, LSL #2]    // Cargar elemento
    str w6, [x5, x4, LSL #2]    // Guardar en temporal
    add x4, x4, #1
    b copy_loop

copy_end:
    // Inicializar índices
    mov x4, x1                  // i = inicio
    add x5, x2, #1              // j = medio + 1
    mov x6, x1                  // k = inicio

merge_loop:
    // Verificar si alguna mitad se acabó
    cmp x4, x2
    bgt copy_right              // Si i > medio, copiar resto de derecha
    cmp x5, x3
    bgt copy_left               // Si j > fin, copiar resto de izquierda

    // Comparar elementos
    adrp x7, temp_array
    add x7, x7, :lo12:temp_array
    ldr w8, [x7, x4, LSL #2]    // Elemento izquierdo
    ldr w9, [x7, x5, LSL #2]    // Elemento derecho
    
    cmp w8, w9
    ble merge_left              // Si izq <= der, tomar izquierdo

merge_right:
    // Copiar elemento derecho
    ldr x0, [x29, 16]           // Recuperar dirección original
    str w9, [x0, x6, LSL #2]
    add x5, x5, #1
    add x6, x6, #1
    b merge_loop

merge_left:
    // Copiar elemento izquierdo
    ldr x0, [x29, 16]           // Recuperar dirección original
    str w8, [x0, x6, LSL #2]
    add x4, x4, #1
    add x6, x6, #1
    b merge_loop

copy_right:
    // Copiar resto de la mitad derecha
    cmp x5, x3
    bgt merge_end
    adrp x7, temp_array
    add x7, x7, :lo12:temp_array
    ldr w8, [x7, x5, LSL #2]
    ldr x0, [x29, 16]
    str w8, [x0, x6, LSL #2]
    add x5, x5, #1
    add x6, x6, #1
    b copy_right

copy_left:
    // Copiar resto de la mitad izquierda
    cmp x4, x2
    bgt merge_end
    adrp x7, temp_array
    add x7, x7, :lo12:temp_array
    ldr w8, [x7, x4, LSL #2]
    ldr x0, [x29, 16]
    str w8, [x0, x6, LSL #2]
    add x4, x4, #1
    add x6, x6, #1
    b copy_left

merge_end:
    ldp x29, x30, [sp], 64
    ret

// Subrutina para imprimir el arreglo (igual que en el código de referencia)
print_array:
    stp x29, x30, [sp, -16]!
    adrp x19, array
    add x19, x19, :lo12:array
    adrp x20, arr_len
    add x20, x20, :lo12:arr_len
    ldr w20, [x20]
    mov w21, #0

print_loop:
    cmp w21, w20
    bge print_end
    adrp x0, msg_elem
    add x0, x0, :lo12:msg_elem
    ldr w1, [x19, w21, UXTW #2]
    bl printf
    add w21, w21, #1
    b print_loop

print_end:
    adrp x0, msg_nl
    add x0, x0, :lo12:msg_nl
    bl printf
    ldp x29, x30, [sp], 16
    ret