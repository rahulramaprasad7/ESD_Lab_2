ORG $0h

BEGIN CLR P1      	;Clearing Port1
	  MOV TMOD, #00h   	;Using Timer 0 in mode 0
	  MOV R1, #0Ah
	  CLR TR0
	  CLR TF0
	  MOV IE, #82h
	  
LOOP: AJMP LEDON      	;Continue to toggle the LED 
      	  
ORG $000Bh
LJMP ISR_TMR0

LEDON: SETB P1.0
       ACALL DELAY
	   DJNZ R1, LEDON  	;Execute 50ms delay 10 times
	   MOV R1, #0Ah
	  
LEDOFF: CLR P1.0
        ACALL DELAY
	    DJNZ R1, LEDOFF
		MOV R1, #0Ah
		AJMP LOOP
	  
DELAY: MOV TH0, #4Bh    ;Upper nibble value for 50ms delay
	   MOV TL0, #0FDh   ;Lower nibble value for 50ms delay
	   SETB TR0
CHECK: SJMP CHECK
       
	   
ISR_TMR0: CPL P1.1      ;Toggling port pin P1.1
		  CLR P1.1      ;Clearing the port pin P1.1 
		  CLR TR0
		  CLR TF0
		  RETI 


 