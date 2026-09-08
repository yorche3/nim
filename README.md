# Nim

Proyectos en **Nim (2.0+)**, con programas simples compilados con `nim` y proyectos con pruebas unitarias gestionados con **Nimble** y el framework **unittest** (biblioteca estándar).

---

## 📂 Módulos / Modules

| Módulo | Descripción |
| ------ | ----------- |
| [`core/foundations/`](core/foundations/) | **Fase 0 — Fundamentos**: `helloworld`, `hellouser`, `unit_test/calculator`, `numbers` |

---

## ▶️ Comenzar / Getting Started

```bash
# Hello, World!
cd core/foundations/helloworld
nim r helloworld.nim

# Hello, User!
cd core/foundations/hellouser
nim r hellouser.nim

# Calculator Tests
cd core/foundations/unit_test/calculator
nimble test

# Numbers Tests
cd core/foundations/numbers
nimble test
```

---

## 📦 Requisitos / Requirements

| Herramienta | Instalación |
| ----------- | ----------- |
| [Nim 2.0+](https://nim-lang.org/install.html) | `choosenim` / `sudo apt install nim` (Linux) / [Descargar](https://nim-lang.org/install.html) |
| [Nimble](https://github.com/nim-lang/nimble) | Incluido con Nim; se instala junto al compilador |

```bash
# Verificar instalación
nim --version
nimble --version
```

---

## 🏗️ Tipos de proyecto / Project Types

### 1. Programa simple (compilación directa con `nim`)

**ES:** Un único archivo fuente, sin dependencias externas, compilado con `nim c` o ejecutado en un paso con `nim r`. Ideal para `helloworld` y `hellouser`. No requiere Nimble.

**EN:** A single source file, no external dependencies, compiled with `nim c` or run in one step with `nim r`. Ideal for `helloworld` and `hellouser`. No Nimble required.

```bash
nim r <File>.nim     # compila (en caché) y ejecuta
nim c <File>.nim     # compila a binario nativo y luego ./<File>
```

### 2. Proyecto con pruebas unitarias (Nimble + unittest)

**ES:** Para proyectos que requieren pruebas unitarias, se usa **Nimble** (manifiesto `.nimble` con tarea `test`) y **unittest**, el framework de pruebas incluido en la biblioteca estándar. El código fuente se organiza en `src/` y las pruebas en `test/` (con `config.nims` que añade `src/` al `--path`).

**EN:** For projects that require unit tests, **Nimble** (a `.nimble` manifest with a `test` task) and **unittest**, the test framework included in the standard library, are used. Source code goes in `src/` and tests in `test/` (with a `config.nims` that adds `src/` to `--path`).

```bash
nimble test                                    # ejecuta la tarea test del .nimble
nim c -r test/<suite>.nim                      # alternativa directa sin Nimble
```

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*