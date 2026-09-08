# Package

version       = "1.0.0"
author        = "yorche"
description   = "Calculator with educational arithmetic implementations."
license       = "MIT"
srcDir        = "src"

# Dependencies

requires "nim >= 2.0.0"

task test, "Run the unit tests":
    exec "nim c -r test/calculator_test.nim"
