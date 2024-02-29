.text 
	li $t0, 10
	li $t1, 20
	
	addi 0($sp), $t0
	addi 4($sp). $t1
	jal conghaiso
	
	addi $t2, $v0, 0
	add $t2 , $t1, $zero
	
conghaiso:
	add $v0, $a0, $a1
	jr  $ra