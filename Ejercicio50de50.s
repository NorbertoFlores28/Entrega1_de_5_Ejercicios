// Autor: Pozos Flores Norberto
// Fecha: 19/11/2024
// Descripción: Programa que escribe en un archivo.
// Equivalente en C#:

/*

class Program
{
    static void Main(string[] args)
    {
        // Nombre del archivo
        string filename = "archivo.txt";
        // Mensaje a escribir
        string message = "¡Hola! Este texto se ha escrito desde ensamblador ARM64.\n";

        try
        {
            // Abrir y escribir en el archivo (esto crea o sobrescribe el archivo)
            File.WriteAllText(filename, message);
            // Imprimir mensaje de éxito
            Console.WriteLine("Archivo escrito correctamente");
        }
        catch (Exception ex)
        {
            // Imprimir mensaje de error
            Console.WriteLine("Error al abrir o escribir en el archivo: " + ex.Message);
            // Salir con código de error (solo se puede simular; en apps normales no se usa explícitamente)
            Environment.Exit(1);
        }
    }
}

*/
.arch armv8-a
    .text
    .align 2
    .global main
    .type main, @function

    // Definir constantes para syscalls
    .equ    SYS_OPEN, 56
    .equ    SYS_WRITE, 64
    .equ    SYS_CLOSE, 57
    .equ    O_WRONLY, 1
    .equ    O_CREAT, 0100
    .equ    O_TRUNC, 01000
    .equ    MODE, 0644      // rw-r--r--

main:
    // Prólogo
    stp     x29, x30, [sp, -16]!
    mov     x29, sp

    // Abrir archivo
    // open("archivo.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644)
    adrp    x0, filename
    add     x0, x0, :lo12:filename    // nombre del archivo
    mov     w1, #(O_WRONLY | O_CREAT | O_TRUNC)  // flags
    mov     w2, #MODE                  // permisos
    mov     x8, #SYS_OPEN
    svc     #0
    
    // Guardar file descriptor
    mov     x19, x0         // Guardar fd en x19
    
    // Comprobar error
    cmp     x0, #0
    b.lt    error

    // Escribir en archivo
    mov     x0, x19         // fd
    adrp    x1, message
    add     x1, x1, :lo12:message     // buffer
    adrp    x2, message_len
    add     x2, x2, :lo12:message_len // longitud
    ldr     x2, [x2]
    mov     x8, #SYS_WRITE
    svc     #0

    // Cerrar archivo
    mov     x0, x19         // fd
    mov     x8, #SYS_CLOSE
    svc     #0

    // Imprimir mensaje de éxito
    adrp    x0, success_msg
    add     x0, x0, :lo12:success_msg
    bl      printf

    // Epílogo y salida exitosa
    mov     w0, #0
    ldp     x29, x30, [sp], 16
    ret

error:
    // Imprimir mensaje de error
    adrp    x0, error_msg
    add     x0, x0, :lo12:error_msg
    bl      printf

    // Salir con código de error
    mov     w0, #1
    ldp     x29, x30, [sp], 16
    ret

    .section    .rodata
filename:       .string     "archivo.txt"
message:        .string     "¡Hola! Este texto se ha escrito desde ensamblador ARM64.\n"
message_len:    .quad       . - message
error_msg:      .string     "Error al abrir el archivo\n"
success_msg:    .string     "Archivo escrito correctamente\n"