import unittest
import numbers

suite "numbers iterative":
    test "sumOfFirstNIte":
        check numbers.sumOfFirstNIte(0) == 0
        check numbers.sumOfFirstNIte(3) == 6

    test "factorialIte":
        check numbers.factorialIte(0) == 1
        check numbers.factorialIte(4) == 24

    test "fibonacciIte":
        check numbers.fibonacciIte(0) == 0
        check numbers.fibonacciIte(1) == 1
        check numbers.fibonacciIte(6) == 8

    test "greatestCommonDivisorIte":
        check numbers.greatestCommonDivisorIte(12, 8) == 4
        check numbers.greatestCommonDivisorIte(7, 5) == 1

    test "leastCommonMultipleIte":
        check numbers.leastCommonMultipleIte(4, 6) == 12
        check numbers.leastCommonMultipleIte(6, 8) == 24
