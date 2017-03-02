.data
	promptn: .asciiz "\nEnter the value of n: "
	promptk: .asciiz "Enter the value of k: "
	debug: .asciiz "\nTEST\n"
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
	move $a2, $t0 
	move $a1, $t1 
	beq $t0, $zero, exit #if n and k are both zero, exit the program
continue:
	li $v1, 0
	jal combo
	
	li $v0, 1
	move $a0, $v1
	syscall
	j start # return to start
exit:
	bne $t1, $zero, continue
	li $v0,10 		# End program
       	syscall
	
	
	

combo:
	addi $sp, $sp, -12     # adjust stack for 2 items    
	sw   $ra, 0($sp)      # save return address    
	sw   $a2, 4($sp)      # save argument
	sw   $a1, 8($sp)
	
	bne $a2, $a1, L1   #see if n and k are equal
	
	addi $v1, $v1, 1
	jr $ra
	
	
L1:
	#li $v0, 4
	#la $a0, debug
	#syscall
	
	beq $a1, $zero, skip
	
	addi $a2, $a2, -1
	addi $a1, $a1, -1
	jal combo
	
	addi $a2, $a2, -1
	jal combo
	lw $ra, 0($sp)		#infinite loop starts here
	lw   $a2, 4($sp)
	lw   $a1, 8($sp)
	addi $sp, $sp, 12
	
	jr $ra
skip: 
	lw $ra, 0($sp)
	addi $v1, $v1, 1
	jr $ra
