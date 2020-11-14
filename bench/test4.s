addi	$4, $0, 1			# n = 1
add		$8, $0, $0			# i = 0, counter
addi	$9, $0, 25			# i_max = 25
addi	$8, $8, 1			# i = i + 1, start of loop
addi 	$29, $29, -8		# Adjust stack pointer, save temps before function call
sw		$8, 4($29)			# Save $8
sw		$9, 0($29)			# Save $9
jal 24						# Jump & Link to Triangular Number function
lw		$9, 0($29)			# Restore $9
lw		$8, 4($29)			# Restore $8
addi 	$29, $29, 8			# Adjust stack pointer, restore temps after function call
add		$10, $2, $10		# b = sum of sums of first n natural numbers
addi	$4, $4, 1			# n = n + 1
blt		$8, $9, -11			# if i < i_max, loop
add		$2, $0, $0			# Reset return value 
add		$8, $0, $0			# Reset counter
add		$4, $10, $0			# n = b
addi	$5, $0, 50			# k = 50
addi	$8, $8, 1			# i = i + 1, start of loop
jal 38
add		$4, $4, $2			# n = n + (n mod k)
addi	$4, $4, -1			# n = n - 1
blt		$8, $9, -5			# if i < i_max, loop
j 51						# Jump past both functions
addi 	$29, $29, -12		# Adjust stack pointer, start of function
sw		$16, 8($29)			# Save $16
sw		$17, 4($29)			# Save $17
sw		$18, 0($29)			# Save $18
addi	$8, $0, 2			# a = 2, we divide by 2 so need register with value of 2
addi 	$16, $4, 1			# x = n + 1
mul		$17, $16, $4		# y = x * n = n * (n + 1)
div		$18, $17, $8		# z = y / 2 = (n * (n + 1)) / 2
add		$2, $18, $0			# Return z
lw 		$18, 0($29)			# Restore $18
lw 		$17, 4($29)			# Restore $17
lw 		$16, 8($29)			# Restore $16
addi 	$29, $29, 12		# Adjust stack pointer, end of function
jr $31
addi 	$29, $29, -12		# mod takes two arguments, a and b, and returns result of a mod b
sw 		$16, 8($29)			# Save $16
sw 		$17, 4($29)			# Save $17
sw 		$18, 0($29)			# Save $18
div 	$16, $4, $5			# a mod b = a - (a/b) * b
mul 	$17, $16, $5
sub 	$18, $4, $17
add 	$2, $18, $0 		# Return result
lw 		$18, 0($29)			# Restore $18
lw 		$17, 4($29)			# Restore $17
lw 		$16, 8($29)			# Restore $16
addi 	$29, $29, 12		# Adjust stack pointer
jr $31
addi 	$1, $0, 1			# Return with Exit Code 1