.data
debug: .asciiz ":\t placeholder"
.text
li $t0, 21
la $a1, 4194304
lw $t1, 0($a1)
add $a0, $a0, $t1
li $v0, 4
syscall
