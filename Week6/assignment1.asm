#Ho va ten : Do Manh Phuong
#MSSV: 20225660
.data
A: .word 0 : 1000 # Array, which can contains up to 1000 values
size: .word 5 # Set temporarily the size of array to 5, then change
Message1: .asciiz "Type the number of elements you want in the array (0 < N < 1000): "
Message2: .asciiz "Input each value to the string "
Message3: .asciiz "Insert value #"
Message4: .asciiz "The maximum sum of this array is: "
Newline: .asciiz "\n"
Space: .asciiz " "
Colon: .asciiz ": "
.text
initiate_the_array:
	li $v0, 4 # load Message1
	la $a0, Message1
	syscall
	li $v0, 5 # read the input from user to enter how much size needed in array
	syscall
	la $t0, size # load the temporarily size of array
	sw $v0, 0($t0) # actual size of the array
value_info: # information before initializing the value for array
	li $v0, 4 # Read message2
	la $a0, Message2
	syscall
	li $v0, 4 # Newline
	la $a0, Newline
	syscall
value_prep:
	la $t0, A # load array to $t0.
	lw $t1, size # load size to $t1.
	li $t2, 0 # loop runner, starting from 0.
value:
	bge $t2, $t1, main # while ($t2 < $t1).
	li $v0, 4 # 4 = print_string syscall.
	la $a0, Message3 # load Message 3 to argument register $a0.
	syscall # issue a system call.
	li $v0, 1 # 1 = print_int syscall.
	addi $a0, $t2, 1 # load (runner + 1) to argument register $a0, show the current index of the value of the array
	syscall # issue a system call.
	li $v0, 4 # 4 = print_string syscall.
	la $a0, Colon # load Colon to argument register $a0.
	syscall # issue a system call.
	li $v0, 5 # 5 = read_int syscall.
	syscall # issue a system call.
	sw $v0, 0($t0) # store the value of $v0 to the current A[i]
	addi $t0, $t0, 4 # increment array pointer by 4, pointer to the current A[i]
	addi $t2, $t2, 1 # increment loop runner by 1
	j value # jump back to the beginning of the loop.
main:
	la $a0, A # again, load the current array we have	
	lw $a1, size # load the actual size of the array to $a1
	j mspfx # when the initialization is done, jump to the function
result: # Show the message with the result of maximum sum of the array
	li $v0, 56
	la $a0, Message4
	move $a1, $v1
	syscall
	j end
end: # exit the program
	li $v0, 10
	syscall
#-----------------------------------------------------------------
#Procedure mspfx
# @brief find the maximum-sum prefix in a list of integers
# @param[in] a0 the base address of this list(A) need to be processed
# @param[in] a1 the number of elements in list(A)
# @param[out] v0 the length of sub-array of A in which max sum reachs.
# @param[out] v1 the max sum of a certain sub-array
#-----------------------------------------------------------------
#Procedure mspfx
#function: find the maximum-sum prefix in a list of integers
#the base address of this list(A) in $a0 and the number of
#elements is stored in a1
mspfx: 
	addi $v0,$zero,0 #initialize length in $v0 to 0
	addi $v1,$zero,0 #initialize max sum in $v1 to 0
	addi $t0,$zero,0 #initialize index i in $t0 to 0
	addi $t1,$zero,0 #initialize running sum in $t1 to 0
loop: 
	add $t2,$t0,$t0 #put 2i in $t2
	add $t2,$t2,$t2 #put 4i in $t2
	add $t3,$t2,$a0 #put 4i+A (address of A[i]) in $t3
	lw $t4,0($t3) #load A[i] from mem(t3) into $t4
	add $t1,$t1,$t4 #add A[i] to running sum in $t1
	slt $t5,$v1,$t1 #set $t5 to 1 if max sum < new sum
	bne $t5,$zero,mdfy #if max sum is less, modify results
	j test #done?
mdfy: 
	addi $v0,$t0,1 #new max-sum prefix has length i+1
	addi $v1,$t1,0 #new max sum is the running sum
test: 
	addi $t0,$t0,1 #advance the index i
	slt $t5,$t0,$a1 #set $t5 to 1 if i<n
	bne $t5,$zero,loop #repeat if i<n
done: 
	j result # when we have the sum we need, then jump to the result