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
	move $t8, $v0 # Store m into $t8
	li $t0, 1
	#lw $t1, 0($a0) # where $a0 contains the address of the value of m
	sllv $t0, $t0, $t8
	addi $t0, $t0, -1 # subtract 1. Now $t0 contains the mask, 2^m - 1
	
	li $v0, 4
	la $a0, message	# Tell the user what the period is
	syscall
	
		
	
	# fibonacci numbers
	li $t1, 1
	li $t2, 1
	
	li $t7, 1 # Use $t7 to check if the modulo is 1
	
	addi $t4, $t4, 0 # Loop counter for period
	
loop:
	addu $t3, $t1, $t2 # Create next Fibonacci number
	addi $t1, $t2, 0
	addi $t2, $t3, 0
	#move $t1, $t2 
	#move $t2, $t3
	
	and $t5, $t1, $t0 # Store $t1 mod 2^m into $5
	and $t6, $t2, $t0 
	addi $t4, $t4, 1
	
	
	bne $t6, $t7, loop # if the modulus isn't equal to 1, loop again	
	bne $t5, $t7, loop

	
	li $v0, 1
	move $a0, $t4
	syscall
