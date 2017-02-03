.data
	prompt: .asciiz "Enter the value of m: "
	message: .asciiz "\nThe period is:  "
.text
	# Prompt the user to enter m.
	li $v0, 4
	la $a0, prompt
	syscall
	
	# Get m
	li $v0, 5
	syscall
	move $t0, $v0 # Store m into $t0
	
	li $v0, 4
	la $a0, message	# Tell the user what the period is
	syscall
	
	addi $t5, $t5, 1
	sllv $t5, $t5, $t0
	#addi $t5, $t5, -1 # $t5 contains 2^m - 1
	
	# fibonacci numbers
	addi $t1, $t1, 1
	addi $t2, $t2, 1
	
	addi $t0, $t0, 0 # Loop counter for period
	
	loop:
	add $t3, $t1, $t2 # Create next Fibonacci number
	move $t1, $t2 
	move $t2, $t3
	
	addi $t0, $t0, 1
	
	beq $t6, $t7, end
	j loop # jump back to the loop
	end:
	
	li $v0, 1
	move $a0, $t0
	syscall