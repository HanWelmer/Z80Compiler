# Z80Compiler
Java command line application that compiles miniJava programs to Z80 assembler and binary.
See [syntax.md](./syntax.md) for a description of the miniJava syntax and semantics.

## Development:
The project was developed using:
* openjdk 11.0.16.1
* Apache Maven 3.9.4
* eclipse 4.26.0

### maven
* open commandline tool
* nagivate to subfolder 
* mvn compile
* mvn test

## Usage:
`Z80Compiler [-Z80] [-b] [-d] source.j`

`where:`

`-b generate binary output (M-code or Z80 assembler)`

`-d issue debug messages during compilation`

`-r run the compiled code using the built-in interpreter`

`-v verbose: issue feedback messages during compilation`

`-z generate Z80 assembler output`

`source.j input sourcecode file in miniJava programming language`
