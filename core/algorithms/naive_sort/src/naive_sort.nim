# NaiveSort — ordenamientos elementales O(n²).
#
# Especificación: 05_Naive_Sort

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

proc bubbleSort*(arr: var seq[int]): seq[int] =
  let n = arr.len
  if n < 1:
    return arr
  for i in 0..<n-1:
    var swapped = false
    for j in 0..<n-i-1:
      if arr[j] > arr[j+1]:
        let temp = arr[j]
        arr[j] = arr[j+1]
        arr[j+1] = temp
        swapped = true
    if not swapped:
      break
  return arr

proc insertionSort*(arr: var seq[int]): seq[int] =
  let n = arr.len
  if n < 1:
    return arr
  for i in 1..<n:
    let key = arr[i]
    var j = i - 1
    while j >= 0 and arr[j] > key:
      arr[j + 1] = arr[j]
      j -= 1
    arr[j + 1] = key
  return arr