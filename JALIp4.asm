.data
debug: .asciiz ":\t addi\n"
opcodes: .ascii "add  ", "addi ", "addiu", 
.text
addi $t0, $t0, 21
la $a1, 0x00400000
lw $t1, 0($a1)

syscall
srl $t1, $t1, 26
sll $t1, $t1, 26
add $a0, $zero, $t1
li $v0, 35
syscall

lw $t1, 4($a1)
srl $t1, $t1, 26
add $a0, $zero, $a1
li $v0, 34
syscall

la $a0, debug
li $v0, 4
syscall

li $t5, 0
loop:
beq $t5, 10, end
#la $a0, debug
add $a0, $zero, $a1
li $v0, 34
syscall

addi $a1, $a1, 4

la $a0, opcodes
li $v0, 4
syscall
addi $t5, $t5, 1
j loop

end:
