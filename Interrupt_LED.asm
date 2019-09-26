	     ORG 00h

BEGIN:	 MOV TMOD, #01h   ;Using Timer 0 in mode 1         
         SJMP INIT        ;Jumping to the Initialization  
         
         ORG 000Bh        ;Vector address of Timer0 Interrupt
         ACALL ISR        ;Calling the ISR sub-routine
         RETI             ;Returning from the ISR 
         
         ORG 0040h
INIT:    MOV R1, #0Ah     ;Counting 50ms Delay 10 times
         MOV TH0, #4Bh    ;Upper Nibble value for counting 50ms
         MOV TL0, #0FCh   ;Lower Nibble value for counting 50ms  
	     MOV IE, #82h     ;Enabling Global and Timer 0 interrupt

MAIN:    CPL P1.1         ;Toggling the LED

TIMER:   SETB TR0         ;Starting Timer0

CHECK:   JNB TF0, CHECK   ;Waiting for TF flag to overflow and interrupt
         DJNZ R1, TIMER   ;
         MOV R1, #0Ah     ;Restore the counter value  
         AJMP MAIN        ;Jump to toggle the led

         ORG 0060h
ISR :    SETB P1.2        ;Set the unused port pin before exiting ISR
         MOV TH0, #4Bh    ;Restore Upper Nibble count for next iteration
         MOV TL0, #0FCh   ;Restore Lower Nibble count for next iteration
         CLR P1.2         ;Clear the unused port pin before exiting ISR
         RET              ;Return from the sub-routine
         
      
	   

