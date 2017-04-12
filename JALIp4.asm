.data
debug: .asciiz ":\t placeholder"
.text
li $t0, 21
la $a0, 0x00400000
li $v0, 1
syscall