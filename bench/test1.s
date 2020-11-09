addi	$16, $0, 0		# reg $16 = 0
addi	$17, $0, 1		# reg $17 = 1
addi	$18, $0, 25		# Number of iterations, z
add		$4, $16, $0		# Agument 1: x ($16)
add		$5, $17, $0 	# Agument 2: y ($17)
jal	8					# Save current PC in $ra, and jump to fun
add		$17, $2, $0		# return value saved in $2. This is y ($17)
j 36					# jump to exit
addi 	$29, $29, -12	# Adjust stack pointer, start of function
sw		$16, 8($29)		# Save $16
sw		$17, 4($29)		# Save $17
sw		$18, 0($29)		# Save $18
add 	$8, $0, $0		# i = 0, counter
add 	$9, $0, $0		# j = 0, counter
add 	$10, $0, $0		# k = 0, counter
addi 	$24, $0, 2		# initialize $24 to 1 for comparison
addi 	$25, $0, 3		# initialize $25 to 2 for comparison
addi 	$8, $8, 1		# i = i + 1, start of loop
addi 	$9, $9, 1		# j = j + 1
addi 	$10, $10, 1		# k = k + 1
add 	$11, $5, $0		# temp to store second argument
add 	$5, $4, $5		# b = a + b
add 	$4, $11, $0		# old b now first argument of next iteration
bne 	$9, $24, 2
add 	$9, $0, $0		# j = 0
addi 	$20, $20, 1		# keeps track of how many times three_counter occurred
bne 	$10, $25, 2		# cont_two
add 	$10, $0, $0		# k = 0
addi 	$21, $21, 1		# keeps track of how many times two_counter occurred
lw 		$18, 0($29)		# Load $18, max number of iterations, cont_three
addi	$19, $19, 1		# counter to check program reached this point
blt 	$8, $18, -15	# continue iterating until z iterations ae complete
add 	$2, $5, $0		# Move return value to $2
lw 		$17, 4($29)		# rstore $17
lw 		$16, 8($29)		# restore $16
addi 	$29, $29, 12	# Adjust stack pointer
j 		$31				# Jump to add stored in $ra
addi 	$20, $0, 100
