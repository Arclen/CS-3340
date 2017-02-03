.text
	li $v0, 1
	addiu $t0, $t0, 18
	#sll $t0, $t0, 2
	andi $t0, 4
	
	
	move $a0, $t0
	syscall