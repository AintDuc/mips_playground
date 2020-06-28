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
find ele equal to x algorithm
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
sum all ele algorithm
int sum_array(int a[],int n){
	int rs = 0;
	for i from 0 to n-1
		rs+=a[i];
	return rs;
}

sum version 2
int sum_arr(int a[],int n){
	int rs = 0;
	for i from 1 to n/2
		rs=a[i]+a[n-i-1]+rs;

	if(n%2!=0)
		rs+=a[n/2+1]
	return rs;
}
# -----------------------------
is primes algorithm
is_primes (int n){
	if(n<2)return false;
	for i from 2 to n-1 
		if n%i==0
			return false
	return true
}
#-------------------------------
print ele which are prime in arr
void print_primes(int a[],int n){
	for(int i=n-1;i>=0;i--){
		if(is_primes(a[i]))
			clog<<a[i]<< " ";
	}
	clog<<endl;
}



#---------------------------------
# bugs input

			# $t3 is stuff to stop j
			addi $t4,$0,4
			mul $t3,$a1,$t4
		
			store: 
				#sw $v0,arr($t1)
				# move arr($t1),$v0
				sb $v0,arr($t1)


				addi $t1,$t1,4 # i++
				blt $t1,$t3,store



# feature 5 bugs
# index - j, n = $a1
		# loop i, stop $t3, temp 4 = $t4
		addi $t1,$0,0
		addi $t4,$0,4
		mul $t3,$t4,$a1

		# result = -1
		addi $v1,$0,-1
		loop_find_value:
			lw $t7,arr($t1)	
				
			# debug
			#li $v0,1
			#move $a0,$t7
			#syscall
			
			beq $s2,$t7,finded
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

# find max bug
	# because of the rule of register is that return value are $v0,$v1 so max is $v1

		# suppose maximun is $v1 = a[0]
		# j = $t1, stop = $t3
		addi $t1,$0,0 # i variable to stop loop
		addi $t4,$0,4 # temp
		mul $t3,$t4,$s0 # j - index of array
		
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


