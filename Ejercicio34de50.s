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