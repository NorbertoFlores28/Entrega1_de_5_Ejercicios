/*
** Lenguajes de Interfaz
**Nombre:** Pozos Flores Norberto  
**Número de Control:** 22210336  
**Fecha:** 06 de Noviembre del 2024  
*/

/* Código equivalente en C#
using System;

class Program
{
    static void Main()
    {
        // Imprimir mensaje inicial
        Console.WriteLine("Serie de Fibonacci: ");
        
        // Inicializar los primeros dos números
        long a = 0, b = 1;

        // Imprimir los primeros dos números
        Console.Write(a + " " + b + " ");

        // Imprimir los siguientes números en la serie Fibonacci
        for (int i = 0; i < 8; i++)
        {
            long next = a + b;
            Console.Write(next + " ");
            a = b;
            b = next;
        }

        // Imprimir nueva línea al final
        Console.WriteLine();
    }
}
*/

.data
msg1:   .string "Serie de Fibonacci: \n"    // Mensaje inicial
newline:.string "\n"                        // Carácter de nueva línea
format: .string "%ld "                      // Formato para imprimir números

    .text
    .global main
    .extern printf

main:
    // Guardar registros
    stp     x29, x30, [sp, -16]!   // Guardar frame pointer y link register
    mov     x29, sp                 // Actualizar frame pointer

    // Imprimir mensaje inicial
    adr     x0, msg1
    bl      printf

    // Inicializar variables
    mov     x19, #0                 // Primer número (n-2)
    mov     x20, #1                 // Segundo número (n-1)
    mov     x21, #0                 // Resultado actual
    mov     x22, #10               // Contador (calcularemos 10 números)

print_first:
    // Imprimir primer número (0)
    adr     x0, format
    mov     x1, x19
    bl      printf

    // Imprimir segundo número (1)
    adr     x0, format
    mov     x1, x20
    bl      printf

    // Decrementar contador por los dos números ya impresos
    sub     x22, x22, #2

fibonacci_loop:
    // Verificar si hemos terminado
    cmp     x22, #0
    ble     end

    // Calcular siguiente número
    add     x21, x19, x20          // x21 = x19 + x20
    mov     x19, x20               // x19 = x20
    mov     x20, x21               // x20 = x21

    // Imprimir número actual
    adr     x0, format
    mov     x1, x21
    bl      printf

    // Decrementar contador
    sub     x22, x22, #1
    b       fibonacci_loop

end:
    // Imprimir nueva línea
    adr     x0, newline
    bl      printf

    // Restaurar registros y retornar
    mov     x0, #0                 // Código de retorno 0
    ldp     x29, x30, [sp], #16    // Restaurar frame pointer y link register
    ret
