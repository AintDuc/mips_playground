.data
	a: .word 5
	b: .word 7

.text
	addi $s0,$0,5
	addi $s1,$0,10

	mul $t0,$s0,$s1

	mult $s0,$s1
	mflo $s3

	li $v0,1
	add $a0,$0,$t0
	syscall

	li $v0,1
	add $a0,$0,$s3
	syscall