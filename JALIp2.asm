.text
	main:
	
         la $a0,prompt # Prompt user for string
         li $v0,4
         syscall

         li $v0,8 #take in input
         la $a0, buffer #load byte space into address
         li $a1, 20 # allot the byte space for string
         move $t0,$a0 #save string to t0
         syscall
         
         la $t3, ($t0) # Load the address of the string into $t3
         li $t2, 0 # Ascii sum
         li $t4, -1 # String length
         loop:
         
    	lb   $t1, 0($t3) # Load the first character into $t1
    	beq  $t1, $zero, continue
    	addiu $t3, $t3, 1 # Move to the next character
    	addiu $t4, $t4, 1 # Add 1 to the length
    	
	j loop
	
	continue:
         move $a0, $t0
         move $a1, $t4
         beq $t4, 0, end # If user entered empty string, no need to call hash
         jal  hash
         
	 li $v0, 1
         move $a0, $v1
         syscall
         
         bne $t4, 0, main # If the user entered a non-empty string, go back to the beginning
         
         end:
         li $v0,10 #end program
       	 syscall
         

         
	hash: 
	#$a0 contains the address of the first character
	#$a1 contains the length of the string
	addi $sp, $sp, -8
	sw $t0, 4($sp)
	sw $t1, 0($sp)
	la $t0, 0($a0)
	move $t1, $a1
	li $v1, 0
	li $t6, 31
	li $t9, 1
	sum:
	lb   $t5, 0($t0) # Load the first character into $t5
	move $t8, $t1
	
	#Calculate 31^i
	pow:
	multu $t6, $t9
	mflo $t9
	addi $t8, $t8, -1
	bne $t8, 0, pow
	
	multu $t5, $t9
    	mflo $t7
    	add $v1, $v1, $t7
	addi $t0, $t0, 1 # Move to the next character
	addi $t1, $t1, -1 # Decrement looper 
	bne $t1, 0, sum
	
	lw $t0, 4($sp) 
	lw $t1, 0($sp) 
	addi $sp, $sp, 8
	
	li $t4, 1
	sll $t4, $t4, 31
	addiu $t4, $t4, -1
	and $v1, $v1, $t4
	jr $ra
	
.data
             buffer: .space 30
             prompt: .ascii "\nEnter number to get hash code(max 20 chars): \n"
