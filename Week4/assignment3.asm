.text	
	addi $s1, $zero, 12 # load the value of $s1
	addi $s2, $zero, 23 # load the value of $s2
	slt $s0, $s2, $s1 # check if $s2 < $s1
	bne $s0, $zero LABEL # If this false, then do the following codes. If not, then branch(it means $s1 <= $s2)
LABEL: 