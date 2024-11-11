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
## Descripción

Programa 11 de 50 Verifica si una cadena es Palindromo.
Video de Prueba
https://asciinema.org/a/688853

## Código Completo
```c
/*
** Lenguajes de Interfaz
** Nombre:** Pozos Flores Norberto  
** Número de Control:** 22210336  
** Fecha:** 07 de Noviembre del 2024  
*/
// Equivalente en C#:
/*
using System;
using System.Runtime.InteropServices;
using System.Text;

class Program
{
    // Importar la función de verificación de palíndromo desde la biblioteca compartida
    [DllImport("libcalculations.so")]
    public static extern int es_palindromo(StringBuilder str);

    static void Main()
    {
        // Pedir al usuario que ingrese una cadena
        Console.Write("Ingresa una cadena para verificar si es palíndromo: ");
        string input = Console.ReadLine();

        // Convertir la cadena a StringBuilder (mutable)
        StringBuilder cadena = new StringBuilder(input);

        // Llamar a la función para verificar si es palíndromo
        int resultado = es_palindromo(cadena);

        // Mostrar el resultado
        if (resultado == 1)
        {
            Console.WriteLine($"\"{input}\" es un palíndromo.");
        }
        else
        {
            Console.WriteLine($"\"{input}\" no es un palíndromo.");
        }
    }
}
*/


.section .data
    prompt:     .asciz "Ingresa para verificar si es palindromo:"
    is_pal:     .asciz "\"\n es palindromo.\n"
    not_pal:    .asciz "\" \n no es palindromo.\n"
    quote:      .asciz "\""
    buffer:     .skip 100
    len:        .quad 0

.section .text
.global _start

es_palindromo:
    // Guardar registros
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    // Encuentra la longitud de la cadena
    mov x1, x0             // x1 apunta al inicio de la cadena
find_end:
    ldrb w2, [x1], #1      // Leer el siguiente byte (carácter) y avanzar
    cbz w2, check_palindrome // Si llegamos al final ('\0'), comenzar verificación
    b find_end             // Continuar hasta encontrar el final

check_palindrome:
    sub x1, x1, #2         // Retroceder una posición (x1 apunta al último carácter)
    mov x2, x1             // x2 apunta al final de la cadena
    mov x3, x0             // x3 apunta al inicio de la cadena

compare_loop:
    cmp x3, x2             // Comparar el inicio con el final
    bge is_palindrome      // Si se cruzan, es un palíndromo
    ldrb w4, [x3]          // Leer carácter desde el inicio
    ldrb w5, [x2]          // Leer carácter desde el final
    cmp w4, w5             // Comparar caracteres
    bne not_palindrome     // Si no son iguales, no es palíndromo
    add x3, x3, #1         // Avanzar el inicio
    sub x2, x2, #1         // Retroceder el final
    b compare_loop         // Repetir la comparación

is_palindrome:
    mov w0, #1              // Retornar 1 si es palíndromo
    b end_palindrome

not_palindrome:
    mov w0, #0              // Retornar 0 si no es palíndromo

end_palindrome:
    // Restaurar registros
    ldp x29, x30, [sp], #16
    ret

_start:
    // Imprimir prompt
    mov x0, #1              // stdout
    adr x1, prompt         // mensaje
    mov x2, #44            // longitud
    mov x8, #64            // write syscall
    svc #0

    // Leer entrada
    mov x0, #0              // stdin
    adr x1, buffer         // buffer
    mov x2, #100           // tamaño máximo
    mov x8, #63            // read syscall
    svc #0

    // Guardar longitud
    sub x0, x0, #1         // restar 1 para quitar el newline
    adr x1, len
    str x0, [x1]           // guardar longitud

    // Poner null terminator
    adr x1, buffer
    strb wzr, [x1, x0]     // reemplazar newline con null

    // Imprimir comilla inicial
    mov x0, #1
    adr x1, quote
    mov x2, #1
    mov x8, #64
    svc #0

    // Imprimir cadena original
    mov x0, #1
    adr x1, buffer
    adr x2, len
    ldr x2, [x2]
    mov x8, #64
    svc #0

    // Llamar a es_palindromo
    adr x0, buffer
    bl es_palindromo
    mov x19, x0            // guardar resultado

    // Imprimir mensaje según resultado
    mov x0, #1
    cmp x19, #1
    beq .Lprint_is
    
    // No es palíndromo
    adr x1, not_pal
    mov x2, #20
    b .Lprint_result

.Lprint_is:
    // Es palíndromo
    adr x1, is_pal
    mov x2, #17

.Lprint_result:
    mov x8, #64
    svc #0

    // Salir
    mov x0, #0
    mov x8, #93
    svc #0
```
## Descripción

Programa 12 de 50 Encontrar el Maximo en un Arreglo.
Video de Prueba
https://asciinema.org/a/688855

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 11/11/2024
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
```
## Descripción

Programa 13 de 50 Encontrar el Minimo en un Arreglo.
Video de Prueba
https://asciinema.org/a/688859

## Código Completo
```c

// Autor: Pozos Flores Norberto
// Fecha: 11/11/2024
// Descripción: Programa en ensamblador que encuentra el mínimo en un arreglo

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

        // Calcular el mínimo si hay elementos en el arreglo
        if (size > 0) {
            int min = EncontrarMinimo(array, size);
            Console.WriteLine("El mínimo es: {0}", min);
        }
    }

    // Función para encontrar el mínimo en un arreglo
    static int EncontrarMinimo(int[] array, int size) {
        int min = array[0];
        for (int i = 1; i < size; i++) {
            if (array[i] < min) {
                min = array[i];
            }
        }
        return min;
    }
}
*/

.section .data
    // Mensajes para interactuar con el usuario
    msg_input:    .string "Ingrese un número (0 para terminar): "
    msg_result:   .string "El mínimo es: %d\n"
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
    cbz w21, find_min

    // Guardar número en el arreglo
    str w21, [x19, x20, lsl #2]
    add x20, x20, #1
    
    // Continuar si no hemos llegado al límite
    cmp x20, #100
    b.lt input_loop

find_min:
    // Verificar si hay elementos
    cbz x20, end

    // Llamar a encontrar_minimo
    mov x0, x19              // Dirección del arreglo
    mov x1, x20              // Número de elementos
    bl encontrar_minimo

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

// Función para encontrar el mínimo en un arreglo
// Parámetros: x0 = puntero al arreglo, x1 = número de elementos
// Retorno: x0 = valor mínimo
encontrar_minimo:
    // Verificar si hay elementos
    cbz x1, min_fin         // Si no hay elementos, retornar
    
    ldr w2, [x0]           // Primer elemento como mínimo inicial
    mov x4, x0             // Guardar puntero original
    mov x3, x1             // Copiar contador
    sub x3, x3, #1         // Ajustar contador para el bucle
    
min_loop:
    cbz x3, min_fin        // Si no hay más elementos, terminar
    
    ldr w5, [x4, #4]!      // Cargar siguiente elemento
    cmp w5, w2             // Comparar con mínimo actual
    csel w2, w5, w2, lt    // Seleccionar el menor
    
    subs x3, x3, #1        // Decrementar contador
    b.ne min_loop          // Continuar si no hemos terminado
    
min_fin:
    mov w0, w2             // Retornar mínimo
    ret

```
## Descripción

Programa 14 de 50 Busqueda Lineal.
Video de Prueba
https://asciinema.org/a/688867

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 11/11/2024
// Descripción: Programa en ensamblador para búsqueda lineal en un arreglo

/*
using System;
class Program {
    static void Main() {
        Console.Write("Ingrese la cantidad de números: ");
        int cantidad = int.Parse(Console.ReadLine());

        int[] array = new int[cantidad];
        for (int i = 0; i < cantidad; i++) {
            Console.Write($"Ingrese el número {i + 1}: ");
            array[i] = int.Parse(Console.ReadLine());
        }

        Console.Write("Ingrese el número a buscar: ");
        int buscar = int.Parse(Console.ReadLine());

        int resultado = BusquedaLineal(array, cantidad, buscar);
        if (resultado != -1) {
            Console.WriteLine($"El número {buscar} se encontró en la posición {resultado}");
        } else {
            Console.WriteLine($"El número {buscar} no se encontró en el arreglo");
        }
    }

    // Función de búsqueda lineal
    static int BusquedaLineal(int[] array, int size, int value) {
        for (int i = 0; i < size; i++) {
            if (array[i] == value) {
                return i;
            }
        }
        return -1; // No se encontró
    }
}
*/

.section .data
    // Mensajes para interactuar con el usuario
    msg_cant:     .string "Ingrese la cantidad de números: "
    msg_input:    .string "Ingrese el número %d: "
    msg_search:   .string "Ingrese el número a buscar: "
    msg_found:    .string "El número %d se encontró en la posición %d\n"
    msg_notfound: .string "El número %d no se encontró en el arreglo\n"
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
    ldr w20, [sp]    // w20 = cantidad de números
    add sp, sp, #16

    // Inicializar variables
    adrp x19, array
    add x19, x19, :lo12:array
    mov w21, #0      // Contador para el bucle

input_loop:
    // Imprimir mensaje de entrada
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
    
    // Guardar número en el arreglo
    ldr w22, [sp]
    str w22, [x19, x21, lsl #2]   // Cambié w21 por x21 para el desplazamiento
    add sp, sp, #16
    
    // Incrementar contador y verificar si terminamos
    add w21, w21, #1
    cmp w21, w20
    b.lt input_loop

    // Pedir número a buscar
    adrp x0, msg_search
    add x0, x0, :lo12:msg_search
    bl printf

    // Leer número a buscar
    sub sp, sp, #16
    mov x1, sp
    adrp x0, fmt_input
    add x0, x0, :lo12:fmt_input
    bl scanf
    ldr w22, [sp]    // w22 = número a buscar
    add sp, sp, #16

    // Llamar a búsqueda lineal
    mov x0, x19      // Dirección del arreglo
    mov w1, w20      // Tamaño del arreglo (cambiado a 32 bits)
    mov w2, w22      // Valor a buscar
    bl busqueda_lineal

    // Verificar resultado y mostrar
    cmp w0, #-1
    b.eq not_found

    // Número encontrado
    adrp x0, msg_found
    add x0, x0, :lo12:msg_found
    mov w1, w22      // Número buscado
    mov w2, w0       // Posición donde se encontró
    bl printf
    b end

not_found:
    // Número no encontrado
    adrp x0, msg_notfound
    add x0, x0, :lo12:msg_notfound
    mov w1, w22      // Número buscado
    bl printf

end:
    // Epílogo y retorno
    mov x0, #0
    ldp x29, x30, [sp], #16
    ret

// Función de búsqueda lineal mejorada
// Parámetros: x0 = arreglo, x1 = tamaño, w2 = valor a buscar
// Retorno: w0 = índice (-1 si no se encuentra)
busqueda_lineal:
    mov x4, x0              // Guardar puntero al arreglo
    mov w5, #0              // Inicializar índice en 0
    
buscar_loop:
    cbz x1, no_encontrado   // Si no quedan elementos, no se encontró
    
    ldr w3, [x4]           // Cargar elemento actual
    cmp w3, w2             // Comparar con valor buscado
    b.eq encontrado        // Si es igual, encontramos el valor
    
    add x4, x4, #4         // Avanzar al siguiente elemento
    add w5, w5, #1         // Incrementar índice
    sub x1, x1, #1         // Decrementar contador
    b buscar_loop          // Continuar búsqueda
    
no_encontrado:
    mov w0, #-1            // Retornar -1 (no encontrado)
    ret
    
encontrado:
    mov w0, w5             // Retornar índice donde se encontró
    ret
```
## Descripción

Programa 15 de 50 Busqueda Lineal.
Video de Prueba
https://asciinema.org/a/688888

## Código Completo
```c
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
```
## Descripción

Programa 16 de 50 Ordenamiento Burbuja.
Video de Prueba
https://asciinema.org/a/688898

## Código Completo
```c
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
```
## Descripción

Programa 17 de 50 Ordenamiento por Seleccion.
Video de Prueba
https://asciinema.org/a/688900

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 11/11/2024
// Descripción: Programa en ensamblador que implementa un algoritmo de ordenamiento de Seleccion

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
msg_before: .asciz "Arreglo antes de ordenar:\n"
msg_after: .asciz "Arreglo después de ordenar:\n"
msg_elem: .asciz "%d "                                 // Para imprimir cada elemento
msg_nl: .asciz "\n"                                    // Nueva línea

.text
.global main

main:
    // Guardar registros
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // Imprimir mensaje inicial
    adrp x0, msg_before
    add x0, x0, :lo12:msg_before
    bl printf

    // Imprimir arreglo original
    bl print_array

    // Preparar para ordenamiento por selección
    adrp x0, arr_len
    add x0, x0, :lo12:arr_len
    ldr w0, [x0]        // w0 = longitud del arreglo
    sub w1, w0, #1      // w1 = n-1 para el bucle externo

outer_loop:
    cmp w1, #0          // Verificar si hemos terminado
    blt done_sort       // Si w1 < 0, terminamos
    
    mov w2, w1          // w2 = índice del máximo actual
    mov w3, w1          // w3 = contador para bucle interno
    
inner_loop:
    cmp w3, #0          // Verificar si llegamos al inicio
    blt end_inner       // Si w3 < 0, terminar bucle interno
    
    // Cargar elementos a comparar
    adrp x4, array
    add x4, x4, :lo12:array
    
    lsl w5, w3, #2      // w5 = índice * 4
    add x5, x4, w5, UXTW    // x5 = dirección del elemento actual
    lsl w6, w2, #2      // w6 = índice_max * 4
    add x6, x4, w6, UXTW    // x6 = dirección del máximo actual
    
    ldr w7, [x5]        // w7 = elemento actual
    ldr w8, [x6]        // w8 = elemento máximo actual
    
    // Comparar elementos
    cmp w7, w8
    ble no_update       // Si actual <= máximo, no actualizar
    mov w2, w3          // Actualizar índice del máximo

no_update:
    sub w3, w3, #1      // Decrementar contador interno
    b inner_loop

end_inner:
    // Intercambiar elementos si es necesario
    cmp w2, w1          // Verificar si el máximo está en su posición
    beq no_swap         // Si está en posición, no intercambiar
    
    // Realizar intercambio
    adrp x4, array
    add x4, x4, :lo12:array
    lsl w5, w1, #2      // Calcular offset para posición actual
    add x5, x4, w5, UXTW
    lsl w6, w2, #2      // Calcular offset para posición del máximo
    add x6, x4, w6, UXTW
    
    ldr w7, [x5]        // Cargar elemento en posición actual
    ldr w8, [x6]        // Cargar elemento máximo
    str w8, [x5]        // Guardar máximo en posición actual
    str w7, [x6]        // Guardar elemento actual en posición del máximo

no_swap:
    sub w1, w1, #1      // Decrementar contador externo
    b outer_loop

done_sort:
    // Imprimir mensaje final
    adrp x0, msg_after
    add x0, x0, :lo12:msg_after
    bl printf

    // Imprimir arreglo ordenado
    bl print_array

    // Restaurar y retornar
    ldp x29, x30, [sp], 16
    ret

// Subrutina para imprimir el arreglo
print_array:
    stp x29, x30, [sp, -16]!    // Guardar registros
    
    adrp x19, array             // Cargar dirección del arreglo
    add x19, x19, :lo12:array
    adrp x20, arr_len
    add x20, x20, :lo12:arr_len
    ldr w20, [x20]              // Cargar longitud
    mov w21, #0                 // Inicializar contador

print_loop:
    cmp w21, w20                // Comparar contador con longitud
    bge print_end               // Si terminamos, salir
    
    // Imprimir elemento actual
    adrp x0, msg_elem
    add x0, x0, :lo12:msg_elem
    ldr w1, [x19, w21, UXTW #2] // Cargar elemento actual
    bl printf
    
    add w21, w21, #1            // Incrementar contador
    b print_loop

print_end:
    // Imprimir nueva línea
    adrp x0, msg_nl
    add x0, x0, :lo12:msg_nl
    bl printf
    
    ldp x29, x30, [sp], 16      // Restaurar registros
    ret


```
## Descripción

Programa 18 de 50 Ordenamiento por Mezcla.
Video de Prueba
https://asciinema.org/a/688903

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 11/11/2024
// Descripción: Programa en ensamblador que implementa un algoritmo de ordenamiento de Mezcla

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


```
## Descripción

Programa 19 de 50 Suma de Matricez.
Video de Prueba
https://asciinema.org/a/688907

## Código Completo
```c
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



```
## Descripción

Programa 20 de 50 Multiplicacion de Matricez.
Video de Prueba
https://asciinema.org/a/688915

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 11/11/2024
// Descripción: Programa en ensamblador que implementa la Multiplica de dos matrices 3x3
/*
using System;

class MatrixMultiplication
{
    static void Main()
    {
        // Definir las dimensiones de las matrices
        int N = 3;  // Filas
        int M = 3;  // Columnas

        // Inicializar las matrices
        int[,] matrix1 = new int[N, M];
        int[,] matrix2 = new int[N, M];
        int[,] result = new int[N, M];

        // Solicitar los elementos de la primera matriz
        Console.WriteLine("\nIngrese los elementos de la primera matriz 3x3:");
        for (int i = 0; i < N; i++)
        {
            for (int j = 0; j < M; j++)
            {
                Console.Write($"Ingrese elemento [{i + 1}][{j + 1}]: ");
                matrix1[i, j] = int.Parse(Console.ReadLine());
            }
        }

        // Solicitar los elementos de la segunda matriz
        Console.WriteLine("\nIngrese los elementos de la segunda matriz 3x3:");
        for (int i = 0; i < N; i++)
        {
            for (int j = 0; j < M; j++)
            {
                Console.Write($"Ingrese elemento [{i + 1}][{j + 1}]: ");
                matrix2[i, j] = int.Parse(Console.ReadLine());
            }
        }

        // Realizar la multiplicación de matrices
        for (int i = 0; i < N; i++)
        {
            for (int j = 0; j < M; j++)
            {
                result[i, j] = 0;
                for (int k = 0; k < M; k++)
                {
                    result[i, j] += matrix1[i, k] * matrix2[k, j];
                }
            }
        }

        // Mostrar la matriz resultado
        Console.WriteLine("\nMatriz resultado:");
        for (int i = 0; i < N; i++)
        {
            for (int j = 0; j < M; j++)
            {
                Console.Write($"{result[i, j],4} ");
            }
            Console.WriteLine(); // Nueva línea al final de cada fila
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
    sub sp, sp, #16
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
    add sp, sp, #16

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
    // Realizar la multiplicación
    mov x19, #0          // i = 0

mult_loop_i:
    cmp x19, #3
    beq end_mult_loop_i
    mov x21, #0          // j = 0

mult_loop_j:
    cmp x21, #3
    beq end_mult_loop_j
    
    // Inicializar el acumulador para el elemento resultado[i][j]
    mov w26, #0          // sum = 0
    mov x22, #0          // k = 0

mult_loop_k:
    cmp x22, #3
    beq end_mult_loop_k

    // Calcular offset para matrix1[i][k]
    mov x23, #12         // 3 * 4
    mul x24, x19, x23    // i * (3 * 4)
    mov x25, #4
    mul x27, x22, x25    // k * 4
    add x24, x24, x27    // offset para matrix1[i][k]

    // Calcular offset para matrix2[k][j]
    mul x25, x22, x23    // k * (3 * 4)
    mov x27, #4
    mul x28, x21, x27    // j * 4
    add x25, x25, x28    // offset para matrix2[k][j]

    // Cargar elementos y multiplicar
    adrp x20, matrix1
    add x20, x20, :lo12:matrix1
    ldr w27, [x20, x24]  // matrix1[i][k]

    adrp x20, matrix2
    add x20, x20, :lo12:matrix2
    ldr w28, [x20, x25]  // matrix2[k][j]

    // Multiplicar y acumular
    mul w27, w27, w28
    add w26, w26, w27    // sum += matrix1[i][k] * matrix2[k][j]

    add x22, x22, #1     // k++
    b mult_loop_k

end_mult_loop_k:
    // Guardar resultado
    mov x23, #12         // 3 * 4
    mul x24, x19, x23    // i * (3 * 4)
    mov x25, #4
    mul x27, x21, x25    // j * 4
    add x24, x24, x27    // offset total

    adrp x20, result
    add x20, x20, :lo12:result
    str w26, [x20, x24]  // guardar sum en result[i][j]

    add x21, x21, #1     // j++
    b mult_loop_j

end_mult_loop_j:
    add x19, x19, #1     // i++
    b mult_loop_i

end_mult_loop_i:
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

```
