.data
	a: .word 5
	space: .asciiz " "
	drop: .asciiz "\n"
	mess: .asciiz "Thank you!"



	arr: .space 3996

	enterN: .asciiz "Enter n: "
	enterElement: .asciiz "Enter element: "


	printElements: .asciiz "1.Print all elements\n"
	sumElements:.asciiz "2.Sum all elements\n"
	printPrimeEle: .asciiz"3.Print prime elements\n"
	maxElement: .asciiz"4.Print element which maximum value\n"
	findElement:.asciiz "5.Find element which is x value\n"
	exitProgram:.asciiz"6.Exit\n"
	
	askFeature: .asciiz "Choose: "
	askChooseAgain: .asciiz "Choose again: "
		

.globl main
.text
	# start app
	main:
		jal menu
		#jal enter_n
		
		#jal ask_user
		#jal get_size_arr
		#jal check_size

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
		sub $sp,$sp,4
		sw $ra,4($sp)

		li $v0,4
		la $a0,drop
		syscall

		lw $ra,4($sp)
		add $sp,$sp,4
		jr $ra

	# function: get_n_arr - get size of arr
	get_size_arr:
		li $v0,5
		syscall
		move $s0,$v0		
		# jr $ra


		
	# function: enter_n - get size of array from user
	enter_n:
		sub $sp,$sp,4
		sw $ra,4($sp)
		
	

		jal handle_n


		lw $ra,4($sp)
		add $sp,$sp,4
		jr $ra

	# function: handle_n - handle array
	handle_n:
		sub $sp,$sp,4
		sw $ra,4($sp)

		enter_n_again:
			li $v0,4
			la $a0,enterN
			syscall

			li $v0,5
			syscall		

		blt $v0,0,enter_n_again
		bgt $v0,1000,enter_n_again

		lw $ra,4($sp)
		add $sp,$sp,4
		jr $ra


	# function: enter_element - print get element
	enter_element:
		sub $sp,$sp,4
		sw $ra,4($sp)

		li $v0,4 
		la $a0,enterElement
		syscall

		lw $ra,4($sp)
		add $sp,$sp,4
		jr $ra

	# function: get_element - get element
	get_element:
		sub $sp,$sp,4
		sw $ra,4($sp)



		lw $ra,4($sp)
		add $sp,$sp,4
		jr $ra

	# function: menu - print menu
	menu:
		sub $sp,$sp,4
		sw $ra,4($sp)		

		li $t0,1
		do:
			jal log_feature

			addi $t0,$t0,1			

			blt $t0,2,do
		
		lw $ra,4($sp)		
		add $sp,$sp,4
		jr $ra

	

	# function: print all feature
	log_feature:

		sub $sp,$sp,4
		sw $ra,4($sp)

		li $v0,4
		la $a0,printElements
		syscall

		li $v0,4
		la $a0,sumElements
		syscall

		li $v0,4
		la $a0,printPrimeEle
		syscall

		li $v0,4
		la $a0,maxElement
		syscall

		li $v0,4
		la $a0,findElement
		syscall

		li $v0,4
		la $a0,exitProgram
		syscall

		jal ask_feature

		jal drop_down

		lw $ra,4($sp)
		add $sp,$sp,4		
		jr $ra

	# function: ask_feature - ask user to choose feature
	ask_feature:
		sub $sp,$sp,4
		sw $ra,4($sp)

		
	
		jal handle_user_chosen
		

		lw $ra,4($sp)
		add $sp,$sp,4
		jr $ra

	# function: handle_user_chosen - 1 to 6
	handle_user_chosen:
		sub $sp,$sp,4
		sw $ra,4($sp)

		again:
			li $v0,4
			la $a0,askFeature
			syscall
			
			li $v0,5
			syscall
			move $s0,$v0

		# handle overflow 
		blt $s0,1,again
		bgt $s0,6,again
		# feature 6
		beq $v0,6,ft_6
		ft_6:
			jal system_pause

	


		lw $ra,4($sp)
		add $sp,$sp,4
		jr $ra
	
		
		
		
	
	
