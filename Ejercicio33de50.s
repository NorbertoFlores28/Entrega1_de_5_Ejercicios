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