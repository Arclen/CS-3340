.data
	prompt: .asciiz "Enter the value of m: "
	message: .asciiz "\nThe period is: "
.text
	# Prompt the user to enter m.
	li $v0, 4
	la $a0, prompt
	syscall
	
	# Get m
	li $v0, 5
	syscall
	move $t7, $v0 # Store m into $t8
	li $t0, 1
	sllv $t0, $t0, $t7 # Shift $t0 over m places, so multiplying by 2^m
	addi $t0, $t0, -1 # Subtract 1. Now $t0 contains the mask, 2^m - 1	
	
	# Load the first two fibonacci numbers 
	li $t1, 1
	li $t2, 1
	
	addi $t4, $t4, 0 # Loop counter for period
	
loop:
	addu $t3, $t1, $t2 # Create next Fibonacci number
	move $t1, $t2 
	move $t2, $t3
	addi $t4, $t4, 1 # Increment the counter
	
	and $t5, $t1, $t0 # Store $t1 mod 2^m into $5
	and $t6, $t2, $t0 
	
	bne $t6, 1, loop # If the modulus isn't equal to 1, loop again
	bne $t5, 1, loop

	li $v0, 4
	la $a0, message	# Tell the user what the period is
	syscall
	li $v0, 1
	move $a0, $t4 # Print the period
	syscall
