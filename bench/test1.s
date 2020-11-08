.text
main:
    # boilerplate from https://ecs-network.serv.pacific.edu/ecpe-170/tutorials/example5_function_with_stack.asm/view
	# Register assignments
	# $r16 = x
	# $r17 = y

	# Initialize registers
	addi	$r16, $r0, 0	# Reg $s0 = $r16 = 0
	addi	$r17, $r0, 1	# Reg $s1 = $r17 = 1
    addi	$r18, $r0, 25	# Number of iterations, z

	# Call function
	add $r4, $r16, $r0      # Argument 1: x ($r16)
    add $r5, $r17, $r0      # Argument 2: y ($r17)
	jal	fun		            # Save current PC in $ra, and jump to fun
	add	$r17, $r2, $r0	    # Return value saved in $r2. This is y ($r17)

	# Exit
	j exit

# ------------------------------------------------------------------
	
	# FUNCTION: fibonacci with a twist
	
fun:	# This function may overwrite $r16 and $r17
	    # We should save those on the stack
	addi $r29, $r29, -12	# Adjust stack pointer
	sw $r16, 8($r29)		# Save $r16
	sw $r17, 4($r29)		# Save $r17
	sw $r18, 0($r29)		# Save $r18

	add $r8, $r0, $r0		# initialize counter to 0
	add $r9, $r0, $r0		# initialize every two counter to 0
	add $r10, $r0, $r0		# initialize every three counter to 0
	addi $r24, $r0, 2		# initialize $r24 to 1 for comparison
	addi $r25, $r0, 3		# initialize $r25 to 2 for comparison

loop:
	addi $r8, $r8, 1		# increment counter by 1
	addi $r9, $r9, 1		# increment counter by 1
	addi $r10, $r10, 1		# increment counter by 1

    add $r11, $r5, $r0		# temp to store second argument
    add $r5, $r4, $r5		# add first and second argument, save result as 
    add $r4, $r11, $r0		# $r17 now first argument of next iteration

	bne $r9, $r24, conttwo

twos:
	addi $r9, $r9, -2		# reset two counter
	addi $r4, $r4, -1		# reduce x by 1

conttwo:
	bne $r10, $r25, contthree

three:	
	addi $r10, $r10, -3		# reset three counter
	addi $r5, $r5, -1		# reduce y by 1

contthree:

	lw $r18, 0($r29)		# Load $r18, max number of iterations
    blt $r8, $r18, loop		# continue iterating until z iterations are complete
	sw $r18, 0($r29)		# Save $r18

	add $r2, $r5, $r0		# Move return value to $r2

	# Restore saved register values from stack in opposite order
	lw $r18, 0($r29)		# Restore $r18
	lw $r17, 4($r29)		# Restore $r17
	lw $r16, 8($r29)		# Restore $r16
	addi $r29, $r29, 12		# Adjust stack pointer
	
	# Return from function
	jr $r31					# Jump to addr stored in $ra
	
# ------------------------------------------------------------------

exit:
