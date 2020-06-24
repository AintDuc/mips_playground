.data

# n = s0
# i = t0
	a: .word 5
	space: .asciiz " "
	drop: .asciiz "\n"
	mess: .asciiz "\nApp done!"

	wrongInputMess: .asciiz "Enter input again!\n"
	rightInputMess: .asciiz "Input accepted!\n"

	arr: .space 3996
	askMess: .asciiz "How many elements in the array?\n"

.globl main
.text
	# start app
	main:
		jal ask_user
		jal get_size_arr
		jal check_size

		#jal check_user_input
		#jal log_input_user
		
		
		
	# end of app
	jal system_pause

	



	# function: pause the app
	system_pause:
		jal mess_pop_up
	
	# function: work - test something in the app
	work:
		li $v0,1
		addi $t2,$t2,5
		move $a0,$t2
		syscall
#		jr $ra

	# function: spacing
	spacing:
		li $v0,4
		la $a0,space
		syscall
#		jr $ra

	# function: mess pop up - notification end of app
	mess_pop_up:
		li $v0,4
		la $a0,mess
		syscall
		
		li $v0,10
		syscall
		

	# function: drop down - drop down the line
	drop_down:
		li $v0,4
		la $a0,drop
		syscall
#		jr $ra

	# function: get_n_arr - get size of arr
	get_size_arr:
		li $v0,5
		syscall
		move $s0,$v0		
		# jr $ra

	# function: ask_user - ask amount of elements in array
	ask_user:
		li $v0,4
		la $a0,askMess
		syscall
		jr $ra
	

	# function: log_input_user - print value from user input
	log_input_user:
		li $v0,1
		move $a0,$t2
		syscall
		jr $ra

	# function: check_size - check size array
	# 0 < n < 1000
	check_size:
		# if (n<0 || n>1000) - input again
		blt $s0,0,if
		bgt $s0,1000,if
	
		
		# else 
		jal right_input_mess

		if: 
			jal wrong_input_mess
			jal ask_user
		jr $ra
		
	# function: print wrong input message
	wrong_input_mess:
		li $v0,4
		la $a0,wrongInputMess
		syscall
		jr $ra


	# function: print right input message
	right_input_mess:
		li $v0,4
		la $a0,rightInputMess
		syscall
		jr $ra
		
		
	
	
