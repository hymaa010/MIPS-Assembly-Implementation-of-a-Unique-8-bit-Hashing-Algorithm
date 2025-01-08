.text
hash_fn:
	lw   $t0,0($a1)
	lb   $t0,0($t0)
	addi $t0,$t0,-48
	addi $s7,$0,20
	srl  $s3,$t0,24
	sll  $s2,$t0,8
	srl  $s2,$s2,24
	sll  $s1,$t0,16
	srl  $s1,$s1,24
	sll  $s0,$t0,24
	srl  $s0,$s0,24
	xor  $a0,$s3,$s7
	jal  fx
	xor  $a0,$s2,$v0
	andi  $a0,$a0,255
	jal  fx
	xor  $a0,$s1,$v0
	andi  $a0,$a0,255
	jal  fx
	xor  $a0,$s0,$v0
	andi  $a0,$a0,255
	jal  fx
	andi  $v0,$v0,255
	addi $t1,$0,0
	lui  $t1,4097
	sw   $v0,0($t1)
	addi $s0,$v0,0 
	addi $v0,$0,10
	syscall 
		
fx: 	addi $sp,$sp,-4
	sw   $ra,0($sp)
	addi $s4,$a0,0
	#x^2
	addi $a1,$a0,0
	jal multi
	#282x^2+271
	addi $a0,$s6,0
	addi $a1,$0,282
	jal  multi
	addi $v0,$s6,271
	#282X^2-99x+271
	addi $a0,$s4,0
	addi $a1,$0,99
	jal  multi
	sub  $v0,$v0,$s6
	lw   $ra,0($sp)
	addi $sp,$sp,4
	jr   $ra

	multi: 	addi $s6,$0,0
		addi $t1,$a0,0
		addi $t2,$a1,0
		addi $t3,$0,32
		addi $t4,$0,32
		loop:	beq  $t3,$t4,skip
			sll  $t1,$t1,1
			srl  $t2,$t2,1
		skip:	andi $t5,$t2,1
			addi $t3,$t3,-1
			beq  $t5,$0,z
			add  $s6,$s6,$t1
		z:      bne  $t3,$0,loop
		jr $ra
