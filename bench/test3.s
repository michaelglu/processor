.text
# we will take the mod base a of every number from 0 to b, right-exclusive
# returns sum of remainders in register $v0
addi $r4, $r0, 0 
addi $r5, $r0, 3	# a
addi $r16, $r16, 0	# stores result
addi $r17, $r0, 11	# b,

loop:
	addi $r8, $r8, 1		# counter
	jal mod
	add $r10, $r2, $r0		# remainder
	add $r16, $r16, $r10
	addi $r8, $r8, 1
	add $r4, $r8, $r0
	blt $r8, $r17, loop		# loop b times
	j exit					# exit program

# -----------------------------------------------------------------------------
# mod takes two arguments, a and b, and returns result of 
# a mod b
mod:
	addi $r29, $r29, -12	# Adjust stack pointer
	sw $r16, 8($r29)		# Save $r16
	sw $r17, 4($r29)		# Save $r17
	sw $r18, 0($r29)		# Save $r18

	# a mod b = a - (a/b) * b
	div $r16, $r4, $r5
	mul $r17, $r16, $r5
	sub $r18, $r4, $r17

	add $r2, $r18, $r0 		# puts result in register $v0

	lw $r18, 0($r29)		# Restore $r18
	lw $r17, 4($r29)		# Restore $r17
	lw $r16, 8($r29)		# Restore $r16
	addi $r29, $r29, 12		# Adjust stack pointer
	jr $r31

exit:
	add $r2, $r16, $r0
