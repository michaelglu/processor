add		$2, $0, $0			# keeps track of number of branch instructions
addi 	$5, $0, 1			# a
addi 	$6, $0, 2			# b
addi 	$7, $0, 4			# c
addi 	$8, $0, 0			# i, counter
addi 	$9, $0, 0			# j, counter
addi	$10, $0, 0			# k, counter
addi 	$11, $0, 2			# i_max
addi 	$12, $0, 50			# j_max
addi	$13, $0, 4			# k_max
addi 	$14, $0, 1			# q = even/odd var, loop starts here
addi 	$8, $8, 1			# i = i + 1
add 	$5, $5, $6			# a = a + b
add 	$15, $5, $7			# y = a + b + c
addi	$2, $2, 1			# increment branch counter by 1
bne 	$14, $0, 3			# if q is odd, goto ODD
sub 	$16, $14, $7		# EVEN, i.e. q = 0
j 21						# jump to loop end
add 	$6, $6, $14			# ODD, b = b + 1
addi 	$14, $14, -1		# q = 0
addi	$2, $2, 1			# increment branch counter by 1
bne 	$8, $11, -12		# loop end, branch to loop start if i != i_max
add 	$8, $0, $0			# i = 0
addi 	$9, $9, 1 			# j = j + 1
addi	$2, $2, 1			# increment branch counter by 1
bne 	$9, $12, -16		# branch to loop start if j != j_max
add 	$9, $0, $0			# j = 0
addi 	$10, $10, 1 		# k = k + 1
addi	$2, $2, 1			# increment branch counter by 1
bne 	$10, $13, -19		# branch to loop start if k != k_max
addi 	$1, $0, 1			# return with Exit Code 1
