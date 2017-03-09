.data
	promptn: .asciiz "\nEnter the value of n: "
.text
	# Prompt the user to enter n
	li $v0, 4
	la $a0, promptn
	syscall
	# Get n
	li $v0, 5
	syscall
	move $t0, $v0 # Store n into $t0
	move $a1, $t0
	
	jal root
	
	li $v0, 1
	move $a0, $v1
	syscall
	
	li $v0,10 		# End program
       	syscall
       	
       	
	root:
		li $t0, 1 # sum
		li $t2, 1 # i
		li $t1, 1 # N 
	loop:
		beq $a1, $t0, eq
		blt $a1, $t0, grt
		addi $t2, $t2, 2
		add $t0, $t0, $t2
		addi $t1, $t1, 1
		j loop
		
	eq: 	
		move $v1, $t1
		jr $ra
	grt:
		addi $t1, $t1, -1
		move $v1, $t1
		jr $ra
