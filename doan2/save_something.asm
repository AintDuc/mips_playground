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


# do while menu
		again:
			li $v0,4
			la $a0,askFeature
			syscall
			
			li $v0,5
			syscall

			move $s0,$v0

		# handle overflow 
		blt $s0,1,again
		bgt $s0,6,again
#----------------------------------------
		# find maximum algorithm C++
		#	int max(int arr[],int n){
		#		int max=a[0];
		#		for i from 0 to n-1
		#			if max<=a[i]
		#				max=a[i]
		#		return max	
		#	}
#----------------------------------------
find ele equal to x
int find_element(int a[],int n,int x){
	int result=-1;
	for(int i=n-1;i>=0;i--){
		if (a[i]==x){
			result = i;
		}
	}
	return result;
}

#----------------------------------------
