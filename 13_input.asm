.data
	drop: .ascii "\n"
	ip_mess: .asciiz "\nEnter your age: "
	mess: .asciiz "\nYour age is: "
	
.text

	main:
		li $v0,4
		la $t0,ip_mess
		jal	log_string

		jal get_user_input

		li $v0,4
		la $t0,mess
		jal log_string		

		li $v0,4
		move $t0,$t1
		jal log_int
	
	# end
	li $v0,10
	syscall

	# log int function
	log_int:
	li $v0,1
	move $a0,$t0
	syscall

	jr $ra

	# log string function
	log_string:
	li $v0,4
	move $a0,$t0
	syscall

	jr $ra

	# get user input
	get_user_input:
	li $v0,5
	syscall

	move $t1,$v0

	jr $ra