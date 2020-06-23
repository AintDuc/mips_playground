.data
myDB: .double 123.12312331
zrDB: .double 0.0


.text
	ldc1 $f2,myDB
	ldc1 $f0,zrDB

	li $v0,3
	add.d $f12,$f2,$f0
	syscall
