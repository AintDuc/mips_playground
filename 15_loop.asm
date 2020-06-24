.data
	space: .asciiz " "
	drop: .ascii "\n"
	mess: .asciiz "\nDone"
# 8 bit = 1 byte
# 32 bit = 4 byte
.text

main:
	addi $t0,$0,0

	while:
		bgt $t0,10,exit
		jal logNumber

		addi $t0,$t0,1
		j while
		


	exit:
		li $v0,4
		la $a0,mess
		syscall


	li $v0,10
	syscall

	logNumber:
		li $v0,1
		add $a0,$t0,$0
		syscall

		li $v0,4
		la $a0,space
		syscall

		jr $ra

		
