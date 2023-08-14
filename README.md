# Z80Compiler
Java command line application that compiles miniJava programs to Z80 assembler and binary.
See [syntax.md](./syntax.md) for a description of the miniJava syntax and semantics.

Development:
All you need is Java JDK and Maven. More is better.
* mvn compile
* mvn test

Usage:
* java Z80Compiler
* java Z80Compiler -r test1.j
* java Z80Compiler -r -z -b -d test1.j >test1.log
