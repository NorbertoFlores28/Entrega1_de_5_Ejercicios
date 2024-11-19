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