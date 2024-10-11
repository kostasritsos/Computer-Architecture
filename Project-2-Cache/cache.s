#define t0      $8
#define t1      $9
#define t2      $10
#define t3      $11
#define t4      $12
#define t5      $13
#define t6      $14
#define t7      $15
#define t8      $24
#define t9      $25
#define k0      $26
#define k1      $27

#define s0      $16
#define s1      $17
#define s2      $18
#define s3      $19
#define s4      $20
#define s5      $21
#define s6      $22
#define s7      $23

#define gp      $28
#define sp      $29
#define fp      $30
#define ra      $31

.text
.globl _start
.set noat
.set noreorder
.ent _start

_start:
la $s6, array_x 			
la $s7, array_y
la $s5, array_z
addi $s1, $zero, 0
addi $a1, $zero, 0
addi $a3, $zero,8
addi $a2, $zero, 0
addi $ra,$zero,4 //block size=2
	
	
outer:


	beq $a1, $a3, out
		// load y matrix block
		lw $t7, 24 ($s7)//- 4
		lw $t6, 16 ($s7)//- 3
		lw $t5, 8 ($s7)	//- 2
		lw $t4, 0 ($s7)//- 1	
    		lw $t3, 4 ($s7)
    inner:
			beq $a2, $ra, out3
				//load z
				lw $v0, 0 ($s5)
				lw $v1, 4 ($s5)
				
				mult $v0, $t4 		//mul $30, $v0, $t4
					mfhi $s3    
					bne $s3,$zero,out //overflow check in multiplication 
					mflo $30
					addu $26, $26, $30	//add $26, $26, $30
					slt $s2,$26,$30 //overflow check in addu,if result<$30 then we have overflow
					bne $s2,$zero,out
					addi $s2,$zero,0
				mult $v1, $t4		//mul $30, $v1, $t4
					mfhi $s3
					bne $s3,$zero,out //overflow check in multiplication 
					mflo $30
					addu $27, $27, $30	//add $27, $27, $30
					slt $s2,$27,$30 //overflow check in addu,if result<$30 then we have overflow
					bne $s2,$zero,out
					addi $s2,$zero,0
				//since moving to next column i add by 8*ra to go to the next
				lw $v0, 32 ($s5)
				lw $v1, 36 ($s5)
				lw $28, 4 ($s7)
				
				mult $v0, $28		//mul $30, $v0, $28
					mfhi $s3
					bne $s3,$zero,out //overflow check in multiplication 
					mflo $30
					addu $26, $26, $30	//add $26, $26, $30
					slt $s2,$26,$30 //overflow check in addu,if result<$30 then we have overflow
					bne $s2,$zero,out
					addi $s2,$zero,0
				mult $v1, $28		//mul $30, $v1, $28
					mfhi $s3
					bne $s3,$zero,out //overflow check in multiplication 
					mflo $30
					addu $27, $27, $30	//add $27, $27, $30 //- 1 - s0
					slt $s2,$27,$30 //overflow check in addu,if result<$30 then we have overflow
					bne $s2,$zero,out
					addi $s2,$zero,0
				
				lw $v0, 64 ($s5)
				lw $v1, 68 ($s5)
				
				mult $v0, $t5
					mfhi $s3
					bne $s3,$zero,out //overflow check in multiplication 
					mflo $30
					addu $26, $26, $30
					slt $s2,$26,$30 //overflow check in addu,if result<$30 then we have overflow
					bne $s2,$zero,out
					addi $s2,$zero,0
				mult $v1, $t5
					mfhi $s3
					bne $s3,$zero,out //overflow check in multiplication 
					mflo $30
					addu $27, $27, $30
					slt $s2,$27,$30 //overflow check in addu,if result<$30 then we have overflow
					bne $s2,$zero,out
					addi $s2,$zero,0
				
				lw $v0, 96 ($s5)
				lw $v1, 100 ($s5)
				lw $28, 12 ($s7)
				
				mult $v0, $28
					mfhi $s3
					bne $s3,$zero,out //overflow check in multiplication 
					mflo $30					
					addu $26, $26, $30
					slt $s2,$26,$30 //overflow check in addu,if result<$30 then we have overflow
					bne $s2,$zero,out
					addi $s2,$zero,0
				mult  $v1, $28
					mfhi $s3
					bne $s3,$zero,out //overflow check in multiplication 
					mflo $30
					addu $27, $27, $30 //- 2 - s1
					slt $s2,$27,$30 //overflow check in addu,if result<$30 then we have overflow
					bne $s2,$zero,out
					addi $s2,$zero,0
				
				lw $v0, 128 ($s5)
				lw $v1, 132 ($s5)
				
				mult $v0, $t6
					mfhi $s3
					bne $s3,$zero,out //overflow check in multiplication 
					mflo $30
					addu $26, $26, $30
					slt $s2,$26,$30 //overflow check in addu,if result<$30 then we have overflow
					bne $s2,$zero,out
					addi $s2,$zero,0
				mult $v1, $t6
					mfhi $s3
					bne $s3,$zero,out //overflow check in multiplication 
					mflo $30
					addu $27, $27, $30
					slt $s2,$27,$30 //overflow check in addu,if result<$30 then we have overflow
					bne $s2,$zero,out
					addi $s2,$zero,0
				
				lw $v0, 160 ($s5)
				lw $v1, 164 ($s5)
				lw $28, 20 ($s7)
				
				mult  $v0, $28
					mfhi $s3
					bne $s3,$zero,out //overflow check in multiplication 
					mflo $30
					addu $26, $26, $30
					slt $s2,$26,$30 //overflow check in addu,if result<$30 then we have overflow
					bne $s2,$zero,out
					addi $s2,$zero,0
				mult $v1, $28
					mfhi $s3
					bne $s3,$zero,out //overflow check in multiplication 
					mflo $30
					addu $27, $27, $30 //- 3 - s2
					slt $s2,$27,$30 //overflow check in addu,if result<$30 then we have overflow
					bne $s2,$zero,out
					addi $s2,$zero,0
				
				lw $v0, 192 ($s5)
				lw $v1, 196 ($s5)
				
				mult  $v0, $t7
					mfhi $s3
					bne $s3,$zero,out //overflow check in multiplication 
					mflo $30
					addu $26, $26, $30
					slt $s2,$26,$30 //overflow check in addu,if result<$30 then we have overflow
					bne $s2,$zero,out
					addi $s2,$zero,0
				mult $v1, $t7
					mfhi $s3
					bne $s3,$zero,out //overflow check in multiplication 
					mflo $30
					addu $27, $27, $30
					slt $s2,$27,$30 //overflow check in addu,if result<$30 then we have overflow
					bne $s2,$zero,out
					addi $s2,$zero,0
				
				lw $v0, 224 ($s5)
				lw $v1, 228 ($s5)
				lw $28, 28 ($s7)
				
				mult  $v0, $28
					mfhi $s3
					bne $s3,$zero,out //overflow check in multiplication 
					mflo $30
					addu $26, $26, $30
					slt $s2,$26,$30 //overflow check in addu,if result<$30 then we have overflow
					bne $s2,$zero,out
					addi $s2,$zero,0
				mult  $v1, $28
					mfhi $s3
					bne $s3,$zero,out //overflow check in multiplication 
					mflo $30
					addu $27, $27, $30 //- 4 - s3
					slt $s2,$27,$30 //overflow check in addu,if result<$30 then we have overflow
					bne $s2,$zero,out
					addi $s2,$zero,0
				//load x
				lw $t0, 0 ($s6)
				lw $t1, 4 ($s6)
				//add to t8 and t9 the result element after adding the columns of array_z*row of array_y
				add $t8,$26,$zero
				add $t9,$27,$zero
				//add the result with the element of array_x back to array_x,check for overflow similar to before
				addu $t8, $t8, $t0
				slt $s2,$t8,$t0
				bne $s2,$zero,out
				addi $s2,$zero,0
    				sw $t8, 0 ($s6)
				addi $s1,$s1,1
				addu $t9, $t9, $t1
				slt $s2,$t9,$t1
				bne $s2,$zero,out
				addi $s2,$zero,0
    				sw $t9, 4 ($s6)
				addi $s1,$s1,1
				addi $26, $zero, 0 //temp register to store the result to be initialized to zero for the next loop
				addi $27, $zero, 0 //temp register to store the result to be initialized to zero for the next loop
				//counters update
				addi $s6, $s6, 8
				addi $s5, $s5, 8
				addi $a2, $a2, 1

			j inner  
out3:
	//counter update ang go back to outer loop
	addi $a1, $a1, 1
	addi $a2, $zero, 0
	j outer	    
out: 
	break
	nop   
.end _start

.data
.org 10000000
	   
array_z:    .word 23, 45, 12, 67, 89, 34, 56, 78
            .word 76, 98, 54, 32, 87, 10, 98, 76
            .word 56, 78, 90, 21, 43, 65, 76, 98
            .word 12, 67, 89, 34, 56, 78, 90, 21
            .word 54, 32, 87, 10, 98, 76, 54, 32
            .word 98, 54, 32, 87, 10, 98, 76, 54
            .word 21, 43, 65, 76, 98, 54, 32, 87
            .word 32, 21, 43, 65, 76, 98, 54, 32
       

array_y:    .word 87, 10, 98, 76, 54, 32, 21, 43
            .word 32, 87, 10, 98, 76, 54, 32, 21
            .word 54, 32, 21, 43, 65, 76, 98, 54
            .word 76, 54, 32, 87, 10, 98, 76, 54
            .word 43, 65, 76, 98, 54, 32, 87, 10
            .word 21, 43, 65, 76, 98, 54, 32, 87
            .word 32, 87, 10, 98, 76, 54, 32, 21
            .word 76, 54, 32, 21, 43, 65, 76, 98


array_x:    .word 98, 54, 32, 87, 10, 98, 76, 54
            .word 32, 87, 10, 98, 76, 54, 32, 21
            .word 54, 32, 21, 43, 65, 76, 98, 54
            .word 76, 54, 32, 87, 10, 98, 76, 54
            .word 43, 65, 76, 98, 54, 32, 87, 10
            .word 21, 43, 65, 76, 98, 54, 32, 87
            .word 32, 87, 10, 98, 76, 54, 32, 21
            .word 76, 54, 32, 21, 43, 65, 76, 98
     




