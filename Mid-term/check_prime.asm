# write a program that check if an number is prime or not within m and n entered from keyboard
#---------------------------------------------------------
#An easy ALGORITHM
#for (int j = m: j<= n;j++{
# for (int i= 2; i <= sqrt(j); i++) {
#   if (number % i == 0) break;
# }
# if (count = 0 ) print j;
#}
#---------------------------------------------------------
.data   
command:    .asciiz "Enter m and n: "
wrong_message: .asciiz "Please enter again, the problem is m is lesser than limit 1 or n are bigger than limit 2"
newline: .asciiz "\n"
space:      .asciiz " "
limit1:     .word 2
limit2:     .word 1000000
.text   
main:       
    li      $v0,        4
    la      $a0,        command
    syscall 
    
    li      $v0,        4
    la      $a0,        newline
    syscall 
    
    #enter m:
    li      $v0,        5
    syscall 
    
    move    $t0,        $v0                         #store m in $t0
    #enter n:
    li      $v0,        5
    syscall 
    
    move    $t1,        $v0                         #store n in $t1
    lw 	    $t7,        limit1
    lw	    $t8,        limit2
    slt     $s2,	 $t0,	     $t7	      #check if m < limit1 and n >limit2
    sgt	    $s3,	 $t1,	     $t8
    add	    $t9,	 $s2,        $s3
    bne     $t9,	 $zero,      wrong           #If m and n out of limit, user has to enter again
    beq	    $t0,        2,          yes1	      #Check if m = 2, print m too
    add     $s0,        $zero,	     $t0	      #If not, j=m
    #function to loop m to n
outerLoop: 
    bgt     $s0,        $t1,        exit            #if j > n then exit the program
    move    $t6,        $s0                         #move j to $t6 for check function
#---------------------------------------------------------------------------------------------
#function is_prime is used to check if j is a prime number
#function is_prime_loop is used to check if j is divisible by i, with i ranging from 1 to sqrt(j).
#function increase_i as it's name, to increase the value of i
#---------------------------------------------------------------------------------------------
isPrime:  
    li      $t3,        0                           # create count variable $t3 = count
    li      $t2,        2                           # initialize 1 to i :	$t2 = i
isPrimeLoop:
    div     $t6,        $t2                         #j div i
    mfhi    $t5                                     #store the ramainder into $t3
    beq     $t5,        $zero,		no           #if remainder = 0 then break
    j       increaseI
increaseI: 
    addi    $t2,        $t2,        1               #increase i by 1
    mul     $v0,        $t2,        $t2			      
    slt     $t4,        $t6,        $v0             # check if i^2 > number, store boolean value in $t4
    beq     $t4,        $zero,          isPrimeLoop
    # loop end
    j       yes
wrong:
    li	    $v0,        4
    la      $a0,        wrong_message
    syscall
    
    li      $v0,        4
    la      $a0,        newline
    syscall 
    
    j       main
yes1:
    li      $v0,        1		#print $t0 onto the screen
    move      $a0,        $t0
    syscall
    addi    $s0,        $s0,	     3               #Initialize $s0 = 3
    li      $v0,        4
    la      $a0,        space
    syscall
    
    j outerLoop
yes:        
    li      $v0,        1		#print $s0 onto the screen
    move      $a0,        $s0
    syscall 
    
    addi    $s0,        $s0,        1               #increase j by 1
    li      $v0,        4
    la      $a0,        space
    syscall 
    
    j       outerLoop

no:         
    addi    $s0,        $s0,        1               #increase j by 1
    j       outerLoop
exit:    
	li $v0 , 10
	syscall
