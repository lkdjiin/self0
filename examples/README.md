# Program Examples

## Output 123

    1 1 123 0

```
00: START #1
01: OUT 123
03: END
```

## Random Number I

    1 3 99 5 1 99 3 97 5 6 97 2 97 4 97

```
00: START #1
01: DEC #99     ; Content of #99 will eventually become END
03: JNZ #1 #99  ; Go to #1 and loop until content of #99 isn't 0
06: DEC #97     ; Do the same with content of #97
08: JNZ #6 #97
11: INC #97     ; Then transform #97 into an OUT opcode
13: JMP #97     ; Finally output content of #98
```

## Random Number II

    4 1 0 0 3 99 2 2 5 4 99 4 1

```
00: START #4
01: OUT 0
03: END
04: DEC #99
06: INC #2
08: JNZ #4 #99
11: JMP #1
```

## Substraction

    1 3 9 3 10 5 1 10 1 19 7

```
; a - b
00: START #1
01: DEC #9
03: DEC #10
05: JNZ #1 #10
08: 1          ; Code for OUT
09: 19         ; number a
10: 7          ; number b
```

### Addition

    4 1 2 3 3 3 2 2 5 4 3 4 1

```
00: START #3
01: 1          ; Code for OUT
02: 2          ; first number
03: 3          ; second number
04: DEC #3
06: INC #2
08: JNZ #4 #3
11: JMP #1
```

### Ouput numbers from 1 to 10

    2 10 1 1 2 3 3 1 5 2 1 0

```
00: START #2
01: 10
02: OUT 1
04: INC #3
06: DEC #1
08: JNZ #2 #1
11: END
```

### Echo until zero

    1 3 24 2 9 5 1 24 1 0 3 9 5 10 9 2 2 2 7 2 23 5 1 24 150 140 170 0

```
00: START #1
; Dec zz, inc pp+1 until zz is zero
01: DEC #24      ;aa
03: INC #9
05: JNZ #1 #24
08: OUT 0        ;pp
; Reset pp to zero
10: DEC #9       ;rr
12: JNZ #10 #9
; Inc pointers on zz
15: INC #2
17: INC #7
19: INC #23
; Do it again if zz != zero
21: JNZ #1 #24
; Beginning of data
24: 150     ;zz By the time execution arrives here, the octet was changed to 0 (END)
    140
    170
    0
```

### Test equality between two octets

    3 123 234 3 1 3 2 5 3 1 5 17 2 1 1 4 19 1 0 0

```
; Output 1 if a == b or output 0 if a != b
00: START #3
01: 123          ; number a
02: 234          ; number b
03: DEC #1
05: DEC #2
07: JNZ #3 #1
; Now #1 is zero. If #2 is also zero then a == b.
; If #2 isn't zero then a != b.
10: JNZ #17 #2
13: OUT 1   ; Equal
15: JMP #19
17: OUT 0   ; Not equal
19: END
```
