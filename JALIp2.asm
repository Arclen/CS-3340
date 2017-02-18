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
    	add $t2, $t2, $t1 
	j loop
	
	continue:
         move $a0, $t3
         move $a1, $t4
         
         beq $t4, 0, end # If user entered empty string, no need to call hash
         jal  hash
         
	 li $v0, 1
         move $a0, $t2
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
	move $t0, $a0
	add $t1, $t1, $a1
	sum:
	lb   $t5, 0($t0) # Load the first character into $t1
	addi $t1, $t1, -1
	addiu $t0, $t0, 1
	bne $t1, 0, sum
	
	lw $t0, 4($sp) 
	lw $t1, 0($sp) 
	addi $sp, $sp, 8
	jr $ra
	
.data
             buffer: .space 30
             prompt:  .ascii "\nEnter number to get hash code(max 20 chars): \n"
