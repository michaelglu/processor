add		$1, $0, $0			# Exit Code
add		$2, $0, $0			# b, Branch Counter
addi	$4, $0, 0			# x
addi	$8, $0, 5			# k, multiplier
addi	$9, $0, 0			# two_counter
addi	$10, $0, 2			# two_max
addi	$11, $0, 0			# thr_counter
addi	$12, $0, 3			# thr_max
addi	$13, $0, 0			# fou_counter
addi	$14, $0, 4			# fou_max
addi	$15, $0, 400		# y_max
addi	$4, $4, 1			# x = x + 1, loop start
addi	$9, $9, 1			# two_counter++
addi	$11, $11, 1			# thr_counter++
addi	$13, $13, 1			# fou_counter++
addi	$2, $2, 1			# b = b + 1
blt		$13, $14, 3			# do fou_action?
mul		$20, $4, $14		
or		$21, $4, $13
add		$13, $0, $0			# reset fou_counter
addi	$2, $2, 1			# b = b + 1
blt		$11, $12, 4			# do thr_action?
addi	$20, $4, -1			
or		$21, $20, $4
addi	$4, $4, -1			# x = x - 1
add		$11, $0, $0			# reset thr_counter
addi	$2, $2, 1			# b = b + 1
blt		$9, $10, 4			# do two_action?
addi	$20, $4, 1			
or		$21, $20, $4
addi	$4, $4, 1			# x = x + 1
add		$9, $0, $0			# reset two_counter
mul		$5, $4, $8			# y = x * 5
addi	$2, $2, 1			# b = b + 1
blt		$5, $15, -24		# if y < y_max, loop
addi	$1, $0, 1			# Return with Exit Code 1