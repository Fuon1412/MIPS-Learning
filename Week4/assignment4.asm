#Laboratory Exercise 4, Home Assignment 1
.text
start:
	addi $s1, $0, 2147483647 # load the value of $s1
	addi $s2, $0, 2 # load the value of $s2
	li $t0,0 # No Overflow is default status
	addu $s3,$s1,$s2 # s3 = s1 + s2
	xor $t2,$s1,$s3 # Test if $s1 and $s3 have the same sign
	bltz $t2, ELSE # If true, then do the following code. If not, then jump to ELSE
	j EXIT
ELSE:
	xor $t2,$s3,$s2 # Check if $s2 and $s3 have the same sign
	bltz $t2,OVERFLOW # If not, then the addition if OVERFLOW
	j EXIT
OVERFLOW:
	li $t0,1 # load the new value for $t0 if OVERFLOW occurs.
EXIT: