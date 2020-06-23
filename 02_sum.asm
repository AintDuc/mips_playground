.data
x: .word 0  # int x = 0


.text
.globl main
main:
add $s0,$0,5
add $s1,$0,3

sub  $s2,$s0,$s1
mult $s2,$s1
div $s0,$s1

mflo $s2 # thuong
mfhi $s3 #du


addi $v0,$0,1
add  $a0,$0,$s2
# syscall

# store s2 vo x
sw $s2,x


# a0 = x, xuat x ra = a0
lw $a0,x
syscall
