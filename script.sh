#!/bin/bash

# Step 1: Compile the program
make all
if [ $? -ne 0 ]; then
	echo "Compilation failed!"
	exit 1
fi
cc tests.c -o lol -L. -lftprintf
if [ $? -ne 0 ]; then
	echo "Compilation failed!"
	exit 1
fi

# Step 2: Run the program and append output to result.txt
./lol > result.txt

# Step 3: Define the expected test outputs
expected_outputs=(
	"| +0 |"
	"| +9 |"
	"| -1 |"
	"| +10 |"
	"| +11 |"
	"| +15 |"
	"| +16 |"
	"| +17 |"
	"| +99 |"
	"| +100 |"
	"| +101 |"
	"| -9 |"
	"| -10 |"
	"| -11 |"
	"| -14 |"
	"| -15 |"
	"| -16 |"
	"| -99 |"
	"| -100 |"
	"| -101 |"
	"| +2147483647 |"
	"| -2147483648 |"
	"| -1 |"
	"| +0 |"
	"| -1 |"
	"| -1 |"
	"| -1 |"
	"| +2147483647 -2147483648 -1 +0 -1 +0 -42 |"
	"| +0 |"
	"| -1 |"
	"| +1 |"
	"| +9 |"
	"| +10 |"
	"| +11 |"
	"| +15 |"
	"| +16 |"
	"| +17 |"
	"| +99 |"
	"| +100 |"
	"| +101 |"
	"| -9 |"
	"| -10 |"
	"| -11 |"
	"| -14 |"
	"| -15 |"
	"| -16 |"
	"| -99 |"
	"| -100 |"
	"| -101 |"
	"| +2147483647 |"
	"| -2147483648 |"
	"| -1 |"
	"| +0 |"
	"| -1 |"
	"| -1 |"
	"| -1 |"
	"| +2147483647 -2147483648 -1 +0 -1 +0 -42 |"
	"| 0 |"
	"| -1 |"
	"| 0009 |"
	"| 10 |"
	"| 11 |"
	"| 015 |"
	"| 0016 |"
	"| 00017 |"
	"| 99 |"
	"| 100 |"
	"| 101 |"
	"| -9 |"
	"| -10 |"
	"| -11 |"
	"| -014 |"
	"| -0015 |"
	"| -00016 |"
	"| -99 |"
	"| -100 |"
	"| -101 |"
	"| 2147483647 |"
	"| -2147483648 |"
	"| -0000000001 |"
	"| 000000000000 |"
	"| -000000000001 |"
	"| -0000000000001 |"
	"| -00000000000001 |"
	"| 2147483647 -2147483648 -0000000001 000000000000 -000000000001 00000000000000 -00000000000042
	"| 0 |"
	"| -1 |"
	"| 001 |"
	"| 0009 |"
	"| 10 |"
	"| 11 |"
	"| 015 |"
	"| 0016 |"
	"| 00017 |"
	"| 99 |"
	"| 100 |"
	"| 101 |"
	"| -9 |"
	"| -10 |"
	"| -11 |"
	"| -014 |"
	"| -0015 |"
	"| -00016 |"
	"| -99 |"
	"| -100 |"
	"| -101 |"
	"| 2147483647 |"
	"| -2147483648 |"
	"| -0000000001 |"
	"| 000000000000 |"
	"| -000000000001 |"
	"| -0000000000001 |"
	"| -00000000000001 |"
	"| 2147483647 -2147483648 -0000000001 000000000000 -000000000001 00000000000000 -00000000000042
	"| 0 |"
	"| 4294967295 |"
	"| 001 |"
	"| 0009 |"
	"| 10 |"
	"| 11 |"
	"| 015 |"
	"| 0016 |"
	"| 00017 |"
	"| 99 |"
	"| 100 |"
	"| 101 |"
	"| 4294967287 |"
	"| 4294967286 |"
	"| 4294967285 |"
	"| 4294967282 |"
	"| 4294967281 |"
	"| 4294967280 |"
	"| 4294967197 |"
	"| 4294967196 |"
	"| 4294967195 |"
	"| 2147483647 |"
	"| 2147483648 |"
	"| 04294967295 |"
	"| 000000000000 |"
	"| 0004294967295 |"
	"| 00004294967295 |"
	"| 000004294967295 |"
	"| 2147483647 2147483648 04294967295 000000000000 0004294967295 00000000000000 000004294967254
	"| 0 |"
	"| ffffffff |"
	"| 001 |"
	"| 0009 |"
	"| a |"
	"| 0b |"
	"| 00f |"
	"| 0010 |"
	"| 00011 |"
	"| 63 |"
	"| 64 |"
	"| 065 |"
	"| fffffff7 |"
	"| fffffff6 |"
	"| fffffff5 |"
	"| fffffff2 |"
	"| fffffff1 |"
	"| fffffff0 |"
	"| ffffff9d |"
	"| ffffff9c |"
	"| ffffff9b |"
	"| 07fffffff |"
	"| 0080000000 |"
	"| 000ffffffff |"
	"| 000000000000 |"
	"| 00000ffffffff |"
	"| 000000ffffffff |"
	"| 0000000ffffffff |"
	"| 07fffffff 0080000000 000ffffffff 000000000000 00000ffffffff 00000000000000 0000000ffffffd6
	"| 0 |"
	"| FFFFFFFF |"
	"| 001 |"
	"| 0009 |"
	"| A |"
	"| 0B |"
	"| 00F |"
	"| 0010 |"
	"| 00011 |"
	"| 63 |"
	"| 64 |"
	"| 065 |"
	"| FFFFFFF7 |"
	"| FFFFFFF6 |"
	"| FFFFFFF5 |"
	"| FFFFFFF2 |"
	"| FFFFFFF1 |"
	"| FFFFFFF0 |"
	"| FFFFFF9D |"
	"| FFFFFF9C |"
	"| FFFFFF9B |"
	"| 07FFFFFFF |"
	"| 0080000000 |"
	"| 000FFFFFFFF |"
	"| 000000000000 |"
	"| 00000FFFFFFFF |"
	"| 000000FFFFFFFF |"
	"| 0000000FFFFFFFF |"
	"| 07FFFFFFF 0080000000 000FFFFFFFF 000000000000 00000FFFFFFFF 00000000000000 0000000FFFFFFD6 |"
)

# Step 4: Read the result file line by line and compare with expected outputs
line_number=0
while IFS= read -r result_line; do
	expected_line="${expected_outputs[$line_number]}"
	echo "$result_line "| $expected_line : $(if [ "$result_line" = "$expected_line" ]; then echo "OK"; else echo "KO"; fi)"
	line_number=$((line_number + 1))
done < result.txt

# Cleanup (optional)
# rm -f lol result.txt
