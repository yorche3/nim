# Package

version       = "1.0.0"
author        = "yorche"
description   = "Elementary sorting algorithms (selection, bubble, insertion)."
license       = "MIT"
srcDir        = "src"

# Dependencies

requires "nim >= 2.0.0"

task test, "Run the unit tests":
    exec "nim c -r test/naive_sort_tests.nim"
