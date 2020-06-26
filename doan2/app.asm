.data
	a: .word 5
	space: .asciiz " "
	drop: .asciiz "\n"
	mess: .asciiz "Thank you!"



	arr: .space 3996

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

		

.globl main
.text
	# start app
	main:
		jal enter_n
		# restore register by rule of register
		jal restore_register
		
		
	# end of app
	jal system_pause

#-----------------------------  UTILS   ---------------------------------------	
	# function: pause the app
	system_pause:
		jal mess_pop_up

	# function: work - test something in the app
	work:
		li $v0,1
		addi $t2,$t2,5
		move $a0,$t2
		syscall
	#	jr $ra

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


#-----------------------------  END UTILS   ---------------------------------------	




#-----------------------------  USER CHOSEN HANDLE ---------------------------------------	
	
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
		beq $v0,0,enter_n_again
		bgt $v0,1000,enter_n_again

		# if get n - then get element
		# $a1 save value of n (a0-a3 is register that contain argument)
		move $a1,$v0

		# handle get element
		jal handle_get_element
			
		# after that print menu
		jal menu

		lw $ra,4($sp)
		add $sp,$sp,4

		jr $ra


	# function: handle_get_element(int n = $a1) - print enter element
	handle_get_element:
		sub $sp,$sp,4
		sw $ra,4($sp)
	 
		# i = $t1
		# index = j = $t1 (a[j])
	
		addi $t0,$0,0
		addi $t1,$0,0
		enter_ele:
			# clear $t1 to 0
			addi $t1,$t1,0

			li $v0,4 
			la $a0,enterElement
			syscall

			li $v0,5
			syscall

			# push to array
			# how to push value to array

			# $t3 is stuff to stop j
			addi $t4,$0,4
			mul $t3,$a1,$t4
		
			store: 
				sb $v0,arr($t1)
				addi $t1,$t1,4 # i++
				beq $t1,$t3,store
						
			add $t0,$t0,1
			blt $t0,$a1,enter_ele # if i < n
			
		# debug
		# jal log_array 

		lw $ra,4($sp)
		add $sp,$sp,4

		jr $ra
#----------------------------- END USER CHOSEN HANDLE ---------------------------------------


#----------------------------- FEATURE HANDLE ---------------------------------------

# feature 1: print all elements in the array
# function: log_array (int n = $a1) - print all elements in the array
	log_array:
		sub $sp,$sp,4
		sw $ra,4($sp)

		li $v0,4 
		la $a0,printArrMess
		syscall

		# j = $t1 - index of array a[j]
		# $t3 is stuff to stop j, $t4 is save 4 byte
		addi $t4,$0,4
		mul $t3,$a1,$t4 
		addi $t1,$0,0

		log_arr:
			lb $t6,arr($t1)
			
			li $v0,1
			move $a0,$t6
			syscall 

			jal spacing
		
			addi $t1,$t1,4
			bne $t1,$t3,log_arr
	

		jal drop_down

		# still choose
		jal ask_feature

		lw $ra,4($sp)
		add $sp,$sp,4

		jr $ra

# feature 4: Find element which is maximum value in the array
# function: find_max (int array[] = arr .space 3996, int n = $a1)  - find maximum value in the array
	find_max:
		sub $sp,$sp,4
		sw $ra,4($sp)

		# because of the rule of register is that return value are $v0,$v1 so max is $v1

		# suppose maximun is $v1 = a[0]
		# j = $t1, stop = $t3
		addi $t1,$0,0 # i variable to stop loop
		addi $t4,$0,4 # temp
		mul $t3,$t4,$a1 # j - index of array
		
		# $v1 = a[0]		
		lb $v1,arr($t1)
	
		find_loop:
			# if max <= a[i] -> update max 
			lb $t8,arr($t1)

			#add $t9,$0,$t8
			ble $v1,$t8,this_is_max
			j else_find_max	
			this_is_max:		
				move $v1,$t8
			else_find_max:
				addi $t1,$t1,4	# j++		

			bne $t1,$t3,find_loop

		# print notification
		li $v0,4
		la $a0,printMaxIs
		syscall

		# return max
		li $v0,1
		move $a0,$v1
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

		# x = $s1
		move $s1,$v0
		
	

		# index - j, n = $a1
		# loop i, stop $t3, temp 4 = $t4
		addi $t1,$0,0
		addi $t4,$0,4
		mul $t3,$t4,$a1

		# result = -1
		addi $v1,$0,-1
		loop_find_value:
			lb $t7,arr($t1)	
				
			# debug
			#li $v0,1
			#move $a0,$t7
			#syscall
			
			beq $s1,$t7,finded
			j increate_j
			finded:
				move $v1,$t1
		
			increate_j:
				addi $t1,$t1,4
		
			bne $t1,$t3,loop_find_value
		
		li $v0,4
		la $a0,resultFind
		syscall

		# print result: -1 or exist
		# because index is divisor 4 of j so divide by 4
		# debug
		#li $v0,1
		#move $a0,$v1
		#syscall

		bne $v1,-1,in_arr
			# if v1 = -1 mean find nothing
			addi $v1,$0,-1
			li $v0,1
			move $a0,$v1
			syscall

			j continue_machine
			# if vi != -1 mean finded
		in_arr:
			div $v1,$v1,4
			li $v0,1
			move $a0,$v1
			syscall


		
		continue_machine:

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
	
#----------------------------- END FEATURE HANDLE ---------------------------------------



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

			move $s0,$v0

			# feature 1
			beq $s0,1,log_array

			# feature 2
			beq $s0,2,do_choose

			# feature 3
			beq $s0,3,log_array

			# feature 4
			beq $s0,4,find_max

			# feature 5
			beq $s0,5,find_value


			# feature 6
			beq $s0,6,exit_app
		
			
			blt $s0,1,do_choose
			bgt $s0,6,do_choose
			beq $s0,0,do_choose

			beq $t5,1,do_choose # while true


		li $v0,1
		la $a0,500
		syscall

		lw $ra,4($sp)
		add $sp,$sp,4

		jr $ra
#----------------------------- END - MENU HANDLE ---------------------------------------
		
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

#----------------------------- THE END  ---------------------------------------
		
	
	
