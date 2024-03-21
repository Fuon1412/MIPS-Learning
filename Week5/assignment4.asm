#Laboratory Exercise 5, Home Assignment 3
#Ho va ten : Do Manh Phuong
#MSSV : 20225660
.data
string: .space 50
Message1: .asciiz "Nhap xau: "
Message2: .asciiz "Do dai xau la: "
.text
main:
get_string: 
	li $v0, 54 # MessageDialogString
	la $a0, Message1
	la $a1, string
	la $a2, 50
	syscall
get_length: 
	la $a0, string # $a0 = address(string[0])
	add $t0, $zero, $zero # $t0 = i = 0
	lb $t3, 0($a0) # $t3 = string[0]
	beqz $t3, end_of_get_length # if string [0] = null, then end
check_char: 
	add $t1,$a0,$t0 # $t1 = $a0 + $t0
	# = address(string[i])
	lb $t2, 0($t1) # $t2 = string[i]
	beq $t2, $zero, end_of_str # is null char?
	addi $t0, $t0, 1 # $t0 = $t0 + 1 -> i = i + 1
	j check_char
end_of_str: 
	subi $t0, $t0, 1 # because we don’t count the null-terminator \0, we have to decrease i to 1.
end_of_get_length:
print_length:
	move $a1, $t0 # Copy the value of $
	li $v0, 56
	la $a0, Message2
	syscall # execute