#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>

#define SIZE_OF_RAM 256

uint8_t * init_ram(char * program);
void randomize_ram(uint8_t * ram);
void load_program(uint8_t * ram, char * program);
void run(uint8_t * ram);
void do_print(uint8_t * ram);
void do_dec(uint8_t * ram);
void do_inc(uint8_t * ram);
void do_jnz(uint8_t * ram);
void do_jmp(uint8_t * ram);

int32_t main(int argc, char ** argv)
{
    if(argc != 2) {
        printf("Usage: self0 \"your program here\"\n");
        exit(1);
    }

    uint8_t * ram = init_ram(argv[1]);
    run(ram);

    return 0;
}

// Initialize memory, that is randomize each octet and put the program at
// the beginning.
//
// program - The sequence of opcodes, i.e "1 1 234 0" will output 234.
//
// Returns the octets of memory.
uint8_t * init_ram(char * program)
{
    static uint8_t ram[SIZE_OF_RAM];

    randomize_ram(ram);
    load_program(ram, program);

    return ram;
}

// Randomize each octet of the memory.
//
// Not a great randomization, it creates the same sequence during a
// whole second. But do the job.
void randomize_ram(uint8_t * ram)
{
    srand(time(NULL));

    for(uint32_t i = 0; i < SIZE_OF_RAM; i++) {
        ram[i] = rand() % SIZE_OF_RAM;
    }
}

// Replace the beginning of the memory by the program.
void load_program(uint8_t * ram, char * program)
{
    char * pch = strtok(program, " ");
    uint8_t index = 0;
    while(pch != NULL) {
        ram[index] = atoi(pch);
        index++;
        pch = strtok(NULL, " ");
    }
}

void run(uint8_t * ram)
{
    while(true) {
        switch(ram[ram[0]]) {
            case 0:
                exit(0);
                break;
            case 1:
                do_print(ram);
                break;
            case 2:
                do_inc(ram);
                break;
            case 3:
                do_dec(ram);
                break;
            case 4:
                do_jmp(ram);
                break;
            case 5:
                do_jnz(ram);
                break;
            default:
                printf("Unknown opcode %d\n", ram[ram[0]]);
                exit(1);
                break;
        }
    }
}

// Print the octet at current instruction + 1.
void do_print(uint8_t * ram)
{
    printf("%d\n", ram[ram[0] + 1]);
    ram[0] += 2;
}

// Decrement octet at address given by instruction + 1.
void do_dec(uint8_t * ram)
{
    ram[ram[ram[0] + 1]] -= 1;
    ram[0] += 2;
}

// Increment octet at address given by instruction + 1.
void do_inc(uint8_t * ram)
{
    ram[ram[ram[0] + 1]] += 1;
    ram[0] += 2;
}

// Jump to address given by instruction + 1.
void do_jmp(uint8_t * ram)
{
    ram[0] = ram[ram[0] + 1];
}

// Jump at address given by instruction + 1, but only if octet given by
// instruction + 2 is equal to zero.
void do_jnz(uint8_t * ram)
{
    if(ram[ram[ram[0] + 2]] == 0) {
        ram[0] += 3;
    } else {
        ram[0] = ram[ram[0] + 1];
    }
}

