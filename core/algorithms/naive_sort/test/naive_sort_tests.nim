import unittest

import naive_sort

# Casos de prueba de la especificación 05_Naive_Sort.md
#
# Caso nulo omitido: `seq[int]` no admite `nil` en Nim 2.2 (`var s: seq[int] = nil`
# es un error de tipo) y esta fase todavía no introduce `Option`. El array puede
# recibir una entrada vacía, pero no una nula, así que no hay indicador de fallo
# que comprobar y se conservan los 7 casos de la especificación.
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

type
    SortCase = object
        description: string
        input: seq[int]
        expected: seq[int]

    SortProc = proc(arr: var seq[int]): seq[int]

let cases = @[
    SortCase(description: "an unsorted array",
             input: standardInput, expected: standardOutput),
    SortCase(description: "an already sorted array",
             input: sortedInput, expected: sortedOutput),
    SortCase(description: "a reverse ordered array",
             input: reverseInput, expected: reverseOutput),
    SortCase(description: "an array of identical elements",
             input: identicalInput, expected: identicalOutput),
    SortCase(description: "an array with negative numbers",
             input: negativeInput, expected: negativeOutput),
    SortCase(description: "a single element array",
             input: singleInput, expected: singleOutput),
    SortCase(description: "an empty array",
             input: emptyInput, expected: emptyOutput),
]

# Copia elemento a elemento: los tres algoritmos ordenan in-place sobre el array
# recibido y los casos son fixtures compartidos.
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
        var actual = copyArray(sortCase.input)
        checkpoint algorithm & " should sort " & sortCase.description
        check sort(actual) == expected

suite "naive_sort":
    test "selection_sort":
        assertSortsAllCases(naive_sort.selectionSort, "selection_sort")

    test "bubble_sort":
        assertSortsAllCases(naive_sort.bubbleSort, "bubble_sort")

    test "insertion_sort":
        assertSortsAllCases(naive_sort.insertionSort, "insertion_sort")
