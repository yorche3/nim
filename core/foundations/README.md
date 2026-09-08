# 🚀 Fundamentos / Foundations — Nim

Implementación de los ejercicios de la sección [Fundamentos / Foundations](https://yorche3.github.io/programming_languages/core/foundations/) del repositorio principal en **Nim (2.0+)**.

---

## 📖 Descripción / Description

**ES:** Esta sección reúne los conceptos esenciales para empezar a trabajar con **Nim**. Cubre desde los programas más básicos (`Hello, World!` y `Hello, User!`) hasta la implementación de una calculadora con pruebas unitarias y algoritmos numéricos en tres enfoques progresivos (recursivo directo, recursivo con acumulador e iterativo).

**EN:** This section brings together the essential concepts to start working with **Nim**. It covers everything from the most basic programs (`Hello, World!` and `Hello, User!`) to the implementation of a calculator with unit tests and numerical algorithms in three progressive approaches (direct recursion, accumulator recursion, and iterative).

---

## 📁 Estructura / Structure

```text
nim/
└── core/
    └── foundations/
        ├── README.md              # Este archivo / This file
        ├── helloworld/            # 01_Hello_World — Primer programa
        │   ├── helloworld.nim
        │   └── README.md
        ├── hellouser/             # 02_Hello_User — Entrada y salida
        │   ├── hellouser.nim
        │   └── README.md
        ├── unit_test/
        │   └── calculator/        # 03_Unit_Test_Calculator — Pruebas unitarias
        │       ├── calculator.nimble
        │       ├── src/
        │       │   └── calculator.nim
        │       ├── test/
        │       │   ├── config.nims
        │       │   └── calculator_test.nim
        │       └── README.md
        └── numbers/               # 04_Numbers — Algoritmos numéricos
            ├── numbers.nimble
            ├── src/
            │   └── numbers.nim
            ├── test/
            │   ├── config.nims
            │   ├── recursive_tests.nim
            │   └── iterative_tests.nim
            └── README.md
```

---

## 🔢 Progresión / Progression

| Especificación | Proyecto | Conceptos | Tests | Dependencias externas |
| -------------- | -------- | --------- | :---: | :-------------------: |
| [`01_Hello_World`](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) | [`helloworld/`](helloworld/) | `echo`, código de nivel superior, `nim c` / `nim r` | — | ❌ Solo stdlib |
| [`02_Hello_User`](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) | [`hellouser/`](hellouser/) | `stdout.write`, `readLine`, `var`, `echo` con argumentos | — | ❌ Solo stdlib |
| [`03_Unit_Test_Calculator`](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) | [`unit_test/calculator/`](unit_test/calculator/) | Nimble, `unittest`, `suite`/`test`, `check` | 5 | ❌ Solo stdlib |
| [`04_Numbers`](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) | [`numbers/`](numbers/) | Recursión, iteración, acumuladores, helpers privados, TCO | 10 | ❌ Solo stdlib |

---

## 🛠️ Enfoque general / General Approach

**ES:** Los proyectos en esta sección siguen un patrón progresivo:

1. **Hello World** y **Hello User**: Programas de un solo archivo, compilados con `nim c` o ejecutados con `nim r`, sin Nimble. Usan exclusivamente la biblioteca estándar.
2. **Calculator**: Primer proyecto con manifest de **Nimble** (`.nimble` con tarea `test`). Introduce la separación `src/` + `test/` y el framework `unittest` (incluido en la biblioteca estándar; no hay dependencias externas).
3. **Numbers**: Expande el patrón de Calculator a dos suites de prueba (una por enfoque probado). Nim **no garantiza TCO**, por lo que `_acc` se conserva como puente didáctico sin pruebas propias: `_rec` + `_ite` = 10 tests (22 casos).

**EN:** The projects in this section follow a progressive pattern:

1. **Hello World** and **Hello User**: Single-file programs, compiled with `nim c` or run with `nim r`, without Nimble. Use only the standard library.
2. **Calculator**: First project with a **Nimble** manifest (`.nimble` with a `test` task). Introduces the `src/` + `test/` separation and the `unittest` framework (included in the standard library; no external dependencies).
3. **Numbers**: Expands the Calculator pattern to two test suites (one per tested approach). Nim **does not guarantee TCO**, so `_acc` is kept as an educational bridge without dedicated tests: `_rec` + `_ite` = 10 tests (22 cases).

---

## 🚀 Ejecución rápida / Quick Start

### Hello World

```bash
cd nim/core/foundations/helloworld
nim r helloworld.nim
```

### Hello User

```bash
cd nim/core/foundations/hellouser
nim r hellouser.nim
```

### Calculator (pruebas)

```bash
cd nim/core/foundations/unit_test/calculator
nimble test
```

### Numbers (pruebas)

```bash
cd nim/core/foundations/numbers
nimble test
```

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
