# Hello, World! — Nim

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **Nim**, con un enfoque manual y minimalista.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`helloworld.nim`](helloworld.nim) | Código fuente: imprime `"Hello, World! from Nim!"` en la salida estándar. |
| `helloworld` | Binario nativo generado por `nim c` (no versionado). |
| `nimcache/` | Caché de compilación generada por el compilador (ignorada en `.gitignore`). |

**Estructura de directorios esperada:**

```text
helloworld/
├── helloworld.nim   # Código fuente
├── helloworld       # Binario nativo (generado por nim c)
├── nimcache/        # Caché de compilación (generado, ignorado)
└── README.md        # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin herramientas de scaffolding. Nim compila a binario nativo (vía C), pero un único archivo `.nim` con una sola instrucción es suficiente. No se necesita `nimble` ni un archivo de proyecto para programas de un solo archivo.

**EN:** The project was created manually, without scaffolding tools. Nim compiles to a native binary (via C), but a single `.nim` file with one statement is enough. Neither `nimble` nor a project file is needed for single-file programs.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p nim/core/foundations/helloworld
   ```

2. Escribir el archivo `helloworld.nim` con el código fuente.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración de build. El compilador (`nim`) se invoca directamente desde línea de comandos.

```nim
echo "Hello, World! from Nim!"
```

| Elemento | Propósito |
|----------|-----------|
| `echo "..."` | Imprime la cadena en la salida estándar con un salto de línea al final. |
| Código de nivel superior | Nim permite ejecutar instrucciones a nivel de archivo, sin necesidad de un procedimiento `main`. |

> **ES:** `echo` acepta múltiples argumentos y los separa con espacios. El salto de línea final lo añade automáticamente.
> **EN:** `echo` accepts multiple arguments and separates them with spaces. The trailing newline is added automatically.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Nim instalado

```bash
# Verificar instalación
nim --version
```

### Compilar y ejecutar en un paso (recomendado) / Compile & run in one step (recommended)

**ES:** `nim r` compila (en caché) y ejecuta el programa en un solo comando.

**EN:** `nim r` compiles (cached) and runs the program in a single command.

```bash
cd nim/core/foundations/helloworld
nim r helloworld.nim
```

### Compilar y ejecutar por separado / Compile & run separately

```bash
cd nim/core/foundations/helloworld
nim c helloworld.nim
./helloworld
```

> **ES:** Con `nim c` se genera el binario `helloworld` y la caché `nimcache/`. Para una compilación optimizada añade `-d:release`.
> **EN:** `nim c` generates the `helloworld` binary and the `nimcache/` cache. For an optimized build, add `-d:release`.

### Salida esperada / Expected output

```text
Hello, World! from Nim!
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Nim no exige un `main`: el código de nivel superior actúa como punto de entrada.
- **EN:** Nim does not require a `main`: top-level code acts as the entry point.
- **ES:** El compilador traduce Nim a C y luego a binario nativo, por lo que el ejecutable no necesita runtime externo.
- **EN:** The compiler translates Nim to C and then to a native binary, so the executable needs no external runtime.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
