addi $1, $0, 1		# a
addi $2, $0, 2		# b
addi $3, $0, 3		# c
addi $4, $0, 0		# i, counter
addi $5, $0, 0		# j, counter
addi $6, $0, 20		# max i
addi $7, $0, 10		# max j
addi $8, $0, 1		# q = even/odd var, loop starts here
addi $4, $4, 1		# i = i + 1
add $1, $1, $2
add $9, $1, $3		# y = a + b + c
bne $8, $0, 3		# if q is odd, goto 14
sub $10, $8, $3		# even, i.e. q = 0
j 16				# jump to loop end
add $2, $2, $9		# odd, b = b + 1
addi $8, $8, -1		# q = 0
bne $4, $6, -10		# loop end, branch to loop start if i =/= max i
add $4, $0, $0		# i = 0
addi $5, $5, 1 		# j = j + 1
bne $5, $7, -13		# branch to loop start if j =/= max j
addi $11, $0, 100	
