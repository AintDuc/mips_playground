.data
	mess: .asciiz "sdasdasdasdsadasd\n"

.text
	main:
		jal show_text
		
		addi $s0,$0,5
		addi $s1,$0,10

		jal sum
		
		li $v0,1
		add $a0,$0,$v1
		syscall
	# end of program
	li $v0,10
	syscall

	show_text:
		li $v0,4
		la $a0,mess
		syscall

		jr $ra
	sum:
		add $v1,$s0,$s1
		jr $ra