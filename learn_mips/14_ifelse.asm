.data
	drop: .asciiz "\n"
	mess: .asciiz "Hellllll\n"

	m1: .asciiz "\nNothing happend"
	m2: .asciiz "\nThe numbers are equal"
.text

	main:
	jal drop_down_the_line
	
	li $v0,4
	la $a0,mess
	syscall
	
	addi $t0,$0,5
	addi $t1,$0,10

	beq $t0,$t1,numberEqual
	beq $t0,$t1,m1

	


	#end
	li $v0,10
	syscall

	drop_down_the_line:
	li $v0,4
	la $a0,drop
	syscall
	
	jr $ra

	numberEqual:
		li $v0,4
		la $a0,m2		
		syscall

	












