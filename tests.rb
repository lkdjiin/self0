def test(cmd, expected, desc = "")
  result = %x( #{cmd} )
  if result == expected
    print(".")
  else
    puts("Fail: #{cmd}")
    puts("Description: #{desc}")
    puts("Expected: #{expected.inspect}")
    puts("Result  : #{result.inspect}")
  end
end

# Test the C version of self0.
puts "Testing C version"

# Write a value.
test('./self0 "1 1 123 0"', "123\n", "Print 123")
test('./self0 "1 1 57 0"', "57\n", "Print 57")

# Substraction.
test('./self0 "1 3 9 3 10 5 1 10 1 19 7"', "12\n", "19 - 7")
test('./self0 "1 3 9 3 10 5 1 10 1 91 1"', "90\n", "91 - 1")

# Addition.
test('./self0 "4 1 2 3 3 3 2 2 5 4 3 4 1"', "5\n", "2 + 3")
test('./self0 "4 1 21 34 3 3 2 2 5 4 3 4 1"', "55\n", "21 + 34")

test('./self0 "2 10 1 1 2 3 3 1 5 2 1 0"', "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n",
     "Write 1 to 10")

test('./self0 "1 3 24 2 9 5 1 24 1 0 3 9 5 10 9 2 2 2 7 2 23 5 1 24 150 140 170 0"',
     "150\n140\n170\n", "Echo till 0")

# Compare two numbers.
test('./self0 "3 123 234 3 1 3 2 5 3 1 5 17 2 1 1 4 19 1 0 0"', "0\n",
     "123 and 234 are not equal")
test('./self0 "3 97 97 3 1 3 2 5 3 1 5 17 2 1 1 4 19 1 0 0"', "1\n",
     "97 and 97 are equal")

# Test the Ruby version of self0.
puts "\nTesting Ruby version"

# Write a value.
test('ruby self0.rb "1 1 123 0"', "123\n", "Print 123")
test('ruby self0.rb "1 1 57 0"', "57\n", "Print 57")

# Substraction.
test('ruby self0.rb "1 3 9 3 10 5 1 10 1 19 7"', "12\n", "19 - 7")
test('ruby self0.rb "1 3 9 3 10 5 1 10 1 91 1"', "90\n", "91 - 1")

# Addition.
test('ruby self0.rb "4 1 2 3 3 3 2 2 5 4 3 4 1"', "5\n", "2 + 3")
test('ruby self0.rb "4 1 21 34 3 3 2 2 5 4 3 4 1"', "55\n", "21 + 34")

test('ruby self0.rb "2 10 1 1 2 3 3 1 5 2 1 0"', "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n",
     "Write 1 to 10")

test('ruby self0.rb "1 3 24 2 9 5 1 24 1 0 3 9 5 10 9 2 2 2 7 2 23 5 1 24 150 140 170 0"',
     "150\n140\n170\n", "Echo till 0")

# Compare two numbers.
test('ruby self0.rb "3 123 234 3 1 3 2 5 3 1 5 17 2 1 1 4 19 1 0 0"', "0\n",
     "123 and 234 are not equal")
test('ruby self0.rb "3 97 97 3 1 3 2 5 3 1 5 17 2 1 1 4 19 1 0 0"', "1\n",
     "97 and 97 are equal")
puts
