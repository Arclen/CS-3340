.data
debug: .asciiz ":\t addi\n"
.text
addi $t0, $t0, 21
la $a1, 0x00400000
lw $t1, 0($a1)

srl $t1, $t1, 26
add $a0, $zero, $t1
li $v0, 1
syscall

lw $t1, 4($a1)
srl $t1, $t1, 26
add $a0, $zero, $a1
li $v0, 34
syscall

la $a0, debug
li $v0, 4
syscall

loop:
#beq something
la $a0, debug
li $v0, 4
#syscall
add $a0, $zero, $a1
#la $a0, addi
li $v0, 34
syscall
addi $a1, $a1, 4

#j loop
