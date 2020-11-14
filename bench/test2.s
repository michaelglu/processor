addi 	$4, $0, 1			# a = 1
addi 	$5, $0, 2			# b = 2
addi 	$6, $0, 3			# c = 3
addi 	$7, $0, 4			# d = 4
addi 	$11, $0, 15			# m, iterations
addi 	$13, $13, 35		# n, iterations
addi 	$29, $29, -16		# Adjust stack pointer, start of function
sw		$16, 12($29)		# Save $16
sw		$17, 8($29)			# Save $17
sw		$18, 4($29)			# Save $18
sw		$19, 0($29)			# Save $19
addi 	$12, $12, 1			# i, counter, function takes four arguments: a,b,c,d
add 	$16, $4, $0
add 	$17, $5, $0
add 	$18, $6, $0
add 	$19, $7, $0
add 	$8, $16, $17		# a + b
mul 	$9, $8, $18			# (a + b) * c
addi 	$20, $20, 1			# pad with noop
addi 	$21, $21, 1			# pad with noop
addi 	$22, $22, 1			# pad with noop
sub 	$10, $9, $19		# z = ((a + b) * c) - d
add 	$4, $8, $0			# a = z
addi	$8, $8, 1
lw		$19, 0($29)			# restore $19
lw		$18, 4($29)			# restore $18
lw 		$17, 8($29)			# restore $17
lw 		$16, 12($29)		# restore $16
addi 	$29, $29, 16		# Adjust stack pointer, end of function
addi	$2, $2, 1			# increment branch counter
blt 	$12, $11, -25		# foo repeats until i = m
addi 	$4, $12, 1
addi 	$20, $20, 1			# pad with noop
addi 	$21, $21, 1			# pad with noop
addi 	$22, $22, 1			# pad with noop
addi	$2, $2, 1			# increment branch counter
blt 	$12, $13, -31		# foo repeats until i = n
addi 	$1, $0, 1			# exit with code 1