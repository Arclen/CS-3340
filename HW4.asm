.text
	
	root:
		li $t0, 1 # sum
		li $t2, 1 # i
		li $t1, 1 # N 
	loop:
		beq $a0, $t0, eq
		blt $a0, $t0, grt
		addi $t2, $t2, 2
		add $t0, $t0, $t2
		addi $t1, $t1, 1
		
	eq: 	
		move $v0, $t1
		jr $ra
	grt:
		subi $t1, $t1, -1
		move $v0, $t1