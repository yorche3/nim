import unittest
import numbers

suite "numbers recursive":
    test "sumOfFirstNRec":
        check numbers.sumOfFirstNRec(0) == 0
        check numbers.sumOfFirstNRec(3) == 6

    test "factorialRec":
        check numbers.factorialRec(0) == 1
        check numbers.factorialRec(4) == 24

    test "fibonacciRec":
        check numbers.fibonacciRec(0) == 0
        check numbers.fibonacciRec(1) == 1
        check numbers.fibonacciRec(6) == 8

    test "greatestCommonDivisorRec":
        check numbers.greatestCommonDivisorRec(12, 8) == 4
        check numbers.greatestCommonDivisorRec(7, 5) == 1

    test "leastCommonMultipleRec":
        check numbers.leastCommonMultipleRec(4, 6) == 12
        check numbers.leastCommonMultipleRec(6, 8) == 24
