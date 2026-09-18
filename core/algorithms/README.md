# Algorithms Pure — Nim

Implementaciones de la [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-) en **Nim**: ordenamientos elementales, estructuras de datos propias, ordenamientos óptimos y distribuidos, y búsqueda.

Los módulos de esta fase trabajan sobre `seq[int]`, que en Nim **es mutable**, **se indexa desde 0** y **no admite `nil`**.

---

## 📂 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`naive_sort/`](naive_sort/) | [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) | `nimble test` + unittest | 3 | ✅ |

---

## 📁 Estructura / Structure

```text
algorithms/
└── naive_sort/                    # 05_Naive_Sort
    ├── naive_sort.nimble          # srcDir = "src" y task test
    ├── .gitignore                 # Ignora el binario de los tests
    ├── src/
    │   └── naive_sort.nim         # selectionSort, bubbleSort, insertionSort
    ├── test/
    │   ├── config.nims            # path a src/
    │   └── naive_sort_tests.nim   # 3 tests × 7 casos
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | Nim 2.0+ (compila a C y ejecuta el binario; sin máquina virtual) |
| **CLI** | `nimble test` |
| **Manifiesto** | `{modulo}.nimble` — `version`, `author`, `license`, `srcDir = "src"`, `requires "nim >= 2.0.0"` y `task test` |
| **Framework de tests** | `unittest`, de la biblioteca estándar (`suite`/`test`/`check`/`checkpoint`) |
| **Verificación estática** | `nim check`, el verificador semántico del propio compilador |
| **Runner** | La tarea `test` del `.nimble`, que lanza `nim c -r test/{modulo}_tests.nim` |
| **Separación** | `src/{Modulo}.nim` (módulo) ↔ `test/` (suites `*_tests.nim`) |
| **Acceso al módulo** | `switch("path", "$projectDir/../src")` en `test/config.nims`, que permite `import {modulo}` sin flags |
| **Iteración** | Bucles `for`/`while` nativos sobre `seq[int]` |
| **Indexación** | **0-based**, como el pseudocódigo |
| **Visibilidad** | `proc nombre*` exporta; sin `*` el procedimiento queda privado del módulo |
| **Naming** | `camelCase` para procedimientos (`selectionSort`); el nombre de la especificación se conserva como nombre del test |
| **Mutabilidad** | El array se recibe como `var seq[int]`, así que la ordenación es in-place; con ARC, asignar un `seq` a otro **copia** el búfer |
| **Nulabilidad** | `seq[int]` no admite `nil`; el caso nulo no es representable y se omite |
| **Intercambios** | Con `let temp` explícita: Nim solo admite multiasignación entre paréntesis |
| **Artefactos** | El binario del test (ignorado por el `.gitignore` del módulo), `nimcache/` y `nimblecache/` (ignorados por la raíz de `nim/`) |

---

## 🚀 Compilación rápida / Quick Build

```bash
# Naive Sort Tests
cd naive_sort
nimble test
```

---

## ▶️ Siguiente / Next

👉 Continúa con los módulos pendientes de esta fase en el [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).
👉 Continue with the pending modules of this phase in the [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).

---

*[← Volver a Core](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
