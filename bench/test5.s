add		$4, $0, $0			# a = 0, same as counter
addi	$8, $0, 2			# used for 26 function
addi	$9, $0, 3
addi	$10, $0, 4
addi	$11, $0, 5
addi	$12, $0, 7			# a_max
addi	$13, $0, 0			# sum
addi	$4, $4, 1			# a = a + 1, start of loop
add		$5, $11, $0			# b = 5
jal 31
addi	$2, $2, 1			# increment branch counter by 1
bne		$3, $0, 1			# skip next instruction if result != 0
jal 40
add		$5, $10, $0			# b = 4
jal 31
addi	$2, $2, 1			# increment branch counter by 1
bne		$3, $0, 1			# skip next instruction if result != 0
jal 40
add		$5, $9, $0			# b = 3
jal 31
addi	$2, $2, 1			# increment branch counter by 1
bne		$3, $0, 1			# skip next instruction if result != 0
jal 40
add		$5, $8, $0			# b = 2
jal 31
addi	$2, $2, 1			# increment branch counter by 1
bne		$3, $0, 1			# skip next instruction if result != 0
jal 40
addi	$2, $2, 1			# increment branch counter by 1
blt		$4, $12, -23		# loop
j 42						# jump to exit
add		$0, $0, $0			# noop
div 	$16, $4, $5			# a mod b = a - (a/b) * b
add		$0, $0, $0			# noop
mul 	$17, $16, $5
add		$0, $0, $0			# noop
sub 	$18, $4, $17
addi	$14, $14, 1
add 	$3, $18, $0 		# Return result
jr $31
addi	$13, $13, 1			# increment sum by 1
jr $31
addi 	$1, $0, 1			# Return with Exit Code 1