.data
.text
	addi $s0,$0,4

	sll $t0,$s0,4
	
	li $v0,1
	add $a0,$0,$t0
	syscall