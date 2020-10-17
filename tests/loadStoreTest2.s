addi $r1, $r0, 1
addi $r2, $r0, 2
addi $r3, $r0, 3
addi $r4, $r0, 4
addi $r5, $r0, 5
sw $r1, 1($r0)
sw $r2, 2($r0)
sw $r3, 3($r0)
sw $r4, 4($r0)
sw $r5, 5($r0)
addi $r1, $r0, 0
addi $r2, $r0, 0
addi $r3, $r0, 0
addi $r4, $r0, 0
addi $r5, $r0, 0
lw $r5, 1($r0)
lw $r4, 2($r0)
lw $r3, 3($r0)
lw $r2, 4($r0)
lw $r1, 5($r0)
