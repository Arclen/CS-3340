.data
debug: .asciiz ":\t placeholder\n"
.text
li $t0, 21
la $a1, 0x00400000 #or 4194304
#lw $t1, 0($a1)
add $a0, $a0, $t1
li $v0, 1
syscall

loop:

addi $a1, $a1, 4
la $a0, debug
li $v0, 4
syscall

j loop
