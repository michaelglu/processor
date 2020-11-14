addi	$16, $0, 0			# reg $16 = 0
addi	$17, $0, 1			# reg $17 = 1
addi	$18, $0, 125		# Number of iterations, z
addi	$19, $0, 250		# Number of iterations, m
add		$4, $16, $0			# Agument 1: x ($16)
add		$5, $17, $0 		# Agument 2: y ($17)
jal	9						# Save current PC in $ra, and jump to fun
add		$17, $3, $0			# return value saved in $3. This is y ($17)
j 45						# jump to exit
addi 	$29, $29, -12		# Adjust stack pointer, start of function
sw		$16, 8($29)			# Save $16
sw		$17, 4($29)			# Save $17
sw		$18, 0($29)			# Save $18
add 	$8, $0, $0			# i = 0, counter
add 	$9, $0, $0			# j = 0, counter
add 	$10, $0, $0			# k = 0, counter
addi 	$24, $0, 2			# initialize $24 to 2 for comparison
addi 	$25, $0, 3			# initialize $25 to 3 for comparison
addi 	$8, $8, 1			# i = i + 1, start of loop
addi 	$9, $9, 1			# j = j + 1
addi 	$10, $10, 1			# k = k + 1
add 	$11, $5, $0			# temp to store second argument
add 	$5, $4, $5			# b = a + b
add 	$4, $11, $0			# old b now first argument of next iteration
addi	$2, $2, 1			# increment branch counter by 1
bne 	$9, $24, 3			# branch to cont_two
add 	$9, $0, $0			# j = 0, reset counter if $9 = 2
sub		$5, $5, $4			# b = b - a
j 30						# jump past cont_two
addi 	$20, $20, 1			# keeps track of how many times cont_two occurred
addi	$2, $2, 1			# increment branch counter by 1
bne 	$10, $25, 3			# branch to cont_three
add 	$10, $0, $0			# k = 0, reset counter if $10 = 3
addi	$4, $4, 1			# a = a + 1
j 36						# jump past cont_three
addi 	$21, $21, 1			# keeps track of how many times cont_three occurred
addi	$2, $2, 1			# increment branch counter by 1
blt 	$8, $18, -20		# continue iterating until z iterations are complete
blt		$8, $19, -21
add 	$3, $5, $0			# Move return value to $3
lw		$18, 0($29)			# restore $18
lw 		$17, 4($29)			# restore $17
lw 		$16, 8($29)			# restore $16
addi 	$29, $29, 12		# Adjust stack pointer
jr $31						# Jump to address stored in $ra
addi 	$1, $0, 1			# return with Exit Code 1