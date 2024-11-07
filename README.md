# Entrega 1 de 5 Ejercicios - Lenguajes de Interfaz

**Nombre:** Pozos Flores Norberto  
**Número de Control:** 22210336  
**Fecha:** 06 de Noviembre del 2024  

## Descripción

Programa 1 de 50 Realiza la conversion de temperatura de Celsius a Fahrenheit.
Video de Prueba
https://asciinema.org/a/687834

## Código Completo

```c
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
        // Solicitar la temperatura en Celsius
        Console.Write("Ingresa la temperatura en Celsius: ");
        
        // Leer la temperatura en Celsius
        if (double.TryParse(Console.ReadLine(), out double celsius))
        {
            // Realizar la conversión a Fahrenheit: F = C * (9/5) + 32
            double fahrenheit = celsius * 1.8 + 32;
            
            // Imprimir el resultado
            Console.WriteLine("La temperatura en Fahrenheit es: {0:F2}", fahrenheit);
        }
        else
        {
            Console.WriteLine("Entrada no válida.");
        }
    }
}
*/

/* Ensamblador
.data
msg_prompt: .asciz "Ingresa la temperatura en Celsius: " // Mensaje para solicitar la temperatura en Celsius
msg_result: .asciz "La temperatura en Fahrenheit es: %.2f\n" // Mensaje para imprimir el resultado en Fahrenheit
fmt_float: .asciz "%lf" // Formato para leer flotantes
factor: .double 1.8 // Constante 9/5
addend: .double 32.0 // Constante 32

    .text
    .global main

main:
    // Guardar el puntero de marco y el enlace de retorno
    stp x29, x30, [sp, -16]! // Reservar espacio en la pila
    mov x29, sp // Establecer el puntero de marco
    sub sp, sp, #16 // Reservar espacio para la temperatura en Celsius (double, 8 bytes)

    // Solicitar la temperatura en Celsius
    ldr x0, =msg_prompt // Cargar el mensaje para la temperatura en Celsius
    bl printf // Imprimir el mensaje
    ldr x0, =fmt_float // Cargar el formato para leer un número de punto flotante
    mov x1, sp // Dirección donde se guardará la temperatura en Celsius en la pila
    bl scanf // Leer la temperatura en Celsius (double) desde el usuario

    // Cargar la temperatura en Celsius desde la pila
    ldr d0, [sp] // Cargar la temperatura en Celsius en d0 (double)

    // Realizar la conversión a Fahrenheit: F = C * (9/5) + 32
    ldr x1, =factor // Cargar la dirección de factor (1.8) en x1
    ldr d1, [x1]    // Cargar el valor 1.8 en d1 desde la memoria
    fmul d2, d0, d1 // Multiplicar Celsius por 9/5 -> d2 = C * (9/5)
    ldr x2, =addend // Cargar la dirección de addend (32) en x2
    ldr d3, [x2]    // Cargar el valor 32 en d3 desde la memoria
    fadd d2, d2, d3 // Sumar 32 al resultado -> d2 = C * (9/5) + 32

    // Imprimir el resultado
    ldr x0, =msg_result // Cargar el mensaje de resultado
    fmov d0, d2 // Mover el resultado (Fahrenheit) a d0 para printf
    bl printf // Imprimir la temperatura en Fahrenheit

    // Restaurar el puntero de pila y regresar
    add sp, sp, #16 // Restaurar el puntero de pila
    ldp x29, x30, [sp], 16 // Restaurar el puntero de marco y el enlace de retorno
    ret // Regresar del programa
*/
```
## Descripción

Programa 2 de 50 Realiza la Suma de dos numeros ingresados por el usuario.
Video de Prueba
https://asciinema.org/a/687838

## Código Completo

```c
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
                // Realizar la suma
                double suma = num1 + num2;
                
                // Imprimir el resultado
                Console.WriteLine("La suma de los números es: {0:F2}", suma);
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
msg_result: .asciz "La suma de los numeros es: %.2f\n" // Mensaje para imprimir el resultado
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

    // Realizar la suma
    fadd d2, d0, d1 // Sumar los dos números -> d2 = num1 + num2

    // Imprimir el resultado
    ldr x0, =msg_result // Cargar el mensaje de resultado
    fmov d0, d2 // Mover el resultado de la suma a d0 para printf
    bl printf // Imprimir la suma

    // Restaurar el puntero de pila y regresar
    add sp, sp, #16 // Restaurar el puntero de pila
    ldp x29, x30, [sp], 16 // Restaurar el puntero de marco y el enlace de retorno
    ret // Regresar del programa
*/
```
## Descripción

Programa 3 de 50 Realiza la Resta de dos numeros ingresados por el usuario.
Video de Prueba
https://asciinema.org/a/687843

## Código Completo
```c
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
*/
```
## Descripción

Programa 4 de 50 Realiza la Multiplicacion de dos numeros ingresados por el usuario.
Video de Prueba
https://asciinema.org/a/687844

## Código Completo
```c
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
                // Realizar la multiplicación
                double multiplicacion = num1 * num2;
                
                // Imprimir el resultado
                Console.WriteLine("La multiplicación de los números es: {0:F2}", multiplicacion);
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
msg_result: .asciz "La multiplicacion de los numeros es: %.2f\n" // Mensaje para imprimir el resultado
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

    // Realizar la multiplicación
    fmul d2, d0, d1 // Multiplicar los dos números -> d2 = num1 * num2

    // Imprimir el resultado
    ldr x0, =msg_result // Cargar el mensaje de resultado
    fmov d0, d2 // Mover el resultado de la multiplicación a d0 para printf
    bl printf // Imprimir la multiplicación

    // Restaurar el puntero de pila y regresar
    add sp, sp, #16 // Restaurar el puntero de pila
    ldp x29, x30, [sp], 16 // Restaurar el puntero de marco y el enlace de retorno
    ret // Regresar del programa
*/
```
## Descripción

Programa 5 de 50 Realiza la Division de dos numeros ingresados por el usuario.
Video de Prueba
https://asciinema.org/a/687846

## Código Completo
```c
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
        // Solicitar el primer número (dividendo)
        Console.Write("Ingresa el primer número (dividendo): ");
        if (double.TryParse(Console.ReadLine(), out double num1))
        {
            // Solicitar el segundo número (divisor)
            Console.Write("Ingresa el segundo número (divisor): ");
            if (double.TryParse(Console.ReadLine(), out double num2))
            {
                // Verificar si el divisor es cero
                if (num2 != 0)
                {
                    // Realizar la división
                    double division = num1 / num2;
                    
                    // Imprimir el resultado
                    Console.WriteLine("La división de los números es: {0:F2}", division);
                }
                else
                {
                    Console.WriteLine("Error: División por cero no permitida.");
                }
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
msg_prompt1: .asciz "Ingresa el primer numero (dividendo): " // Mensaje para solicitar el primer número (dividendo)
msg_prompt2: .asciz "Ingresa el segundo numero (divisor): " // Mensaje para solicitar el segundo número (divisor)
msg_result: .asciz "La division de los numeros es: %.2f\n" // Mensaje para imprimir el resultado
fmt_float: .asciz "%lf" // Formato para leer flotantes

    .text
    .global main

main:
    // Guardar el puntero de marco y el enlace de retorno
    stp x29, x30, [sp, -16]! // Reservar espacio en la pila
    mov x29, sp // Establecer el puntero de marco
    sub sp, sp, #16 // Reservar espacio en la pila para dos números (double, 8 bytes cada uno)

    // Solicitar el primer número (dividendo)
    ldr x0, =msg_prompt1 // Cargar el mensaje para el primer número
    bl printf // Imprimir el mensaje
    ldr x0, =fmt_float // Cargar el formato para leer un número de punto flotante
    mov x1, sp // Dirección donde se guardará el primer número en la pila
    bl scanf // Leer el primer número (double) desde el usuario

    // Solicitar el segundo número (divisor)
    ldr x0, =msg_prompt2 // Cargar el mensaje para el segundo número
    bl printf // Imprimir el mensaje
    ldr x0, =fmt_float // Cargar el formato para leer un número de punto flotante
    add x1, sp, #8 // Dirección donde se guardará el segundo número en la pila (8 bytes después del primero)
    bl scanf // Leer el segundo número (double) desde el usuario

    // Cargar los dos números desde la pila
    ldr d0, [sp]       // Cargar el primer número (dividendo) en d0 (double)
    ldr d1, [sp, #8]   // Cargar el segundo número (divisor) en d1 (double)

    // Realizar la división
    fdiv d2, d0, d1 // Dividir el dividendo entre el divisor -> d2 = num1 / num2

    // Imprimir el resultado
    ldr x0, =msg_result // Cargar el mensaje de resultado
    fmov d0, d2 // Mover el resultado de la división a d0 para printf
    bl printf // Imprimir la división

    // Restaurar el puntero de pila y regresar
    add sp, sp, #16 // Restaurar el puntero de pila
    ldp x29, x30, [sp], 16 // Restaurar el puntero de marco y el enlace de retorno
    ret // Regresar del programa
*/
```
## Descripción

Programa 6 de 50 Suma de los primeros N numeros naturales
Video de Prueba
https://asciinema.org/a/687848

## Código Completo
```c
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
        Console.Write("Ingresa el valor de N (número de términos a sumar): ");
        if (int.TryParse(Console.ReadLine(), out int N))
        {
            int suma = 0;

            // Realizar la suma de los primeros N números naturales
            for (int i = 1; i <= N; i++)
            {
                suma += i;
            }

            // Imprimir el resultado
            Console.WriteLine("La suma de los primeros N números naturales es: {0}", suma);
        }
        else
        {
            Console.WriteLine("Entrada no válida para N.");
        }
    }
}
*/

.data
msg_prompt_n: .asciz "Ingresa el valor de N (número de términos a sumar): " // Mensaje para solicitar N
msg_result: .asciz "La suma de los primeros N números naturales es: %d\n" // Mensaje para imprimir el resultado
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

    // Inicializar variables para la suma
    mov w2, #0 // Inicializar la suma en 0
    mov w3, #1 // Inicializar el contador en 1

loop:
    cmp w3, w1 // Comparar el contador con N
    bgt end // Si el contador es mayor que N, salir del bucle
    add w2, w2, w3 // Acumular el contador en la suma
    add w3, w3, #1 // Incrementar el contador
    b loop // Volver al inicio del bucle

end:
    // Guardar el resultado en la pila
    str w2, [sp, #4] // Guardar la suma en la posición de pila reservada

    // Imprimir el resultado
    ldr x0, =msg_result // Cargar el mensaje de resultado
    ldr w1, [sp, #4] // Cargar el resultado en w1 para printf
    bl printf // Imprimir la suma

    // Restaurar el puntero de pila y regresar
    add sp, sp, #16 // Restaurar el puntero de pila
    ldp x29, x30, [sp], 16 // Restaurar el puntero de marco y el enlace de retorno
    ret // Regresar del programa
*/
```
## Descripción

Programa 7 de 50 Realiza el Factorial de un Numero Ingresado por el Usuario.
Video de Prueba
https://asciinema.org/a/687851

## Código Completo
```c
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
*/
```
## Descripción

Programa 8 de 50 Realiza la Serie Fibonacci.
Video de Prueba
https://asciinema.org/a/687853

## Código Completo
```c
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
*/
```
## Descripción

Programa 9 de 50 Indica si un numero es primo o no es primo.
Video de Prueba
https://asciinema.org/a/687859

## Código Completo
```c
/*
** Lenguajes de Interfaz
** Nombre:** Pozos Flores Norberto  
** Número de Control:** 22210336  
** Fecha:** 06 de Noviembre del 2024  
*/

/* Código equivalente en C#
using System;

class Program
{
    static void Main()
    {
        // Solicitar el valor de N
        Console.Write("Ingresa un número para verificar si es primo: ");
        int N = int.Parse(Console.ReadLine());

        // Verificar si el número es menor o igual a 1 (no primo)
        if (N <= 1)
        {
            Console.WriteLine($"El número {N} no es primo.");
            return;
        }

        // Verificar si N es primo
        for (int i = 2; i <= Math.Sqrt(N); i++)
        {
            if (N % i == 0)
            {
                Console.WriteLine($"El número {N} no es primo.");
                return;
            }
        }

        // Si no fue divisible por ningún número, es primo
        Console.WriteLine($"El número {N} es primo.");
    }
}
*/

.data
msg_prompt_n: .asciz "Ingresa un número para verificar si es primo: " // Mensaje para solicitar N
msg_prime: .asciz "El número %d es primo.\n" // Mensaje cuando el número es primo
msg_not_prime: .asciz "El número %d no es primo.\n" // Mensaje cuando el número no es primo
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

    // Verificar si el número es menor o igual a 1 (no primo)
    cmp w1, #1 // Comparar N con 1
    ble not_prime // Si N <= 1, no es primo

    // Inicializar el contador i en 2
    mov w2, #2 // w2 será el contador i

    // Bucle para verificar si N es divisible por algún número desde 2 hasta √N
check_prime_loop:
    mul w3, w2, w2 // w3 = i * i
    cmp w3, w1 // Comparar i * i con N
    bgt prime // Si i * i > N, el número es primo

    // Verificar si N es divisible por i
    udiv w4, w1, w2 // w4 = N / i
    mul w5, w4, w2 // w5 = (N / i) * i
    cmp w5, w1 // Comparar (N / i) * i con N
    beq not_prime // Si son iguales, N es divisible por i, no es primo

    // Incrementar el contador i
    add w2, w2, #1 // i = i + 1
    b check_prime_loop // Repetir el bucle

prime:
    // El número es primo
    ldr x0, =msg_prime // Cargar el mensaje "es primo"
    ldr w1, [sp] // Cargar N en w1 para mostrarlo en el mensaje
    bl printf // Imprimir el mensaje

    b end_program // Saltar al final del programa

not_prime:
    // El número no es primo
    ldr x0, =msg_not_prime // Cargar el mensaje "no es primo"
    ldr w1, [sp] // Cargar N en w1 para mostrarlo en el mensaje
    bl printf // Imprimir el mensaje

end_program:
    // Restaurar el puntero de pila y regresar
    add sp, sp, #16 // Restaurar el puntero de pila
    ldp x29, x30, [sp], 16 // Restaurar el puntero de marco y el enlace de retorno
    ret // Regresar del programa
*/
```
## Descripción

Programa 10 de 50 Muestra una cadena de mensaje al reves.
Video de Prueba
https://asciinema.org/a/687861

## Código Completo
```c
/*
** Lenguajes de Interfaz
** Nombre:** Pozos Flores Norberto  
** Número de Control:** 22210336  
** Fecha:** 06 de Noviembre del 2024  
*/

/* Código equivalente en C#
using System;

class Program
{
    static void Main()
    {
        // Solicitar la cadena de texto
        Console.Write("Ingresa una cadena de texto: ");
        string input = Console.ReadLine();

        // Invertir la cadena
        char[] charArray = input.ToCharArray();
        Array.Reverse(charArray);
        string reversed = new string(charArray);

        // Imprimir la cadena invertida
        Console.WriteLine("La cadena invertida es: " + reversed);
    }
}
*/

.data
msg_prompt: .asciz "Ingresa una cadena de texto: " // Mensaje para solicitar la cadena
msg_result: .asciz "La cadena invertida es: %s\n" // Mensaje para imprimir la cadena invertida

    .text
    .global main

main:
    // Guardar el puntero de marco y el enlace de retorno
    stp x29, x30, [sp, -16]! // Reservar espacio en la pila
    mov x29, sp // Establecer el puntero de marco
    sub sp, sp, #256 // Reservar espacio para la cadena de entrada (máximo 255 caracteres)

    // Solicitar la cadena de texto
    ldr x0, =msg_prompt // Cargar el mensaje para solicitar la cadena
    bl printf // Imprimir el mensaje
    ldr x0, =input_format // Cargar el formato para leer una cadena
    mov x1, sp // Dirección donde se guardará la cadena en la pila
    bl scanf // Leer la cadena desde el usuario

    // Encontrar el final de la cadena (buscando el carácter nulo '\0')
    mov x2, sp // Dirección de la cadena
find_end:
    ldrb w3, [x2] // Cargar el siguiente byte de la cadena
    cmp w3, #0 // Verificar si es el carácter nulo ('\0')
    beq reverse_string // Si es el final de la cadena, salir del bucle
    add x2, x2, #1 // Avanzar al siguiente carácter
    b find_end // Continuar buscando

reverse_string:
    // x2 contiene la dirección del carácter nulo ('\0'), retrocedemos una posición
    sub x2, x2, #1 // Retroceder una posición, apuntar al último carácter válido

    // Iniciar el proceso de invertir la cadena
    mov x3, sp // Dirección inicial de la cadena
reverse_loop:
    cmp x3, x2 // Comparar los punteros
    bge end_reverse // Si los punteros se cruzan, terminamos
    ldrb w4, [x3] // Cargar el carácter de la posición inicial
    ldrb w5, [x2] // Cargar el carácter de la posición final
    strb w5, [x3] // Colocar el carácter final en la posición inicial
    strb w4, [x2] // Colocar el carácter inicial en la posición final
    add x3, x3, #1 // Avanzar el puntero inicial
    sub x2, x2, #1 // Retroceder el puntero final
    b reverse_loop // Continuar invirtiendo

end_reverse:
    // Imprimir la cadena invertida
    ldr x0, =msg_result // Cargar el mensaje para mostrar el resultado
    mov x1, sp // Dirección de la cadena invertida
    bl printf // Imprimir la cadena invertida

    // Restaurar el puntero de pila y regresar
    add sp, sp, #256 // Restaurar el puntero de pila
    ldp x29, x30, [sp], 16 // Restaurar el puntero de marco y el enlace de retorno
    ret // Regresar del programa

    .data
input_format: .asciz "%255s" // Formato para leer una cadena de hasta 255 caracteres
*/
```





