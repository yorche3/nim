import unittest
import calculator

suite "calculator":
    test "addition(2, 3) returns 5":
        check addition(2, 3) == 5

    test "subtraction(5, 2) returns 3":
        check subtraction(5, 2) == 3

    test "multiplication(3, 4) returns 12":
        check multiplication(3, 4) == 12

    test "division(10, 3) returns 3":
        check division(10, 3) == 3

    test "modulus(10, 3) returns 1":
        check modulus(10, 3) == 1
