convert:                # convert string to integer
  li $t3, 0x30          # $t6 = '0'
  li $t4, 0x39          # $t7 = '9'
  li $v0, 0             # initialize $v0 = 0
  move $t0, $a0         # $t0 = pointer to string contained in $a0
  lb $t1, ($t0)         # load $t1 = digit character

LOOP:
  blt $t1, $t3, notInt  #
  bgt $t1, $t4, notInt  #
  subu $t1, $t1, $t6    # convert char to integer
  mul $v0, $v0, 10      # multiply by 10
  add $v0, $v0, $t1     # $v0 = $v0 * 10 + digit
  addiu $t0, $t0, 1     # point to next char
  lb $t1, ($t0)         # load $t1 = next digit
  bne $t1, $0, LOOP     # loop if char is not null
  jr $ra                # return integer value

notInt:
  li $v0, -1            # return -1 in $v0
  jr $ra 
