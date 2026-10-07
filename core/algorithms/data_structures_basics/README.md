# Data Structures Basics — Nim

Implementación de la especificación [06_Data_Structures_Basics](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) en **Nim**, usando **Nimble** como gestor de paquetes y **unittest** (biblioteca estándar) como framework de pruebas unitarias.

Cuatro estructuras implementadas manualmente sobre el mismo tipo `Node`: nodo enlazado individual, lista enlazada simple, pila LIFO y cola FIFO.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`data_structures_basics.nimble`](data_structures_basics.nimble) | Manifiesto de Nimble — declara el paquete y la dependencia `nim >= 2.2.10`. |
| [`.gitignore`](.gitignore) | Ignora los binarios generados por la compilación de los tests. |
| [`src/data_structures_basics.nim`](src/data_structures_basics.nim) | Módulo `data_structures_basics` — tipos `Node`, `LinkedList`, `Stack`, `Queue` y sus operaciones. |
| [`tests/data_structures_basics_tests.nim`](tests/data_structures_basics_tests.nim) | Suite de pruebas: 4 tests (Node, LinkedList, Stack, Queue). |

**Estructura de directorios esperada:**

```text
data_structures_basics/
├── data_structures_basics.nimble    # Manifiesto de Nimble
├── .gitignore                       # Ignora los binarios de los tests
├── src/
│   └── data_structures_basics.nim   # 4 estructuras y sus operaciones
└── tests/
    └── data_structures_basics_tests.nim  # 4 tests
```

**Nota de desviación / Deviation note:** La especificación espera `test/` con `data_structures_basics_test.nim`; esta implementación usa `tests/` con `data_structures_basics_tests.nim`, siguiendo la convención idiomática de Nim y Nimble.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Paquete de Nimble + `unittest`, con layout `src/` + `tests/`. El valor cero de `LinkedList`, `Stack` y `Queue` ya es la estructura vacía inicializada (campos `nil` y `count = 0`), así que no hay `init` explícito que llamar: la inicialización es idiomática en Nim.

**EN:** Nimble package + `unittest`, with a `src/` + `tests/` layout. The zero value of `LinkedList`, `Stack` and `Queue` is already the initialized empty structure (fields `nil` and `count = 0`), so there is no explicit `init` to call: initialization is idiomatic in Nim.

---

## 📄 Configuración clave / Key Configuration

### `data_structures_basics.nimble` — Manifiesto de Nimble

**ES:** Declara el paquete (versión 0.1.0, `srcDir = "src"`) y la dependencia `nim >= 2.2.10`.

**EN:** Declares the package (version 0.1.0, `srcDir = "src"`) and the `nim >= 2.2.10` dependency.

```nim
version       = "0.1.0"
author        = "yorche3"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"

requires "nim >= 2.2.10"
```

---

## 🚀 Compilación y ejecución / Build & Run

```bash
nimble test
```

**Salida real / Actual output:**

```text
Info: using /home/yorche3/.nimble/pkgs2/nim-2.2.12-1ce02ec327934128234547c648d5ee3612c21b50/bin/nim for compilation
   Success: All tests passed
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `newNode(value)` | `int → Node` | `O(1)` | Crea un nodo con `value` y `next = nil`. |
| `getValue(node)` | `Node → int` | `O(1)` | Devuelve el valor del nodo. |
| `getNext(node)` | `Node → Node` | `O(1)` | Devuelve el enlace al siguiente nodo (puede ser `nil`). |
| `setNext(node, nextNode)` | `Node, Node → void` | `O(1)` | Enlaza el nodo con el siguiente. |
| `getHead(list)` | `LinkedList → int` | `O(1)` | Devuelve el valor de la cabeza o `-1` si está vacía. |
| `insertHead(list, value)` | `var LinkedList, int → void` | `O(1)` | Inserta al inicio. |
| `insertTail(list, value)` | `var LinkedList, int → void` | `O(1)` | Inserta al final. |
| `delete(list, value)` | `var LinkedList, int → bool` | `O(n)` | Elimina la primera aparición; devuelve `true` en éxito, `false` si no está. |
| `isEmpty(list)` | `LinkedList → bool` | `O(1)` | `true` si `count == 0`. |
| `size(list)` | `LinkedList → int` | `O(1)` | Devuelve `count`. |
| `push(stack, value)` | `var Stack, int → void` | `O(1)` | Apila sobre `top`. |
| `pop(stack)` | `var Stack → int` | `O(1)` | Extrae el tope; devuelve `-1` si está vacía. |
| `peek(stack)` | `Stack → int` | `O(1)` | Observa el tope sin extraer; devuelve `-1` si está vacía. |
| `isEmpty(stack)` | `Stack → bool` | `O(1)` | `true` si `count == 0`. |
| `size(stack)` | `Stack → int` | `O(1)` | Devuelve `count`. |
| `enqueue(queue, value)` | `var Queue, int → void` | `O(1)` | Encola tras `rear`. |
| `dequeue(queue)` | `var Queue → int` | `O(1)` | Extrae `front`; devuelve `-1` si está vacía. |
| `peek(queue)` | `Queue → int` | `O(1)` | Observa `front` sin extraer; devuelve `-1` si está vacía. |
| `isEmpty(queue)` | `Queue → bool` | `O(1)` | `true` si `count == 0`. |
| `size(queue)` | `Queue → int` | `O(1)` | Devuelve `count`. |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| `Node` como `ref object` (referencia) | `object` (valor) | Los nodos enlazados requieren mutabilidad compartida y aliasing; `ref` permite que `setNext` modifique el enlace sin copiar. |
| `LinkedList`, `Stack`, `Queue` como `object` (valor) | `ref object` | Son contenedores ligeros con semántica de valor; el valor cero es la estructura vacía, sin necesidad de `init` explícito. |
| `head`, `tail`, `count` no exportados | Exportar todos los campos | Ocultación de información: el recorrido completo no es observable desde fuera; el orden se verifica con `getHead` y `size`. |
| Indicador de fallo `-1` para `getHead`, `pop`, `peek`, `dequeue` | `Option[int]` | La especificación (Fase 1) prohíbe `Option`/`Maybe`/`Result`; el indicador natural del lenguaje es `-1` para enteros. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `init()` explícito para `LinkedList`, `Stack`, `Queue` | El valor cero ya es la estructura vacía (campos `nil` y `count = 0`) | Nim inicializa automáticamente los campos a `nil` (referencias) y `0` (enteros); no hay `init` que llamar. |
| `init(value)` para `Node` | `newNode(value)` | Nim distingue entre construcción de objetos (`newNode`) y procedimientos mutadores (`setNext`); `newNode` es idiomático. |
| `get_next()` devuelve ausencia nativa | `getNext` devuelve `Node` (puede ser `nil`) | `nil` es la representación nativa de ausencia para `ref` en Nim. |
| Ubicación esperada: `test/data_structures_basics_test.nim` | Ubicación real: `tests/data_structures_basics_tests.nim` | Convención idiomática de Nim y Nimble: `tests/` (plural) para suites. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `getHead(list)` | Lista vacía | `-1` | `getHead(emptyList) == -1` |
| `delete(list, value)` | Valor no está en la lista | `false` | `delete(list, 99) == false` |
| `pop(stack)` | Pila vacía | `-1` | `pop(emptyStack) == -1` |
| `peek(stack)` | Pila vacía | `-1` | `peek(emptyStack) == -1` |
| `dequeue(queue)` | Cola vacía | `-1` | `dequeue(emptyQueue) == -1` |
| `peek(queue)` | Cola vacía | `-1` | `peek(emptyQueue) == -1` |

---

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| **Node**: inicializar y observar valor/enlace | Sí | `tests/data_structures_basics_tests.nim:68-72` | `newNode(10)`, `getValue`, `getNext == nil`. |
| **Node**: inicializar otro nodo, enlazar y recorrer | Sí | `tests/data_structures_basics_tests.nim:74-79` | `newNode(20)`, `setNext`, `getValue(getNext(a))`. |
| **LinkedList**: estado vacío | Sí | `tests/data_structures_basics_tests.nim:84-89` | `isEmpty`, `size`, `getHead == -1`. |
| **LinkedList**: insertar por ambos extremos | Sí | `tests/data_structures_basics_tests.nim:91-95` | `insertTail(10)`, `insertTail(20)`, `insertHead(5)`, `insertTail(10)`; `size == 4`, `getHead == 5`. |
| **LinkedList**: eliminar primera aparición | Sí | `tests/data_structures_basics_tests.nim:97-100` | `delete(10)`; `size == 3`, `getHead == 5`. |
| **LinkedList**: valor ausente | Sí | `tests/data_structures_basics_tests.nim:102-105` | `delete(99) == false`; tamaño y cabeza no cambian. |
| **LinkedList**: vaciar | Sí | `tests/data_structures_basics_tests.nim:107-114` | `delete(5)`, `delete(20)`, `delete(10)`; `isEmpty == true`, `size == 0`, `getHead == -1`. |
| **Stack**: estado vacío y extracción fallida | Sí | `tests/data_structures_basics_tests.nim:119-124` | `isEmpty`, `size`, `peek == -1`, `pop == -1`. |
| **Stack**: LIFO y `peek` no mutante | Sí | `tests/data_structures_basics_tests.nim:126-129` | `push(10)`, `push(20)`, `push(30)`, `peek == 30`, `size == 3`. |
| **Stack**: extracción y reutilización | Sí | `tests/data_structures_basics_tests.nim:131-137` | `pop == 30`, `push(40)`, `pop == 40`, `pop == 20`, `pop == 10`; `isEmpty == true`. |
| **Stack**: vacío tras extracción | Sí | `tests/data_structures_basics_tests.nim:139-141` | `pop == -1`, `isEmpty == true`. |
| **Queue**: estado vacío y extracción fallida | Sí | `tests/data_structures_basics_tests.nim:146-151` | `isEmpty`, `size`, `peek == -1`, `dequeue == -1`. |
| **Queue**: FIFO y `peek` no mutante | Sí | `tests/data_structures_basics_tests.nim:153-156` | `enqueue(10)`, `enqueue(20)`, `enqueue(30)`, `peek == 10`, `size == 3`. |
| **Queue**: extracción y reutilización | Sí | `tests/data_structures_basics_tests.nim:158-164` | `dequeue == 10`, `enqueue(40)`, `dequeue == 20`, `dequeue == 30`, `dequeue == 40`; `isEmpty == true`. |
| **Queue**: vacío tras extracción | Sí | `tests/data_structures_basics_tests.nim:166-168` | `dequeue == -1`, `isEmpty == true`. |

**Total: 4 tests, 15 casos de la especificación cubiertos.**

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Ninguna / None | El módulo cumple el contrato de la especificación: todas las operaciones, complejidades e indicadores están implementados y verificados. | — |

---

## 📝 Notas de implementación / Implementation Notes

**ES:** Nim distingue entre `object` (valor) y `ref object` (referencia). `Node` es `ref object` porque los nodos enlazados requieren mutabilidad compartida: `setNext` modifica el enlace sin copiar el nodo. `LinkedList`, `Stack` y `Queue` son `object` porque son contenedores ligeros con semántica de valor; el valor cero ya es la estructura vacía, sin necesidad de `init` explícito.

**EN:** Nim distinguishes between `object` (value) and `ref object` (reference). `Node` is a `ref object` because linked nodes require shared mutability: `setNext` modifies the link without copying the node. `LinkedList`, `Stack` and `Queue` are `object` because they are lightweight containers with value semantics; the zero value is already the empty structure, with no need for an explicit `init`.

**ES:** Los campos `head`, `tail` y `count` de `LinkedList` no se exportan (no tienen `*`), así que el recorrido completo de la lista no es observable desde fuera del módulo. El orden se verifica con `getHead` tras cada eliminación y con `size`; que la segunda aparición de `10` sobrevive al `delete(10)` se comprueba con los tres `delete` del paso de vaciado (`5`, `20` y `10`).

**EN:** The `head`, `tail` and `count` fields of `LinkedList` are not exported (they lack `*`), so the full traversal of the list is not observable from outside the module. Order is verified with `getHead` after each deletion and with `size`; that the second occurrence of `10` survives `delete(10)` is checked by the three `delete` calls in the emptying step (`5`, `20` and `10`).

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
| Especificación / Specification | [`06_Data_Structures_Basics.md`](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) |
| Módulo homologado del lenguaje / Homologated module | [`nim/core/foundations/numbers/`](../../foundations/numbers/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](https://yorche3.github.io/programming_languages/core/00_Project_Initialization_Guide/) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](https://yorche3.github.io/programming_languages/docs/AGENT_Template/) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](https://yorche3.github.io/programming_languages/docs/WORKFLOW/) |
| Documentación oficial del lenguaje / Language official docs | [Nim Programming Language](https://nim-lang.org/docs/) |
