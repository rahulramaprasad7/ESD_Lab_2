	     ORG 00h

BEGIN:	 MOV P1, #00h 	    ;Clearing Port1
		 MOV TMOD, #00h   	;Using Timer 0 in mode 0
	     MOV R1, #0Ah       ;Storing the count for 50ms delay
	     CLR TR0
	     CLR TF0
	     MOV IE, #82h       ;Enabling interrupt for Timer0
	  
LOOP: 	 AJMP LEDON      	;Continue to toggle the LED 
      	  
	     ORG 0Bh
	     LJMP ISR_TMR0

LEDON: 	 SETB P1.0          ;Switching on LED on P1.1
         ACALL DELAY        ;Keeping the LED ON for 50ms
	     DJNZ R1, LEDON  	;Execute 50ms delay 10 times
	     MOV R1, #0Ah       ;Restoring the count value
	  
LEDOFF:  CLR P1.0           ;Switching off LED on P1.1
         ACALL DELAY        ;Keeping the LED OFF for 50ms
	     DJNZ R1, LEDOFF    ;Execute 50ms delay 10 times
		 MOV R1, #0Ah       ;Restoring the count value
		 AJMP LOOP
	  
DELAY:   MOV TH0, #4Bh      ;Upper nibble value for 50ms delay
	     MOV TL0, #0FDh     ;Lower nibble value for 50ms delay
	     SETB TR0           ;Starting Timer0
CHECK:   JNB TF0, CHECK     ;Waiting for TF0 flag to get set and trigger an interrupt
       
	   
ISR_TMR0:SETB P1.1          ;Setting the port pin P1.1
		  CLR TR0
		 CLR TF0
		 CLR P1.1           ;Clearing the port pin P1.1 
		 RETI 


 
