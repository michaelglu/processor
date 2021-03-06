addi	$4, $0, 1			# a = 1
addi	$5, $0, 1			# b = 1
addi	$6, $0, 1			# c = 1
addi	$8, $0, 0			# i, counter
addi	$9, $0, 0			# p, parity
addi	$10, $0, 30			# i_max
addi	$11, $0, 0			# s, sum of f(n) and p(n) terms
addi	$8, $8, 1			# i = i + 1, loop start
addi	$9, $9, 1			# p = p + 1
addi	$2, $2, 1			# increment branch counter
bne		$9, $0, 7			# if odd, branch to padovan pre-fun setup
addi 	$29, $29, -4		# adjust stack pointer, save temps before function call
sw		$8, 0($29)			# save $8
jal 35						# jump to fibonacci
lw		$8, 0($29)			# restore $8
addi 	$29, $29, 4			# adjust stack pointer, restore temps after function call
add		$11, $11, $5		# s = s + f(i)
j 25						# jump past call to padovan
addi	$9, $9, -2			# p = -1
addi 	$29, $29, -4		# Adjust stack pointer, save temps before function call
sw		$8, 0($29)			# Save $8
jal 39						# jump to padovan
lw		$8, 0($29)			# Restore $8
addi 	$29, $29, 4			# Adjust stack pointer, restore temps after function call
add		$11, $11, $6		# s = s + p(i)
addi	$12, $12, 2			# v = v + 2
addi	$13, $9, 3			# w = p + 3
div		$15, $12, $13		# y = v / w
and		$14, $12, $13		# x = v ^ w
addi	$12, $12, 2			# v = v + 2
addi	$13, $9, 3			# w = p + 3
div		$15, $12, $13		# y = v / w
addi	$2, $2, 1			# increment branch counter
blt		$8, $10, -27		# loop until i = i_max
j 44						# jump to exit
# fibonacci
add		$8, $5, $0			# save what will be new second term
add		$5, $5, $4			# f(n) = f(n-1) + f(n-2)
add		$4, $8, $0			# move f(n-1) to f(n-2)
jr $31
# padovan
add		$8, $6, $0			# save what will be new second term 
add		$6, $5, $4			# p(n) = p(n-2) + p(n-3)
add		$4, $5, $0			# move p(n-2) to p(n-3)
add		$5, $8, $0			# move p(n-1) to p(n-2)
jr $31
# exit
addi	$1, $0, 1			# return with Exit Code 1