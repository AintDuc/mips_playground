.data
	a: .word 5
	b: .word 10
.text
	lw $t0,a
	lw $t1,b

	add $t2,$t0,$t1

	li $v0,1
	add $a0,$0,$t2
	syscall