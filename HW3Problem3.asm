.data
	string: .asciiz "2747184"
.text
#li $v0, 8
#li $a1, 8
#syscall 


str2int:                # convert string to integer
  li $t6, 0x30          # $t6 = '0'
  li $t7, 0x39          # $t7 = '9'
  li $v0, 0             # initialize $v0 = 0
  move $t0, $a0         # $t0 = pointer to string
  lb $t1, ($t0)         # load $t1 = digit character

LOOP:
  blt $t1, $t6, NoDigit # char < ‘0’
  bgt $t1, $t7, NoDigit # char > ‘9’
  subu $t1, $t1, $t6    # convert char to integer
  mul $v0, $v0, 10      # multiply by 10
  add $v0, $v0, $t1     # $v0 = $v0 * 10 + digit
  addiu $t0, $t0, 1     # point to next char
  lb $t1, ($t0)         # load $t1 = next digit
  bne $t1, $0, LOOP     # branch if not end of string
  jr $ra                # return integer value

NoDigit:
  li $v0, -1            # return -1 in $v0
  jr $ra 
