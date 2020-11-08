addi $1, $0, 10
addi $2, $0, 25
addi $3, $0, 42
addi $10, $0, 100
add $9, $0, $0
add $4, $0, $0
add $5, $1, $1	# loop starts here
add $6, $5, $2
add $7, $6, $3
addi $8, $7, -86	# first counter
sw $4, 1($0)
sw $8, 2($0)
bne $9, $0, 2
addi $9, $9, 1	# even
j 18
add $4, $1, $0	# odd
addi $9, $9, -1
add $8, $9, $0
lw $8, 2($0)		# loop end
bne $8, $10, -14
addi $4, $4, 1 	# second counter
addi $8, $8, -100
bne $4, $1, -17
