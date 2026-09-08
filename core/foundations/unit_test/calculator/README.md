# Calculator — Nim

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **Nim**, usando **Nimble** como gestor de paquetes y **unittest** (biblioteca estándar) como framework de pruebas unitarias.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`calculator.nimble`](calculator.nimble) | Manifiesto de Nimble — declara el paquete y la tarea `test`. |
| [`.gitignore`](.gitignore) | Ignora el binario generado por la compilación del test. |
| [`src/calculator.nim`](src/calculator.nim) | Módulo `calculator` con las 5 operaciones aritméticas (procedimientos exportados con `*`). |
| [`test/calculator_test.nim`](test/calculator_test.nim) | 5 pruebas unitarias con `suite`/`test` y `check`. |
| [`test/config.nims`](test/config.nims) | Añade `src/` al `--path` para resolver `import calculator`. |

**Estructura de directorios esperada:**

```text
calculator/
├── calculator.nimble           # Manifiesto de Nimble
├── .gitignore                  # Ignora el binario del test
├── src/
│   └── calculator.nim          # 5 operaciones aritméticas
└── test/
    ├── config.nims             # path a src/
    └── calculator_test.nim     # 5 tests con unittest
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa **Nimble** (manifiesto `.nimble` con tarea `test`) y **unittest**, el framework de pruebas de la biblioteca estándar de Nim:

1. `calculator` es un módulo con procedimientos exportados (el `*` tras el nombre).
2. Cada prueba usa `suite`/`test` y verifica con `check`.
3. `config.nims` agrega `src/` al `--path`, de modo que `import calculator` funciona sin pasos extra.
4. `multiplication`, `division` y `modulus` se implementan con las estrategias educativas de la especificación (sin usar los operadores `*`, `/` ni `mod` respectivamente).

**EN:** This project uses **Nimble** (a `.nimble` manifest with a `test` task) and **unittest**, Nim's standard-library test framework:

1. `calculator` is a module with exported procedures (the `*` after the name).
2. Each test uses `suite`/`test` and verifies with `check`.
3. `config.nims` adds `src/` to `--path`, so `import calculator` works with no extra steps.
4. `multiplication`, `division` and `modulus` are implemented with the educational strategies from the specification (without using the `*`, `/` or `mod` operators respectively).

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `calculator.nimble` — Manifiesto de Nimble

**ES:** Declara el paquete (versión 1.0.0, `srcDir = "src"`), la dependencia `nim >= 2.0.0` y la tarea `test` que compila y ejecuta la suite.

**EN:** Declares the package (version 1.0.0, `srcDir = "src"`), the `nim >= 2.0.0` dependency, and the `test` task that compiles and runs the suite.

```nim
version       = "1.0.0"
author        = "yorche"
description   = "Calculator with educational arithmetic implementations."
license       = "MIT"
srcDir        = "src"

requires "nim >= 2.0.0"

task test, "Run the unit tests":
    exec "nim c -r test/calculator_test.nim"
```

### `src/calculator.nim` — Módulo principal

| Operación | Implementación educativa |
| --------- | ------------------------ |
| `addition(a, b)` | Suma directa (`a + b`). |
| `subtraction(a, b)` | Resta directa (`a - b`). |
| `multiplication(a, b)` | Suma repetitiva: acumula `a`, `b` veces (no usa `*`). |
| `division(a, b)` | Resta repetitiva: resta `b` de `a` mientras `a >= b` (no usa `/`). |
| `modulus(a, b)` | Construida sobre `division` y `multiplication` (no usa `mod`). |

```nim
proc addition*(a, b: int): int =
    a + b

proc subtraction*(a, b: int): int =
    a - b

proc multiplication*(a, b: int): int =
    var result = 0
    for _ in 1..b:
        result = addition(result, a)
    result

proc division*(a, b: int): int =
    var remaining = a
    var quotient = 0
    while remaining >= b:
        remaining = subtraction(remaining, b)
        quotient = addition(quotient, 1)
    quotient

proc modulus*(a, b: int): int =
    let q = division(a, b)
    let p = multiplication(q, b)
    subtraction(a, p)
```

### `test/calculator_test.nim` — Pruebas unitarias (unittest)

**ES:** Un `test` por operación, con los mismos casos del pseudocódigo de la especificación.

**EN:** One `test` per operation, with the same cases as the specification pseudocode.

```nim
import unittest
import calculator

suite "calculator":
    test "addition(2, 3) returns 5":
        check addition(2, 3) == 5

    test "subtraction(5, 2) returns 3":
        check subtraction(5, 2) == 3

    test "multiplication(3, 4) returns 12":
        check multiplication(3, 4) == 12

    test "division(10, 3) returns 3":
        check division(10, 3) == 3

    test "modulus(10, 3) returns 1":
        check modulus(10, 3) == 1
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Nim 2.0+** (`nim`).
- **Nimble** (`nimble`).

```bash
nim --version
nimble --version
```

### Ejecutar las pruebas unitarias / Run tests

```bash
cd nim/core/foundations/unit_test/calculator
nimble test
```

### Alternativa sin Nimble / Alternative without Nimble

```bash
cd nim/core/foundations/unit_test/calculator
nim c -r test/calculator_test.nim
```

### Salida esperada / Expected output

```text
[Suite] calculator
  [OK] addition(2, 3) returns 5
  [OK] subtraction(5, 2) returns 3
  [OK] multiplication(3, 4) returns 12
  [OK] division(10, 3) returns 3
  [OK] modulus(10, 3) returns 1
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** El proyecto no usa un `main`: el "punto de entrada" es el propio archivo de pruebas de `unittest`, ejecutado con `nim c -r` (directamente o vía `nimble test`). Por eso no se necesita el `run_tests` del pseudocódigo (la especificación lo pide solo si el framework no lo incluye).
- **EN:** The project has no `main`: the "entry point" is the `unittest` test file itself, run with `nim c -r` (directly or via `nimble test`). That's why the pseudocode's `run_tests` is not needed (the specification asks for it only if the framework doesn't include one).
- **ES:** `division` no valida `b == 0` (fuera del alcance de este ejemplo, como indica la especificación).
- **EN:** `division` does not validate `b == 0` (out of scope for this example, as the specification states).
- **ES:** Solo se usa la biblioteca estándar: `unittest` viene incluido en Nim; no hay dependencias externas.
- **EN:** Only the standard library is used: `unittest` ships with Nim; there are no external dependencies.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
