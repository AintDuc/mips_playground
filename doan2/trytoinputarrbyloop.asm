.data
arr: .space 3996

mess:.asciiz"enter n: "
mess2: .asciiz "enter value: "
space: " "
.text
	main:
		jal enter_n
			
		
		
		
		li $v0,10
		syscall

	enter_n:
		sub $sp,$sp,4
		sw $ra,4($sp)

		enter_n_again:
			li $v0,4
			la $a0,mess
			syscall

			li $v0,5
			syscall		

			blt $v0,0,enter_n_again
			beq $v0,0,enter_n_again
			bgt $v0,1000,enter_n_again

		move $s0,$v0 # n = s0

		addi $t0,$0,0
		addi $t1,$0,0
		store:
			li $v0,4
			la $a0,mess2
			syscall
		
			li $v0,5
			syscall
		
			sw $v0,arr($t1)
			addi $t1,$t1,4
					
			addi $t0,$t0,1
			blt $t0,$s0,store

		jal log
			
		lw $ra,4($sp)
		add $sp,$sp,4

		jr $ra

	log:
		sub $sp,$sp,4
		sw $ra,4($sp)


		addi $t0,$0,0
		addi $t1,$0,0
		log_loop:

			lw $t5,arr($t1)

			li $v0,1
			move $a0,$t5
			syscall			

			addi $t1,$t1,4

			addi $t0,$t0,1
			blt $t0,$s0,log_loop



		lw $ra,4($sp)
		add $sp,$sp,4

		jr $ra
	
	