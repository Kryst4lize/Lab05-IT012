# Le Thanh Minh KHTN2021
# 21520063
.data #base data
array:		.space 440
string1: 	.asciiz "Moi ban nhap so phan tu cua mang (<=100): "
string3: 	.asciiz "So phan tu khong hop le ,vui long nhap lai (<=100): "
string4:	.asciiz "Nhap phan tu thu "
string5:	.asciiz ": "
string6:	.asciiz " "
string10:	.asciiz "\n"
string7:	.asciiz "Cac phan tu cua mang truoc khi sap xep lan luot la: "
string8:	.asciiz "Phan tu vua nhap <1, moi nhap lai: "
string9:	.asciiz "\nCac phan tu cua mang sau khi sap xep lan luot la: "
.text #instruction
	la $s0,array #array
	li $v0,4
	la $a0,string1
	syscall #print
	li $v0,5
	syscall #load input
	#check if element <0 or >100
	addi $t2,$v0,0 #number of elements
	slti $t3,$t2,1 
	bne $t3,$0,InputElementNumber
	subi $t4,$t2,101 
	slti $t3,$t4,0  
	beq $t3,$0,InputElementNumber
	#if condition is true, start to get the input of element
	bne $t3,$0,Elements
InputElementNumber:
	li $v0,4
	la $a0,string3
	syscall #print
	li $v0,5
	syscall #load input
	addi $t2,$v0,0 
	slti $t3,$t2,1 
	bne $t3,$0,InputElementNumber
	subi $t4,$t2,101 #t4=t2-50
	slti $t3,$t4,0  #if t4>0 then t3=0 , else t3=1 to check whether t4 exceed 50 or not
	beq $t3,$0,InputElementNumber
Elements:
	addi $t3,$0,0 #
While: #nhap phan tu thu i
	slt $t4,$t3,$t2 
	beq $t4,$0, Check
	li $v0,4
	la $a0,string4
	syscall #print 
	li $v0, 1							
	addi $a0, $t3,1	#input number ith element
	syscall
	li $v0, 4
	la $a0,string5
	syscall #print	
	li $v0,5
	syscall #load input
	add $t5,$0,$v0 #input=t5
ForinWhile:
	slti $t6,$t5,1
	beq $t6,$0,Out
	li $v0, 4
	la $a0,string8
	syscall #print
	li $v0, 5			
	syscall	
	addi $t5,$v0,0
	j ForinWhile
Out:
	sll $s1, $t3, 2
	add $s1,$s0,$s1
	sw $t5,0($s1)
	addi $t3,$t3,1
	j While
Check:
	li $v0, 4
	la $a0,string7
	syscall #print
	addi $t3,$0,0 #counting element
	addi $s2,$s0,0 # temp store address of s0
ForinPrint1: 
	slt $t4,$t3,$t2 
	beq $t4,$0, Sort
	lw $s1,0($s2) #get element
	li $v0, 1							
	addi $a0, $s1,0#print number ith element
	syscall
	li $v0, 4
	la $a0,string6
	syscall #print
	addi $t3,$t3,1  #changeelement
	addi $s2,$s2,4
	j ForinPrint1
Sort:
#initialize
	li $v0, 4
	la $a0,string9
	addi $s2,$s0,0
	syscall #print
	addi $t3,$0,-1 #counting element first loop
Forsort1:
	addi $t3,$t3,1	
	addi $t5,$t3,0 #t5 was current first comparasion
	addi $t6,$t3,0
	slt $t4,$t3,$t2
	beq $t4,$0,After
Forsort2:
	slt $t4,$t5,$t2
	beq $t4,$0,Forsort1
	sll $t5,$t5,2
	sll $t6,$t6,2
	# load two mediate parameter
	add $s2,$s0,$t5
	add $s3,$s0,$t6
	lw $t8,0($s2) 
	lw $t7,0($s3)
	slt $t4,$t8,$t7
	bne $0,$t4,Swap
Continue2:
	srl $t5,$t5,2
	srl $t6,$t6,2
	addi $t5,$t5,1
	j Forsort2
Swap:
	addi $s4,$t7,0
	sw ,$t8,0($s3)
	sw, $s4,0($s2)
	j Continue2
After:
	addi $s2,$s0,0
	addi $t3,$0,0
ForinPrint2: 
	slt $t4,$t3,$t2 
	beq $t4,$0, Exit
	lw $s1,0($s2) #get element
	li $v0, 1							
	addi $a0, $s1,0#print number ith element
	syscall
	li $v0, 4
	la $a0,string6
	syscall #print
	addi $t3,$t3,1  #changeelement
	addi $s2,$s2,4
	j ForinPrint2
Exit: