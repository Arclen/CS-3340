.data
	promptn: .asciiz "\nEnter the value of n: "
	promptk: .asciiz "Enter the value of k: "
.text

start:	
	# Prompt the user to enter n
	li $v0, 4
	la $a0, promptn
	syscall
	# Get n
	li $v0, 5
	syscall
	move $t0, $v0 # Store n into $t0
	
	# Prompt the user to enter k
	li $v0, 4
	la $a0, promptk
	syscall
	# Get k
	li $v0, 5
	syscall
	move $t1, $v0 # Store k into $t1
	jal combo
	j start # return to start
	
combo:
	beq $t0, $t1, equal #see if n and k are equal
	beq $t1, $zero, zero
	
	addi $t0, $t0, -1
	addi $t1, $t1, -1
	jal combo
	addi $t0, $t0, -1
	jal combo

	jr $ra
	
zero:
	li $v0, 1 #otherwise, print 1
	li $a0, 1
	syscall
	
	jr $ra
equal:
	beq $t0, $zero, exit #if n and k are both zero, exit the program
	
	li $v0, 1 #otherwise, print 1
	li $a0, 1
	syscall
	
	jr $ra
	
exit:
	li $v0,10 		# End program
       	syscall
