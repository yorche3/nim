# Numbers — Nim

Implementación de la especificación [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) en **Nim**, usando **Nimble** como gestor de paquetes y **unittest** (biblioteca estándar) como framework de pruebas unitarias.

Tres enfoques de implementación para los mismos 5 algoritmos: **recursivo directo** (`Rec`), **recursivo con acumulador** (`Acc`) e **iterativo** (`Ite`).

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`numbers.nimble`](numbers.nimble) | Manifiesto de Nimble — declara el paquete y la tarea `test` (ejecuta las dos suites). |
| [`.gitignore`](.gitignore) | Ignora los binarios generados por la compilación de los tests. |
| [`src/numbers.nim`](src/numbers.nim) | Módulo `numbers` — 15 procedimientos (3 enfoques × 5 algoritmos) + 4 helpers privados (no exportados). |
| [`test/recursive_tests.nim`](test/recursive_tests.nim) | Suite recursiva: 5 tests (11 casos). |
| [`test/iterative_tests.nim`](test/iterative_tests.nim) | Suite iterativa: 5 tests (11 casos). |
| [`test/config.nims`](test/config.nims) | Añade `src/` al `--path` para resolver `import numbers`. |

**Estructura de directorios esperada:**

```text
numbers/
├── numbers.nimble               # Manifiesto de Nimble
├── .gitignore                   # Ignora los binarios de los tests
├── src/
│   └── numbers.nim              # 15 procedimientos + 4 helpers privados
└── test/
    ├── config.nims              # path a src/
    ├── recursive_tests.nim      # Tests recursivos (5 tests, 11 casos)
    └── iterative_tests.nim      # Tests iterativos (5 tests, 11 casos)
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Sigue el mismo patrón que [`calculator`](../unit_test/calculator/): paquete de Nimble + `unittest`, con layout `src/` + `test/`. Los 15 procedimientos se organizan en 3 grupos por enfoque:

| Enfoque | Sufijo | Ejemplo | ¿Tiene tests directos? |
| ------- | ------ | ------- | :---------------------: |
| Recursivo directo | `...Rec` | `fibonacciRec(n)` | ✅ Sí |
| Recursivo con acumulador | `...Acc` | `fibonacciAcc(n)` | ❌ No (ver nota TCO) |
| Iterativo | `...Ite` | `fibonacciIte(n)` | ✅ Sí |

**EN:** Follows the same pattern as [`calculator`](../unit_test/calculator/): a Nimble package + `unittest`, with a `src/` + `test/` layout. The 15 procedures are organized into 3 groups by approach:

| Approach | Suffix | Example | Direct tests? |
| -------- | ------ | ------- | :-----------: |
| Direct recursion | `...Rec` | `fibonacciRec(n)` | ✅ Yes |
| Accumulator recursion | `...Acc` | `fibonacciAcc(n)` | ❌ No (see TCO note) |
| Iterative | `...Ite` | `fibonacciIte(n)` | ✅ Yes |

**Combinación aplicada:** TCO ❌ + iteración ✅ → `_rec` + `_ite` = **2 suites × 5 tests = 10 tests (22 casos)**.

**Applied combination:** No TCO + iteration ✅ → `_rec` + `_ite` = **2 suites × 5 tests = 10 tests (22 cases)**.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `numbers.nimble` — Manifiesto de Nimble

**ES:** Declara el paquete (versión 1.0.0, `srcDir = "src"`), la dependencia `nim >= 2.0.0` y la tarea `test` que compila y ejecuta las dos suites.

**EN:** Declares the package (version 1.0.0, `srcDir = "src"`), the `nim >= 2.0.0` dependency, and the `test` task that compiles and runs both suites.

```nim
version       = "1.0.0"
author        = "yorche"
description   = "Numerical algorithms in three approaches (recursive, accumulator, iterative)."
license       = "MIT"
srcDir        = "src"

requires "nim >= 2.0.0"

task test, "Run the unit tests":
    exec "nim c -r test/recursive_tests.nim"
    exec "nim c -r test/iterative_tests.nim"
```

### `src/numbers.nim` — Implementación

**ES:** Cada algoritmo tiene 3 implementaciones en un único archivo. Los helpers del enfoque con acumulador **no se exportan** (sin `*`), por lo que son privados del módulo. Por ejemplo, `fibonacci`:

**EN:** Each algorithm has 3 implementations in a single file. The accumulator helpers are **not exported** (no `*`), so they are private to the module. For example, `fibonacci`:

```nim
# Enfoque recursivo directo / Direct recursion
proc fibonacciRec*(n: int): int =
    if n <= 1:
        return n
    return fibonacciRec(n - 1) + fibonacciRec(n - 2)

# Enfoque con acumulador / Accumulator recursion
proc fibonacciAccHelp(n: int, acc2: int, acc1: int): int =
    if n <= 0:
        return acc2
    if n <= 2:
        return acc1 + acc2
    return fibonacciAccHelp(n - 1, acc1, acc1 + acc2)

proc fibonacciAcc*(n: int): int =
    fibonacciAccHelp(n, 0, 1)

# Enfoque iterativo / Iterative
proc fibonacciIte*(n: int): int =
    if n <= 1:
        return n
    var acc2 = 0
    var acc1 = 1
    for i in 2..n:
        let temp = acc1 + acc2
        acc2 = acc1
        acc1 = temp
    acc1
```

| Algoritmo | `Rec` | `Acc` | `Ite` |
| --------- | ----- | ----- | ----- |
| `sumOfFirstN` | `n + sumRec(n-1)` | helper con `acc + n` | bucle `1..n` |
| `factorial` | `n * factRec(n-1)` | helper con `acc * n` | bucle `2..n` |
| `fibonacci` | `fibRec(n-1) + fibRec(n-2)` | helper con `acc2, acc1` | bucle de intercambio |
| `greatestCommonDivisor` | Euclides recursivo | helper (Euclides) | Euclides con `while y != 0` |
| `leastCommonMultiple` | `(a*b) div gcdRec` | `(a*b) div gcdAcc` | `(a*b) div gcdIte` |

### Suites de pruebas — unittest

**ES:** Dos suites, una por enfoque probado. Cada suite agrupa un `test` por función (5 por suite); los 11 casos del pseudocódigo viven como `check` dentro de ellos (22 en total).

**EN:** Two suites, one per tested approach. Each suite groups one `test` per function (5 per suite); the specification pseudocode's 11 cases live as `check`s within them (22 in total).

```nim
suite "numbers recursive":
    test "fibonacciRec":
        check numbers.fibonacciRec(0) == 0
        check numbers.fibonacciRec(1) == 1
        check numbers.fibonacciRec(6) == 8
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
cd nim/core/foundations/numbers
nimble test
```

### Alternativa sin Nimble / Alternative without Nimble

```bash
cd nim/core/foundations/numbers
nim c -r test/recursive_tests.nim
nim c -r test/iterative_tests.nim
```

### Salida esperada / Expected output

```text
[Suite] numbers recursive
  [OK] sumOfFirstNRec
  [OK] factorialRec
  [OK] fibonacciRec
  [OK] greatestCommonDivisorRec
  [OK] leastCommonMultipleRec
[Suite] numbers iterative
  [OK] sumOfFirstNIte
  [OK] factorialIte
  [OK] fibonacciIte
  [OK] greatestCommonDivisorIte
  [OK] leastCommonMultipleIte
```

> **ES:** 10 tests en total (5 por suite); los 22 casos viven como `check` dentro de ellos, todos pasando.
> **EN:** 10 tests in total (5 per suite); the 22 cases live as `check`s within them, all passing.

---

## 🔁 Sobre recursión con acumulador y Tail Call Optimization (TCO)

**ES:**
Tail recursion ocurre cuando la llamada recursiva es la última acción que ejecuta una función; después de la llamada no hay más instrucciones. La recursión con acumulador consigue esto pasando el estado previo como parámetro, sin dejar trabajo pendiente en la pila.

En Nim, **no se garantiza TCO**: el lenguaje no garantiza la eliminación de llamadas de cola (aunque el compilador de C subyacente pueda optimizarlas en algunos casos con `-d:release`), por lo que una recursión suficientemente profunda desborda la pila. La versión con acumulador se conserva únicamente con fines educativos, como puente conceptual entre la recursión directa (`_rec`) y la versión iterativa (`_ite`). Como no hay un beneficio práctico de rendimiento garantizado, **no se desarrollan pruebas unitarias específicas para los procedimientos `_acc`**. Su comportamiento queda validado a través de las suites recursiva e iterativa, que ejercitan los mismos resultados.

**EN:**
Tail recursion occurs when the recursive call is the last action executed by a function; after the call there are no more instructions. Accumulator recursion achieves this by passing the previous state as a parameter, leaving no pending work on the stack.

In Nim, **TCO is not guaranteed**: the language does not guarantee tail-call elimination (although the underlying C compiler may optimize them in some cases with `-d:release`), so sufficiently deep recursion overflows the stack. The accumulator version is kept purely for educational purposes, as a conceptual bridge between direct recursion (`_rec`) and the iterative version (`_ite`). Since there is no guaranteed performance benefit, **no dedicated unit tests are written for the `_acc` procedures**. Their behavior is validated through the recursive and iterative suites, which exercise the same results.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** El proyecto no usa un `main`: el "punto de entrada" es el propio archivo de pruebas de `unittest`, ejecutado con `nim c -r` (directamente o vía `nimble test`). Por eso no se necesita el `run_tests` del pseudocódigo (la especificación lo pide solo si el framework no lo incluye).
- **EN:** The project has no `main`: the "entry point" is the `unittest` test file itself, run with `nim c -r` (directly or via `nimble test`). That's why the pseudocode's `run_tests` is not needed (the specification asks for it only if the framework doesn't include one).
- **ES:** Los helpers `_help` no se exportan (sin `*`), por lo que son privados del módulo.
- **EN:** The `_help` helpers are not exported (no `*`), so they are private to the module.
- **ES:** En Nim el operador `%` no existe para enteros: el resto se calcula con `mod`. Para el MCM se usa `div` (división entera), porque `/` devuelve `float`.
- **EN:** In Nim there is no `%` operator for integers: the remainder is computed with `mod`. For LCM, `div` (integer division) is used, because `/` returns `float`.
- **ES:** Solo se usa la biblioteca estándar: `unittest` viene incluido en Nim; no hay dependencias externas.
- **EN:** Only the standard library is used: `unittest` ships with Nim; there are no external dependencies.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
