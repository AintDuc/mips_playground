.data
	arr: .space 12
	drop: .asciiz "\n"
.text
	addi $s0,$0,4
	addi $s1,$0,10
	addi $s2,$0,12

	#index = t0
	addi $t0,$0,0
	
	sw $s0,arr($t0)
		addi $t0,$t0,4
	sw $s1,arr($t0)
		addi $t0,$t0,4
	sw $s2,arr($t0)
	
	# clear t0 to 0
	addi $t0,$0,0

	# log arr
	while:
		beq $t0,12,exit
	
		lw $t6,arr($t0)

		addi $t0,$t0,4
			
		# log current number
		li $v0,1
		move $a0,$t6
		syscall

		#new line
		li $v0,4
		la $a0,drop
		syscall

		

		j while


	exit:
		li $v0,10
		syscall
	