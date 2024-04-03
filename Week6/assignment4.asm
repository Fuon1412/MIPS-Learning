#Ho va ten : Do Manh Phuong
#MSSV: 20225660
.data
A: .word 7, -2, 5, 1, 5,6,7,3,6,8,8,59,5
Aend: .word
Message1: .asciiz "Array after each round is:"
Message2: .asciiz " , "
Newline: .asciiz "\n"
.text
	la $a0, A #address of A[0]
	la $a1, Aend # n
	subi $a1, $a1, 4 # n-1
	j insertion_sort
print_sort:
	li $v0, 4
	la $a0, Message1
	syscall #print message1
	la $a0, Newline
	syscall #print newLine
	la $s0, A
	la $s1, Aend
	lw $s2, 0($s0)
	li $v0, 1
	la $a0, 0($s2) #print number1 of array
	syscall
	addi $t3, $zero, 0 #i = 0
	j print_array
print_array:
	addi $t3, $t3, 4 # i++
	add $t4, $s0, $t3 # $t1 = adrress of A[0] + 4*i (A[i])
	lw $t5, 0($t4) # x = A[i]
	beq $t4, $s1, end # if i>(n-1) end
	li $v0, 4
	la $a0, Message2
	syscall # print Message2
	li $v0, 1
	la $a0, 0($t5)
	syscall # print A[i]
	j print_array
end:
	li $v0, 4
	la $a0, Newline
	syscall
	j insertion_sort
insertion_sort:
	la $a0, A
	addi $t0, $t0, 4 # i++
	add $v0, $a0, $t0 # i = 1
	bgt $v0, $a1, end_main
	lw $s0, 0($v0) # key = A[i]
	subi $v1, $v0, 4 # j = i-1
loop:
	blt $v1, $a0, end_loop# if j < 0 end_loop
	lw $s1, 0($v1) # $s1 = A[j]
	blt $s1, $s0, end_loop # if A[j] < key end_loop
	addi $t2, $v1, 4 # $t2 = j+1
	sw $s1, 0($t2) # A[j+1] = A[j]
	subi $v1, $v1, 4 # j--
	j loop
end_loop:
	addi $t2, $v1, 4 # $t2 = j+1
	sw $s0, 0($t2) # A[j+1] = key
	j print_sort
end_main:
	li $v0, 10
	syscall