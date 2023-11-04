.data

# numbers: .word -- -- -- -- -- -- -- -- -- 	//UPDATE HERE ARRAY SIZE N		
# .text
main:
	la $s7, numbers							//data memory pointer

	li $s0, 0					
	li $s6, 8								//UPDATE HERE N-1
	
	li $s1, 0 					

	li $t3, 0					
	li $t4, 9  							//UPDATE HERE N

loop:
	sll $t7, $s1, 2				
	add $t7, $s7, $t7 			

	lw $t0, 0($t7)  						//load numbers[j]
	lw $t1, 4($t7) 							//load numbers[j+1]

	slt $t2, $t0, $t1						//if t0 < t1

	beq $t2, $zero, swap
	j increment

swap:
	sw $t1, 0($t7) 							//swap
	sw $t0, 4($t7)

increment:	

	addi $s1, $s1, 1				
	add $s5, $s1, $s0 				

	beq $s6, $s5, continue
	j loop
continue:
	addi $s0, $s0, 1 				
	li $s1, 0 					

	beq  $s0, $s6, print

	j loop				
	
# print:
# 	beq $t3, $t4, final				
	
# 	lw $t5, 0($s7)					
	
# 	li $v0, 1					
# 	move $a0, $t5
# 	syscall

# 	li $a0, 32					
# 	li $v0, 11
# 	syscall
	
# 	addi $s7, $s7, 4						//increment through the numbers
# 	addi $t3, $t3, 1						//increment counter

# 	j print

final:	
	li $v0, 10					
	syscall