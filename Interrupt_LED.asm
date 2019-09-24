ORG 0h

MOV P1, #03h

ORG 000Bh
MOV P1, A
XRL A, #02h  //Toggling Unused pin
MOV P1, A 
MOV A, P1
ANL A, #0FDh //Clearing the bit 
CLR TF0
RETI 
 