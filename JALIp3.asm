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
	move $a0, $t0 # Store k into $t1
	move $a1, $t1 # Store k into $t1
	beq $t0, $zero, exit #if n and k are both zero, exit the program
continue:
	jal comb
	
	li $v0, 1
	move $a0, $v1
	syscall
	j start # return to start
exit:
	bne $t1, $zero, continue
	li $v0,10 		# End program
       	syscall
	
	
	
	
	comb:
sub $sp, $sp, 16
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $a0, 8($sp)
sw $a1, 12($sp)
jal fact
move $s0, $v1
lw $a0, 12($sp)
jal fact
div $s0, $s0, $v1
lw $a0, 8($sp)
lw $a1, 12($sp)
sub $a0, $a0, $a1
jal fact
div $s0, $s0, $v0
move $v1, $s0
lw $ra, 0($sp)
lw $s0, 4($sp)
addi $sp, $sp, 16
jr $ra
combo:
	addi $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $a0, 8($sp)
	sw $a1, 12($sp)
	beq $a0, $a1, equal   #see if n and k are equal
	beq $a1, $zero, zero
	
	
	addi $t0, $t0, -1
	addi $t1, $t1, -1
	jal combo
	addi $t0, $t0, -1
	jal combo

	li $v0, 1 
	add $a0, $zero, $v1
	syscall

	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addi $sp, $sp, 16
	jr $ra
	
zero:
	addi $v1, $v1, 1
	
	jr $ra
equal:
	
	li $v1, 1
	jr $ra
	
fact:  
	addi $sp, $sp, -8     # adjust stack for 2 items    
	sw   $ra, 4($sp)      # save return address    
	sw   $a0, 0($sp)      # save argument    
	slti $t0, $a0, 1      # test for n < 1    
	beq  $t0, $zero, L1    
	addi $v1, $zero, 1    # if so, result is 1    
	addi $sp, $sp, 8      #   pop 2 items from stack    
	jr   $ra              #   and return
L1:
	addi $a0, $a0, -1     # else decrement n      
	jal  fact             # recursive call    
	lw   $a0, 0($sp)      # restore original n    
	lw   $ra, 4($sp)      #   and return address    
	addi $sp, $sp, 8      # pop 2 items from stack    
	mul  $v1, $a0, $v1    # multiply to get result    
	jr   $ra              # and return
