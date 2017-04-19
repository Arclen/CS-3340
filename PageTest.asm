.text
li $a1, 0x00400000
loop:
lw $t1, 0($a1)
addi $t2, $t1, -32
beq $t2, $0, fin
add $a0, $0, $t1
li $v0, 34
syscall
addi $a0, $0, 0xA
addi $v0, $0, 0xB 
syscall
addi $a1, $a1, 4
j loop
add $0,$0,$0
fin:
