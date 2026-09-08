# Hello, User! — Nim

Implementación de la especificación [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) en **Nim**, con un enfoque manual y minimalista.

Lee un nombre desde la entrada estándar y saluda al usuario.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hellouser.nim`](hellouser.nim) | Código fuente: solicita un nombre al usuario y saluda. |
| `hellouser` | Binario nativo generado por `nim c` (no versionado). |
| `nimcache/` | Caché de compilación generada por el compilador (ignorada en `.gitignore`). |

**Estructura de directorios esperada:**

```text
hellouser/
├── hellouser.nim    # Código fuente
├── hellouser        # Binario nativo (generado por nim c)
├── nimcache/        # Caché de compilación (generado, ignorado)
└── README.md        # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este programa introduce tres conceptos nuevos respecto a `helloworld`:

1. **Escritura sin salto de línea** — `stdout.write` imprime el prompt dejando el cursor en la misma línea.
2. **Entrada de usuario** — `readLine(stdin)` lee una línea desde la entrada estándar.
3. **Variables y concatenación** — `var name: string` declara una variable con tipo explícito, y `echo` separa sus argumentos con espacios.

**EN:** This program introduces three new concepts compared to `helloworld`:

1. **Writing without newline** — `stdout.write` prints the prompt leaving the cursor on the same line.
2. **User input** — `readLine(stdin)` reads a line from standard input.
3. **Variables and concatenation** — `var name: string` declares a variable with an explicit type, and `echo` separates its arguments with spaces.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p nim/core/foundations/hellouser
   ```

2. Escribir el archivo `hellouser.nim` con el código fuente.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. El compilador (`nim`) se invoca directamente desde línea de comandos.

**ES:** El flujo del programa es:

1. Imprimir `"Enter your name: "` con `stdout.write` (sin salto de línea).
2. Leer una línea desde `stdin` con `readLine(stdin)`.
3. Imprimir `"Hello, <nombre>!"` con `echo` (une los argumentos con espacios).

**EN:** Program flow:

1. Print `"Enter your name: "` with `stdout.write` (no newline).
2. Read a line from `stdin` with `readLine(stdin)`.
3. Print `"Hello, <name>!"` with `echo` (joins arguments with spaces).

```nim
stdout.write("Enter your name: ")
var name: string = readLine(stdin)
echo "Hello, ", name, "!"
```

| Elemento | Propósito |
|----------|-----------|
| `stdout.write(...)` | Imprime en la salida estándar **sin** salto de línea al final (el cursor permanece junto al prompt). |
| `readLine(stdin)` | Lee una línea desde la entrada estándar (sin el salto de línea final). |
| `var name: string` | Variable mutable con tipo explícito; Nim también puede inferirlo con `var name = readLine(stdin)`. |
| `echo "Hello, ", name, "!"` | Imprime sus argumentos separados por espacios y añade el salto de línea final. |

> **ES:** En Nim, `echo` siempre añade un salto de línea al final; por eso el prompt usa `stdout.write`, que no lo añade.
> **EN:** In Nim, `echo` always appends a newline at the end; that's why the prompt uses `stdout.write`, which does not.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Nim instalado

```bash
# Verificar instalación
nim --version
```

### Compilar y ejecutar en un paso (recomendado) / Compile & run in one step (recommended)

```bash
cd nim/core/foundations/hellouser
nim r hellouser.nim
```

### Compilar y ejecutar por separado / Compile & run separately

```bash
cd nim/core/foundations/hellouser
nim c hellouser.nim
./hellouser
```

### Salida esperada / Expected output

```text
Enter your name: Ada
Hello, Ada!
```

> **ES:** El programa espera a que el usuario escriba su nombre y presione Enter antes de mostrar el saludo.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Nim no exige un `main`: el código de nivel superior actúa como punto de entrada.
- **EN:** Nim does not require a `main`: top-level code acts as the entry point.
- **ES:** `stdout.write` no añade salto de línea, a diferencia de `echo` (que sí lo añade).
- **EN:** `stdout.write` does not append a newline, unlike `echo` (which does).

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
