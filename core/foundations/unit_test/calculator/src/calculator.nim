proc addition*(a, b: int): int =
    a + b

proc subtraction*(a, b: int): int =
    a - b

proc multiplication*(a, b: int): int =
    var result = 0
    for _ in 1..b:
        result = addition(result, a)
    result

proc division*(a, b: int): int =
    var remaining = a
    var quotient = 0
    while remaining >= b:
        remaining = subtraction(remaining, b)
        quotient = addition(quotient, 1)
    quotient

proc modulus*(a, b: int): int =
    let q = division(a, b)
    let p = multiplication(q, b)
    subtraction(a, p)
