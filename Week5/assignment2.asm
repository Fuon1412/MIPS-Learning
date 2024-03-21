#Ho va ten : Do Manh Phuong
#MSSV : 20225660
.data # All messages required to display
Message1: .asciiz "First number is: " # require user to type the first number
Message2: .asciiz "Second number is: " # require user to type the second number
Message3: .asciiz "The sum of " # using multiple Message, concatenate with Message4 
#and Message5, we will have the format like this "The sum of (s1) and (s2) is (result)"
Message4: .asciiz " and "
Message5: .asciiz " is "
.text
	li $v0, 4 # print Message1
	la $a0, Message1
	syscall # execute commands, Message1 will be displayed
	li $v0, 5 # read the first number typed by user
	syscall # execute commands and type the first number, the value will be stored in $v0
	move $s0, $v0 # copy the value of $v0 to $s0, then we have $s0 = $v0(therefore the first number will be stored in $s0)
	li $v0, 4 # print Message2
	la $a0, Message2
	syscall # execute command, Message2 will be displayed
	li $v0, 5 # read the second number typed by user
	syscall # execute commands and type the second number, the value will be stored in $v0
	move $s1, $v0 # copy the value of $v0 to $s1, then we have $s1 = $v0 (therefore the second number is stored in $s1)
	add $s2, $s0, $s1 # sum of $s1 and $s0, then stored in $s0 (thus $s0 is the sum)
	li $v0, 4 # print Message3
	la $a0, Message3
	syscall # execute command, Message3 will be displayed
	move $a0, $s0 # temporarily stored the first number in $a0
	li $v0, 1 # print the first number
	syscall
	li $v0, 4 # print Message4
	la $a0, Message4
	syscall # execute commands, Message4 will be displayed
	move $a0, $s1 # temporarily stored the second number in $a0
	li $v0, 1 # print the second number
	syscall
	li $v0, 4 # print Message5
	la $a0, Message5
	syscall # execute commands, Meesage5 will be displayed
	move $a0, $s2 # temporarily stored the second number in $a0
	li $v0, 1 # print the sum
	syscall
	# When all of the commands above are executed, we will have our desired output in Run I/O