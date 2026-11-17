# Package

version       = "0.1.0"
author        = "yorche3"
description   = "Advanced data structures (binary search tree and directed graph)"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 2.2.10"
task test, "Run the unit tests":
    exec "nim c -r tests/data_structures_advanced_tests.nim"
