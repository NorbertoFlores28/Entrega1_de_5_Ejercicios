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
        // Solicitar el primer número
        Console.Write("Ingresa el primer número: ");
        if (double.TryParse(Console.ReadLine(), out double num1))
        {
            // Solicitar el segundo número
            Console.Write("Ingresa el segundo número: ");
            if (double.TryParse(Console.ReadLine(), out double num2))
            {
                // Realizar la resta
                double resta = num1 - num2;
                
                // Imprimir el resultado
                Console.WriteLine("La resta de los números es: {0:F2}", resta);
            }
            else
            {
                Console.WriteLine("Entrada no válida para el segundo número.");
            }
        }
        else
        {
            Console.WriteLine("Entrada no válida para el primer número.");
        }
    }
}
*/

.data
msg_prompt1: .asciz "Ingresa el primer numero: " // Mensaje para solicitar el primer número
msg_prompt2: .asciz "Ingresa el segundo numero: " // Mensaje para solicitar el segundo número
msg_result: .asciz "La resta de los numeros es: %.2f\n" // Mensaje para imprimir el resultado
fmt_float: .asciz "%lf" // Formato para leer flotantes

    .text
    .global main

main:
    // Guardar el puntero de marco y el enlace de retorno
    stp x29, x30, [sp, -16]! // Reservar espacio en la pila
    mov x29, sp // Establecer el puntero de marco
    sub sp, sp, #16 // Reservar espacio en la pila para dos números (double, 8 bytes cada uno)

    // Solicitar el primer número
    ldr x0, =msg_prompt1 // Cargar el mensaje para el primer número
    bl printf // Imprimir el mensaje
    ldr x0, =fmt_float // Cargar el formato para leer un número de punto flotante
    mov x1, sp // Dirección donde se guardará el primer número en la pila
    bl scanf // Leer el primer número (double) desde el usuario

    // Solicitar el segundo número
    ldr x0, =msg_prompt2 // Cargar el mensaje para el segundo número
    bl printf // Imprimir el mensaje
    ldr x0, =fmt_float // Cargar el formato para leer un número de punto flotante
    add x1, sp, #8 // Dirección donde se guardará el segundo número en la pila (8 bytes después del primero)
    bl scanf // Leer el segundo número (double) desde el usuario

    // Cargar los dos números desde la pila
    ldr d0, [sp]       // Cargar el primer número en d0 (double)
    ldr d1, [sp, #8]   // Cargar el segundo número en d1 (double)

    // Realizar la resta
    fsub d2, d0, d1 // Restar el segundo número del primero -> d2 = num1 - num2

    // Imprimir el resultado
    ldr x0, =msg_result // Cargar el mensaje de resultado
    fmov d0, d2 // Mover el resultado de la resta a d0 para printf
    bl printf // Imprimir la resta

    // Restaurar el puntero de pila y regresar
    add sp, sp, #16 // Restaurar el puntero de pila
    ldp x29, x30, [sp], 16 // Restaurar el puntero de marco y el enlace de retorno
    ret // Regresar del programa
