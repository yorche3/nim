# NaiveSort — ordenamientos elementales O(n²).
#
# Especificación: 05_Naive_Sort
#
# Contrato pendiente de implementación (de menor a mayor, in-place sobre el
# array recibido):
#   selectionSort(arr)
#   bubbleSort(arr)
#   insertionSort(arr)
#
# Caso nulo: `seq[int]` no admite `nil` en Nim, así que el indicador de fallo del
# contrato se representa con `Option[seq[int]]`: la entrada es `none(seq[int])`
# cuando es nula y la salida es `none(seq[int])` en ese caso, sin lanzar
# excepciones.
