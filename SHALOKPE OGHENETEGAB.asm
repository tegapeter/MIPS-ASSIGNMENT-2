.data
aic: .asciiz "aX2 + bX + c"
 aicA: .asciiz "\nEneter value for a = "
 aicB: .asciiz "\nEneter value for b = "
 aicC: .asciiz "\nEneter value for c = "
 error: .asciiz "\nThis equation has a complex root it cannot be solved.\nTry again!!!!!!!"
 ans: .asciiz "\nThe two value for x = "
 want: .asciiz "\nEnter 1 to continue, Enter any other number to quit = "
 an: .asciiz " & "
zeroFloat: .float 0.0
one: .float -1.0
four: .float 4 
two: .float 2
posone: .word 1
.text
lw $t3,posone
 
 li $v0,4
 la $a0,aic
 syscall
 
 main:
 lwc1 $f4,zeroFloat
 lwc1 $f2,one
 lwc1 $f20,two
 lwc1 $f18,four
 
 
 li $v0,4#ask for first input
 la $a0,aicA
 syscall
 
 li $v0,6
 syscall
mov.s $f6,$f0
 
 
 li $v0,4 #ask for second input
 la $a0,aicB
 syscall
 
 li $v0,6
 syscall
mov.s $f8,$f0
  
li $v0,4#ask for third input
 la $a0,aicC
 syscall
 
 
 li $v0,6
 syscall
 mov.s $f10,$f0

mul.s $f14,$f8,$f8 #b2
mul.s $f2,$f8,$f2 #-b value
mul.s $f16,$f6,$f10   #ac
mul.s $f10,$f18,$f16 #4ac
sub.s $f22,$f14,$f10 #b2-4ac
mfc1 $t1,$f22
bltz $t1 complexRoot
sqrt.s $f28,$f22 #sqrt(b2-4ac)
add.s $f22,$f2,$f28 #-b+sqrt(b2-4ac)
sub.s $f24,$f2,$f28 #-b-sqrt(b2-4ac)
mul.s $f16,$f20,$f6 #2a check $f16 if errorr
div.s $f26,$f22,$f16#(-b+sqrt(b2-4ac))/2a
div.s $f30,$f24,$f16#(-b-sqrt(b2-4ac))/2a

li $v0,4
 la $a0,ans
 syscall
 
 
 li $v0,2
 add.d $f12,$f4,$f26
 syscall
 li $v0,4
 la $a0,an
 syscall
 
  li $v0,2
 add.d $f12,$f4,$f30
 syscall
b wants
complexRoot:
li $v0,4
la $a0,error
syscall
j main
wants:
li $v0,4
la $a0,want
syscall

li $v0,5
syscall
move $t0,$v0
beq $t0,$t3,main #branch main if input = 1

li $v0,10
syscall

