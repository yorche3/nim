# Package

version       = "1.0.0"
author        = "yorche"
description   = "Numerical algorithms in three approaches (recursive, accumulator, iterative)."
license       = "MIT"
srcDir        = "src"

# Dependencies

requires "nim >= 2.0.0"

task test, "Run the unit tests":
    exec "nim c -r tests/recursive_tests.nim"
    exec "nim c -r tests/iterative_tests.nim"
