# loop
addi $t0,$0,0
addi $s0,$0,10
while:
			bgt $t0,$s0,exit	
			jal work
			jal spacing

			addi $t0,$t0,1 # i++
	
			j while
		exit:	
			jal drop_down