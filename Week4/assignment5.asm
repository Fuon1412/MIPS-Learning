.text
	addi $s0, $zero, 3 # load the value of $s0
	addi $t0, $zero, 16 # load the value of $s1
	addi $t1, $zero, 2 # load the value of $s2
	# The following loop will divide gradually the dividend $t0 until it reachs to 0. Each time, when
	#do the division, the bits the shift is increase by 1. If $t0 = 2x, then the bits we expected to shift left
	#are x. Finally, we will have the result $s5 = $s0 * 2x
LOOP:
	divu $t3, $t0, $t1 # divide $t0 and $t1, load the value to $t3
	beqz $t3, EXIT # check if $t3 = 0, exit. If not, do the following code
	addi $s4, $s4, 1 # increment $s4 by 1 when $t3 is not equal to 0
	sllv $s5, $s0, $s4 # shift left $s4 bits. Each time, the $s5 value is multiply by 2.
	add $t0, $zero, $t3 # add the quotient to the new dividend and continue to loop
	j LOOP
EXIT: