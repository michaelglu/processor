addi $4, $0, 3 			# a
addi $5, $0, 3			# b
addi $16, $16, 0		# stores result
addi $17, $0, 11		# max b
addi $8, $8, 1			# i = i + 1, start of loop
jal 12
add $10, $2, $0			# remainder
add $16, $16, $10
addi $4, $4, 1
blt $8, $17, -6			# loop b times
j 27					# exit program
addi $29, $29, -12		# mod takes two arguments, a and b, and returns result of a mod b
sw $16, 8($29)			# Save $16
sw $17, 4($29)			# Save $17
sw $18, 0($29)			# Save $18
div $16, $4, $5			# a mod b = a - (a/b) * b
add $0 $0 $0
mul $17, $16, $5
add $0 $0 $0
sub $18, $4, $17
add $2, $18, $0 		# puts result in register $v0
lw $18, 0($29)			# restore $18
lw $17, 4($29)			# restore $17
lw $16, 8($29)			# restore $16
addi $29, $29, 12		# Adjust stack pointer
jr $31
add $2, $16, $0
addi $1, $0, 1			# exit with code 1
