addi 	$4, $0, 0 			# a
addi 	$5, $0, 3			# b
addi 	$16, $16, 0			# stores result
addi 	$17, $0, 24			# max b
addi	$21, $0, 0			# parity
addi 	$22, $0, 2			# compare
addi 	$8, $8, 1			# i = i + 1, start of loop
jal 14
add 	$10, $3, $0			# remainder
add 	$16, $16, $10
addi 	$4, $4, 1			# a = a + 1
add		$2, $2, 1			# increment branch counter
blt 	$8, $17, -7			# loop b times
j 30						# exit program
addi 	$29, $29, -12		# mod takes two arguments, a and b, and returns result of a mod b
sw 		$16, 8($29)			# Save $16
sw 		$17, 4($29)			# Save $17
sw 		$18, 0($29)			# Save $18
add		$0, $0, $0			# noop
div 	$16, $4, $5			# a mod b = a - (a/b) * b
add		$0, $0, $0			# noop
mul 	$17, $16, $5
add		$0, $0, $0			# noop
sub 	$18, $4, $17
add 	$3, $18, $0 		# puts result in register $v0
lw 		$18, 0($29)			# restore $18
lw 		$17, 4($29)			# restore $17
lw 		$16, 8($29)			# restore $16
addi 	$29, $29, 12		# Adjust stack pointer
jr $31
addi	$23, $23, 1			# j = j + 1
addi	$21, $21, 1			# p = p + 1
add		$0, $0, $0			# noop
blt		$17, $23, 3			# branch to exit
bne		$21, $22, -5		# branch if p != 2
add		$21, $0, $0			# reset parity
j 30						# jump if p = 0
addi 	$1, $0, 1			# exit with code 1 
