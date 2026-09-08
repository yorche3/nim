# Direct recursion (_rec)

proc sumOfFirstNRec*(n: int): int =
    if n <= 0:
        return 0
    return n + sumOfFirstNRec(n - 1)

proc factorialRec*(n: int): int =
    if n <= 0:
        return 1
    return n * factorialRec(n - 1)

proc fibonacciRec*(n: int): int =
    if n <= 1:
        return n
    return fibonacciRec(n - 1) + fibonacciRec(n - 2)

proc greatestCommonDivisorRec*(a, b: int): int =
    if b == 0:
        return a
    return greatestCommonDivisorRec(b, a mod b)

proc leastCommonMultipleRec*(a, b: int): int =
    (a * b) div greatestCommonDivisorRec(a, b)

# Accumulator recursion (_acc): educational bridge, no TCO in Nim

proc sumOfFirstNAccHelp(n: int, acc: int): int =
    if n <= 0:
        return acc
    return sumOfFirstNAccHelp(n - 1, n + acc)

proc sumOfFirstNAcc*(n: int): int =
    sumOfFirstNAccHelp(n, 0)

proc factorialAccHelp(n: int, acc: int): int =
    if n <= 1:
        return acc
    return factorialAccHelp(n - 1, n * acc)

proc factorialAcc*(n: int): int =
    factorialAccHelp(n, 1)

proc fibonacciAccHelp(n: int, acc2: int, acc1: int): int =
    if n <= 0:
        return acc2
    if n <= 2:
        return acc1 + acc2
    return fibonacciAccHelp(n - 1, acc1, acc1 + acc2)

proc fibonacciAcc*(n: int): int =
    fibonacciAccHelp(n, 0, 1)

proc greatestCommonDivisorAccHelp(a, b: int): int =
    if b == 0:
        return a
    return greatestCommonDivisorAccHelp(b, a mod b)

proc greatestCommonDivisorAcc*(a, b: int): int =
    greatestCommonDivisorAccHelp(a, b)

proc leastCommonMultipleAcc*(a, b: int): int =
    (a * b) div greatestCommonDivisorAcc(a, b)

# Iterative (_ite)

proc sumOfFirstNIte*(n: int): int =
    var result = 0
    for i in 1..n:
        result += i
    result

proc factorialIte*(n: int): int =
    var result = 1
    for i in 2..n:
        result *= i
    result

proc fibonacciIte*(n: int): int =
    if n <= 1:
        return n
    var acc2 = 0
    var acc1 = 1
    for i in 2..n:
        let temp = acc1 + acc2
        acc2 = acc1
        acc1 = temp
    acc1

proc greatestCommonDivisorIte*(a, b: int): int =
    var x = a
    var y = b
    while y != 0:
        let temp = y
        y = x mod y
        x = temp
    x

proc leastCommonMultipleIte*(a, b: int): int =
    (a * b) div greatestCommonDivisorIte(a, b)
