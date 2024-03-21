#Laboratory Exercise 5, Home Assignment 1
#Ho va ten : Do Manh Phuong
#MSSV : 20225660
.data
test: .asciiz "Hello World"
.text
 	li $v0, 4
 	la $a0, test
 	syscall 
 	