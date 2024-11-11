// Autor: Pozos Flores Norberto
// Fecha: 11/11/2024
// Descripción: Programa en ensamblador que implementa búsqueda binaria recursiva

/*
using System;
class Program {
    static void Main() {
        Console.Write("Ingrese la cantidad de números: ");
        int cantidad = int.Parse(Console.ReadLine());

        int[] array = new int[cantidad];
        for (int i = 0; i < cantidad; i++) {
            Console.Write($"Ingrese el número {i + 1} (en orden ascendente): ");
            array[i] = int.Parse(Console.ReadLine());
        }

        Console.Write("\nIngrese el número a buscar: ");
        int buscar = int.Parse(Console.ReadLine());

        int resultado = BinarySearch(array, 0, cantidad - 1, buscar);
        if (resultado != -1) {
            Console.WriteLine($"El número {buscar} se encontró en la posición {resultado}");
        } else {
            Console.WriteLine($"El número {buscar} no se encontró en el arreglo");
        }
    }

    // Función de búsqueda binaria recursiva
    static int BinarySearch(int[] array, int inicio, int fin, int valor) {
        if (inicio > fin) return -1; // Caso base: no encontrado
        int medio = (inicio + fin) / 2;
        if (array[medio] == valor) return medio;
        else if (array[medio] > valor) return BinarySearch(array, inicio, medio - 1, valor);
        else return BinarySearch(array, medio + 1, fin, valor);
    }
}
*/

.section .data
    msg_cant:     .string "Ingrese la cantidad de números: "
    msg_input:    .string "Ingrese el número %d (en orden ascendente): "
    msg_search:   .string "\nIngrese el número a buscar: "
    msg_found:    .string "El número %d se encontró en la posición %d\n"
    msg_notfound: .string "El número %d no se encontró en el arreglo\n"
    fmt_input:    .string "%d"
    
    .align 4
    array:      .skip 400    // Espacio para 100 números
    size:       .word 0

.section .text
.global main
.extern printf
.extern scanf

main:
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    // Pedir cantidad de números
    adrp x0, msg_cant
    add x0, x0, :lo12:msg_cant
    bl printf

    // Leer cantidad
    sub sp, sp, #16
    mov x1, sp
    adrp x0, fmt_input
    add x0, x0, :lo12:fmt_input
    bl scanf
    ldr w20, [sp]    // w20 = cantidad
    add sp, sp, #16

    // Inicializar variables
    adrp x19, array
    add x19, x19, :lo12:array
    mov x21, #0      // Contador

input_loop:
    // Mensaje de entrada
    adrp x0, msg_input
    add x0, x0, :lo12:msg_input
    add w1, w21, #1
    bl printf

    // Leer número
    sub sp, sp, #16
    mov x1, sp
    adrp x0, fmt_input
    add x0, x0, :lo12:fmt_input
    bl scanf
    
    // Guardar en array
    ldr w22, [sp]
    str w22, [x19, x21, lsl #2]
    add sp, sp, #16
    
    add x21, x21, #1
    cmp x21, x20
    b.lt input_loop

    // Pedir número a buscar
    adrp x0, msg_search
    add x0, x0, :lo12:msg_search
    bl printf

    // Leer número
    sub sp, sp, #16
    mov x1, sp
    adrp x0, fmt_input
    add x0, x0, :lo12:fmt_input
    bl scanf
    ldr w22, [sp]    // Número a buscar
    add sp, sp, #16

    // Llamar búsqueda binaria
    mov x0, x19      // Array
    mov w1, #0       // Inicio
    sub w2, w20, #1  // Fin
    mov w3, w22      // Valor a buscar
    bl binary_search

    // Verificar resultado
    cmp w0, #-1
    b.eq not_found

    // Encontrado
    adrp x0, msg_found
    add x0, x0, :lo12:msg_found
    mov w1, w22
    mov w2, w0
    bl printf
    b end

not_found:
    adrp x0, msg_notfound
    add x0, x0, :lo12:msg_notfound
    mov w1, w22
    bl printf

end:
    mov w0, #0
    ldp x29, x30, [sp], #16
    ret

// Función de búsqueda binaria recursiva
// x0 = array, w1 = inicio, w2 = fin, w3 = valor a buscar
binary_search:
    stp x29, x30, [sp, #-32]!   // Guardar registros
    str x19, [sp, #16]          // Guardar x19
    mov x29, sp

    // Verificar caso base (inicio > fin)
    cmp w1, w2
    b.gt not_found_binary

    // Calcular punto medio
    add w4, w1, w2              // w4 = inicio + fin
    lsr w4, w4, #1              // w4 = (inicio + fin) / 2

    // Cargar elemento del medio
    lsl w5, w4, #2              // w5 = medio * 4
    ldr w6, [x0, w5, SXTW]      // w6 = array[medio]

    // Comparar con valor buscado
    cmp w6, w3
    b.eq found_binary           // Si son iguales, encontrado
    b.gt search_left            // Si medio > valor, buscar a la izquierda
    b.lt search_right           // Si medio < valor, buscar a la derecha

search_left:
    sub w2, w4, #1              // fin = medio - 1
    bl binary_search            // Búsqueda recursiva
    b return_binary

search_right:
    add w1, w4, #1              // inicio = medio + 1
    bl binary_search            // Búsqueda recursiva
    b return_binary

found_binary:
    mov w0, w4                  // Retornar posición encontrada
    b return_binary

not_found_binary:
    mov w0, #-1                 // No encontrado

return_binary:
    ldr x19, [sp, #16]          // Restaurar x19
    ldp x29, x30, [sp], #32     // Restaurar registros
    ret
