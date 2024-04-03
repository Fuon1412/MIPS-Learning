#Ho va ten : Do Manh Phuong
#MSSV: 20225660
.data
A: .word 7, -2, 5, 1, 5,6,7,3,6,8,8,59,5
Aend: .word
Message1: .asciiz "Array after each round is:"
Message2: .asciiz " , "
Newline: .asciiz "\n"
.text
main:
	la $a0, A #address of A[0]
	la $a1, Aend # n
	subi $a1, $a1, 4 # n-1
	addi $a2, $a0, 4 # i = 2
	j bubble_sort
swat:
	lw $t2, 0($a2) # $t2 = value of address A[i]
	sw $t2, 0($t1) # value of address A[j] = $t2
	sw $v0, 0($a2) # value of A[i] = A[j]
	j continue
reset:
	la $a0, A
	addi $t0, $zero, 0 # j = 0
	addi $a2, $a2, 4 # i++
	j bubble_sort
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
bubble_sort:
	bgt $a2, $a1, end_main # if i>(n-1) end
	add $t1, $a0, $t0 # $t1 = address of A[0] + 4*j (A[j])
	beq $t1, $a2, print_sort# if j = i print
	lw $v0, 0($t1) # $v0 = A[j]
	lw $v1, 0($a2) # $v1 = A[i]
	blt $v1, $v0, swat # if A[i] > A[j] swat
continue:
	addi $t0, $t0, 4 # j++
	j bubble_sort
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
	j reset
end_main:
	li $v0, 10
	syscall # exit