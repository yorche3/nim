# data_structures_basics — contrato y esqueletos del módulo.
#
# Especificación: 06_Data_Structures_Basics
#
# Contrato del paso 4b: tipos nuevos, firmas e indicadores de fallo; el
# algoritmo es del paso 5 y la suite, del 4c.
#
# Indicadores: solo el enlace de un Node puede ser nil; el resto de las
# operaciones devuelve -1 (números), false (banderas) o 0 (contadores).

type
  ## Shared linked cell used by LinkedList, Stack and Queue.
  ## The value is immutable after construction; next is mutable.
  Node* = ref object
    value: int
    next: Node

  ## Singly linked list built from scratch over Node.
  ## The zero value is a ready-to-use empty list: no init call is needed.
  LinkedList* = object
    head: Node
    tail: Node
    count: int

  ## LIFO stack built from scratch over Node.
  ## The zero value is a ready-to-use empty stack.
  Stack* = object
    top: Node
    count: int

  ## FIFO queue built from scratch over Node.
  ## The zero value is a ready-to-use empty queue.
  Queue* = object
    front: Node
    rear: Node
    count: int

# ---------------------------------------------------------------------------
# Node
# ---------------------------------------------------------------------------

func newNode*(value: int): Node =
  Node(value: value, next: nil)

func getValue*(node: Node): int =
  node.value

func getNext*(node: Node): Node =
  node.next

proc setNext*(node: Node, nextNode: Node) =
  node.next = nextNode

# ---------------------------------------------------------------------------
# LinkedList
# ---------------------------------------------------------------------------

func getHead*(list: LinkedList): int =
  return -1

proc insertHead*(list: var LinkedList, value: int) =
  discard

proc insertTail*(list: var LinkedList, value: int) =
  discard

proc delete*(list: var LinkedList, value: int): bool =
  return false

func isEmpty*(list: LinkedList): bool =
  return false

func size*(list: LinkedList): int =
  return 0

# ---------------------------------------------------------------------------
# Stack
# ---------------------------------------------------------------------------

proc push*(stack: var Stack, value: int) =
  discard

proc pop*(stack: var Stack): int =
  return -1

func peek*(stack: Stack): int =
  return -1

func isEmpty*(stack: Stack): bool =
  return false

func size*(stack: Stack): int =
  return 0

# ---------------------------------------------------------------------------
# Queue
# ---------------------------------------------------------------------------

proc enqueue*(queue: var Queue, value: int) =
  discard

proc dequeue*(queue: var Queue): int =
  return -1

func peek*(queue: Queue): int =
  return -1

func isEmpty*(queue: Queue): bool =
  return false

func size*(queue: Queue): int =
  return 0
