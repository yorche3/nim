import unittest

import data_structures_basics

# Casos de prueba de la especificación 06_Data_Structures_Basics.md
#
# Los casos de cada estructura son pasos sucesivos sobre la misma instancia: en
# Nim el valor cero de `LinkedList`, `Stack` y `Queue` ya es la estructura vacía
# inicializada, así que no hay `init` que llamar y el escenario no se reinicia.
#
# Indicadores: solo el enlace de un `Node` es `nil`; el resto de los fallos son
# valores devueltos (-1, false, 0), nunca excepciones.
#
# Adaptación declarada: `head`, `tail` y `count` no se exportan, así que el
# recorrido completo de la lista no es observable desde fuera del módulo. El
# orden se comprueba con `getHead` tras cada eliminación y con el tamaño, y que
# la segunda aparición de 10 sobrevive al `delete(10)` se comprueba con los tres
# `delete` del paso de vaciado (5, 20 y 10).
const
    nodeAValue = 10
    nodeBValue = 20

    listFirstValue = 10
    listSecondValue = 20
    listHeadValue = 5
    listAbsentValue = 99
    listInsertedSize = 4
    listDeletedSize = 3

    stackFirstValue = 10
    stackSecondValue = 20
    stackThirdValue = 30
    stackReuseValue = 40
    stackFullSize = 3

    queueFirstValue = 10
    queueSecondValue = 20
    queueThirdValue = 30
    queueReuseValue = 40
    queueFullSize = 3

    emptySize = 0
    failureValue = -1

# Helper compartido: recorre los pasos en orden, sobre la misma instancia, y
# compara cada observación con la esperada nombrando el caso.
#
# Es una plantilla —no un `proc`— para que el `check` quede dentro del bloque
# `test` y unittest marque el test como `[FAILED]`, y para que `checkpoint`
# anteponga el nombre del caso a la salida del fallo.
template assertSteps(subject: string, body: untyped) =
    template step(description: string, observed, expected: untyped) =
        checkpoint subject & " should " & description
        check (observed) == (expected)
    body

suite "data_structures_basics":
    test "Node":
        var a, b: Node

        assertSteps("Node"):
            # Caso: inicializar y observar valor/enlace.
            a = newNode(nodeAValue)
            step "assign the value on init", getValue(a), nodeAValue
            step "leave the next link absent on init", getNext(a) == nil, true

            # Caso: inicializar otro nodo, enlazar y recorrer.
            b = newNode(nodeBValue)
            step "assign the value of the second node on init", getValue(b), nodeBValue
            setNext(a, b)
            step "link the next node with set_next", getValue(getNext(a)), nodeBValue
            step "keep the next link absent on a linked node", getNext(b) == nil, true

    test "LinkedList":
        var list: LinkedList

        assertSteps("LinkedList"):
            # Paso: estado vacío.
            step "be empty after init", isEmpty(list), true
            step "report size 0 after init", size(list), emptySize
            step("return the failure indicator from getHead on an empty list",
                 getHead(list), failureValue)

            # Paso: insertar por ambos extremos (5, 10, 20, 10).
            insertTail(list, listFirstValue)
            insertTail(list, listSecondValue)
            insertHead(list, listHeadValue)
            insertTail(list, listFirstValue)
            step "count one element per insertion", size(list), listInsertedSize
            step "put 5 at the head after inserting 5, 10, 20, 10", getHead(list), listHeadValue
            step "stop reporting itself empty after the first insertion", isEmpty(list), false

            # Paso: eliminar la primera aparición de 10 (la lista queda 5, 20, 10).
            step "succeed on the first occurrence with delete", delete(list, listFirstValue), true
            step "decrement the size on a successful delete", size(list), listDeletedSize
            step "keep 5 at the head after deleting the first 10", getHead(list), listHeadValue

            # Paso: valor ausente.
            step "fail with delete on an absent value", delete(list, listAbsentValue), false
            step "keep the size after a failed delete", size(list), listDeletedSize
            step "keep 5 at the head after a failed delete", getHead(list), listHeadValue

            # Paso: vaciar la lista (5, 20, 10).
            step "remove the remaining head with delete", delete(list, listHeadValue), true
            step "leave 20 at the head after removing 5", getHead(list), listSecondValue
            step "remove the remaining second value with delete", delete(list, listSecondValue), true
            step "remove the remaining first value with delete", delete(list, listFirstValue), true
            step "be empty after removing every element", isEmpty(list), true
            step "report size 0 after removing every element", size(list), emptySize
            step("return the failure indicator from getHead after emptying the list",
                 getHead(list), failureValue)

    test "Stack":
        var stack: Stack

        assertSteps("Stack"):
            # Paso: estado vacío y extracción fallida.
            step "be empty after init", isEmpty(stack), true
            step "report size 0 after init", size(stack), emptySize
            step "return the failure indicator from peek on an empty stack", peek(stack), failureValue
            step "return the failure indicator from pop on an empty stack", pop(stack), failureValue
            step "stay empty after a failed pop", isEmpty(stack), true

            # Paso: LIFO y `peek` no mutante.
            push(stack, stackFirstValue)
            push(stack, stackSecondValue)
            push(stack, stackThirdValue)
            step "observe the top with peek without removing it", peek(stack), stackThirdValue
            step "report size 3 after three pushes", size(stack), stackFullSize

            # Paso: extracción y reutilización.
            step "extract the top with pop", pop(stack), stackThirdValue
            push(stack, stackReuseValue)
            step "extract the reused value with pop", pop(stack), stackReuseValue
            step "extract the second value with pop", pop(stack), stackSecondValue
            step "extract the first value with pop", pop(stack), stackFirstValue
            step "be empty after extracting every value", isEmpty(stack), true
            step "report size 0 after extracting every value", size(stack), emptySize

            # Paso: vacío tras extracción.
            step "return the failure indicator from pop after emptying", pop(stack), failureValue
            step "stay empty after the last failed pop", isEmpty(stack), true

    test "Queue":
        var queue: Queue

        assertSteps("Queue"):
            # Paso: estado vacío y extracción fallida.
            step "be empty after init", isEmpty(queue), true
            step "report size 0 after init", size(queue), emptySize
            step "return the failure indicator from peek on an empty queue", peek(queue), failureValue
            step "return the failure indicator from dequeue on an empty queue", dequeue(queue), failureValue
            step "stay empty after a failed dequeue", isEmpty(queue), true

            # Paso: FIFO y `peek` no mutante.
            enqueue(queue, queueFirstValue)
            enqueue(queue, queueSecondValue)
            enqueue(queue, queueThirdValue)
            step "observe the front with peek without removing it", peek(queue), queueFirstValue
            step "report size 3 after three enqueues", size(queue), queueFullSize

            # Paso: extracción y reutilización.
            step "extract the front with dequeue", dequeue(queue), queueFirstValue
            enqueue(queue, queueReuseValue)
            step "extract the second value with dequeue", dequeue(queue), queueSecondValue
            step "extract the third value with dequeue", dequeue(queue), queueThirdValue
            step "extract the reused value with dequeue", dequeue(queue), queueReuseValue
            step "be empty after extracting every value", isEmpty(queue), true
            step "report size 0 after extracting every value", size(queue), emptySize

            # Paso: vacío tras extracción.
            step "return the failure indicator from dequeue after emptying", dequeue(queue), failureValue
            step "stay empty after the last failed dequeue", isEmpty(queue), true
