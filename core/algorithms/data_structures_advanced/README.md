# Data Structures Advanced — Nim

Implementación de la especificación [07_Data_Structures_Advanced](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced/) en **Nim**, usando **Nimble** como gestor de paquetes y **unittest** (biblioteca estándar) como framework de pruebas unitarias.

**ES:** Estructuras que requieren múltiples enlaces por nodo: árbol binario de búsqueda (`BinaryTree`) y grafo dirigido (`Graph`), construidos manualmente sobre nodos derivados (`TreeNode`, `GraphNode`) que reutilizan la base `Node` mediante herencia de tipos.

**EN:** Structures that require multiple links per node: binary search tree (`BinaryTree`) and directed graph (`Graph`), built manually over derived nodes (`TreeNode`, `GraphNode`) that reuse the base `Node` via type inheritance.

---

## 📂 Archivos y estructura / Files & Structure

Describe la estructura del proyecto y el propósito de cada archivo.

| Archivo / Directory | Propósito / Purpose |
|---|---|
| [`data_structures_advanced.nimble`](data_structures_advanced.nimble) | Manifiesto de Nimble — declara el paquete, dependencias y tarea `test` / Nimble manifest — declares package, dependencies, and `test` task |
| [`.gitignore`](.gitignore) | Archivos generados excluidos (binarios de tests y compilados) / Ignored generated files (test and compiled binaries) |
| [`src/data_structures_advanced.nim`](src/data_structures_advanced.nim) | Código fuente principal: tipos `Node`, `TreeNode`, `BinaryTree`, `GraphNode`, `Graph` y operaciones / Main source code: types `Node`, `TreeNode`, `BinaryTree`, `GraphNode`, `Graph` and operations |
| [`tests/data_structures_advanced_tests.nim`](tests/data_structures_advanced_tests.nim) | Suite de pruebas unitarias: 3 suites (`TreeNode`, `BinaryTree`, `Graph`) con 23 tests / Unit test suite: 3 suites (`TreeNode`, `BinaryTree`, `Graph`) with 23 tests |
| [`tests/config.nims`](tests/config.nims) | Configuración de NimScript para resolver imports desde `src/` / NimScript configuration to resolve imports from `src/` |

**Estructura de directorios / Directory layout:**

```text
data_structures_advanced/
├── data_structures_advanced.nimble        # Manifiesto de Nimble
├── .gitignore                             # Ignora binarios generados
├── src/
│   └── data_structures_advanced.nim       # 5 estructuras y sus operaciones
└── tests/
    ├── config.nims                        # Path hacia src/
    └── data_structures_advanced_tests.nim  # 23 tests en 3 suites
```

**Nota de desviación / Deviation note:**
**ES:** La especificación propone `test/` con `data_structures_advanced_test.ext` y `run_tests.ext`. Siguiendo las convenciones idiomáticas de Nim y Nimble, se utiliza la carpeta `tests/` con `data_structures_advanced_tests.nim` y `config.nims`, ejecutada directamente mediante `nimble test` (o `nim c -r`).
**EN:** The specification proposes `test/` with `data_structures_advanced_test.ext` and `run_tests.ext`. Following idiomatic Nim and Nimble conventions, the `tests/` folder with `data_structures_advanced_tests.nim` and `config.nims` is used, executed directly via `nimble test` (or `nim c -r`).

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Paquete de Nimble + `unittest`, con layout estándar `src/` + `tests/`. La base `Node` almacena únicamente el valor entero (`value: int`) sin enlaces ni validaciones (`ref object of RootObj`). `TreeNode` y `GraphNode` heredan de `Node` (`ref object of Node`), reutilizando el campo de valor por herencia de tipos. `BinaryTree` y `Graph` son tipos de valor (`object`) cuyos constructores (`initBinaryTree()`, `initGraph()`) inicializan estructuras vacías sin límites contractuales de capacidad ni arrays de índices preasignados. Tanto el registro global de vértices como las listas de adyacencia de vecinos se construyen manualmente mediante listas enlazadas propias (`nextVertex` y `NeighborNode`), garantizando complejidad `O(V)` en búsqueda de vértices y `O(d(u))` en adyacencia ordenada sin delegar en diccionarios ni tablas hash de biblioteca.

**EN:** Nimble package + `unittest`, with standard `src/` + `tests/` layout. The `Node` base stores only the integer value (`value: int`) with no links or validations (`ref object of RootObj`). `TreeNode` and `GraphNode` inherit from `Node` (`ref object of Node`), reusing the value field through type inheritance. `BinaryTree` and `Graph` are value types (`object`) whose constructors (`initBinaryTree()`, `initGraph()`) initialize empty structures without contractual capacity limits or preallocated index arrays. Both the global vertex registry and neighbor adjacency lists are constructed manually via custom linked lists (`nextVertex` and `NeighborNode`), ensuring `O(V)` vertex lookup and `O(d(u))` sorted adjacency without delegating to library dictionaries or hash tables.

---

## 📄 Configuración clave / Key Configuration

### `data_structures_advanced.nimble` — Manifiesto de Nimble

**ES:** Declara el paquete (versión `0.1.0`, `srcDir = "src"`), la dependencia `nim >= 2.2.10` y la tarea `test` que ejecuta la suite unitaria.

**EN:** Declares the package (version `0.1.0`, `srcDir = "src"`), the `nim >= 2.2.10` dependency, and the `test` task that executes the unit test suite.

```nim
version       = "0.1.0"
author        = "yorche3"
description   = "Advanced data structures (binary search tree and directed graph)"
license       = "MIT"
srcDir        = "src"

requires "nim >= 2.2.10"
task test, "Run the unit tests":
    exec "nim c -r tests/data_structures_advanced_tests.nim"
```

### `tests/config.nims` — Configuración de compilación de pruebas

**ES:** Añade la carpeta `../src` a la ruta de búsqueda de módulos de Nim para resolver `import data_structures_advanced` desde `tests/`.

**EN:** Adds `../src` to Nim's module search path to resolve `import data_structures_advanced` from `tests/`.

```nim
switch("path", "$projectDir/../src")
```

---

## 🚀 Compilación y ejecución / Build & Run

```bash
nimble test
```

Alternativa sin Nimble / Alternative without Nimble:

```bash
nim c -r tests/data_structures_advanced_tests.nim
```

**Salida real / Actual output:**

```text
      Info: using ~/.nimble/pkgs2/nim-2.4.2-ca3c55dbfc8144af6b6ff0b3ff9a075959374e7c/bin/nim for compilation
  Executing task test in ~/programming_languages/nim/core/algorithms/data_structures_advanced/data_structures_advanced.nimble
Hint: used config file '~/.nimble/pkgs2/nim-2.4.2-ca3c55dbfc8144af6b6ff0b3ff9a075959374e7c/config/nim.cfg' [Conf]
Hint: used config file '~/.nimble/pkgs2/nim-2.4.2-ca3c55dbfc8144af6b6ff0b3ff9a075959374e7c/config/config.nims' [Conf]
Hint: used config file '~/programming_languages/nim/core/algorithms/data_structures_advanced/tests/config.nims' [Conf]
....................................................................................................................................
Hint: codegen mm: orc; threads: on; opt: none (DEBUG BUILD, `-d:release` generates faster code)
75069 lines; 0.633s; 110.402MiB peakmem; proj: ~/programming_languages/nim/core/algorithms/data_structures_advanced/tests/data_structures_advanced_tests.nim; out: ~/.cache/nim/data_structures_advanced_tests_d [SuccessX]
Hint:  [Link]
Hint: mm: orc; threads: on; opt: none (DEBUG BUILD, `-d:release` generates faster code)
21721 lines; 0.853s; 24.754MiB peakmem; proj: ~/programming_languages/nim/core/algorithms/data_structures_advanced/tests/data_structures_advanced_tests.nim; out: ~/programming_languages/nim/core/algorithms/data_structures_advanced/tests/data_structures_advanced_tests [SuccessX]
Hint: ~/programming_languages/nim/core/algorithms/data_structures_advanced/tests/data_structures_advanced_tests [Exec]

[Suite] TreeNode
  [OK] Create a tree node
  [OK] Absent initial links
  [OK] Link two children
  [OK] Traverse each link
  [OK] Unlink children

[Suite] BinaryTree
  [OK] Create empty
  [OK] Insert the root
  [OK] Insert lower and higher
  [OK] Multilevel branches
  [OK] Missing value in nonempty tree
  [OK] Idempotent duplicate
  [OK] Ordered insertions

[Suite] Graph
  [OK] Create empty
  [OK] Isolated vertex
  [OK] Nonconsecutive labels and directed edge
  [OK] Duplicate vertex preserves adjacency
  [OK] Duplicate edge
  [OK] Missing endpoint without mutation
  [OK] Sorted neighbours and counts
  [OK] Missing-edge query
  [OK] Neighbours of missing vertex
  [OK] Self-loop and duplicate
  [OK] Neighbour-result isolation
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `getValue(node)` | `Node → int` | `O(1)` | Accede al valor almacenado en la base `Node`; heredado por `TreeNode` y `GraphNode`. / Reads value in base `Node`; inherited by `TreeNode` and `GraphNode`. |
| `newTreeNode(value)` | `int → TreeNode` | `O(1)` | Constructor de nodo de árbol con enlaces `left` y `right` en `nil`. / Tree node constructor with initial `nil` links. |
| `getLeft(node)` | `TreeNode → TreeNode` | `O(1)` | Devuelve enlace izquierdo o `nil` si ausente. / Returns left link or `nil` if absent. |
| `getRight(node)` | `TreeNode → TreeNode` | `O(1)` | Devuelve enlace derecho o `nil` si ausente. / Returns right link or `nil` if absent. |
| `setLeft(node, child)` | `TreeNode, TreeNode → void` | `O(1)` | Modifica enlace izquierdo en el sitio. / Modifies left link in-place. |
| `setRight(node, child)` | `TreeNode, TreeNode → void` | `O(1)` | Modifica enlace derecho en el sitio. / Modifies right link in-place. |
| `initBinaryTree()` | `void → BinaryTree` | `O(1)` | Inicializa árbol vacío con `root = nil` y `count = 0`. / Initializes empty tree with `root = nil` and `count = 0`. |
| `insert(tree, value)` | `var BinaryTree, int → bool` | `O(h)` | Inserta en el ABB; incrementa `count` solo si el valor es nuevo. Duplicados devuelven éxito idempotente sin mutar tamaño. / Inserts into BST; increments `count` only for new values. Duplicates return idempotent success without mutating size. |
| `contains(tree, value)` | `BinaryTree, int → bool` | `O(h)` | Búsqueda guiada por la invariante de orden del ABB; devuelve `true` si existe, `false` si no. / Guided search via BST order invariant; returns `true` if found, `false` otherwise. |
| `isEmpty(tree)` | `BinaryTree → bool` | `O(1)` | Comprueba si el árbol no tiene nodos (`count == 0`). / Checks whether the tree has no nodes (`count == 0`). |
| `size(tree)` | `BinaryTree → int` | `O(1)` | Devuelve la cantidad de nodos en el árbol. / Returns number of nodes in tree. |
| `initGraph()` | `void → Graph` | `O(1)` | Inicializa grafo dirigido vacío con registro de vértices nulo y contadores en cero. / Initializes empty directed graph with null vertex registry and zero counts. |
| `addVertex(graph, label)` | `var Graph, int → bool` | `O(V)` | Registra vértice si es nuevo; duplicados devuelven éxito conservando vecinos y contadores. / Registers vertex if new; duplicates return success preserving existing adjacency and counts. |
| `addEdge(graph, u, v)` | `var Graph, int, int → bool` | `O(V + d(u))` | Inserta arista dirigida `u → v` en orden creciente de vecinos; falla (`false`) si falta algún extremo. Admite bucles y aristas duplicadas idempotentes. / Adds directed edge `u → v` in sorted order; fails (`false`) if either endpoint is missing. Supports self-loops and duplicate edges. |
| `hasEdge(graph, u, v)` | `Graph, int, int → bool` | `O(V + d(u))` | Verifica existencia de arista dirigida `u → v`; devuelve `false` si no existe o falta algún extremo. / Checks existence of directed edge `u → v`; returns `false` if missing either endpoint or edge. |
| `getNeighbors(graph, u)` | `Graph, int → ref seq[int]` | `O(V + d(u))` | Copia independiente de la secuencia ordenada de vecinos. Devuelve `nil` si `u` no existe; devuelve secuencia vacía `@[]` si `u` está aislado. / Independent copy of sorted neighbors. Returns `nil` if `u` is missing; returns empty `@[]` if `u` is isolated. |
| `isEmpty(graph)` | `Graph → bool` | `O(1)` | Comprueba si el grafo no tiene vértices (`vertexTotal == 0`). / Checks whether graph has no vertices (`vertexTotal == 0`). |
| `vertexCount(graph)` | `Graph → int` | `O(1)` | Devuelve la cantidad de vértices registrados. / Returns count of registered vertices. |
| `edgeCount(graph)` | `Graph → int` | `O(1)` | Devuelve la cantidad de aristas dirigidas registradas. / Returns count of registered directed edges. |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Herencia real de tipo base (`TreeNode` y `GraphNode` heredan de `Node = ref object of RootObj`) | Valor embebido (composición sin tipo base) | Nim cuenta con soporte nativo de herencia para tipos por referencia (`ref object of Base`). `getValue` se define una sola vez sobre `Node` y aplica transparentemente a `TreeNode` y `GraphNode`, satisfaciendo la reutilización del valor sin duplicar código. |
| `BinaryTree` y `Graph` como `object` (semántica de valor) | `ref object` (semántica de referencia) | Son contenedores ligeros que encapsulan punteros a la raíz/registro y contadores. El uso de `object` con parámetros `var` en procedimientos mutadores hace explícita la mutación y evita sobrecargas de indirección en el heap. |
| `getNeighbors` devuelve `ref seq[int]` | `seq[int]` o centinela especial | En Nim `seq[T]` es un tipo valor no anulable donde `@[]` representa una secuencia vacía pero no puede ser `nil`. Como la especificación prohíbe `Option`/`Result` en esta fase, devolver `ref seq[int]` permite distinguir inequívocamente entre fallo por vértice ausente (`nil`) y éxito de un vértice aislado (secuencia vacía `@[]`). Además, al devolver una copia en el heap, aisla completamente el grafo de modificaciones externas del llamador. |
| Registro de vértices y listas de adyacencia manuales con enlace simple | Colecciones de biblioteca estándar (`Table`, `HashSet`, `seq` indexada) | La especificación prohíbe delegar el registro de vértices o la adyacencia en colecciones asociativas de biblioteca. `GraphNode.nextVertex` implementa el registro enlazado canónico con búsqueda `O(V)`, y `NeighborNode.next` implementa la adyacencia ordenada con inserción manual `O(d(u))`. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| Base `Node(value)` con valor y sin validaciones | `Node` como `ref object of RootObj` con `value: int` | Nim implementa herencia sobre `RootObj`. `TreeNode` y `GraphNode` heredan de `Node` sin duplicar el almacenamiento de valor y validando sus propios enlaces. |
| Constructores `newTreeNode(value)`, `initBinaryTree()`, `initGraph()` | Nombres idiomáticos de constructores | En Nim es convención usar el prefijo `new` para tipos por referencia (`ref object`) e `init` para inicializadores de tipos por valor (`object`). |
| Ausencia de enlaces en `TreeNode` | Representada mediante `nil` | `nil` es la representación nativa de referencia nula para `ref object` en Nim. |
| Indicador de fallo en `getNeighbors` | Devuelve `ref seq[int]` (`nil` si falta vértice, `@[]` si aislado) | Nim no permite `nil` en tipos valor `seq[int]`; `ref seq[int]` permite indicar ausencia nativa mediante `nil` respetando la prohibición de `Option`/`Result`. |
| Adaptación inmutable de `TreeNode` | No aplica: `TreeNode` es mutable | En Nim `TreeNode` es un `ref object` con mutación directa en el sitio vía `setLeft` y `setRight`. |
| Ubicación esperada: `test/data_structures_advanced_test.ext` | Ubicación real: `tests/data_structures_advanced_tests.nim` | Convención idiomática de Nim y Nimble: carpeta `tests/` con sufijo `_tests.nim`. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `BinaryTree.contains(tree, value)` | Valor ausente en el árbol | `false` | `contains(tree, 99) == false` |
| `Graph.addEdge(graph, u, v)` | Vértice origen `u` o destino `v` no registrado | `false` | `addEdge(graph, 10, 99) == false` |
| `Graph.hasEdge(graph, u, v)` | Arista ausente o alguno de los extremos no existe | `false` | `hasEdge(graph, 10, 99) == false` |
| `Graph.getNeighbors(graph, u)` | Vértice `u` no registrado | `nil` | `getNeighbors(graph, 99).isNil == true` |

---

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| **TreeNode**: Crear un nodo de árbol | Sí | `tests/data_structures_advanced_tests.nim:56-58` | `newTreeNode(10)`, `getValue == 10`. |
| **TreeNode**: Enlaces iniciales ausentes | Sí | `tests/data_structures_advanced_tests.nim:60-63` | `getLeft.isNil == true`, `getRight.isNil == true`. |
| **TreeNode**: Enlazar dos hijos | Sí | `tests/data_structures_advanced_tests.nim:65-70` | `setLeft`, `setRight`, verificación de `getValue` de hijos. |
| **TreeNode**: Recorrer cada enlace | Sí | `tests/data_structures_advanced_tests.nim:72-82` | Navegación a hijos y verificación de enlaces ausentes en nietos. |
| **TreeNode**: Desenlazar hijos | Sí | `tests/data_structures_advanced_tests.nim:84-95` | `setLeft(nil)`, `setRight(nil)`, conservación de valor y enlaces restantes. |
| **TreeNode**: Adaptación inmutable | Omitido | `tests/data_structures_advanced_tests.nim:15-17` | No aplica en Nim: `TreeNode` es un `ref object` mutable en el sitio. |
| **BinaryTree**: Crear vacío | Sí | `tests/data_structures_advanced_tests.nim:98-102` | `isEmpty == true`, `size == 0`, `contains(50) == false`. |
| **BinaryTree**: Insertar la raíz | Sí | `tests/data_structures_advanced_tests.nim:104-109` | `insert(50) == true`, `size == 1`, `isEmpty == false`, `contains(50) == true`. |
| **BinaryTree**: Insertar menor y mayor | Sí | `tests/data_structures_advanced_tests.nim:111-120` | Inserción de 50, 30, 70; `size == 3`, todos presentes. |
| **BinaryTree**: Ramas de varios niveles | Sí | `tests/data_structures_advanced_tests.nim:122-128` | Inserción de 50, 30, 70, 20, 40; `size == 5`, pertenencia de los 5. |
| **BinaryTree**: Valor ausente en árbol no vacío | Sí | `tests/data_structures_advanced_tests.nim:130-135` | `insert(50)`, `contains(99) == false`, `size == 1`, 50 presente. |
| **BinaryTree**: Duplicado idempotente | Sí | `tests/data_structures_advanced_tests.nim:137-146` | Inserción de 50, 30, 70, 30; `size == 3`, conserva los tres valores. |
| **BinaryTree**: Inserciones ordenadas | Sí | `tests/data_structures_advanced_tests.nim:148-155` | Inserción de 20, 30, 40, 50, 70; `size == 5`, pertenencia y ausencia de 99. |
| **Graph**: Crear vacío | Sí | `tests/data_structures_advanced_tests.nim:158-164` | `isEmpty == true`, `vertexCount == 0`, `edgeCount == 0`, `hasEdge` y `getNeighbors` fallan. |
| **Graph**: Vértice aislado | Sí | `tests/data_structures_advanced_tests.nim:166-173` | `addVertex(10)`, `vertexCount == 1`, `edgeCount == 0`, vecinos devuelven secuencia vacía `@[]`. |
| **Graph**: Etiquetas no consecutivas y arista dirigida | Sí | `tests/data_structures_advanced_tests.nim:175-183` | `addVertex(10, 70)`, `addEdge(10, 70)`; forward presente, reverse ausente, 2 vértices, 1 arista. |
| **Graph**: Vértice duplicado conserva adyacencia | Sí | `tests/data_structures_advanced_tests.nim:185-193` | `addVertex(10, 30)`, `addEdge(10, 30)`, `addVertex(10)`; vecinos `[30]` intactos, 2 vértices, 1 arista. |
| **Graph**: Arista duplicada | Sí | `tests/data_structures_advanced_tests.nim:195-203` | `addEdge(10, 30)` dos veces; idempotente, 2 vértices, 1 arista, vecinos `[30]`. |
| **Graph**: Extremo inexistente sin mutación | Sí | `tests/data_structures_advanced_tests.nim:205-223` | Cuatro intentos de aristas con extremos faltantes fallan; contadores y adyacencia intactos; consultas fallan. |
| **Graph**: Vecinos ordenados y contadores | Sí | `tests/data_structures_advanced_tests.nim:225-238` | Inserción desordenada `(10,70)`, `(10,30)`, `(10,50)`, `(30,50)`; vecinos ordenados `[30, 50, 70]`; 4 vértices, 4 aristas. |
| **Graph**: Consulta de arista ausente | Sí | `tests/data_structures_advanced_tests.nim:240-247` | Vértices 10 y 30 sin arista: `hasEdge(10, 30) == false`; 2 vértices, 0 aristas. |
| **Graph**: Vecinos de vértice inexistente | Sí | `tests/data_structures_advanced_tests.nim:249-255` | `getNeighbors(99)` falla (`nil`), distinguiéndose de vecinos vacíos de 10 (`@[]`). |
| **Graph**: Bucle y duplicado | Sí | `tests/data_structures_advanced_tests.nim:257-265` | `addEdge(10, 10)` dos veces; bucle presente, vecinos `[10]`, 1 vértice, 1 arista. |
| **Graph**: Aislamiento del resultado de vecinos | Sí | `tests/data_structures_advanced_tests.nim:267-283` | Modificar una copia devuelta (`ref seq[int]`) no altera el grafo ni la copia guardada; inserción posterior reflejada solo en consulta fresca. |

**Total: 23 tests ejecutados en 3 suites (`TreeNode`, `BinaryTree`, `Graph`), cubriendo 23 casos aplicables y 1 caso omitido justificado.**

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Ninguna / None | El módulo cumple íntegramente el contrato de la especificación: todas las operaciones, complejidades, invariantes e indicadores están implementados y verificados. / The module fully satisfies the specification contract: all operations, complexities, invariants, and indicators are implemented and verified. | — |

---

## 📝 Notas de implementación / Implementation Notes

**ES:** Nim distingue entre tipos por valor (`object`) y tipos por referencia en el heap (`ref object`). Los nodos (`TreeNode`, `GraphNode`, `NeighborNode`) se definen como `ref object` porque requieren mutabilidad compartida y enlaces entre instancias sin duplicar memoria. `TreeNode` y `GraphNode` reutilizan el campo de valor mediante herencia real de `Node` (`ref object of Node`), manteniendo la API polimórfica `getValue(node)`. Por su parte, `BinaryTree` y `Graph` son tipos `object` con parámetros `var` en los procedimientos mutadores (`insert`, `addVertex`, `addEdge`), haciendo explícita la modificación en el punto de llamada.

**EN:** Nim distinguishes between value types (`object`) and heap reference types (`ref object`). Nodes (`TreeNode`, `GraphNode`, `NeighborNode`) are defined as `ref object` because they require shared mutability and links across instances without copying memory. `TreeNode` and `GraphNode` reuse the value field via real inheritance from `Node` (`ref object of Node`), maintaining the polymorphic `getValue(node)` API. Meanwhile, `BinaryTree` and `Graph` are `object` types using `var` parameters on mutator procs (`insert`, `addVertex`, `addEdge`), making in-place mutation explicit at the call site.

**ES:** El registro de vértices se gestiona manualmente mediante el enlace simple `nextVertex` en `GraphNode`, y la adyacencia de cada vértice mediante `NeighborNode`. La inserción en la lista de adyacencia mantiene el orden creciente en tiempo `O(d(u))` durante `addEdge`, de modo que `getNeighbors` no necesita ordenar al consultar. Para respetar el contrato y la prohibición de `Option`/`Result`, `getNeighbors` devuelve `ref seq[int]`, distinguiendo entre un vértice no registrado (`nil`) y un vértice aislado existente (referencia a una secuencia vacía `@[]`). Además, al construir una nueva secuencia en cada llamada, se garantiza el aislamiento frente a mutaciones del llamador.

**EN:** The vertex registry is manually maintained via the `nextVertex` single link on `GraphNode`, and vertex adjacency via `NeighborNode`. Insertion into the adjacency list preserves ascending order in `O(d(u))` time during `addEdge`, so `getNeighbors` does not sort on read. To respect the contract and the phase prohibition on `Option`/`Result`, `getNeighbors` returns `ref seq[int]`, distinguishing between an unrecorded vertex (`nil`) and an existing isolated vertex (a reference to an empty sequence `@[]`). Furthermore, by allocating a fresh sequence on each call, caller mutation isolation is fully guaranteed.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_ (o `Omitido` con razón).
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe.
- [x] Ninguna sección repite lo que ya dice la especificación.

---

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`07_Data_Structures_Advanced.md`](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced/) |
| Primera base del lenguaje / First language reference | `data_structures_basics` — [`../data_structures_basics/`](../data_structures_basics/) |
| Segunda base del lenguaje / Second language reference | `numbers` — [`../../foundations/numbers/`](../../foundations/numbers/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](https://yorche3.github.io/programming_languages/core/00_Project_Initialization_Guide/) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](https://yorche3.github.io/programming_languages/docs/AGENT_Template/) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](https://yorche3.github.io/programming_languages/docs/WORKFLOW/) |
| Documentación oficial del lenguaje / Language official docs | [Nim Programming Language](https://nim-lang.org/docs/) |
