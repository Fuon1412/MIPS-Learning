#Ho va ten : Do Manh Phuong
#MSSV : 20225660
.data # All messages required to display
Message1: .asciiz "The sum of " # using multiple Message
#and Message3, we will have the format like this "The sum of (s0) and (s1) is (result)"
Message2: .asciiz " and "
Message3: .asciiz " is "
.text
	addi $s0, $zero, 10 #$s0=3
	addi $s1, $zero, 15 #$s1=5
	add $s2, $s0, $s1 # sum of $s1 and $s0, then stored in $s2 (thus $s2 is the sum)
	li $v0, 4 # print Message1
	la $a0, Message1
	syscall # execute command, Message1 will be displayed
	move $a0, $s0 # temporarily stored the first number in $a0
	li $v0, 1 # print the first number
	syscall
	li $v0, 4 # print Message2
	la $a0, Message2
	syscall # execute commands, Message2 will be displayed
	move $a0, $s1 # temporarily stored the second number in $a0
	li $v0, 1 # print the second number
	syscall
	li $v0, 4 # print Message3
	la $a0, Message3
	syscall # execute commands, Meesage5 will be displayed
	move $a0, $s2 # temporarily stored the second number in $a0
	li $v0, 1 # print the sum
	syscall
	# When all of the commands above are executed, we will have our desired output in Run I/O
