.text
main:
addi $r1, $r0, 10
addi $r2, $r0, 25
addi $r3, $r0, 42
addi $r10, $r0, 100
add $r9, $r0, $r0
add $r4, $r0, $r0
loopstart:
add $r5, $r1, $r1
add $r6, $r5, $r2
add $r7, $r6, $r3
addi $r8, $r7, -86 # first counter
sw $r4, 1($r0)
sw $r8, 2($r0)
bne $r9, $r0, odd
even:
addi $r9, $r9, 1
j loopend
odd:
add $r4, $r1, $r0
addi $r9, $r9, -1
add $r8, $r9, $r0
loopend:
lw $r8, 2($r0)
bne $r8, $r10, loopstart
addi $r4, $r4, 1 # second counter
addi $r8, $r8, -100
bne $r4, $r1, loopstart
