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
        // Solicitar el valor de N
        Console.Write("Ingresa un número para calcular su factorial: ");
        if (int.TryParse(Console.ReadLine(), out int N))
        {
            int factorial = 1;

            // Calcular el factorial de N
            for (int i = 1; i <= N; i++)
            {
                factorial *= i;
            }

            // Imprimir el resultado
            Console.WriteLine("El factorial de {0} es: {1}", N, factorial);
        }
        else
        {
            Console.WriteLine("Entrada no válida para N.");
        }
    }
}
*/

.data
msg_prompt_n: .asciz "Ingresa un número para calcular su factorial: " // Mensaje para solicitar N
msg_result: .asciz "El factorial de %d es: %d\n" // Mensaje para imprimir el resultado
fmt_int: .asciz "%d" // Formato para leer enteros

    .text
    .global main

main:
    // Guardar el puntero de marco y el enlace de retorno
    stp x29, x30, [sp, -16]! // Reservar espacio en la pila
    mov x29, sp // Establecer el puntero de marco
    sub sp, sp, #16 // Reservar espacio para N y el resultado en la pila

    // Solicitar el valor de N
    ldr x0, =msg_prompt_n // Cargar el mensaje para solicitar N
    bl printf // Imprimir el mensaje
    ldr x0, =fmt_int // Cargar el formato para leer un entero
    mov x1, sp // Dirección donde se guardará N en la pila
    bl scanf // Leer el valor de N desde el usuario

    // Cargar N desde la pila
    ldr w1, [sp] // Cargar N en w1

    // Inicializar variables para el cálculo del factorial
    mov w2, #1 // Inicializar el factorial en 1 (w2 almacena el resultado)
    mov w3, #1 // Inicializar el contador en 1

factorial_loop:
    cmp w3, w1 // Comparar el contador con N
    bgt factorial_end // Si el contador es mayor que N, salir del bucle
    mul w2, w2, w3 // Multiplicar el factorial acumulado por el contador
    add w3, w3, #1 // Incrementar el contador
    b factorial_loop // Volver al inicio del bucle

factorial_end:
    // Guardar el resultado en la pila
    str w2, [sp, #4] // Guardar el factorial en la posición de pila reservada

    // Imprimir el resultado
    ldr x0, =msg_result // Cargar el mensaje de resultado
    ldr w1, [sp] // Cargar N en w1 para mostrarlo en el mensaje
    ldr w2, [sp, #4] // Cargar el factorial en w2 para printf
    bl printf // Imprimir el resultado

    // Restaurar el puntero de pila y regresar
    add sp, sp, #16 // Restaurar el puntero de pila
    ldp x29, x30, [sp], 16 // Restaurar el puntero de marco y el enlace de retorno
    ret // Regresar del programa
