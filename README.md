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

Programa 15 de 50 Busqueda Binaria.
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

## Descripción

Programa 21 de 50 Transposicion de una Matriz.
Video de Prueba
https://asciinema.org/a/689325

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 12/11/2024
// Descripción: Programa completo de transposición de matriz

/*
using System;

class MatrixTranspose
{
    static void Main()
    {
        // Definimos la matriz original
        long[,] matriz = {
            { 1, 2, 3 },
            { 4, 5, 6 },
            { 7, 8, 9 }
        };

        int filas = 3;
        int columnas = 3;
        long[,] transpuesta = new long[filas, columnas];

        Console.WriteLine("Matriz Original:");
        ImprimirMatriz(matriz, filas, columnas);

        // Transponer la matriz
        TransponerMatriz(matriz, transpuesta, filas, columnas);

        Console.WriteLine("\nMatriz Transpuesta:");
        ImprimirMatriz(transpuesta, filas, columnas);
    }

    // Función para transponer una matriz
    static void TransponerMatriz(long[,] matriz, long[,] transpuesta, int filas, int columnas)
    {
        for (int i = 0; i < filas; i++)
        {
            for (int j = 0; j < columnas; j++)
            {
                transpuesta[j, i] = matriz[i, j];
            }
        }
    }

    // Función para imprimir una matriz
    static void ImprimirMatriz(long[,] matriz, int filas, int columnas)
    {
        for (int i = 0; i < filas; i++)
        {
            for (int j = 0; j < columnas; j++)
            {
                Console.Write($"{matriz[i, j],4} ");
            }
            Console.WriteLine();
        }
    }
}
*/

//Ensamblador
 .arch armv8-a              // Especifica la arquitectura ARMv8-A

    .data
    // Matriz original 3x3
matriz:     .quad   1, 2, 3
           .quad   4, 5, 6
           .quad   7, 8, 9
    
    // Matriz transpuesta 3x3
transpuesta: .zero   72          // 9 elementos * 8 bytes = 72 bytes
    
    // Dimensiones de la matriz
filas:      .quad   3
columnas:   .quad   3
    
    // Mensajes para imprimir
msg_original:   .string "\nMatriz Original:\n"
msg_trans:      .string "\nMatriz Transpuesta:\n"
msg_elemento:   .string "%3ld "  // Formato para long int en Linux
msg_newline:    .string "\n"

    .text
    .global main
    .type main, %function
    .align 2
main:
    // Prólogo
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    
    // Mostrar matriz original
    adr     x0, msg_original
    bl      printf
    adr     x0, matriz
    bl      imprimir_matriz
    
    // Transponer matriz
    bl      transponer_matriz
    
    // Mostrar matriz transpuesta
    adr     x0, msg_trans
    bl      printf
    adr     x0, transpuesta
    bl      imprimir_matriz
    
    // Epílogo y retorno
    ldp     x29, x30, [sp], 16
    mov     w0, 0
    ret

// Función para transponer matriz
transponer_matriz:
    stp     x29, x30, [sp, -64]!
    mov     x29, sp
    // Inicializar contadores
    mov     x19, #0              // i = 0
    adr     x20, filas
    ldr     x20, [x20]          // Cargar número de filas
    adr     x21, columnas
    ldr     x21, [x21]          // Cargar número de columnas

bucle_i:
    cmp     x19, x20            // Comparar i con filas
    b.ge    fin_transposicion
    mov     x22, #0             // j = 0

bucle_j:
    cmp     x22, x21            // Comparar j con columnas
    b.ge    siguiente_i
    
    // Calcular índice matriz original [i][j]
    mul     x23, x19, x21       // i * columnas
    add     x23, x23, x22       // + j
    lsl     x23, x23, #3        // * 8 (tamaño de quad)
    
    // Calcular índice matriz transpuesta [j][i]
    mul     x24, x22, x20       // j * filas
    add     x24, x24, x19       // + i
    lsl     x24, x24, #3        // * 8
    
    // Cargar elemento de matriz original
    adr     x25, matriz
    ldr     x26, [x25, x23]
    
    // Guardar en matriz transpuesta
    adr     x27, transpuesta
    str     x26, [x27, x24]
    
    add     x22, x22, #1        // j++
    b       bucle_j

siguiente_i:
    add     x19, x19, #1        // i++
    b       bucle_i

fin_transposicion:
    ldp     x29, x30, [sp], 64
    ret

// Función para imprimir matriz
imprimir_matriz:
    stp     x29, x30, [sp, -48]!
    mov     x29, sp
    str     x0, [sp, 16]        // Guardar dirección de la matriz
    mov     x19, #0             // i = 0
    adr     x20, filas
    ldr     x20, [x20]          // Cargar número de filas
    adr     x21, columnas
    ldr     x21, [x21]          // Cargar número de columnas

bucle_imprimir_ext:
    cmp     x19, x20
    b.ge    fin_imprimir
    mov     x22, #0             // j = 0

bucle_imprimir_int:
    cmp     x22, x21
    b.ge    nueva_linea
    // Calcular offset
    mul     x23, x19, x21
    add     x23, x23, x22
    lsl     x23, x23, #3
    // Imprimir elemento
    adr     x0, msg_elemento
    ldr     x24, [sp, 16]
    ldr     x1, [x24, x23]
    bl      printf
    add     x22, x22, #1
    b       bucle_imprimir_int

nueva_linea:
    adr     x0, msg_newline
    bl      printf
    add     x19, x19, #1
    b       bucle_imprimir_ext

fin_imprimir:
    ldp     x29, x30, [sp], 48
    ret

```

## Descripción

Programa 22 de 50 Conversion de ASCII a entero.
Video de Prueba 
https://asciinema.org/a/689331


## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 12/11/2024
// Descripción: Programa que convierte ASCII a Entero correspondiente.

/*using System;

class Program
{
    static void Main()
    {
        // Mensajes
        string msgIngreso = "Ingrese la letra que quiere convertir a entero: ";
        string msgResultado = "El valor entero es: {0}\n";

        // Mostrar mensaje de ingreso
        Console.Write(msgIngreso);

        // Leer carácter y convertir a número entero
        char inputChar = Console.ReadKey().KeyChar;
        Console.WriteLine(); // Salto de línea para el resultado

        // Convertir ASCII a entero
        int valorEntero = inputChar - '0';

        // Mostrar resultado
        Console.WriteLine(msgResultado, valorEntero);
    }
}
*/



  .data
msg_ingreso:    .string "Ingrese la letra a convertir a entero: "
msg_resultado:  .string "El valor entero es: %d\n"
formato_char:   .string " %c"    // Espacio antes de %c para ignorar whitespace
buffer:         .skip 2          // Buffer para almacenar el carácter

    .text
    .global main
    .align 2

main:
    // Prólogo
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

    // Mostrar mensaje de ingreso
    adr     x0, msg_ingreso
    bl      printf

    // Leer carácter
    adr     x0, formato_char
    adr     x1, buffer
    bl      scanf

    // Convertir ASCII a entero
    adr     x0, buffer
    ldrb    w0, [x0]            // Cargar el carácter
    sub     w0, w0, #48         // Restar 48 (ASCII '0') para obtener el valor

    // Mostrar resultado
    mov     w1, w0              // Mover resultado a w1 para printf
    adr     x0, msg_resultado
    bl      printf

    // Epílogo y retorno
    mov     w0, #0
    ldp     x29, x30, [sp], 16
    ret

```

## Descripción

Programa 23 de 50 Conversion de entero a ASCII.
Video de Prueba
https://asciinema.org/a/689329

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 12/11/2024
// Descripción: Programa que convierte entero a ASCII correspondiente

/*using System;

class Program
{
    static void Main()
    {
        // Mensajes
        string msgIngreso = "Ingrese un número entero (0-9): ";
        string msgResultado = "El carácter ASCII es: {0}\n";

        // Mostrar mensaje de ingreso
        Console.Write(msgIngreso);

        // Leer número entero ingresado por el usuario
        if (int.TryParse(Console.ReadLine(), out int numero) && numero >= 0 && numero <= 9)
        {
            // Convertir entero a carácter ASCII
            char caracterASCII = (char)(numero + '0');

            // Mostrar resultado
            Console.WriteLine(msgResultado, caracterASCII);
        }
        else
        {
            Console.WriteLine("Entrada no válida. Por favor, ingrese un número entre 0 y 9.");
        }
    }
}
*/



    
    .data
msg_ingreso:    .string "Ingrese un número entero (0-9): "
msg_resultado:  .string "El carácter ASCII es: %c\n"
formato_int:    .string "%d"     // Formato para leer entero
numero:         .word 0          // Variable para almacenar el número

    .text
    .global main
    .align 2

main:
    // Prólogo
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

    // Mostrar mensaje de ingreso
    adr     x0, msg_ingreso
    bl      printf

    // Leer número entero
    adr     x0, formato_int
    adr     x1, numero
    bl      scanf

    // Convertir entero a ASCII
    adr     x0, numero
    ldr     w0, [x0]            // Cargar el número
    add     w1, w0, #48         // Sumar 48 (ASCII '0') para obtener el carácter

    // Mostrar resultado
    adr     x0, msg_resultado
    bl      printf

    // Epílogo y retorno
    mov     w0, #0
    ldp     x29, x30, [sp], 16
    ret

```

## Descripción

Programa 24 de 50 Calcular la longitud de una cadena.
Video de Prueba
https://asciinema.org/a/689332

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 12/11/2024
// Descripción: Programa que calcula la Logitud de una Cadena.

/*
using System;

class Program
{
    static void Main()
    {
        // Mensajes
        string msgIngreso = "Ingrese una cadena: ";
        string msgResultado = "La longitud de la cadena es: {0}\n";

        // Mostrar mensaje de ingreso
        Console.Write(msgIngreso);

        // Leer cadena ingresada por el usuario
        string input = Console.ReadLine();

        // Calcular longitud de la cadena
        int longitud = input.Length;

        // Mostrar resultado
        Console.WriteLine(msgResultado, longitud);
    }
}
*/

//Ensamblador ARM64bits
 .data
msg_ingreso:    .string "Ingrese una cadena: "
msg_resultado:  .string "La longitud de la cadena es: %d\n"
buffer:         .skip 100        // Buffer para almacenar la cadena
formato_str:    .string "%[^\n]" // Leer hasta encontrar newline

    .text
    .global main
    .align 2

main:
    // Prólogo
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

    // Mostrar mensaje de ingreso
    adr     x0, msg_ingreso
    bl      printf

    // Leer cadena
    adr     x0, formato_str
    adr     x1, buffer
    bl      scanf

    // Calcular longitud
    adr     x0, buffer
    mov     x1, #0              // Contador de caracteres

contar_loop:
    ldrb    w2, [x0, x1]       // Cargar carácter
    cbz     w2, fin_conteo      // Si es 0, fin de cadena
    add     x1, x1, #1         // Incrementar contador
    b       contar_loop

fin_conteo:
    // Mostrar resultado
    adr     x0, msg_resultado
    bl      printf

    // Epílogo y retorno
    mov     w0, #0
    ldp     x29, x30, [sp], 16
    ret

```

## Descripción

Programa 25 de 50 Contar vocales y consonantes.
Video de Prueba
https://asciinema.org/a/689333

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 12/11/2024
// Descripción: Programa que cuenta las vocales y consonantes.

/*using System;

class Program
{
    static void Main()
    {
        // Mensajes
        string msgIngreso = "Ingrese una cadena: ";
        string msgVocales = "Número de vocales: {0}\n";
        string msgConsonantes = "Número de consonantes: {0}\n";
        
        // Definir vocales
        string vocales = "aeiouAEIOU";

        // Mostrar mensaje de ingreso
        Console.Write(msgIngreso);

        // Leer la cadena del usuario
        string input = Console.ReadLine();

        // Contadores
        int vocalesCount = 0;
        int consonantesCount = 0;

        // Procesar la cadena
        foreach (char c in input)
        {
            // Verificar si el carácter es una letra
            if (Char.IsLetter(c))
            {
                // Verificar si es una vocal
                if (vocales.Contains(c))
                {
                    vocalesCount++;
                }
                else
                {
                    consonantesCount++;
                }
            }
        }

        // Mostrar resultados
        Console.WriteLine(msgVocales, vocalesCount);
        Console.WriteLine(msgConsonantes, consonantesCount);
    }
}
*/

 .data
msg_ingreso:    .string "Ingrese una cadena: "
msg_vocales:    .string "Número de vocales: %d\n"
msg_consonantes: .string "Número de consonantes: %d\n"
buffer:         .skip 100        // Buffer para almacenar la cadena
formato_str:    .string "%[^\n]" // Leer hasta encontrar newline
vocales:        .ascii "aeiouAEIOU"

    .text
    .global main
    .align 2

main:
    // Prólogo
    stp     x29, x30, [sp, -32]!
    mov     x29, sp
    
    // Guardar contadores en el stack
    str     xzr, [sp, 16]       // Contador vocales
    str     xzr, [sp, 24]       // Contador consonantes

    // Mostrar mensaje de ingreso
    adr     x0, msg_ingreso
    bl      printf

    // Leer cadena
    adr     x0, formato_str
    adr     x1, buffer
    bl      scanf

    // Iniciar procesamiento de la cadena
    adr     x0, buffer          // x0 = dirección de la cadena
    mov     x1, #0              // x1 = índice en la cadena

procesar_char:
    ldrb    w2, [x0, x1]       // Cargar carácter
    cbz     w2, fin_conteo      // Si es 0, fin de cadena

    // Verificar si es letra
    cmp     w2, #'A'
    b.lt    siguiente_char
    cmp     w2, #'z'
    b.gt    siguiente_char
    cmp     w2, #'Z'
    b.le    es_letra
    cmp     w2, #'a'
    b.ge    es_letra
    b       siguiente_char

es_letra:
    // Verificar si es vocal
    adr     x3, vocales         // x3 = dirección de vocales
    mov     x4, #0              // x4 = índice en vocales

check_vocal:
    ldrb    w5, [x3, x4]       // Cargar vocal
    cbz     w5, es_consonante   // Si llegamos al final, es consonante
    cmp     w2, w5             // Comparar con vocal actual
    b.eq    es_vocal
    add     x4, x4, #1
    b       check_vocal

es_vocal:
    ldr     x4, [sp, 16]       // Cargar contador de vocales
    add     x4, x4, #1         // Incrementar
    str     x4, [sp, 16]       // Guardar nuevo valor
    b       siguiente_char

es_consonante:
    ldr     x4, [sp, 24]       // Cargar contador de consonantes
    add     x4, x4, #1         // Incrementar
    str     x4, [sp, 24]       // Guardar nuevo valor

siguiente_char:
    add     x1, x1, #1         // Siguiente carácter
    b       procesar_char

fin_conteo:
    // Mostrar resultados
    adr     x0, msg_vocales
    ldr     x1, [sp, 16]
    bl      printf

    adr     x0, msg_consonantes
    ldr     x1, [sp, 24]
    bl      printf

    // Epílogo y retorno
    mov     w0, #0
    ldp     x29, x30, [sp], 32
    ret
```

## Descripción

Programa 26 de 50 Operaciones AND, OR, XOR a nivel de bits.
Video de Prueba
https://asciinema.org/a/689342

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 12/11/2024
// Descripción:  Programa que realiza operaciones AND, OR, XOR.

/*using System;

class Program
{
    static void Main()
    {
        int opcion, numero1, numero2, resultado;

        // Menú de operaciones
        while (true)
        {
            Console.WriteLine("\nOperaciones a nivel de bits");
            Console.WriteLine("1. AND");
            Console.WriteLine("2. OR");
            Console.WriteLine("3. XOR");
            Console.WriteLine("4. Salir");
            Console.Write("Seleccione una opción: ");

            // Leer opción
            opcion = int.Parse(Console.ReadLine());

            // Verificar si se quiere salir
            if (opcion == 4)
                break;

            // Leer primer número
            Console.Write("Ingrese el primer número: ");
            numero1 = int.Parse(Console.ReadLine());

            // Leer segundo número
            Console.Write("Ingrese el segundo número: ");
            numero2 = int.Parse(Console.ReadLine());

            // Realizar operación según la opción seleccionada
            switch (opcion)
            {
                case 1: // AND
                    resultado = numero1 & numero2;
                    break;
                case 2: // OR
                    resultado = numero1 | numero2;
                    break;
                case 3: // XOR
                    resultado = numero1 ^ numero2;
                    break;
                default:
                    continue;
            }

            // Mostrar resultado en decimal
            Console.WriteLine("Resultado: " + resultado);

            // Mostrar resultado en binario
            Console.Write("En binario: ");
            MostrarEnBinario(resultado);
        }
    }

    static void MostrarEnBinario(int numero)
    {
        for (int i = 31; i >= 0; i--)
        {
            int bit = (numero >> i) & 1; // Obtener el bit correspondiente
            Console.Write(bit);
        }
        Console.WriteLine();
    }
}
*/

//Ensamblador ARM64bits

 .data
msg_menu:       .string "\nOperaciones a nivel de bits\n"
                .string "1. AND\n"
                .string "2. OR\n"
                .string "3. XOR\n"
                .string "4. Salir\n"
                .string "Seleccione una opción: "

msg_num1:       .string "Ingrese el primer número: "
msg_num2:       .string "Ingrese el segundo número: "
msg_resultado:  .string "Resultado: %d\n"
msg_binario:    .string "En binario: "
msg_bit:        .string "%d"
msg_newline:    .string "\n"
formato_int:    .string "%d"

opcion:         .word 0
numero1:        .word 0
numero2:        .word 0

    .text
    .global main
    .align 2

main:
    // Prólogo
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

menu_loop:
    // Mostrar menú
    adr     x0, msg_menu
    bl      printf

    // Leer opción
    adr     x0, formato_int
    adr     x1, opcion
    bl      scanf

    // Verificar si es opción de salida
    adr     x0, opcion
    ldr     w0, [x0]
    cmp     w0, #4
    b.eq    fin_programa

    // Leer primer número
    adr     x0, msg_num1
    bl      printf
    adr     x0, formato_int
    adr     x1, numero1
    bl      scanf

    // Leer segundo número
    adr     x0, msg_num2
    bl      printf
    adr     x0, formato_int
    adr     x1, numero2
    bl      scanf

    // Cargar números en registros
    adr     x0, numero1
    ldr     w1, [x0]
    adr     x0, numero2
    ldr     w2, [x0]

    // Verificar operación seleccionada
    adr     x0, opcion
    ldr     w0, [x0]

    cmp     w0, #1
    b.eq    hacer_and
    cmp     w0, #2
    b.eq    hacer_or
    cmp     w0, #3
    b.eq    hacer_xor
    b       menu_loop

hacer_and:
    and     w1, w1, w2
    b       mostrar_resultado

hacer_or:
    orr     w1, w1, w2
    b       mostrar_resultado

hacer_xor:
    eor     w1, w1, w2

mostrar_resultado:
    // Guardar resultado para mostrar
    mov     w19, w1             // Guardar resultado para mostrar en binario después

    // Mostrar resultado en decimal
    adr     x0, msg_resultado
    bl      printf

    // Mostrar resultado en binario
    adr     x0, msg_binario
    bl      printf

    mov     w20, #32            // Contador de bits
mostrar_bits:
    sub     w20, w20, #1        // Decrementar contador
    lsr     w21, w19, w20       // Desplazar a la derecha
    and     w1, w21, #1         // Obtener bit menos significativo
    
    // Imprimir bit
    adr     x0, msg_bit
    bl      printf

    cmp     w20, #0
    b.ne    mostrar_bits

    // Nueva línea
    adr     x0, msg_newline
    bl      printf

    b       menu_loop

fin_programa:
    // Epílogo y retorno
    mov     w0, #0
    ldp     x29, x30, [sp], 16
    ret

```

## Descripción

Programa 27 de 50 Desplazamiento de Izquierda a Derecha.
Video de Prueba
https://asciinema.org/a/689352

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 12/11/2024
// Descripción: Programa que realiza desplazamientos de izquierda y derecha de numeros.

/*using System;

class Program
{
    static void Main()
    {
        int opcion, numero, posiciones, resultado;

        // Menú de desplazamientos de bits
        while (true)
        {
            Console.WriteLine("\nDesplazamientos de bits");
            Console.WriteLine("1. Desplazamiento a la izquierda (LSL)");
            Console.WriteLine("2. Desplazamiento a la derecha (LSR)");
            Console.WriteLine("3. Salir");
            Console.Write("Seleccione una opción: ");

            // Leer opción
            opcion = int.Parse(Console.ReadLine());

            // Verificar si se quiere salir
            if (opcion == 3)
                break;

            // Leer número
            Console.Write("Ingrese el número: ");
            numero = int.Parse(Console.ReadLine());

            // Leer posiciones
            Console.Write("Ingrese posiciones a desplazar: ");
            posiciones = int.Parse(Console.ReadLine());

            // Realizar desplazamiento según la opción seleccionada
            switch (opcion)
            {
                case 1: // Desplazamiento a la izquierda (LSL)
                    resultado = numero << posiciones;
                    break;
                case 2: // Desplazamiento a la derecha (LSR)
                    resultado = numero >> posiciones;
                    break;
                default:
                    continue;
            }

            // Mostrar resultado en decimal
            Console.WriteLine("Resultado: " + resultado);

            // Mostrar resultado en binario
            Console.Write("En binario: ");
            MostrarEnBinario(resultado);
        }
    }

    static void MostrarEnBinario(int numero)
    {
        for (int i = 31; i >= 0; i--)
        {
            int bit = (numero >> i) & 1; // Obtener el bit correspondiente
            Console.Write(bit);
        }
        Console.WriteLine();
    }
}
*/


.data
msg_menu:       .string "\nDesplazamientos de bits\n"
                .string "1. Desplazamiento a la izquierda (LSL)\n"
                .string "2. Desplazamiento a la derecha (LSR)\n"
                .string "3. Salir\n"
                .string "Seleccione una opción: "

msg_num:        .string "Ingrese el número: "
msg_pos:        .string "Ingrese posiciones a desplazar: "
msg_resultado:  .string "Resultado: %d\n"
msg_binario:    .string "En binario: "
msg_bit:        .string "%d"
msg_newline:    .string "\n"
formato_int:    .string "%d"

opcion:         .word 0
numero:         .word 0
posiciones:     .word 0

    .text
    .global main
    .align 2

main:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

menu_loop:
    // Mostrar menú
    adr     x0, msg_menu
    bl      printf

    // Leer opción
    adr     x0, formato_int
    adr     x1, opcion
    bl      scanf

    // Verificar salida
    adr     x0, opcion
    ldr     w0, [x0]
    cmp     w0, #3
    b.eq    fin_programa

    // Leer número
    adr     x0, msg_num
    bl      printf
    adr     x0, formato_int
    adr     x1, numero
    bl      scanf

    // Leer posiciones
    adr     x0, msg_pos
    bl      printf
    adr     x0, formato_int
    adr     x1, posiciones
    bl      scanf

    // Cargar valores
    adr     x0, numero
    ldr     w1, [x0]
    adr     x0, posiciones
    ldr     w2, [x0]
    adr     x0, opcion
    ldr     w0, [x0]

    // Seleccionar operación
    cmp     w0, #1
    b.eq    shift_left
    cmp     w0, #2
    b.eq    shift_right
    b       menu_loop

shift_left:
    lsl     w1, w1, w2
    b       mostrar_resultado

shift_right:
    lsr     w1, w1, w2

mostrar_resultado:
    // Guardar resultado
    mov     w19, w1

    // Mostrar en decimal
    adr     x0, msg_resultado
    bl      printf

    // Mostrar en binario
    adr     x0, msg_binario
    bl      printf

    mov     w20, #32
mostrar_bits:
    sub     w20, w20, #1
    lsr     w21, w19, w20
    and     w1, w21, #1
    adr     x0, msg_bit
    bl      printf

    cmp     w20, #0
    b.ne    mostrar_bits

    adr     x0, msg_newline
    bl      printf

    b       menu_loop

fin_programa:
    mov     w0, #0
    ldp     x29, x30, [sp], 16
    ret

```

## Descripción

Programa 28 de 50 Establecer, borrar y alternar bits
Video de Prueba
https://asciinema.org/a/689354

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 12/11/2024
// Descripción: Establecer, borrar y alternar bits.

/*using System;

class Program
{
    static void Main()
    {
        int opcion, numero, posicion, resultado;

        // Menú de manipulación de bits
        while (true)
        {
            Console.WriteLine("\nManipulación de bits");
            Console.WriteLine("1. Establecer bit (SET)");
            Console.WriteLine("2. Borrar bit (CLEAR)");
            Console.WriteLine("3. Alternar bit (TOGGLE)");
            Console.WriteLine("4. Salir");
            Console.Write("Seleccione una opción: ");

            // Leer opción
            opcion = int.Parse(Console.ReadLine());

            // Verificar si se quiere salir
            if (opcion == 4)
                break;

            // Leer número
            Console.Write("Ingrese el número: ");
            numero = int.Parse(Console.ReadLine());

            // Leer posición del bit
            Console.Write("Ingrese la posición del bit (0-31): ");
            posicion = int.Parse(Console.ReadLine());

            // Realizar la operación según la opción seleccionada
            switch (opcion)
            {
                case 1: // Establecer bit (SET)
                    resultado = EstablecerBit(numero, posicion);
                    break;
                case 2: // Borrar bit (CLEAR)
                    resultado = BorrarBit(numero, posicion);
                    break;
                case 3: // Alternar bit (TOGGLE)
                    resultado = AlternarBit(numero, posicion);
                    break;
                default:
                    continue;
            }

            // Mostrar resultado en decimal
            Console.WriteLine("Resultado: " + resultado);

            // Mostrar resultado en binario
            Console.Write("En binario: ");
            MostrarEnBinario(resultado);
        }
    }

    static int EstablecerBit(int numero, int posicion)
    {
        return numero | (1 << posicion); // Establecer el bit en la posición dada
    }

    static int BorrarBit(int numero, int posicion)
    {
        return numero & ~(1 << posicion); // Borrar el bit en la posición dada
    }

    static int AlternarBit(int numero, int posicion)
    {
        return numero ^ (1 << posicion); // Alternar el bit en la posición dada
    }

    static void MostrarEnBinario(int numero)
    {
        for (int i = 31; i >= 0; i--)
        {
            int bit = (numero >> i) & 1; // Obtener el bit correspondiente
            Console.Write(bit);
        }
        Console.WriteLine();
    }
}
*/

//Ensamblador ARM64bits

  .data
msg_menu:       .string "\nManipulación de bits\n"
                .string "1. Establecer bit (SET)\n"
                .string "2. Borrar bit (CLEAR)\n"
                .string "3. Alternar bit (TOGGLE)\n"
                .string "4. Salir\n"
                .string "Seleccione una opción: "

msg_num:        .string "Ingrese el número: "
msg_pos:        .string "Ingrese la posición del bit (0-31): "
msg_resultado:  .string "Resultado: %d\n"
msg_binario:    .string "En binario: "
msg_bit:        .string "%d"
msg_newline:    .string "\n"
formato_int:    .string "%d"

opcion:         .word 0
numero:         .word 0
posicion:       .word 0

    .text
    .global main
    .align 2

main:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

menu_loop:
    // Mostrar menú
    adr     x0, msg_menu
    bl      printf

    // Leer opción
    adr     x0, formato_int
    adr     x1, opcion
    bl      scanf

    // Verificar salida
    adr     x0, opcion
    ldr     w0, [x0]
    cmp     w0, #4
    b.eq    fin_programa

    // Leer número
    adr     x0, msg_num
    bl      printf
    adr     x0, formato_int
    adr     x1, numero
    bl      scanf

    // Leer posición
    adr     x0, msg_pos
    bl      printf
    adr     x0, formato_int
    adr     x1, posicion
    bl      scanf

    // Cargar valores
    adr     x0, numero
    ldr     w1, [x0]        // Número original
    adr     x0, posicion
    ldr     w2, [x0]        // Posición
    adr     x0, opcion
    ldr     w0, [x0]        // Opción

    // Seleccionar operación
    cmp     w0, #1
    b.eq    set_bit
    cmp     w0, #2
    b.eq    clear_bit
    cmp     w0, #3
    b.eq    toggle_bit
    b       menu_loop

set_bit:
    mov     w3, #1          // Crear máscara
    lsl     w3, w3, w2      // Desplazar 1 a la posición
    orr     w1, w1, w3      // OR con la máscara
    b       mostrar_resultado

clear_bit:
    mov     w3, #1          // Crear máscara
    lsl     w3, w3, w2      // Desplazar 1 a la posición
    mvn     w3, w3          // Invertir bits
    and     w1, w1, w3      // AND con la máscara
    b       mostrar_resultado

toggle_bit:
    mov     w3, #1          // Crear máscara
    lsl     w3, w3, w2      // Desplazar 1 a la posición
    eor     w1, w1, w3      // XOR con la máscara

mostrar_resultado:
    // Guardar resultado
    mov     w19, w1

    // Mostrar en decimal
    adr     x0, msg_resultado
    bl      printf

    // Mostrar en binario
    adr     x0, msg_binario
    bl      printf

    mov     w20, #32
mostrar_bits:
    sub     w20, w20, #1
    lsr     w21, w19, w20
    and     w1, w21, #1
    adr     x0, msg_bit
    bl      printf

    cmp     w20, #0
    b.ne    mostrar_bits

    adr     x0, msg_newline
    bl      printf

    b       menu_loop

fin_programa:
    mov     w0, #0
    ldp     x29, x30, [sp], 16
    ret

```

## Descripción

Programa 29 de 50 Numero de Bits Activados en un numero.
Video de Prueba
https://asciinema.org/a/689356

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 12/11/2024
// Descripción: Programa que cuenta el numero de bits activados en un numero.

/*using System;

class Program
{
    static void Main()
    {
        int numero;

        // Solicitar número
        Console.Write("Ingrese un número: ");
        numero = int.Parse(Console.ReadLine());

        // Contar bits activados (1)
        int contador = ContarBitsActivados(numero);

        // Mostrar resultado
        Console.WriteLine($"Número de bits activados: {contador}");

        // Mostrar representación binaria
        Console.Write("Representación binaria: ");
        MostrarEnBinario(numero);
    }

    static int ContarBitsActivados(int numero)
    {
        int contador = 0;
        
        while (numero != 0)
        {
            // Obtener el bit menos significativo
            contador += numero & 1;
            // Desplazar el número a la derecha
            numero >>= 1;
        }

        return contador;
    }

    static void MostrarEnBinario(int numero)
    {
        // Mostrar cada bit en la representación binaria de 32 bits
        for (int i = 31; i >= 0; i--)
        {
            int bit = (numero >> i) & 1; // Obtener el bit correspondiente
            Console.Write(bit);
        }
        Console.WriteLine();
    }
}
*/

//Ensamblador ARM64bits

 .data
msg_ingreso:    .string "Ingrese un número: "
msg_resultado:  .string "Número de bits activados: %d\n"
msg_binario:    .string "Representación binaria: "
msg_bit:        .string "%d"
msg_newline:    .string "\n"
formato_int:    .string "%d"

numero:         .word 0

    .text
    .global main
    .align 2

main:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

    // Solicitar número
    adr     x0, msg_ingreso
    bl      printf

    // Leer número
    adr     x0, formato_int
    adr     x1, numero
    bl      scanf

    // Cargar número
    adr     x0, numero
    ldr     w1, [x0]
    mov     w19, w1          // Guardar copia para mostrar binario

    // Contador de bits
    mov     w2, #0          // Inicializar contador

contar_loop:
    cbz     w1, fin_conteo  // Si el número es 0, terminar
    and     w3, w1, #1      // Obtener bit menos significativo
    add     w2, w2, w3      // Sumar al contador si es 1
    lsr     w1, w1, #1      // Desplazar a la derecha
    b       contar_loop

fin_conteo:
    // Mostrar resultado
    mov     w1, w2
    adr     x0, msg_resultado
    bl      printf

    // Mostrar representación binaria
    adr     x0, msg_binario
    bl      printf

    mov     w20, #32
mostrar_bits:
    sub     w20, w20, #1
    lsr     w21, w19, w20
    and     w1, w21, #1
    adr     x0, msg_bit
    bl      printf

    cmp     w20, #0
    b.ne    mostrar_bits

    adr     x0, msg_newline
    bl      printf

    // Retorno
    mov     w0, #0
    ldp     x29, x30, [sp], 16
    ret
```

## Descripción

Programa 30 de 50 Programa que calcula el MCD.
Video de Prueba
https://asciinema.org/a/689359

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 12/11/2024
// Descripción: Programa que calcula el MCD y MCM.

/*using System;

class Program
{
    static void Main()
    {
        int opcion, numero1, numero2;

        do
        {
            // Mostrar menú
            Console.WriteLine("\nCálculo de MCD y MCM");
            Console.WriteLine("1. Calcular MCD");
            Console.WriteLine("2. Calcular MCM");
            Console.WriteLine("3. Salir");
            Console.Write("Seleccione una opción: ");
            opcion = int.Parse(Console.ReadLine());

            // Verificar opción
            if (opcion == 3)
            {
                break;  // Salir del programa
            }

            // Leer los dos números
            Console.Write("Ingrese el primer número: ");
            numero1 = int.Parse(Console.ReadLine());

            Console.Write("Ingrese el segundo número: ");
            numero2 = int.Parse(Console.ReadLine());

            if (opcion == 1)
            {
                // Calcular y mostrar el MCD
                int mcd = CalcularMCD(numero1, numero2);
                Console.WriteLine($"El MCD es: {mcd}");
            }
            else if (opcion == 2)
            {
                // Calcular y mostrar el MCM
                int mcm = CalcularMCM(numero1, numero2);
                Console.WriteLine($"El MCM es: {mcm}");
            }
        }
        while (opcion != 3);
    }

    // Función para calcular el MCD utilizando el algoritmo de Euclides
    static int CalcularMCD(int a, int b)
    {
        while (b != 0)
        {
            int residuo = a % b;
            a = b;
            b = residuo;
        }
        return a;
    }

    // Función para calcular el MCM usando la fórmula MCM = (a * b) / MCD
    static int CalcularMCM(int a, int b)
    {
        int mcd = CalcularMCD(a, b);
        return (a * b) / mcd;
    }
}
*/

 .data
msg_menu:       .string "\nCálculo de MCD y MCM\n"
                .string "1. Calcular MCD\n"
                .string "2. Calcular MCM\n"
                .string "3. Salir\n"
                .string "Seleccione una opción: "

msg_num1:       .string "Ingrese el primer número: "
msg_num2:       .string "Ingrese el segundo número: "
msg_mcd:        .string "El MCD es: %d\n"
msg_mcm:        .string "El MCM es: %d\n"
formato_int:    .string "%d"

opcion:         .word 0
numero1:        .word 0
numero2:        .word 0

    .text
    .global main
    .align 2

// Función principal
main:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

menu_loop:
    // Mostrar menú
    adr     x0, msg_menu
    bl      printf

    // Leer opción
    adr     x0, formato_int
    adr     x1, opcion
    bl      scanf

    // Verificar salida
    adr     x0, opcion
    ldr     w0, [x0]
    cmp     w0, #3
    b.eq    fin_programa

    // Leer números
    adr     x0, msg_num1
    bl      printf
    adr     x0, formato_int
    adr     x1, numero1
    bl      scanf

    adr     x0, msg_num2
    bl      printf
    adr     x0, formato_int
    adr     x1, numero2
    bl      scanf

    // Cargar números en registros
    adr     x0, numero1
    ldr     w19, [x0]        // Primer número en w19
    adr     x0, numero2
    ldr     w20, [x0]        // Segundo número en w20

    // Verificar opción
    adr     x0, opcion
    ldr     w0, [x0]
    cmp     w0, #1
    b.eq    calcular_mcd
    cmp     w0, #2
    b.eq    calcular_mcm
    b       menu_loop

calcular_mcd:
    // Preservar valores originales para MCM
    mov     w21, w19         // Guardar primer número
    mov     w22, w20         // Guardar segundo número

mcd_loop:
    // Algoritmo de Euclides
    cmp     w20, #0
    b.eq    mostrar_mcd
    
    // Calcular residuo
    sdiv    w23, w19, w20    // División
    msub    w23, w23, w20, w19  // Residuo = Dividendo - (Cociente * Divisor)
    
    // Actualizar valores
    mov     w19, w20         // a = b
    mov     w20, w23         // b = residuo
    b       mcd_loop

mostrar_mcd:
    mov     w1, w19          // MCD está en w19
    adr     x0, msg_mcd
    bl      printf
    b       menu_loop

calcular_mcm:
    // Primero calculamos el MCD
    mov     w21, w19         // Guardar primer número
    mov     w22, w20         // Guardar segundo número

mcm_mcd_loop:
    cmp     w20, #0
    b.eq    calcular_mcm_final
    
    sdiv    w23, w19, w20
    msub    w23, w23, w20, w19
    
    mov     w19, w20
    mov     w20, w23
    b       mcm_mcd_loop

calcular_mcm_final:
    // MCM = (a * b) / MCD
    mul     w20, w21, w22    // a * b
    sdiv    w20, w20, w19    // Dividir por MCD

mostrar_mcm:
    mov     w1, w20
    adr     x0, msg_mcm
    bl      printf
    b       menu_loop

fin_programa:
    mov     w0, #0
    ldp     x29, x30, [sp], 16
    ret
```

## Descripción

Programa 31 de 50 Mínimo Común Múltiplo (MCM).
Video de Prueba
https://asciinema.org/a/690840

## Código Completo
```c

// Autor: Pozos Flores Norberto
// Fecha: 19/11/2024
// Descripción: Programa que calcula el MCM.

/*using System;

class Program
{
    static void Main()
    {
        int opcion, numero1, numero2;

        do
        {
            // Mostrar menú
            Console.WriteLine("\nCálculo de MCD y MCM");
            Console.WriteLine("1. Calcular MCD");
            Console.WriteLine("2. Calcular MCM");
            Console.WriteLine("3. Salir");
            Console.Write("Seleccione una opción: ");
            opcion = int.Parse(Console.ReadLine());

            // Verificar opción
            if (opcion == 3)
            {
                break;  // Salir del programa
            }

            // Leer los dos números
            Console.Write("Ingrese el primer número: ");
            numero1 = int.Parse(Console.ReadLine());

            Console.Write("Ingrese el segundo número: ");
            numero2 = int.Parse(Console.ReadLine());

            if (opcion == 1)
            {
                // Calcular y mostrar el MCD
                int mcd = CalcularMCD(numero1, numero2);
                Console.WriteLine($"El MCD es: {mcd}");
            }
            else if (opcion == 2)
            {
                // Calcular y mostrar el MCM
                int mcm = CalcularMCM(numero1, numero2);
                Console.WriteLine($"El MCM es: {mcm}");
            }
        }
        while (opcion != 3);
    }

    // Función para calcular el MCD utilizando el algoritmo de Euclides
    static int CalcularMCD(int a, int b)
    {
        while (b != 0)
        {
            int residuo = a % b;
            a = b;
            b = residuo;
        }
        return a;
    }

    // Función para calcular el MCM usando la fórmula MCM = (a * b) / MCD
    static int CalcularMCM(int a, int b)
    {
        int mcd = CalcularMCD(a, b);
        return (a * b) / mcd;
    }
}
*/

 .data
msg_menu:       .string "\nCálculo de MCD y MCM\n"
                .string "1. Calcular MCD\n"
                .string "2. Calcular MCM\n"
                .string "3. Salir\n"
                .string "Seleccione una opción: "

msg_num1:       .string "Ingrese el primer número: "
msg_num2:       .string "Ingrese el segundo número: "
msg_mcd:        .string "El MCD es: %d\n"
msg_mcm:        .string "El MCM es: %d\n"
formato_int:    .string "%d"

opcion:         .word 0
numero1:        .word 0
numero2:        .word 0

    .text
    .global main
    .align 2

// Función principal
main:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

menu_loop:
    // Mostrar menú
    adr     x0, msg_menu
    bl      printf

    // Leer opción
    adr     x0, formato_int
    adr     x1, opcion
    bl      scanf

    // Verificar salida
    adr     x0, opcion
    ldr     w0, [x0]
    cmp     w0, #3
    b.eq    fin_programa

    // Leer números
    adr     x0, msg_num1
    bl      printf
    adr     x0, formato_int
    adr     x1, numero1
    bl      scanf

    adr     x0, msg_num2
    bl      printf
    adr     x0, formato_int
    adr     x1, numero2
    bl      scanf

    // Cargar números en registros
    adr     x0, numero1
    ldr     w19, [x0]        // Primer número en w19
    adr     x0, numero2
    ldr     w20, [x0]        // Segundo número en w20

    // Verificar opción
    adr     x0, opcion
    ldr     w0, [x0]
    cmp     w0, #1
    b.eq    calcular_mcd
    cmp     w0, #2
    b.eq    calcular_mcm
    b       menu_loop

calcular_mcd:
    // Preservar valores originales para MCM
    mov     w21, w19         // Guardar primer número
    mov     w22, w20         // Guardar segundo número

mcd_loop:
    // Algoritmo de Euclides
    cmp     w20, #0
    b.eq    mostrar_mcd
    
    // Calcular residuo
    sdiv    w23, w19, w20    // División
    msub    w23, w23, w20, w19  // Residuo = Dividendo - (Cociente * Divisor)
    
    // Actualizar valores
    mov     w19, w20         // a = b
    mov     w20, w23         // b = residuo
    b       mcd_loop

mostrar_mcd:
    mov     w1, w19          // MCD está en w19
    adr     x0, msg_mcd
    bl      printf
    b       menu_loop

calcular_mcm:
    // Primero calculamos el MCD
    mov     w21, w19         // Guardar primer número
    mov     w22, w20         // Guardar segundo número

mcm_mcd_loop:
    cmp     w20, #0
    b.eq    calcular_mcm_final
    
    sdiv    w23, w19, w20
    msub    w23, w23, w20, w19
    
    mov     w19, w20
    mov     w20, w23
    b       mcm_mcd_loop

calcular_mcm_final:
    // MCM = (a * b) / MCD
    mul     w20, w21, w22    // a * b
    sdiv    w20, w20, w19    // Dividir por MCD

mostrar_mcm:
    mov     w1, w20
    adr     x0, msg_mcm
    bl      printf
    b       menu_loop

fin_programa:
    mov     w0, #0
    ldp     x29, x30, [sp], 16
    ret

```

## Descripción

Programa 32 de 50 Potencia (x^n).
Video de Prueba
https://asciinema.org/a/690843

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 19/11/2024
// Descripción: Programa que calcula el exponente de un numero.

/*using System;

class Program
{
    static void Main()
    {
        // Solicitar base y exponente
        Console.Write("Ingrese la base (x): ");
        int baseNum = int.Parse(Console.ReadLine());

        Console.Write("Ingrese el exponente (n): ");
        int exponent = int.Parse(Console.ReadLine());

        // Verificar si el exponente es negativo
        if (exponent < 0)
        {
            Console.WriteLine("Error: exponente negativo no soportado");
            return;
        }

        // Caso especial: exponente = 0
        if (exponent == 0)
        {
            Console.WriteLine($"El resultado de {baseNum}^{exponent} es: 1");
            return;
        }

        // Calcular la potencia
        int result = 1;
        for (int i = 1; i <= exponent; i++)
        {
            result *= baseNum;
        }

        // Mostrar el resultado
        Console.WriteLine($"El resultado de {baseNum}^{exponent} es: {result}");
    }
}
*/

.data
msg_base:       .string "Ingrese la base (x): "
msg_exp:        .string "Ingrese el exponente (n): "
msg_resultado:  .string "El resultado de %d^%d es: %d\n"
msg_error:      .string "Error: exponente negativo no soportado\n"
formato_int:    .string "%d"

base:           .word 0
exponente:      .word 0

    .text
    .global main
    .align 2

main:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

    // Solicitar base
    adr     x0, msg_base
    bl      printf

    adr     x0, formato_int
    adr     x1, base
    bl      scanf

    // Solicitar exponente
    adr     x0, msg_exp
    bl      printf

    adr     x0, formato_int
    adr     x1, exponente
    bl      scanf

    // Cargar valores
    adr     x0, base
    ldr     w19, [x0]        // Base en w19
    adr     x0, exponente
    ldr     w20, [x0]        // Exponente en w20

    // Verificar si exponente es negativo
    cmp     w20, #0
    b.lt    error_exp

    // Caso especial: exponente = 0
    cmp     w20, #0
    b.eq    exp_cero

    // Calcular potencia
    mov     w21, w19         // Resultado inicial = base
    mov     w22, #1          // Contador

potencia_loop:
    cmp     w22, w20
    b.eq    mostrar_resultado
    mul     w21, w21, w19
    add     w22, w22, #1
    b       potencia_loop

exp_cero:
    mov     w21, #1
    b       mostrar_resultado

error_exp:
    adr     x0, msg_error
    bl      printf
    b       fin_programa

mostrar_resultado:
    adr     x0, msg_resultado
    mov     w1, w19          // Base
    mov     w2, w20          // Exponente
    mov     w3, w21          // Resultado
    bl      printf

fin_programa:
    mov     w0, #0
    ldp     x29, x30, [sp], 16
    ret


```

## Descripción

Programa 33 de 50 Suma de elementos en un arreglo.
Video de Prueba
https://asciinema.org/a/690847

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 19/11/2024
// Descripción: Programa que realiza la Suma de elementos en un arreglo.

/*using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        List<int> array = new List<int>();
        
        Console.WriteLine("Ingrese los números del arreglo (ingrese 0 para terminar):");
        
        while (true)
        {
            Console.Write("Ingrese un número: ");
            int numero = int.Parse(Console.ReadLine());
            
            if (numero == 0)
                break;
            
            array.Add(numero);
        }
        
        if (array.Count == 0)
        {
            Console.WriteLine("El arreglo está vacío.");
            return;
        }
        
        int suma = 0;
        foreach (int num in array)
        {
            suma += num;
        }
        
        Console.WriteLine($"Resultado de la suma: {suma}");
    }
}
*/

.data
    msg_ingreso: .string "Ingrese los números del arreglo (ingrese 0 para terminar):\n"
    msg_pedir_numero: .string "Ingrese un número: "
    msg_array_vacio: .string "El arreglo está vacío.\n"
    msg_resultado: .string "Resultado de la suma: %d\n"
    formato_int: .string "%d"
    
    array: .zero 400  // Espacio para 100 enteros (4 bytes cada uno)
    tam_array: .word 0

.text
.global main
.align 2

main:
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // Mostrar mensaje de ingreso
    adr x0, msg_ingreso
    bl printf

    // Inicializar puntero de array y tamaño
    adr x20, array
    adr x21, tam_array
    mov w22, #0  // Índice del array

ingresar_numeros:
    // Mostrar prompt
    adr x0, msg_pedir_numero
    bl printf

    // Leer número
    adr x0, formato_int
    sub sp, sp, #16
    mov x1, sp
    bl scanf

    // Cargar número ingresado
    ldr w23, [sp]
    add sp, sp, #16

    // Verificar si es cero
    cbz w23, fin_ingreso

    // Guardar número en el array
    str w23, [x20, w22, SXTW #2]
    add w22, w22, #1

    // Continuar ingresando números
    b ingresar_numeros

fin_ingreso:
    // Guardar tamaño del array
    str w22, [x21]

    // Verificar si el array está vacío
    cbz w22, array_vacio

    // Sumar elementos
    mov w24, #0  // Suma
    mov w25, #0  // Índice

suma_loop:
    ldr w26, [x20, w25, SXTW #2]
    add w24, w24, w26
    add w25, w25, #1
    cmp w25, w22
    b.lt suma_loop

    // Mostrar resultado
    adr x0, msg_resultado
    mov w1, w24
    bl printf
    b fin_programa

array_vacio:
    adr x0, msg_array_vacio
    bl printf

fin_programa:
    mov w0, #0
    ldp x29, x30, [sp], 16
    ret
```

## Descripción

Programa 34 de 50 Invertir los elementos de un arreglo.
Video de Prueba
https://asciinema.org/a/690850

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 19/11/2024
// Descripción: Programa que invierte los elementos de un arreglo.

/*using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        List<int> array = new List<int>();
        
        Console.WriteLine("Ingrese los números del arreglo (ingrese 0 para terminar):");
        
        while (true)
        {
            Console.Write("Ingrese un número: ");
            int numero = int.Parse(Console.ReadLine());
            
            if (numero == 0)
                break;
            
            array.Add(numero);
        }
        
        if (array.Count == 0)
        {
            Console.WriteLine("El arreglo está vacío.");
            return;
        }
        
        // Invertir el arreglo
        array.Reverse();
        
        // Mostrar arreglo invertido
        Console.Write("Arreglo invertido: ");
        foreach (int num in array)
        {
            Console.Write($"{num} ");
        }
        Console.WriteLine();
    }
}
*/

.data
    msg_ingreso: .string "Ingrese los números del arreglo (ingrese 0 para terminar):\n"
    msg_pedir_numero: .string "Ingrese un número: "
    msg_array_vacio: .string "El arreglo está vacío.\n"
    msg_resultado: .string "Arreglo invertido: "
    msg_numero: .string "%d "
    msg_newline: .string "\n"
    formato_int: .string "%d"
    
    array: .zero 400  // Espacio para 100 enteros (4 bytes cada uno)
    tam_array: .word 0

.text
.global main
.align 2

main:
    stp x29, x30, [sp, -16]!
    mov x29, sp

    // Mostrar mensaje de ingreso
    adr x0, msg_ingreso
    bl printf

    // Inicializar puntero de array y tamaño
    adr x20, array
    adr x21, tam_array
    mov w22, #0  // Índice del array

ingresar_numeros:
    // Mostrar prompt
    adr x0, msg_pedir_numero
    bl printf

    // Leer número
    adr x0, formato_int
    sub sp, sp, #16
    mov x1, sp
    bl scanf

    // Cargar número ingresado
    ldr w23, [sp]
    add sp, sp, #16

    // Verificar si es cero
    cbz w23, fin_ingreso

    // Guardar número en el array
    str w23, [x20, w22, SXTW #2]
    add w22, w22, #1

    // Continuar ingresando números
    b ingresar_numeros

fin_ingreso:
    // Guardar tamaño del array
    str w22, [x21]

    // Verificar si el array está vacío
    cbz w22, array_vacio

    // Invertir el arreglo
    mov w24, #0  // Índice inicial
    sub w25, w22, #1  // Índice final

invertir_loop:
    cmp w24, w25
    b.ge mostrar_array

    // Cargar elementos a intercambiar
    ldr w26, [x20, w24, SXTW #2]
    ldr w27, [x20, w25, SXTW #2]

    // Intercambiar
    str w27, [x20, w24, SXTW #2]
    str w26, [x20, w25, SXTW #2]

    // Actualizar índices
    add w24, w24, #1
    sub w25, w25, #1

    b invertir_loop

mostrar_array:
    // Mostrar mensaje de resultado
    adr x0, msg_resultado
    bl printf

    // Reiniciar índice
    mov w24, #0

mostrar_loop:
    // Mostrar número
    ldr w1, [x20, w24, SXTW #2]
    adr x0, msg_numero
    bl printf

    // Incrementar índice
    add w24, w24, #1

    // Verificar si terminamos
    cmp w24, w22
    b.lt mostrar_loop

    // Nueva línea
    adr x0, msg_newline
    bl printf
    b fin_programa

array_vacio:
    adr x0, msg_array_vacio
    bl printf

fin_programa:
    mov w0, #0
    ldp x29, x30, [sp], 16
    ret

```
## Descripción

Programa 35 de 50 Rotación de un arreglo (izquierda/derecha).
Video de Prueba
https://asciinema.org/a/690861

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 19/11/2024
// Descripción: Programa que Rotación de un arreglo (izquierda/derecha) .

/*using System;

class Program
{
    static void Main()
    {
        int opcion, numero, posiciones, resultado;

        // Menú de desplazamientos de bits
        while (true)
        {
            Console.WriteLine("\nDesplazamientos de bits");
            Console.WriteLine("1. Desplazamiento a la izquierda (LSL)");
            Console.WriteLine("2. Desplazamiento a la derecha (LSR)");
            Console.WriteLine("3. Salir");
            Console.Write("Seleccione una opción: ");

            // Leer opción
            opcion = int.Parse(Console.ReadLine());

            // Verificar si se quiere salir
            if (opcion == 3)
                break;

            // Leer número
            Console.Write("Ingrese el número: ");
            numero = int.Parse(Console.ReadLine());

            // Leer posiciones
            Console.Write("Ingrese posiciones a desplazar: ");
            posiciones = int.Parse(Console.ReadLine());

            // Realizar desplazamiento según la opción seleccionada
            switch (opcion)
            {
                case 1: // Desplazamiento a la izquierda (LSL)
                    resultado = numero << posiciones;
                    break;
                case 2: // Desplazamiento a la derecha (LSR)
                    resultado = numero >> posiciones;
                    break;
                default:
                    continue;
            }

            // Mostrar resultado en decimal
            Console.WriteLine("Resultado: " + resultado);

            // Mostrar resultado en binario
            Console.Write("En binario: ");
            MostrarEnBinario(resultado);
        }
    }

    static void MostrarEnBinario(int numero)
    {
        for (int i = 31; i >= 0; i--)
        {
            int bit = (numero >> i) & 1; // Obtener el bit correspondiente
            Console.Write(bit);
        }
        Console.WriteLine();
    }
}
*/

.data
msg_menu:       .string "\nDesplazamientos de bits\n"
                .string "1. Desplazamiento a la izquierda (LSL)\n"
                .string "2. Desplazamiento a la derecha (LSR)\n"
                .string "3. Salir\n"
                .string "Seleccione una opción: "

msg_num:        .string "Ingrese el número: "
msg_pos:        .string "Ingrese posiciones a desplazar: "
msg_resultado:  .string "Resultado: %d\n"
msg_binario:    .string "En binario: "
msg_bit:        .string "%d"
msg_newline:    .string "\n"
formato_int:    .string "%d"

opcion:         .word 0
numero:         .word 0
posiciones:     .word 0

    .text
    .global main
    .align 2

main:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

menu_loop:
    // Mostrar menú
    adr     x0, msg_menu
    bl      printf

    // Leer opción
    adr     x0, formato_int
    adr     x1, opcion
    bl      scanf

    // Verificar salida
    adr     x0, opcion
    ldr     w0, [x0]
    cmp     w0, #3
    b.eq    fin_programa

    // Leer número
    adr     x0, msg_num
    bl      printf
    adr     x0, formato_int
    adr     x1, numero
    bl      scanf

    // Leer posiciones
    adr     x0, msg_pos
    bl      printf
    adr     x0, formato_int
    adr     x1, posiciones
    bl      scanf

    // Cargar valores
    adr     x0, numero
    ldr     w1, [x0]
    adr     x0, posiciones
    ldr     w2, [x0]
    adr     x0, opcion
    ldr     w0, [x0]

    // Seleccionar operación
    cmp     w0, #1
    b.eq    shift_left
    cmp     w0, #2
    b.eq    shift_right
    b       menu_loop

shift_left:
    lsl     w1, w1, w2
    b       mostrar_resultado

shift_right:
    lsr     w1, w1, w2

mostrar_resultado:
    // Guardar resultado
    mov     w19, w1

    // Mostrar en decimal
    adr     x0, msg_resultado
    bl      printf

    // Mostrar en binario
    adr     x0, msg_binario
    bl      printf

    mov     w20, #32
mostrar_bits:
    sub     w20, w20, #1
    lsr     w21, w19, w20
    and     w1, w21, #1
    adr     x0, msg_bit
    bl      printf

    cmp     w20, #0
    b.ne    mostrar_bits

    adr     x0, msg_newline
    bl      printf

    b       menu_loop

fin_programa:
    mov     w0, #0
    ldp     x29, x30, [sp], 16
    ret
```
## Descripción

Programa 36 de 50 Encontrar el segundo elemento más grande.
Video de Prueba
https://asciinema.org/a/690865

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 19/11/2024
// Descripción: Programa que encuentra el segundo elementos mas grande en un arreglo.

/*using System;

class Program
{
    // Mensajes del menú
    static readonly string msgMenu = "\nBúsqueda del Segundo Elemento más Grande\n" +
                                     "1. Encontrar segundo mayor\n" +
                                     "2. Mostrar arreglo\n" +
                                     "3. Salir\n" +
                                     "Seleccione una opción: ";
    static readonly string msgArray = "Arreglo actual: ";
    static readonly string msgMax = "El elemento más grande es: {0}\n";
    static readonly string msgSecond = "El segundo elemento más grande es: {0}\n";
    static readonly string msgError = "No existe un segundo elemento más grande (todos son iguales)\n";
    static readonly string msgNewline = "\n";

    // Arreglo de ejemplo
    static int[] array = { 12, 35, 1, 10, 34, 1, 35, 8, 23, 19 };

    static void Main()
    {
        while (true)
        {
            // Mostrar menú y leer opción
            Console.Write(msgMenu);
            int opcion = int.Parse(Console.ReadLine());

            // Verificar opción de salida
            if (opcion == 3)
            {
                Console.WriteLine("Saliendo del programa...");
                break;
            }
            else if (opcion == 1)
            {
                EncontrarSegundoMayor();
            }
            else if (opcion == 2)
            {
                MostrarArreglo();
            }
            else
            {
                Console.WriteLine("Opción inválida, intente nuevamente.");
            }
        }
    }

    static void EncontrarSegundoMayor()
    {
        if (array.Length < 2)
        {
            Console.WriteLine(msgError);
            return;
        }

        int maxNum = array[0];
        int secondMax = int.MinValue;
        
        foreach (int num in array)
        {
            if (num > maxNum)
            {
                secondMax = maxNum;
                maxNum = num;
            }
            else if (num > secondMax && num < maxNum)
            {
                secondMax = num;
            }
        }

        if (secondMax == int.MinValue)
        {
            Console.WriteLine(msgError);
        }
        else
        {
            Console.WriteLine(msgMax, maxNum);
            Console.WriteLine(msgSecond, secondMax);
        }
    }

    static void MostrarArreglo()
    {
        Console.WriteLine(msgArray);
        foreach (int num in array)
        {
            Console.Write($"{num} ");
        }
        Console.WriteLine(msgNewline);
    }
}
*/


.data
    msg_menu: 
        .string "\nBúsqueda del Segundo Elemento más Grande\n"
        .string "1. Encontrar segundo mayor\n"
        .string "2. Mostrar arreglo\n"
        .string "3. Salir\n"
        .string "Seleccione una opción: "
    
    msg_array: .string "Arreglo actual: "
    msg_max: .string "El elemento más grande es: %d\n"
    msg_second: .string "El segundo elemento más grande es: %d\n"
    msg_error: .string "No existe un segundo elemento más grande (todos son iguales)\n"
    msg_num: .string "%d "
    msg_newline: .string "\n"
    formato_int: .string "%d"
    
    // Arreglo y variables
    array: .word 12, 35, 1, 10, 34, 1, 35, 8, 23, 19  // Arreglo de ejemplo con 10 elementos
    array_size: .word 10
    opcion: .word 0
    max_num: .word 0
    second_max: .word 0

.text
.global main
.align 2

main:
    stp x29, x30, [sp, -16]!
    mov x29, sp

menu_loop:
    // Mostrar menú
    adr x0, msg_menu
    bl printf

    // Leer opción
    adr x0, formato_int
    adr x1, opcion
    bl scanf

    // Verificar opción
    adr x0, opcion
    ldr w0, [x0]
    
    cmp w0, #3
    b.eq fin_programa
    
    cmp w0, #1
    b.eq encontrar_segundo
    
    cmp w0, #2
    b.eq mostrar_arreglo
    
    b menu_loop

encontrar_segundo:
    // Inicializar variables
    adr x20, array        // Dirección base del arreglo
    adr x21, array_size
    ldr w21, [x21]        // Tamaño del arreglo
    
    // Encontrar el máximo primero
    ldr w22, [x20]        // max_num = array[0]
    mov w23, w22          // second_max = array[0]
    mov w24, #1           // índice = 1

encontrar_max_loop:
    ldr w25, [x20, w24, SXTW #2]  // Cargar elemento actual
    
    // Comparar con máximo actual
    cmp w25, w22
    b.le no_es_max       // Si es menor o igual, saltar
    mov w23, w22         // El antiguo máximo se convierte en segundo
    mov w22, w25         // Actualizar máximo
    b continuar_max

no_es_max:
    // Comparar con segundo máximo
    cmp w25, w23
    b.le continuar_max   // Si es menor o igual, saltar
    cmp w25, w22
    b.eq continuar_max   // Si es igual al máximo, saltar
    mov w23, w25         // Actualizar segundo máximo

continuar_max:
    add w24, w24, #1     // Incrementar índice
    cmp w24, w21         // Comparar con tamaño
    b.lt encontrar_max_loop

    // Verificar si encontramos un segundo máximo válido
    cmp w22, w23
    b.eq no_segundo_max

    // Mostrar resultados
    adr x0, msg_max
    mov w1, w22
    bl printf
    
    adr x0, msg_second
    mov w1, w23
    bl printf
    b menu_loop

no_segundo_max:
    adr x0, msg_error
    bl printf
    b menu_loop

mostrar_arreglo:
    adr x0, msg_array
    bl printf
    
    adr x20, array
    adr x21, array_size
    ldr w21, [x21]
    mov w22, #0          // índice

mostrar_loop:
    ldr w1, [x20, w22, SXTW #2]
    adr x0, msg_num
    bl printf
    
    add w22, w22, #1
    cmp w22, w21
    b.lt mostrar_loop
    
    adr x0, msg_newline
    bl printf
    b menu_loop

fin_programa:
    mov w0, #0
    ldp x29, x30, [sp], 16
    ret

```
## Descripción

Programa 37 de 50 Implementar una pila usando un arreglo.
Video de Prueba
https://asciinema.org/a/690869

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 19/11/2024
// Descripción: Programa que Implementa una pila usando un arreglo.

/*using System;
using System.Collections.Generic;

class QueueProgram
{
    // Mensajes del menú y mensajes informativos
    static readonly string msgMenu = "\nOperaciones de Cola\n" +
                                     "1. Enqueue (Insertar)\n" +
                                     "2. Dequeue (Eliminar)\n" +
                                     "3. Peek (Ver frente)\n" +
                                     "4. Mostrar cola\n" +
                                     "5. Salir\n" +
                                     "Seleccione una opción: ";
    static readonly string msgEnqueue = "Ingrese valor a insertar: ";
    static readonly string msgDequeue = "Elemento eliminado: {0}\n";
    static readonly string msgPeek = "Elemento al frente: {0}\n";
    static readonly string msgEmpty = "La cola está vacía\n";
    static readonly string msgFull = "La cola está llena\n";
    static readonly string msgQueue = "Contenido de la cola: ";
    static readonly string msgNewline = "\n";

    // Cola y variables
    static int queueSize = 10;
    static int[] queue = new int[queueSize];
    static int front = -1;
    static int rear = -1;

    static void Main()
    {
        while (true)
        {
            // Mostrar menú
            Console.Write(msgMenu);
            int opcion = int.Parse(Console.ReadLine());

            switch (opcion)
            {
                case 1:
                    Enqueue();
                    break;
                case 2:
                    Dequeue();
                    break;
                case 3:
                    Peek();
                    break;
                case 4:
                    MostrarCola();
                    break;
                case 5:
                    Console.WriteLine("Saliendo del programa...");
                    return;
                default:
                    Console.WriteLine("Opción inválida, intente nuevamente.");
                    break;
            }
        }
    }

    static void Enqueue()
    {
        // Verificar si la cola está llena
        if (rear == queueSize - 1)
        {
            Console.WriteLine(msgFull);
            return;
        }

        // Leer valor a insertar
        Console.Write(msgEnqueue);
        int valor = int.Parse(Console.ReadLine());

        // Si es el primer elemento
        if (front == -1)
        {
            front = 0;
        }

        // Incrementar rear y guardar valor
        rear++;
        queue[rear] = valor;
    }

    static void Dequeue()
    {
        // Verificar si la cola está vacía
        if (front == -1 || front > rear)
        {
            Console.WriteLine(msgEmpty);
            return;
        }

        // Obtener y mostrar el elemento eliminado
        int eliminado = queue[front];
        Console.WriteLine(msgDequeue, eliminado);

        // Actualizar índices
        front++;
        if (front > rear)
        {
            front = -1;
            rear = -1;
        }
    }

    static void Peek()
    {
        // Verificar si la cola está vacía
        if (front == -1)
        {
            Console.WriteLine(msgEmpty);
            return;
        }

        // Mostrar el elemento al frente
        Console.WriteLine(msgPeek, queue[front]);
    }

    static void MostrarCola()
    {
        // Verificar si la cola está vacía
        if (front == -1)
        {
            Console.WriteLine(msgEmpty);
            return;
        }

        // Mostrar los elementos de la cola
        Console.Write(msgQueue);
        for (int i = front; i <= rear; i++)
        {
            Console.Write(queue[i] + " ");
        }
        Console.WriteLine(msgNewline);
    }
}
*/

.data
    msg_menu: 
        .string "\nOperaciones de Cola\n"
        .string "1. Enqueue (Insertar)\n"
        .string "2. Dequeue (Eliminar)\n"
        .string "3. Peek (Ver frente)\n"
        .string "4. Mostrar cola\n"
        .string "5. Salir\n"
        .string "Seleccione una opción: "
    
    msg_enq: .string "Ingrese valor a insertar: "
    msg_deq: .string "Elemento eliminado: %d\n"
    msg_peek: .string "Elemento al frente: %d\n"
    msg_empty: .string "La cola está vacía\n"
    msg_full: .string "La cola está llena\n"
    msg_queue: .string "Contenido de la cola: "
    msg_num: .string "%d "
    msg_newline: .string "\n"
    formato_int: .string "%d"
    
    // Cola y variables
    queue: .skip 40       // Espacio para 10 elementos (4 bytes c/u)
    queue_size: .word 10  // Tamaño máximo de la cola
    front: .word -1       // Índice del frente
    rear: .word -1        // Índice del final
    opcion: .word 0
    valor: .word 0

.text
.global main
.align 2

main:
    stp x29, x30, [sp, -16]!
    mov x29, sp

menu_loop:
    // Mostrar menú
    adr x0, msg_menu
    bl printf

    // Leer opción
    adr x0, formato_int
    adr x1, opcion
    bl scanf

    // Verificar opción
    adr x0, opcion
    ldr w0, [x0]
    
    cmp w0, #5
    b.eq fin_programa
    
    cmp w0, #1
    b.eq enqueue
    
    cmp w0, #2
    b.eq dequeue
    
    cmp w0, #3
    b.eq peek_elemento
    
    cmp w0, #4
    b.eq mostrar_cola
    
    b menu_loop

enqueue:
    // Verificar si la cola está llena
    adr x20, rear
    ldr w21, [x20]
    adr x22, queue_size
    ldr w22, [x22]
    sub w22, w22, #1
    
    cmp w21, w22
    b.ge cola_llena
    
    // Leer valor a insertar
    adr x0, msg_enq
    bl printf
    adr x0, formato_int
    adr x1, valor
    bl scanf
    
    // Si es el primer elemento
    adr x20, front
    ldr w23, [x20]
    cmp w23, #-1
    b.ne continuar_enq
    mov w23, #0
    str w23, [x20]
    
continuar_enq:
    // Incrementar rear y guardar valor
    adr x20, rear
    ldr w21, [x20]
    add w21, w21, #1
    str w21, [x20]
    
    adr x20, queue
    adr x22, valor
    ldr w22, [x22]
    str w22, [x20, w21, SXTW #2]
    
    b menu_loop

dequeue:
    // Verificar si la cola está vacía
    adr x20, front
    ldr w21, [x20]
    cmp w21, #-1
    b.eq cola_vacia
    
    // Obtener elemento del frente
    adr x20, queue
    ldr w22, [x20, w21, SXTW #2]
    
    // Mostrar elemento eliminado
    adr x0, msg_deq
    mov w1, w22
    bl printf
    
    // Actualizar índices
    adr x20, front
    adr x23, rear
    ldr w24, [x23]
    
    cmp w21, w24
    b.eq vaciar_cola
    
    add w21, w21, #1
    str w21, [x20]
    b menu_loop

vaciar_cola:
    mov w21, #-1
    adr x20, front
    str w21, [x20]
    adr x20, rear
    str w21, [x20]
    b menu_loop

peek_elemento:
    // Verificar si la cola está vacía
    adr x20, front
    ldr w21, [x20]
    cmp w21, #-1
    b.eq cola_vacia
    
    // Mostrar elemento del frente
    adr x20, queue
    ldr w22, [x20, w21, SXTW #2]
    adr x0, msg_peek
    mov w1, w22
    bl printf
    
    b menu_loop

mostrar_cola:
    // Verificar si la cola está vacía
    adr x20, front
    ldr w21, [x20]
    cmp w21, #-1
    b.eq cola_vacia
    
    // Mostrar mensaje
    adr x0, msg_queue
    bl printf
    
    // Mostrar elementos
    adr x20, queue
    adr x23, rear
    ldr w23, [x23]

mostrar_loop:
    ldr w1, [x20, w21, SXTW #2]
    adr x0, msg_num
    bl printf
    
    add w21, w21, #1
    cmp w21, w23
    b.le mostrar_loop
    
    adr x0, msg_newline
    bl printf
    b menu_loop

cola_vacia:
    adr x0, msg_empty
    bl printf
    b menu_loop

cola_llena:
    adr x0, msg_full
    bl printf
    b menu_loop

fin_programa:
    mov w0, #0
    ldp x29, x30, [sp], 16
    ret
```
## Descripción

Programa 38 de 50 Implementar una cola usando un arreglo.
Video de Prueba
https://asciinema.org/a/690872

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 19/11/2024
// Descripción: Programa que Implementa una cola usando un arreglo.
 
/*using System;

class QueueProgram
{
    // Mensajes del menú y mensajes informativos
    static readonly string msgMenu = "\nOperaciones de Cola\n" +
                                     "1. Enqueue (Insertar)\n" +
                                     "2. Dequeue (Eliminar)\n" +
                                     "3. Peek (Ver frente)\n" +
                                     "4. Mostrar cola\n" +
                                     "5. Salir\n" +
                                     "Seleccione una opción: ";
    static readonly string msgEnqueue = "Ingrese valor a insertar: ";
    static readonly string msgDequeue = "Elemento eliminado: {0}\n";
    static readonly string msgPeek = "Elemento al frente: {0}\n";
    static readonly string msgEmpty = "La cola está vacía\n";
    static readonly string msgFull = "La cola está llena\n";
    static readonly string msgQueue = "Contenido de la cola: ";
    static readonly string msgNewline = "\n";

    // Cola y variables
    static int queueSize = 10;
    static int[] queue = new int[queueSize];
    static int front = -1;
    static int rear = -1;

    static void Main()
    {
        while (true)
        {
            // Mostrar menú
            Console.Write(msgMenu);
            int opcion = int.Parse(Console.ReadLine());

            switch (opcion)
            {
                case 1:
                    Enqueue();
                    break;
                case 2:
                    Dequeue();
                    break;
                case 3:
                    Peek();
                    break;
                case 4:
                    MostrarCola();
                    break;
                case 5:
                    Console.WriteLine("Saliendo del programa...");
                    return;
                default:
                    Console.WriteLine("Opción inválida, intente nuevamente.");
                    break;
            }
        }
    }

    static void Enqueue()
    {
        // Verificar si la cola está llena
        if (rear == queueSize - 1)
        {
            Console.WriteLine(msgFull);
            return;
        }

        // Leer valor a insertar
        Console.Write(msgEnqueue);
        int valor = int.Parse(Console.ReadLine());

        // Si es el primer elemento
        if (front == -1)
        {
            front = 0;
        }

        // Incrementar rear y guardar valor
        rear++;
        queue[rear] = valor;
    }

    static void Dequeue()
    {
        // Verificar si la cola está vacía
        if (front == -1 || front > rear)
        {
            Console.WriteLine(msgEmpty);
            return;
        }

        // Obtener y mostrar el elemento eliminado
        int eliminado = queue[front];
        Console.WriteLine(msgDequeue, eliminado);

        // Actualizar índices
        front++;
        if (front > rear)
        {
            front = -1;
            rear = -1;
        }
    }

    static void Peek()
    {
        // Verificar si la cola está vacía
        if (front == -1)
        {
            Console.WriteLine(msgEmpty);
            return;
        }

        // Mostrar el elemento al frente
        Console.WriteLine(msgPeek, queue[front]);
    }

    static void MostrarCola()
    {
        // Verificar si la cola está vacía
        if (front == -1)
        {
            Console.WriteLine(msgEmpty);
            return;
        }

        // Mostrar los elementos de la cola
        Console.Write(msgQueue);
        for (int i = front; i <= rear; i++)
        {
            Console.Write(queue[i] + " ");
        }
        Console.WriteLine(msgNewline);
    }
}
*/

.data
    msg_menu: 
        .string "\nOperaciones de Cola\n"
        .string "1. Enqueue (Insertar)\n"
        .string "2. Dequeue (Eliminar)\n"
        .string "3. Peek (Ver frente)\n"
        .string "4. Mostrar cola\n"
        .string "5. Salir\n"
        .string "Seleccione una opción: "
    
    msg_enq: .string "Ingrese valor a insertar: "
    msg_deq: .string "Elemento eliminado: %d\n"
    msg_peek: .string "Elemento al frente: %d\n"
    msg_empty: .string "La cola está vacía\n"
    msg_full: .string "La cola está llena\n"
    msg_queue: .string "Contenido de la cola: "
    msg_num: .string "%d "
    msg_newline: .string "\n"
    formato_int: .string "%d"
    
    // Cola y variables
    queue: .skip 40       // Espacio para 10 elementos (4 bytes c/u)
    queue_size: .word 10  // Tamaño máximo de la cola
    front: .word -1       // Índice del frente
    rear: .word -1        // Índice del final
    opcion: .word 0
    valor: .word 0

.text
.global main
.align 2

main:
    stp x29, x30, [sp, -16]!
    mov x29, sp

menu_loop:
    // Mostrar menú
    adr x0, msg_menu
    bl printf

    // Leer opción
    adr x0, formato_int
    adr x1, opcion
    bl scanf

    // Verificar opción
    adr x0, opcion
    ldr w0, [x0]
    
    cmp w0, #5
    b.eq fin_programa
    
    cmp w0, #1
    b.eq enqueue
    
    cmp w0, #2
    b.eq dequeue
    
    cmp w0, #3
    b.eq peek_elemento
    
    cmp w0, #4
    b.eq mostrar_cola
    
    b menu_loop

enqueue:
    // Verificar si la cola está llena
    adr x20, rear
    ldr w21, [x20]
    adr x22, queue_size
    ldr w22, [x22]
    sub w22, w22, #1
    
    cmp w21, w22
    b.ge cola_llena
    
    // Leer valor a insertar
    adr x0, msg_enq
    bl printf
    adr x0, formato_int
    adr x1, valor
    bl scanf
    
    // Si es el primer elemento
    adr x20, front
    ldr w23, [x20]
    cmp w23, #-1
    b.ne continuar_enq
    mov w23, #0
    str w23, [x20]
    
continuar_enq:
    // Incrementar rear y guardar valor
    adr x20, rear
    ldr w21, [x20]
    add w21, w21, #1
    str w21, [x20]
    
    adr x20, queue
    adr x22, valor
    ldr w22, [x22]
    str w22, [x20, w21, SXTW #2]
    
    b menu_loop

dequeue:
    // Verificar si la cola está vacía
    adr x20, front
    ldr w21, [x20]
    cmp w21, #-1
    b.eq cola_vacia
    
    // Obtener elemento del frente
    adr x20, queue
    ldr w22, [x20, w21, SXTW #2]
    
    // Mostrar elemento eliminado
    adr x0, msg_deq
    mov w1, w22
    bl printf
    
    // Actualizar índices
    adr x20, front
    adr x23, rear
    ldr w24, [x23]
    
    cmp w21, w24
    b.eq vaciar_cola
    
    add w21, w21, #1
    str w21, [x20]
    b menu_loop

vaciar_cola:
    mov w21, #-1
    adr x20, front
    str w21, [x20]
    adr x20, rear
    str w21, [x20]
    b menu_loop

peek_elemento:
    // Verificar si la cola está vacía
    adr x20, front
    ldr w21, [x20]
    cmp w21, #-1
    b.eq cola_vacia
    
    // Mostrar elemento del frente
    adr x20, queue
    ldr w22, [x20, w21, SXTW #2]
    adr x0, msg_peek
    mov w1, w22
    bl printf
    
    b menu_loop

mostrar_cola:
    // Verificar si la cola está vacía
    adr x20, front
    ldr w21, [x20]
    cmp w21, #-1
    b.eq cola_vacia
    
    // Mostrar mensaje
    adr x0, msg_queue
    bl printf
    
    // Mostrar elementos
    adr x20, queue
    adr x23, rear
    ldr w23, [x23]

mostrar_loop:
    ldr w1, [x20, w21, SXTW #2]
    adr x0, msg_num
    bl printf
    
    add w21, w21, #1
    cmp w21, w23
    b.le mostrar_loop
    
    adr x0, msg_newline
    bl printf
    b menu_loop

cola_vacia:
    adr x0, msg_empty
    bl printf
    b menu_loop

cola_llena:
    adr x0, msg_full
    bl printf
    b menu_loop

fin_programa:
    mov w0, #0
    ldp x29, x30, [sp], 16
    ret
```
## Descripción

Programa 39 de 50 Convertir decimal a binario.
Video de Prueba
https://asciinema.org/a/690879

## Código Completo
```c
// Autor: Pozos Flores Norberto
// Fecha: 19/11/2024
// Descripción: Programa que Convierte decimal a binario.

/*using System;

class DecimalToBinaryConverter
{
    static readonly string msgMenu = "\nConversor Decimal a Binario\n" +
                                     "1. Convertir número\n" +
                                     "2. Salir\n" +
                                     "Seleccione una opción: ";
    static readonly string msgInput = "Ingrese un número decimal (positivo): ";
    static readonly string msgResult = "El número {0} en binario es: ";
    static readonly string msgNegative = "Por favor ingrese un número positivo\n";

    static void Main()
    {
        while (true)
        {
            // Mostrar menú
            Console.Write(msgMenu);
            int opcion = int.Parse(Console.ReadLine());

            if (opcion == 2)
            {
                Console.WriteLine("Saliendo del programa...");
                break;
            }
            else if (opcion == 1)
            {
                ConvertirNumero();
            }
            else
            {
                Console.WriteLine("Opción inválida, intente nuevamente.");
            }
        }
    }

    static void ConvertirNumero()
    {
        // Solicitar número
        Console.Write(msgInput);
        int numero;
        if (!int.TryParse(Console.ReadLine(), out numero) || numero < 0)
        {
            Console.WriteLine(msgNegative);
            return;
        }

        // Manejar el caso especial para el número 0
        if (numero == 0)
        {
            Console.WriteLine(msgResult, numero, "0");
            return;
        }

        // Convertir a binario
        string binario = ConvertirADecimal(numero);
        Console.WriteLine(msgResult, numero, binario);
    }

    static string ConvertirADecimal(int numero)
    {
        char[] bits = new char[32];  // Arreglo para almacenar hasta 32 bits
        int indice = 0;

        // Llenar el arreglo de bits en orden inverso
        while (numero > 0)
        {
            bits[indice++] = (char)((numero % 2) + '0');
            numero /= 2;
        }

        // Invertir el orden de los bits para la salida correcta
        Array.Reverse(bits, 0, indice);
        return new string(bits, 0, indice);
    }
}
*/

.data
    msg_menu: 
        .string "\nConversor Decimal a Binario\n"
        .string "1. Convertir número\n"
        .string "2. Salir\n"
        .string "Seleccione una opción: "
    
    msg_input: .string "Ingrese un número decimal (positivo): "
    msg_result: .string "El número %d en binario es: "
    msg_negative: .string "Por favor ingrese un número positivo\n"
    msg_bit: .string "%d"
    msg_newline: .string "\n"
    formato_int: .string "%d"
    
    // Variables
    opcion: .word 0
    numero: .word 0
    binary: .skip 32     // Arreglo para almacenar bits (32 bits máximo)
    binary_size: .word 0

.text
.global main
.align 2

main:
    stp x29, x30, [sp, -16]!
    mov x29, sp

menu_loop:
    // Mostrar menú
    adr x0, msg_menu
    bl printf

    // Leer opción
    adr x0, formato_int
    adr x1, opcion
    bl scanf

    // Verificar opción
    adr x0, opcion
    ldr w0, [x0]
    
    cmp w0, #2
    b.eq fin_programa
    
    cmp w0, #1
    b.eq convertir_numero
    
    b menu_loop

convertir_numero:
    // Solicitar número
    adr x0, msg_input
    bl printf
    
    // Leer número
    adr x0, formato_int
    adr x1, numero
    bl scanf
    
    // Verificar si es positivo
    adr x0, numero
    ldr w0, [x0]
    cmp w0, #0
    b.lt numero_negativo
    
    // Preparar para conversión
    mov w19, w0          // Guardar número original
    adr x20, binary      // Dirección del arreglo de bits
    mov w21, #0          // Contador de bits
    
    // Si el número es 0, manejo especial
    cmp w19, #0
    b.eq caso_cero

conversion_loop:
    // Verificar si el número es 0
    cmp w19, #0
    b.eq mostrar_resultado
    
    // Obtener bit actual (número & 1)
    and w22, w19, #1
    
    // Guardar bit en el arreglo
    str w22, [x20, w21, SXTW #2]
    
    // Incrementar contador
    add w21, w21, #1
    
    // Dividir número por 2 (shift right)
    lsr w19, w19, #1
    
    b conversion_loop

caso_cero:
    mov w22, #0
    str w22, [x20]
    mov w21, #1
    b mostrar_resultado

mostrar_resultado:
    // Guardar tamaño del binario
    adr x22, binary_size
    str w21, [x22]
    
    // Mostrar mensaje inicial
    adr x0, msg_result
    adr x1, numero
    ldr w1, [x1]
    bl printf
    
    // Mostrar bits en orden inverso
    sub w21, w21, #1     // Índice del último bit
    
mostrar_bits:
    ldr w1, [x20, w21, SXTW #2]
    adr x0, msg_bit
    bl printf
    
    sub w21, w21, #1
    cmp w21, #-1
    b.ge mostrar_bits
    
    // Nueva línea
    adr x0, msg_newline
    bl printf
    
    b menu_loop

numero_negativo:
    adr x0, msg_negative
    bl printf
    b menu_loop

fin_programa:
    mov w0, #0
    ldp x29, x30, [sp], 16
    ret
```
## Descripción

Programa 40 de 50 Convertir binario a decimal.
Video de Prueba
https://asciinema.org/a/690884

## Código Completo
```c

// Autor: Pozos Flores Norberto
// Fecha: 19/11/2024
// Descripción: Programa que Convierte binario a decimal.

// Equivalente en C#:
/*
using System;

class BinaryToDecimalConverter
{
    static void Main()
    {
        while (true)
        {
            Console.WriteLine("\nConversor Binario a Decimal");
            Console.WriteLine("1. Convertir número Binario a Decimal");
            Console.WriteLine("2. Salir");
            Console.Write("Seleccione una opción: ");

            int opcion = Convert.ToInt32(Console.ReadLine());

            switch (opcion)
            {
                case 2:
                    return;
                case 1:
                    ConvertirBinarioDecimal();
                    break;
            }
        }
    }

    static void ConvertirBinarioDecimal()
    {
        Console.Write("Ingrese un número binario (solo 0s y 1s): ");
        string binario = Console.ReadLine();

        try 
        {
            int decimal = Convert.ToInt32(binario, 2);
            Console.WriteLine($"El número en decimal es: {decimal}");
        }
        catch (FormatException)
        {
            Console.WriteLine("Número binario inválido. Solo se permiten 0s y 1s.");
        }
    }
}
*/
.data
    msg_menu: 
        .string "\nConversor Binario a Decimal\n"
        .string "1. Convertir número Binario a Decimal\n"
        .string "2. Salir\n"
        .string "Seleccione una opción: "
    
    msg_input_binary: .string "Ingrese un número binario (solo 0s y 1s): "
    msg_result_decimal: .string "El número en decimal es: %d\n"
    msg_error_invalido: .string "Número binario inválido. Solo se permiten 0s y 1s.\n"
    
    formato_int: .string "%d"
    formato_string: .string "%s"
    
    // Variables
    opcion: .word 0
    numero_binario: .skip 33   // Arreglo para almacenar número binario (32 bits + terminador)
    potencia: .word 1          // Variable para calcular potencias de 2
.text
.global main
.align 2

main:
    stp x29, x30, [sp, -16]!
    mov x29, sp

menu_loop:
    // Mostrar menú
    adr x0, msg_menu
    bl printf
    
    // Leer opción
    adr x0, formato_int
    adr x1, opcion
    bl scanf
    
    // Verificar opción
    adr x0, opcion
    ldr w0, [x0]
    
    cmp w0, #2
    b.eq fin_programa
    
    cmp w0, #1
    b.eq convertir_binario_decimal
    
    b menu_loop

convertir_binario_decimal:
    // Solicitar número binario
    adr x0, msg_input_binary
    bl printf
    
    // Limpiar buffer de número binario
    adr x0, numero_binario
    mov w1, #0
    mov w2, #33
    bl memset
    
    // Leer número binario como string
    adr x0, formato_string
    adr x1, numero_binario
    bl scanf
    
    // Preparar registros para conversión
    mov w19, #0         // Resultado decimal (acumulador)
    mov w20, #0         // Índice de cadena
    adr x21, numero_binario  // Dirección del número binario
    
    // Reiniciar potencia
    adr x22, potencia
    mov w23, #1
    str w23, [x22]
    
conversion_loop:
    // Obtener carácter en la posición actual (usando SXTW para extensión de signo)
    ldrb w22, [x21, w20, SXTW]
    
    // Verificar fin de cadena
    cbz w22, mostrar_resultado
    
    // Verificar si es 0 o 1
    cmp w22, #'0'
    b.lo error_conversion
    cmp w22, #'1'
    b.hi error_conversion
    
    // Si es '1', sumar al resultado
    cmp w22, #'1'
    b.ne bit_saltar
    
    // Obtener valor de potencia actual
    adr x22, potencia
    ldr w23, [x22]
    add w19, w19, w23

bit_saltar:
    // Multiplicar potencia por 2 para siguiente posición
    adr x22, potencia
    ldr w23, [x22]
    lsl w23, w23, #1
    str w23, [x22]
    
    // Incrementar índice de cadena
    add w20, w20, #1
    b conversion_loop
    
mostrar_resultado:
    // Mostrar resultado decimal
    adr x0, msg_result_decimal
    mov w1, w19
    bl printf
    
    b menu_loop

error_conversion:
    // Mostrar mensaje de error por número inválido
    adr x0, msg_error_invalido
    bl printf
    
    b menu_loop

fin_programa:
    // Salir del programa
    ldp x29, x30, [sp], 16
    ret
```
