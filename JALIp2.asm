# Jacob Liou CS 3340 Project 2
# I really tried my hardest on this one, but couldn't get it to work unfortunately
# I did have fun however, so it's not all bad 
.data
             buffer: .space 30
             prompt: .ascii "\nEnter number to get hash code(max 20 chars): \n"

.text
	main:
	
         la $a0,prompt		# Prompt user for string
         li $v0,4
         syscall

         li $v0,8 		# Set $v0 to take input
         la $a0, buffer		# Load buffer space into address
         li $a1, 20 		# Set aside the byte space for string
         move $t0, $a0 		# Store string in $t0
         syscall
         
         la $t3, ($t0) 		# Load the address of the string into $t3
         li $t4, -1 		# t4 will hold the String length
         
         loop:
         
    	 lb   $t1, 0($t3) 	# Load the first character into $t1
    	 beq  $t1, $zero, continue
    	 addiu $t3, $t3, 1 	# Move to the next character
    	 addiu $t4, $t4, 1 	# Add 1 to the length
    	
	 j loop
	
	 continue:
         move $a0, $t0
         move $a1, $t4
         beq $t4, 0, end 	# If user entered empty string, no need to call hash
         jal  hash		# Function call
         
	 li $v0, 1		# Set $v0 to return an integer
         move $a0, $v1		# Return the result, stored in $v1
         syscall
         
         bne $t4, 0, main 	# If the user entered a non-empty string, go back to the beginning
         
         end:
         li $v0,10 		# End program
       	 syscall
         

         
	hash: 			#$a0 contains the address of the first character
				#$a1 contains the length of the string
	addi $sp, $sp, -8	# Set aside stack space for two items
	sw $t0, 4($sp)
	sw $t1, 0($sp)
	la $t0, 0($a0)		# Load address of string into $t0
	move $t1, $a1		# Load String length(n) into $t1
	li $t6, 31
	li $t9, 1
	
	sum:
	lb   $t5, 0($t0) 	# Load the first character into $t5
	move $t8, $t1
	
	pow:			# Calculate 31^i
	multu $t6, $t9
	mflo $t9
	addi $t8, $t8, -1
	bne $t8, 0, pow
	
	multu $t5, $t9		# s(i) * (31)^i
    	mflo $t7
    	addu $v1, $v1, $t7
	addi $t0, $t0, 1 	# Move to the next character
	addi $t1, $t1, -1 	# Decrement looper 
	bne $t1, 0, sum
	
	lw $t0, 4($sp) 
	lw $t1, 0($sp) 
	addi $sp, $sp, 8
	
	li $t4, 1
	sll $t4, $t4, 31
	addiu $t4, $t4, -1
	and $v1, $v1, $t4	# mod 2^32
	jr $ra
	
