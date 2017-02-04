self0: self0.c
	gcc -std=c11 -Wall -Wextra -Wpedantic -march=native -O2 self0.c -o self0

test: self0
	ruby tests.rb

clean:
	rm self0
