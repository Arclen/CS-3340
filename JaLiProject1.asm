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
	
	move $t0, $v0
	
	li $v0, 4
	la $a0, message
	syscall
	
	li $v0, 1 
	move $a0, $t0
	addi $t4, $t4, 1
	addi $t2, $t2, 2
	li $t1, 1 # t1 is our counter (i)
	loop:
	beq $t0, 1, end 
	addi $t0, $t0, -1 # add 1 to t1
	mult $t4, $t2
	mflo $t4
	j loop # jump back to the top
	end:
	addi $t3, $t3, 3
	mult $t3, $t4
	mflo $t3
	move $a0, $t3
	syscall
