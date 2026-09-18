# Naive Sort — Nim

Implementación de la especificación [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) en **Nim (2.0+)**, con **Nimble** como gestor de paquetes y **unittest** (biblioteca estándar) como framework de pruebas unitarias.

Tres algoritmos de ordenación con coste $O(n^2)$: **selection sort**, **bubble sort** e **insertion sort**, todos ordenando de forma ascendente el array recibido, sin bibliotecas de ordenamiento ni estructuras auxiliares.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`naive_sort.nimble`](naive_sort.nimble) | Manifiesto de Nimble — declara el paquete y la tarea `test` (compila y ejecuta la suite). |
| [`.gitignore`](.gitignore) | Ignora el binario generado por la compilación de los tests. |
| [`src/naive_sort.nim`](src/naive_sort.nim) | Módulo `naive_sort` — 3 procedimientos exportados. |
| [`test/naive_sort_tests.nim`](test/naive_sort_tests.nim) | Suite única: 3 tests (7 casos cada uno). |
| [`test/config.nims`](test/config.nims) | Añade `src/` al `--path` para resolver `import naive_sort`. |

**Estructura de directorios esperada:**

```text
naive_sort/
├── naive_sort.nimble            # Manifiesto de Nimble
├── .gitignore                   # Ignora el binario de los tests
├── src/
│   └── naive_sort.nim           # selectionSort, bubbleSort, insertionSort
└── test/
    ├── config.nims              # path a src/
    └── naive_sort_tests.nim     # 3 tests, 7 casos cada uno
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Sigue el mismo patrón que [`numbers`](../../foundations/numbers/) y [`calculator`](../../foundations/unit_test/calculator/): paquete de Nimble + `unittest`, con layout `src/` + `test/`. Los tres procedimientos se exportan con `*` y operan sobre el mismo `seq[int]` que reciben.

**EN:** Follows the same pattern as [`numbers`](../../foundations/numbers/) and [`calculator`](../../foundations/unit_test/calculator/): a Nimble package + `unittest`, with a `src/` + `test/` layout. All three procedures are exported with `*` and operate on the same `seq[int]` they receive.

**Combinación aplicada:** algoritmo iterativo (la especificación no usa recursión) → **1 suite × 3 tests = 3 tests (21 casos)**.

**Applied combination:** iterative algorithm (the specification uses no recursion) → **1 suite × 3 tests = 3 tests (21 cases)**.

### Inicialización / Initialization

**ES:** El proyecto se inició con `nimble init` y después se reestructuró para alinearlo con `numbers/`: se pasó de `tests/` a `test/`, se eliminó el submódulo de ejemplo `src/naive_sort/submodule.nim` y el `proc add*` de muestra, se sustituyeron los valores por defecto del manifiesto (versión `0.1.0`, autor `yorche3`, licencia GPL, sin tarea `test`) por los de la convención y se añadió el `.gitignore` del módulo.

**EN:** The project was started with `nimble init` and then restructured to align with `numbers/`: `tests/` became `test/`, the example submodule `src/naive_sort/submodule.nim` and the sample `proc add*` were removed, the manifest defaults (version `0.1.0`, author `yorche3`, GPL license, no `test` task) were replaced with the conventional ones, and the module `.gitignore` was added.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `naive_sort.nimble` — Manifiesto de Nimble

**ES:** Declara el paquete (versión 1.0.0, `srcDir = "src"`), la dependencia `nim >= 2.0.0` y la tarea `test` que compila y ejecuta la suite.

**EN:** Declares the package (version 1.0.0, `srcDir = "src"`), the `nim >= 2.0.0` dependency, and the `test` task that compiles and runs the suite.

```nim
version       = "1.0.0"
author        = "yorche"
description   = "Elementary sorting algorithms (selection, bubble, insertion)."
license       = "MIT"
srcDir        = "src"

requires "nim >= 2.0.0"

task test, "Run the unit tests":
    exec "nim c -r test/naive_sort_tests.nim"
```

### `src/naive_sort.nim` — Implementación

**ES:** Las tres funciones reciben el array como `var seq[int]` y devuelven ese mismo `seq`, ya ordenado. Extracto de `selectionSort`:

**EN:** All three functions take the array as `var seq[int]` and return that same `seq`, already sorted. Excerpt from `selectionSort`:

```nim
proc selectionSort*(arr: var seq[int]): seq[int] =
  let n = arr.len
  if n < 1:
    return arr
  for i in 0..<n-1:
    var minIndex = i
    for j in i+1..<n:
      if arr[j] < arr[minIndex]:
        minIndex = j
    if minIndex != i:
      let temp = arr[i]
      arr[i] = arr[minIndex]
      arr[minIndex] = temp
  return arr
```

### `test/naive_sort_tests.nim` — Suite de pruebas

**ES:** Una única suite con un `test` por función. Los 7 casos viven en una lista de constantes compartida y un único helper los recorre para cualquier función:

**EN:** A single suite with one `test` per function. The 7 cases live in a shared list of constants and a single helper walks them for any function:

```nim
template assertSortsAllCases(sort: SortProc, algorithm: string) =
    for sortCase in cases:
        let expected = sortCase.expected
        var actual = copyArray(sortCase.input)
        checkpoint algorithm & " should sort " & sortCase.description
        check sort(actual) == expected
```

**ES:** El archivo empieza con `import naive_sort`, que resuelve gracias al `switch("path", ...)` de `test/config.nims`, igual que en `numbers/`.

**EN:** The file starts with `import naive_sort`, resolved thanks to the `switch("path", ...)` in `test/config.nims`, exactly like `numbers/`.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Nim 2.0+** (`nim`).
- **Nimble** (`nimble`).

```bash
nim --version
nimble --version
```

### Verificación estática / Static check

**ES:** Nim incluye el verificador semántico en el propio compilador: `nim check` analiza el archivo sin generar binario y reporta errores y avisos.

**EN:** Nim ships its semantic checker inside the compiler itself: `nim check` analyses the file without producing a binary and reports errors and warnings.

```bash
cd nim/core/algorithms/naive_sort
nim check src/naive_sort.nim
nim check test/naive_sort_tests.nim
```

### Ejecutar las pruebas unitarias / Run tests

```bash
cd nim/core/algorithms/naive_sort
nimble test
```

### Alternativa sin Nimble / Alternative without Nimble

```bash
cd nim/core/algorithms/naive_sort
nim c -r test/naive_sort_tests.nim
```

### Salida esperada / Expected output

```text
[Suite] naive_sort
  [OK] selection_sort
  [OK] bubble_sort
  [OK] insertion_sort
```

> **ES:** 3 tests en total (uno por algoritmo); los 21 casos viven como `check` dentro de ellos (7 por algoritmo), todos pasando.
> **EN:** 3 tests in total (one per algorithm); the 21 cases live as `check`s within them (7 per algorithm), all passing.

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Algoritmo | Función | Entrada ordenada | Entrada invertida |
|-----------|---------|:----------------:|:-----------------:|
| Selection sort | `selectionSort` | $O(n^2)$ | $O(n^2)$ |
| Bubble sort | `bubbleSort` | $O(n)$ (salida temprana) | $O(n^2)$ |
| Insertion sort | `insertionSort` | $O(n)$ | $O(n^2)$ |

**ES:** Los tres algoritmos operan **in-place** sobre el `seq` recibido; no se crea ninguna estructura auxiliar.

**EN:** All three algorithms operate **in-place** on the received `seq`; no auxiliary structure is created.

### Casos cubiertos / Covered cases

| # | Entrada | Salida esperada |
|:-:|---------|-----------------|
| 1 | `@[5, 2, 9, 1, 5, 6]` | `@[1, 2, 5, 5, 6, 9]` |
| 2 | `@[1, 2, 3, 4, 5]` | `@[1, 2, 3, 4, 5]` |
| 3 | `@[5, 4, 3, 2, 1]` | `@[1, 2, 3, 4, 5]` |
| 4 | `@[7, 7, 7, 7]` | `@[7, 7, 7, 7]` |
| 5 | `@[3, -1, 4, -5, 0]` | `@[-5, -1, 0, 3, 4]` |
| 6 | `@[42]` | `@[42]` |
| 7 | `@[]` | `@[]` |

**ES:** Son los 7 casos obligatorios de la especificación. El **caso nulo se omite** (ver la nota correspondiente).

**EN:** These are the 7 mandatory cases from the specification. The **null case is omitted** (see the corresponding note).

---

## 📝 Notas de implementación / Implementation Notes

### 🧬 Ordenamiento *in-place* / In-place sorting

**ES:** Los tres procedimientos reciben el array como `var seq[int]`, lo reordenan en el sitio y devuelven ese mismo `seq`. Los tests aíslan cada caso copiando la entrada con un helper local `copyArray`, de modo que un caso no contamine los siguientes.

**EN:** All three procedures take the array as `var seq[int]`, reorder it in place and return that same `seq`. The tests isolate each case by copying the input with a local `copyArray` helper, so one case cannot contaminate the next.

### 🚫 Caso nulo omitido / Null case omitted

**ES:** La especificación pide devolver un indicador de fallo si la entrada es nula. En Nim 2.2 **`seq[int]` no admite `nil`** (`var s: seq[int] = nil` es un error de tipo: `got 'typeof(nil)' for 'nil' but expected 'seq[int]'`), así que una entrada nula **no es representable** en la firma y no hay indicador de fallo que comprobar. La representación alternativa que pide la especificación (`Option`/`Maybe` vacío) queda fuera de alcance porque esta fase todavía no introduce ese tipo. La guarda `if n < 1: return arr` cubre el array vacío, que sí es representable, y se prueba como caso 7.

**EN:** The specification asks for a failure indicator when the input is null. In Nim 2.2 **`seq[int]` does not accept `nil`** (`var s: seq[int] = nil` is a type error: `got 'typeof(nil)' for 'nil' but expected 'seq[int]'`), so a null input **is not representable** in the signature and there is no failure indicator to check. The alternative representation the specification mentions (empty `Option`/`Maybe`) is out of scope because this phase does not introduce that type yet. The `if n < 1: return arr` guard covers the empty array, which is representable, and it is tested as case 7.

### 🔁 Intercambios con una variable temporal / Swaps via a temporary variable

**ES:** Los dos intercambios (`selectionSort` y `bubbleSort`) usan una `let temp` explícita en lugar de asignación múltiple, porque Nim solo admite la forma con paréntesis (`(a, b) = (b, a)`) y el intercambio paso a paso es el que describe el pseudocódigo.

**EN:** Both swaps (`selectionSort` and `bubbleSort`) use an explicit `let temp` instead of multiple assignment, because Nim only accepts the parenthesised form (`(a, b) = (b, a)`) and the step-by-step swap is the one the pseudocode describes.

### 🔁 La bandera `swapped` con `break` / The `swapped` flag with `break`

**ES:** `bubbleSort` mantiene la bandera `swapped` que exige la especificación: si una pasada completa no realiza ningún intercambio, el array ya está ordenado y el bucle se corta con `if not swapped: break`. Es lo que convierte el mejor caso en $O(n)$.

**EN:** `bubbleSort` keeps the `swapped` flag required by the specification: if a full pass performs no swap, the array is already sorted and the loop is cut with `if not swapped: break`. This is what makes the best case $O(n)$.

### ➿ Cotas de los bucles / Loop bounds

**ES:** Las cotas reproducen las del pseudocódigo usando rangos semiabiertos de Nim (`0..<n-1`, `i+1..<n`, `0..<n-i-1`), que ya excluyen el extremo superior. No hay desplazamientos manuales con `-1` ni `+1` que justificar.

**EN:** The bounds reproduce the pseudocode's using Nim's half-open ranges (`0..<n-1`, `i+1..<n`, `0..<n-i-1`), which already exclude the upper end. There are no manual `-1`/`+1` offsets to justify.

### 🔀 Estabilidad de `insertionSort` / `insertionSort` stability

**ES:** El bucle interno se detiene con la comparación estricta `arr[j] > key`; los elementos iguales no se desplazan, por lo que `insertionSort` es estable. El caso 1 (`@[5, 2, 9, 1, 5, 6]`, con dos cincos) se beneficia de ello, aunque la comparación de los tests se hace sobre valores y no sobre identidad.

**EN:** The inner loop stops on the strict comparison `arr[j] > key`; equal elements do not shift, so `insertionSort` is stable. Case 1 (`@[5, 2, 9, 1, 5, 6]`, with two fives) benefits from it, although the tests compare values rather than identity.

### 🏷️ Naming y visibilidad / Naming and visibility

**ES:** Los procedimientos usan `camelCase` (`selectionSort`), que es la convención de Nim, mientras que la especificación los nombra en `snake_case` (`selection_sort`). El nombre de la especificación se conserva como **nombre del test**, de forma que el reporte sigue mostrando `selection_sort`, `bubble_sort` e `insertion_sort`. Los tres procedimientos se exportan con `*`.

**EN:** Procedures use `camelCase` (`selectionSort`), which is Nim's convention, while the specification names them in `snake_case` (`selection_sort`). The specification name is preserved as the **test name**, so the report still shows `selection_sort`, `bubble_sort` and `insertion_sort`. All three procedures are exported with `*`.

### 🧪 Estructura de los tests / Test structure

**ES:** Una única suite con 3 tests. Tres detalles importantes: (1) el helper es una **plantilla** y no un `proc`, para que el `check` quede dentro del bloque `test` y unittest marque el test como `[FAILED]` (un `check` dentro de un `proc` imprime el fallo pero el test aparece como `[OK]`); (2) `checkpoint` antepone el mensaje del contrato (`"{algorithm} should sort an unsorted array"`) a la salida del fallo, porque `check` no admite un mensaje propio; (3) los casos se copian con `copyArray` antes de pasarlos al algoritmo, ya que los fixtures son constantes compartidas y los procedimientos ordenan in-place.

**EN:** A single suite with 3 tests. Three important details: (1) the helper is a **template** rather than a `proc`, so that `check` lands inside the `test` block and unittest marks the test as `[FAILED]` (a `check` inside a `proc` prints the failure but the test shows up as `[OK]`); (2) `checkpoint` prefixes the contract message (`"{algorithm} should sort an unsorted array"`) to the failure output, because `check` takes no message of its own; (3) the cases are copied with `copyArray` before being passed to the algorithm, since the fixtures are shared constants and the procedures sort in-place.

```nim
suite "naive_sort":
    test "selection_sort":
        assertSortsAllCases(naive_sort.selectionSort, "selection_sort")

    test "bubble_sort":
        assertSortsAllCases(naive_sort.bubbleSort, "bubble_sort")

    test "insertion_sort":
        assertSortsAllCases(naive_sort.insertionSort, "insertion_sort")
```

### 📍 Desviaciones respecto a la ubicación esperada / Deviations from the expected location

| Especificación | Implementación | Motivo |
|----------------|----------------|--------|
| `src/naive_sort.ext` | `src/naive_sort.nim` | El nombre coincide exactamente; solo cambia la extensión. |
| `test/naive_sort_test.ext` | `test/naive_sort_tests.nim` | La convención de `numbers/` para las suites es el sufijo plural `_tests.nim` (`recursive_tests.nim`, `iterative_tests.nim`). |
| `test/run_tests.ext` | *(no existe)* | Nimble ejecuta la suite con la tarea `test` del `.nimble`, que lanza `nim c -r`. Ni `numbers/` ni `calculator/` incluyen un runner propio. |

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

*[← Volver a Algoritmos Puros](../README.md) · [↑ Volver a Core](../../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
