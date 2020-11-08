.text
addi $r4, $r0, 1 # a = 1
addi $r5, $r0, 2 # b = 2
addi $r6, $r0, 3 # c = 3
addi $r7, $r0, 4 # d = 4
addi $r11, $r0, 25 # 25 iterations
sw $r5, 1($r0)

# function takes four arguments: a,b,c,d
# x = a + b
# y = x * c
# z = y - d
foo:
addi $r12, $r12, 1 # i, counter
add $r16, $r4, $r0
add $r17, $r5, $r0
add $r18, $r6, $r0
add $r19, $r7, $r0
add $r8, $r16, $r17
mul $r9, $r8, $r18
sub $r10, $r9, $r19
add $r4, $r10, $r0 # a = z
bne $r12, $r11, foo # foo repeats until i = 25

# function takes one argument: a
# divides a by 2 and does extra work
goo:
add $r16, $r4, $r0
lw $r17, 1($r0)
sub $r18, $r0, $r5
mul $r18, $r4, $r5
div $r8, $r16, $r17
add $r17, $r18, $r0
blt $r8, $r11, goo # goo repeats until a/2 < 25
