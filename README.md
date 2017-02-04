# self0

**self0** is an esolang that wants to blur the line between code and data.

[What is an esolang?](https://esolangs.org/wiki/Esoteric_programming_language)

## Features

- 256 octets of RAM, randomly initialized.
- RAM octet 0 is the program counter.
- No isolation of code and data (kind of Von Neumann architecture).
- The program is given as a string of octets (i.e "1 1 123 0").
- Octets are unsigned, meaning that 255 + 1 = 0 and 0 - 1 = 255.

## Instructions

|Value |Mnemonic    |Definition                                                |
|:-----|------------|----------------------------------------------------------|
| 0    | END        | Exit program |
| 1X   | OUT X      | Ouput octet X |
| 2X   | INC #X     | Increment octet at address X |
| 3X   | DEC #X     | Decrement octet at address X |
| 4X   | JMP #X     | Jump to address X |
| 5XY  | JNZ #X #Y  | Jump to address X if octet at address Y equals 0 |

## Examples

There is more examples in the [examples folder](examples).

### Output 123

First example is a small program to output the octet 123:

    1 1 123 0

The same program using mnemonics is simpler to understand:

    START #1
    OUT 123
    END

Your run it like that:

    $ ./self0 "1 1 123 0"
    123

### Random Number

A sligthly more complicated program to output a random number:

    1 3 99 5 1 99 3 97 5 6 97 2 97 4 97

And here is some explanations:

    START #1
    DEC #99        ; Content of #99 will eventually become END
    JNZ #1 #99     ; Go to #1 and loop until content of #99 isn't 0
    DEC #97        ; Do the same with content of #97
    JNZ #6 #97
    INC #97        ; Then transform #97 into an OUT opcode
    JMP #97        ; Finally output content of #98

Your run it like that:

    $ ./self0 "1 3 99 5 1 99 3 97 5 6 97 2 97 4 97"

## Install & Usage

There two different interpreters, one in Ruby and one in C.

### Ruby

    ruby self0.rb "your program here"

### C

To compile it:

    make

To run it:

    ./self0 "your program here"

### Tests

Run the tests with `make test`.

## License

GPLv3 https://www.gnu.org/licenses/gpl-3.0.en.html
