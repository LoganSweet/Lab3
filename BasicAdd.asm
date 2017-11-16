li $sp 0x3ffc

main: 
# take in a number
# want to add sum of all numbers up until that point
# number = number - 1
# when number = 1, add number to register A
# number = number + 1

# ex - let's start with number = 3
addi $a0, $zero, 5
addi $t3, $zero, 7


end:
j end



