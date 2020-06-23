.data
	drop: .ascii "\n"
	a: .word 5
	b: .word 2
.text
	main:
		lw $s0,a
		jal log_value
		jal drop_down_the_line

		lw $s0,b
		jal log_value
		jal drop_down_the_line
	

	#end
	li $v0,10
	syscall



	

	log_value:
	li $v0,1
	move $a0,$s0
	syscall

	jr $ra

	drop_down_the_line:
	li $v0,4
	la $a0,drop
	syscall
	jr $ra

	increase_register:
	addi $sp,$sp,-8
	sw $s0,0($sp)	
	sw $ra 4($sp)

	jal log_value

	lw $s0,0($sp)
	lw $ra,4($sp)
	addi $sp,$sp,4

	jr $ra
