.data
	drop: .ascii "\n"
.text
	main:
		addi $s0,$0,10

		li $v0,1
		move $a0,$s0
		syscall

		li $v0,4
		la $a0,drop
		syscall

		jal increase

		li $v0,1
		move $a0,$s0
		syscall


	# end
	li $v0,10
	syscall

	increase:
		addi $sp,$sp,-4
		sw $s0,0($sp)

		addi $s0,$s0,30

		li $v0,1
		move $a0,$s0
		syscall

		li $v0,4
		la $a0,drop
		syscall

		lw $s0,0($sp)		
		addi $sp,$sp,4


		jr $ra