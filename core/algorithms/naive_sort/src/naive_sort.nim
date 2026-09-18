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
proc selectionSort(arr: var seq[int]): seq[int] =
  if arr.nil || arr.len == 0:
    return arr
  let n = arr.len
  for i in 0..<n-1:
    var minIndex = i
    for j in i+1..<n:
      if arr[j] < arr[minIndex]:
        minIndex = j
    if minIndex != i:
      arr[i], arr[minIndex] = arr[minIndex], arr[i]
  return arr

proc bubbleSort(arr: var seq[int]): seq[int] =
  if arr.nil || arr.len == 0:
    return arr
  let n = arr.len
  for i in 0..<n-1:
    let swapped = false
    for j in 0..<n-i-1:
      if arr[j] > arr[j+1]:
        arr[j], arr[j+1] = arr[j+1], arr[j]
        swapped = true
    if not swapped:
      break
  return arr

proc insertionSort(arr: var seq[int]): seq[int] =
  if arr.nil || arr.len == 0:
    return arr
  let n = arr.len
  for i in 1..<n:
    let key = arr[i]
    var j = i - 1
    while j >= 0 and arr[j] > key:
      arr[j + 1] = arr[j]
      j -= 1
    arr[j + 1] = key
  return arr