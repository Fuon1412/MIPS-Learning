.data
	arr:	.space 100

	num0:	.asciiz "khong "
	num1:	.asciiz "mot "
	num2:	.asciiz "hai "
	num3:	.asciiz "ba "
	num4:	.asciiz "bon "
	num5:	.asciiz "nam "
	num6:	.asciiz "sau "
	num7:	.asciiz "bay "
	num8:	.asciiz "tam "
	num9:	.asciiz "chin "
	numbers:	.word	num0,num1, num2, num3, num4, num5, num6, num7, num8, num9
	
	unit1: 		.asciiz ""
	unit2:		.asciiz "muoi "
	unit3:		.asciiz "tram "
	units:		.word	unit1, unit2, unit3
	
	level1:		.asciiz ""
	level2:		.asciiz "nghin " 
	level3:		.asciiz "trieu "
	levels:		.word	level1,level2,level3
	
	Message:	.asciiz "Enter a number: "
	errorM:		.asciiz "Not a number"

	
.text
main:
	li $v0, 4	#print Enter a number:  onto the screen
	la $a0, Message
	syscall

	li $v0, 8	#input the number into the array
	la $a0, arr
	li $a1, 100
	syscall

	jal strlen	#call the strlen function
	nop
	
	jal numToText
	nop
	
	j exit
#-----------------------------------------------------------	
#function strlen find length of a given string
#-----------------------------------------------------------
strlen:
	la	$a0, arr		#a0 = address(arr[0])
	xor	$v0, $zero, $zero	#v0 = length = 0
	xor 	$t0, $zero, $zero	#t0 = i = 0
checkchar:
	add 	$t1, $a0, $t0		#t1 = address(arr[0] + i)
	lb	$t2, 0($t1)		#t2 = arr[i]
	beq	$t2, $zero, endOfstrlen #is null char?
	addi	$v0, $v0, 1		#length += length
	addi 	$t0, $t0, 1		# i++
	j 	checkchar
endOfstrlen:
	move $t0, $v0			#return the length of string
	addi, $t0 ,$t0, -1		#Need -1 because of '\0' 
	
	jr	$ra 
checkError:
	addi $t1, $zero, 0		#index i = 0
checkErrorLoop:
	beq $t1, $t0, endOfcheckError	#for( i = 0; i < strlen; i++)
	lb  $t9, arr($t1)		#t9 = arr[i]
	addi $t9, $t9, -48		#convert from char to int
	bge $t9, 10, errorMessage	#if arr[i] is not a number, print error
	addi $t1, $t1, 1		#i++
	j checkErrorLoop
#-----------------------------------------------------------	
# function numToText is a function converts given number into Vietnamese text
# output = Vietnamese text of given number
#-----------------------------------------------------------	
numToText:
	xor $s0, $zero, $zero		#int i = 0
	xor $t1, $zero, $zero		#pointer to element in array
	add $s6, $zero, 3		#s6 = 3 for division later in the program
	addi $t5, $t0, -1		#t5 = length - 1 for comparision later in the program
	
startnumToText:
	beq $s0, $t0, exitnumToText	#for(i; i < length; i++)
	
	lb $t8, arr($t1)		#t8 = arr[i]
	addi $t8, $t8, -48		#(arr[i] - 48), use to convertt from asciiz char to interger
	move $t7, $t8
	sll  $t8, $t8, 2		
	bge  $t7, $zero, printNumber

doneprintNumber:
	sub, $t2, $t0, $s0		#t2 = length - i
	addi, $t2, $t2, -1		#t2 = length - i - 1
	
	div $t2, $s6			#$t2 / 3 was stored in lo, $t2 % 3 was stored in hi
	
	mfhi	$t3			#t3 = $t2 % 3
	sll $t3, $t3, 2
	mflo	$t4			#t4 = $t2 /3
	sll $t4, $t4, 2
	
	beq $s0, $t5,	noChange	#if i!= length - 1
	beq $t3, $zero, printLevel	#&& t3 == 0

	j  printUnit
	
noChange:
	nop
	addi $t1, $t1, 1		#t1++
	addi $s0, $s0, 1		#i++
	j startnumToText
	
exitnumToText:
	jr $ra

printLevel:
	li $v0, 4
	lw $a0, levels($t4)
	syscall
	j noChange
	
printUnit:
	li $v0, 4
	lw $a0, units($t3)
	syscall
	
	j noChange

printNumber:

	li $v0, 4
	lw $a0, numbers($t8)		#number[(arr[i] - 48)]
	syscall
	
	j doneprintNumber
endOfcheckError:
	jr $ra
errorMessage:
	li $v0, 4
	la $a0, errorM
	syscall
	
	j main
exit:
	li $v0, 10
	syscall
	
