addi $r1, $r0, 15
sw   $r1, 0($r0)
lw   $r5, 0($r0)
addi $r2, $r0, 30
sw   $r2, 1($r0)
lw   $r6, 1($r0)
add  $r3, $r2, $r1
sw   $r3, 2($r0)
lw   $r7, 2($r0)
sub  $r4, $r1, $r2
sw   $r4, 3($r0)
lw   $r8, 3($r0)
