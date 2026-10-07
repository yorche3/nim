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
  if list.head == nil:
    return -1
  return list.head.value

proc insertHead*(list: var LinkedList, value: int) =
  let new_node = newNode(value)
  new_node.next = list.head
  list.head = new_node
  if list.tail == nil:
    list.tail = new_node
  list.count.inc()

proc insertTail*(list: var LinkedList, value: int) =
  let new_node = newNode(value)
  if list.tail == nil:
    list.head = new_node
    list.tail = new_node
  else:
    list.tail.next = new_node
    list.tail = new_node
  list.count.inc()

proc delete*(list: var LinkedList, value: int): bool =
  var current = list.head
  var previous: Node = nil
  while current != nil:
    if current.value == value:
      if previous != nil:
        previous.next = current.next
      else:
        list.head = current.next
      if current == list.tail:
        list.tail = previous
      list.count.dec()
      return true
    previous = current
    current = current.next
  return false

func isEmpty*(list: LinkedList): bool =
  return list.count == 0

func size*(list: LinkedList): int =
  return list.count

# ---------------------------------------------------------------------------
# Stack
# ---------------------------------------------------------------------------

proc push*(stack: var Stack, value: int) =
  let new_node = newNode(value)
  new_node.next = stack.top
  stack.top = new_node
  stack.count.inc()

proc pop*(stack: var Stack): int =
  if stack.top == nil:
    return -1
  let value = stack.top.value
  stack.top = stack.top.next
  stack.count.dec()
  return value

func peek*(stack: Stack): int =
  if stack.top == nil:
    return -1
  return stack.top.value

func isEmpty*(stack: Stack): bool =
  return stack.count == 0

func size*(stack: Stack): int =
  return stack.count

# ---------------------------------------------------------------------------
# Queue
# ---------------------------------------------------------------------------

proc enqueue*(queue: var Queue, value: int) =
  let new_node = newNode(value)
  if queue.rear == nil:
    queue.front = new_node
    queue.rear = new_node
  else:
    queue.rear.next = new_node
    queue.rear = new_node
  queue.count.inc()

proc dequeue*(queue: var Queue): int =
  if queue.front == nil:
    return -1
  let value = queue.front.value
  queue.front = queue.front.next
  if queue.front == nil:
    queue.rear = nil
  queue.count.dec()
  return value

func peek*(queue: Queue): int =
  if queue.front == nil:
    return -1
  return queue.front.value

func isEmpty*(queue: Queue): bool =
  return queue.count == 0

func size*(queue: Queue): int =
  return queue.count
