import std/options
import unittest

import naive_sort

# Casos de prueba de la especificación 05_Naive_Sort.md
let
    standardInput = @[5, 2, 9, 1, 5, 6]
    standardOutput = @[1, 2, 5, 5, 6, 9]

    sortedInput = @[1, 2, 3, 4, 5]
    sortedOutput = @[1, 2, 3, 4, 5]

    reverseInput = @[5, 4, 3, 2, 1]
    reverseOutput = @[1, 2, 3, 4, 5]

    identicalInput = @[7, 7, 7, 7]
    identicalOutput = @[7, 7, 7, 7]

    negativeInput = @[3, -1, 4, -5, 0]
    negativeOutput = @[-5, -1, 0, 3, 4]

    singleInput = @[42]
    singleOutput = @[42]

    emptyInput: seq[int] = @[]
    emptyOutput: seq[int] = @[]

# Caso nulo incluido: `seq[int]` no admite `nil` en Nim, así que el indicador de
# fallo se representa con `Option[seq[int]]`; la entrada nula es
# `none(seq[int])` y la salida esperada es `none(seq[int])`. No se espera
# ninguna excepción.
type
    SortCase = object
        description: string
        input: Option[seq[int]]
        expected: Option[seq[int]]

    SortProc = proc(arr: Option[seq[int]]): Option[seq[int]]

let cases = @[
    SortCase(description: "an unsorted array",
             input: some(standardInput), expected: some(standardOutput)),
    SortCase(description: "an already sorted array",
             input: some(sortedInput), expected: some(sortedOutput)),
    SortCase(description: "a reverse ordered array",
             input: some(reverseInput), expected: some(reverseOutput)),
    SortCase(description: "an array of identical elements",
             input: some(identicalInput), expected: some(identicalOutput)),
    SortCase(description: "an array with negative numbers",
             input: some(negativeInput), expected: some(negativeOutput)),
    SortCase(description: "a single element array",
             input: some(singleInput), expected: some(singleOutput)),
    SortCase(description: "an empty array",
             input: some(emptyInput), expected: some(emptyOutput)),
    SortCase(description: "a null input",
             input: none(seq[int]), expected: none(seq[int])),
]

# Copia elemento a elemento: los tres algoritmos pueden ordenar in-place sobre
# el array recibido y los casos son fixtures compartidos.
proc copyArray(arr: seq[int]): seq[int] =
    result = newSeq[int](arr.len)
    for i in 0 ..< arr.len:
        result[i] = arr[i]

# Helper compartido: recibe la función a probar y el nombre del algoritmo, y
# ejecuta todos los casos con un mensaje descriptivo cada uno.
#
# Es una plantilla y no un `proc` para que el `check` quede dentro del bloque
# `test` y unittest marque el test como `[FAILED]`, y para que `checkpoint`
# anteponga el mensaje del contrato a la salida del fallo.
template assertSortsAllCases(sort: SortProc, algorithm: string) =
    for sortCase in cases:
        let expected = sortCase.expected
        var actual = sortCase.input
        if actual.isSome:
            actual = some(copyArray(actual.get))
        checkpoint algorithm & " should sort " & sortCase.description
        check sort(actual) == expected

suite "naive_sort":
    test "selection_sort":
        assertSortsAllCases(naive_sort.selectionSort, "selection_sort")

    test "bubble_sort":
        assertSortsAllCases(naive_sort.bubbleSort, "bubble_sort")

    test "insertion_sort":
        assertSortsAllCases(naive_sort.insertionSort, "insertion_sort")
