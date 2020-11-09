addi 	$4, $0, 1		# a = 1
addi 	$5, $0, 2		# b = 2
addi 	$6, $0, 3		# c = 3
addi 	$7, $0, 4		# d = 4
addi 	$11, $0, 15		# m = 15 iterations
addi 	$13, $13, 20	# n = 20 iterations
addi 	$29, $29, -16	# Adjust stack pointer, start of function
sw		$16, 12($29)	# Save $16
sw		$17, 8($29)		# Save $17
sw		$18, 4($29)		# Save $18
sw		$19, 0($29)		# Save $19
addi 	$12, $12, 1		# i, counter, function takes four arguments: a,b,c,d
add 	$16, $4, $0
add 	$17, $5, $0
add 	$18, $6, $0
add 	$19, $7, $0
add 	$8, $16, $17	# a + b
mul 	$9, $8, $18		# (a + b) * c
addi 	$20, $20, 1		# pad with noop
addi 	$21, $21, 1		# pad with noop
addi 	$22, $22, 1		# pad with noop
sub 	$10, $9, $19	# z = ((a + b) * c) - d
add 	$4, $10, $0		# a = z
addi	$7, $4, -1
lw		$19, 0($29)		# restore $19
lw		$18, 4($29)		# restore $18
lw 		$17, 8($29)		# restore $17
lw 		$16, 12($29)	# restore $16
addi 	$29, $29, 16	# Adjust stack pointer, end of function
blt 	$12, $11, -24	# foo repeats until i = m
div 	$4, $4, $8
addi 	$20, $20, 1		# pad with noop
addi 	$21, $21, 1		# pad with noop
addi 	$22, $22, 1		# pad with noop
blt 	$12, $13, -29	# foo repeats until i = n
addi 	$4, $0, 1000	# a = 1000
addi 	$6, $0, 3		# c = 5
addi 	$7, $0, 8		# d = 8
jal 48
add 	$16, $4, $0		# goo
add 	$17, $17, $0	# beginning of loop
sub 	$18, $0, $5
mul 	$18, $6, $7
div 	$16, $16, $7	# a / 2
addi	$17, $17, 1
addi 	$18, $18, -1
blt 	$11, $16, -7 	# goo repeats until a/2 < m
j 52
addi	$5, $0, 10		# b = 10
addi 	$11, $0, 25		# m = 25
sub 	$7, $5, $7		# d = b - d
jr $31
add 	$12, $0, $0
addi	$13, $0, 20		# counter, i
add		$14, $13, $13
and		$15, $12, $13
mul		$16, $15, $14
addi	$13, $13, -1
addi	$12, $12, 1
bne		$13, $0, -6
addi 	$1, $0, 1		# exit with code 1