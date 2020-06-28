.data
	a: .word 5
	b: .word 10
.text
	lw $s0,a
	lw $s1,b

	sub $t0,$s0,$s1
	
	li $v0,1
	add $a0,$0,$t0
	syscall