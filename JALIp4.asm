.data
tab: .asciiz ":\t"
newline: .asciiz "\n"
opcodes: .word addop, addiop, addiuop
addop: .ascii "add  \t"
addiop: .ascii "addi \t"
addiuop: .ascii "addiu\t"

.text
addi $t0, $t0, 21

#load PC initial value onto $a1
la $a1, 0x00400000


loop:
lw $t1, 0($a1)

#Print PC value in hex
add $a0, $zero, $a1
li $v0, 34
syscall

la $a0, tab
li $v0, 4
syscall
la $a0, opcodes
li $v0, 4
#syscall

lw $t1, 0($a1)
#Only want the first 6 bits, because opcode is in the first 6 bits
#srl $t1, $t1, 26
#sll $t1, $t1, 26
add $a0, $zero, $t1
li $v0, 1
syscall

la $a0, newline
li $v0, 4
syscall
addi $t5, $t5, 1

addi $t2, $t1, -32
beq $t2, $0, end
addi $a1, $a1, 4

j loop

add $0,$0,$0
end:
