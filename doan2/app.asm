.data
	arr: .space 3996
	a: .word 5
	space: .asciiz " "
	drop: .asciiz "\n"

	mess: .asciiz "Thank you!"

	enterN: .asciiz "Enter n: "
	enterElement: .asciiz "Enter element: "

	decoratorTop: .asciiz "-------------------- MENU --------------------"
	printElements: .asciiz "1.Print all elements\n"
	sumElements:.asciiz "2.Sum all elements\n"
	printPrimeEle: .asciiz"3.Print prime elements\n"
	maxElement: .asciiz"4.Print element which maximum value\n"
	findElement:.asciiz "5.Find element which is x value\n"
	exitProgram:.asciiz"6.Exit\n"
	decoratorBottom: .asciiz "-------------------- END MENU --------------------"
	
	askFeature: .asciiz "Choose: "
	askChooseAgain: .asciiz "Choose again: "

	# variable that notify result each of feature
	printArrMess: .asciiz "Your array is: "
	printMaxIs: .asciiz "Maximum value is: "
	enterValueX: .asciiz "Enter value to find: "
	resultFind: .asciiz "Index result: "
	isntIn: .asciiz "Value is not in array"
	sum_is: .asciiz "Sum: "
	primes: .asciiz "Primes: "

		

.globl main
.text
	# start app
	main:
		jal enter_n
		jal menu

		# restore register by rules of register
		#jal restore_register
		
		
	# end of app
	jal system_pause


#--------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------
#-----------------------------  UTILS   ---------------------------------------	
	# function: pause the app
	system_pause:
		jal mess_pop_up


	# function: spacing
	spacing:
		sub $sp,$sp,4
		sw $ra,4($sp)

		li $v0,4
		la $a0,space
		syscall

		lw $ra,4($sp)
		add $sp,$sp,4	

		jr $ra

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


#--------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------
#-----------------------------  END UTILS   ---------------------------------------	



#--------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------
#-----------------------------  USER CHOSEN HANDLE ---------------------------------------	
	
	# function: enter_n - get size of array from user
	enter_n:
		sub $sp,$sp,4
		sw $ra,4($sp)
		
		enter_n_again:
			li $v0,4
			la $a0,enterN
			syscall

			li $v0,5
			syscall		

			blt $v0,0,enter_n_again
			beq $v0,0,enter_n_again
			bgt $v0,1000,enter_n_again

		# if get n - then get element
		# $a1 save value of n (a0-a3 is register that contain argument)
		move $s0,$v0 # n = s0

		addi $t0,$0,0
		addi $t1,$0,0

		store:
			li $v0,4
			la $a0,enterElement
			syscall
		
			li $v0,5
			syscall
		
			sw $v0,arr($t1)
			addi $t1,$t1,4
					
			addi $t0,$t0,1
			blt $t0,$s0,store


		lw $ra,4($sp)
		add $sp,$sp,4

		jr $ra





#--------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------
#----------------------------- END USER CHOSEN HANDLE ---------------------------------------



#--------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------
#----------------------------- FEATURE HANDLE ---------------------------------------

# feature 1: print all elements in the array
# function: log_array (int n = $s0) - print all elements in the array
	log_array:
		sub $sp,$sp,4
		sw $ra,4($sp)

		li $v0,4 
		la $a0,printArrMess
		syscall

		# debug n
		#li $v0,1
		#move $a0,$s0
		#syscall

		addi $t0,$0,0
		addi $t1,$0,0
		log_loop:

			lw $t5,arr($t1)

			li $v0,1
			move $a0,$t5
			syscall			

			jal spacing

			addi $t1,$t1,4

			addi $t0,$t0,1
			blt $t0,$s0,log_loop

		jal drop_down

		# still choose
		jal ask_feature

		lw $ra,4($sp)
		add $sp,$sp,4

		jr $ra

# feature 2: Get sum of all elements
# function: sum_array (int n = $a1) - sum all elements in the array
	sum_array:
		sub $sp,$sp,4
		sw $ra,4($sp)

		# int rs = 0 
		addi $t3,$0,0
		
		# i, index
		addi $t0,$0,0
		addi $t1,$0,0

		loop_sum:
			lw $t5,arr($t1) # a[i]
		
			add $t3,$t3,$t5 # rs = rs + a[i]

			addi $t1,$t1,4
			addi $t0,$t0,1

			blt $t0,$s0,loop_sum
	
		
		li $v0,4
		la $a0,sum_is
		syscall

		li $v0,1
		move $a0,$t3
		syscall

		jal drop_down

		jal ask_feature

		lw $ra,4($sp)
		add $sp,$sp,4
		
		jr $ra

# feature 3: Prints all elements which are prime
# function: is_primes (int n) - check n is primes ? true 1 - false 0
# n = a[i] -> argument just a0-a3 -> so take a3, return is v1
	is_primes:
		sub $sp,$sp,4
		sw $ra,4($sp)

		addi $t3,$0,-1 # int rs = -1
		blt $a3,2,isnt_prime # if n < 2 false
		beq $a3,2,prime # n == 2 true

		# i = t9
		addi $t9,$0,2
		loop_check_prime:
			div $a3,$t9
			mfhi $t8 # get modulo

			beq $t8,0,isnt_prime # if n % i = 0 so isnt prime

			addi $t9,$t9,1

			blt $t9,$a3,loop_check_prime

		# else prime
		j prime

	
		isnt_prime:
			addi $t3,$0,-1
			j return_value_prime

		prime:
			addi $t3,$0,1
			j return_value_prime

		return_value_prime:
			move $v1,$t3
			j end_func_is_primes
	
		end_func_is_primes:

		lw $ra,4($sp)
		add $sp,$sp,4

		jr $ra
	
# function: print_primes - print all elements which are prime
	print_primes:
		sub $sp,$sp,4
		sw $ra,4($sp)

		li $v0,4
		la $a0,primes
		syscall

		addi $t0,$0,0
		addi $t1,$0,0
		loop_print_primes:
			lw $t5,arr($t1)

			move $a3,$t5 # n = a3 to check prime
			jal is_primes # check primes $v1, return is v1

			beq $v1,1,print_it
			
			j continue_loop_print_prime

			print_it:
				li $v0,1
				move $a0,$t5
				syscall 

		
			#debug
			#li $v0,1
			#move $a0,$t7
			#syscall


			#debug
			#li $v0,1
			#move $a0,$v1
			#syscall
		
			jal spacing

			continue_loop_print_prime:
				addi $t1,$t1,4
				addi $t0,$t0,1
				blt $t0,$s0,loop_print_primes
			
	####### COMMMMPLEEEETEDDDDD!!!!

		jal drop_down 

		jal ask_feature
	
	
		lw $ra,4($sp)
		add $sp,$sp,4

		jr $ra

		


# feature 4: Find element which is maximum value in the array
# function: find_max (int array[] = arr .space 3996, int n = $s0)  - find maximum value in the array
	find_max:
		sub $sp,$sp,4
		sw $ra,4($sp)

		# i, index
		addi $t0,$0,0
		addi $t1,$0,0
		# suppose max = a[0]
		lw $t5,arr($t1)
		move $t3,$t5 # max = a[0]

		find_max_loop:
			lw $t5,arr($t1)

			bgt $t3,$t5,this_is_max # if max>a[i] so this is max
			# else - update max
			move $t3,$t5

			this_is_max:
				addi $t1,$t1,4
				addi $t0,$t0,1

			blt $t0,$s0,find_max_loop

		li $v0,4
		la $a0,printMaxIs
		syscall

		li $v0,1
		move $a0,$t3
		syscall

		jal drop_down			
		
		jal ask_feature

		lw $ra,4($sp)
		add $sp,$sp,4

		jr $ra

# feature 5: Find the element which is equal to x
# function: find_value - find the element which is equal to x
	find_value:
		sub $sp,$sp,4
		sw $ra,4($sp)

		li $v0,4
		la $a0,enterValueX
		syscall

		li $v0,5
		syscall
		
		# int rs = -1
		addi $t3,$0,-1

		# x = $s2
		move $s2,$v0
		
		addi $t0,$0,0
		addi $t1,$0,0

		loop_find:
			lw $t5,arr($t1)		
			
			bne $t5,$s2,continue_find # a[i]!= x
			# else finded -> rs = index
			div $t3,$t1,4
			# debug
			#li $v0,1
			#move $a0,$t3
			#syscall
			continue_find:
				addi $t1,$t1,4
				addi $t0,$t0,1

			blt $t0,$s0,loop_find
	
	
		
		bne $t3,-1,finded

		li $v0,4
		la $a0,isntIn
		syscall

		jal spacing

		finded:		
			li $v0,4	
			la $a0,resultFind
			syscall

			li $v0,1
			move $a0,$t3
			syscall


		

		jal drop_down

		jal ask_feature


		lw $ra,4($sp)
		add $sp,$sp,4

		jr $ra


# feature 6: Exit
# function: exit_app - stop the app
	exit_app:
		# restore register before end of app
		# jal restore_register

		jal system_pause

#--------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------
#----------------------------- END FEATURE HANDLE ---------------------------------------



#--------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------
#----------------------------- MENU HANDLE ---------------------------------------
	# function: menu - print menu
	menu:
		sub $sp,$sp,4
		sw $ra,4($sp)		

		li $v0,4
		la $a0,decoratorTop	
		syscall

		jal drop_down

		# log menu
		jal log_feature

				
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
		
		# after print, ask them
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
		addi $t5,$0,1

		# do
		do_choose:
			li $v0,4
			la $a0,askFeature
			syscall
			
			li $v0,5
			syscall

			move $s1,$v0

			# feature 1
			beq $s1,1,log_array

			# feature 2
			beq $s1,2,sum_array

			# feature 3
			beq $s1,3,print_primes

			# feature 4
			beq $s1,4,find_max

			# feature 5
			beq $s1,5,find_value


			# feature 6
			beq $s1,6,exit_app
		
			
			blt $s1,1,do_choose
			bgt $s1,6,do_choose
			beq $s1,0,do_choose

			beq $t5,1,do_choose # while true


		li $v0,1
		la $a0,500
		syscall

		lw $ra,4($sp)
		add $sp,$sp,4

		jr $ra

#--------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------
#----------------------------- END - MENU HANDLE ---------------------------------------
		

#--------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------
#----------------------------- RESTORE REGISTER  ---------------------------------------
	restore_register:
		sub $sp,$sp,4
		sw $ra,4($sp)
		
		lw $s0,0	

		li $v0,1
		move $a0,$s0
		syscall

		jal drop_down

		li $v0,1
		move $a0,$s1
		syscall

		jal drop_down

		li $v0,1
		move $a0,$s2
		syscall
jal drop_down

		li $v0,1
		move $a0,$s3
		syscall
jal drop_down

		li $v0,1
		move $a0,$s4
		syscall
jal drop_down

		li $v0,1
		move $a0,$s5
		syscall
jal drop_down

		li $v0,1
		move $a0,$s6
		syscall

jal drop_down
		li $v0,1
		move $a0,$s7
		syscall
jal drop_down
		li $v0,1
		move $a0,$sp
		syscall

		lw $ra,4($sp)
		add $sp,$sp,4

		jr $ra
#--------------------------------------------------------------------------------------
#------------------------------ Thank you! --------------------------------------------
#----------------------------- THE END  ---------------------------------------
		
	
	
