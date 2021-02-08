        ORG  0000H
        AJMP MAIN
        ORG  000BH
        LJMP CLOCK
        ORG  0023H
        LJMP INPUT
        
        ORG  0100H
MAIN:   MOV  TMOD,#21H          
        CLR  A
        MOV  30H,A	;hour 
        MOV  31H,A	;min
        MOV  32H,A	;second

        MOV  TH0,#3CH           
        MOV  TL0,#0B0H
        MOV  50H,#14H           
        MOV  TH1,#0F3H          ;SMOD=0  ?
        MOV  TL1,#0F3H          

        MOV  SCON,#50H          
        SETB PS
        MOV  IE,#92H            
        SETB TR1                
        SETB TR0

SLED:   MOV  R0,#30H
        MOV  R1,#20H
        LJMP LED


CLOCK:  ;PUSH PSW
		;PUSH ACC
		MOV  TH0,#3CH
        MOV  TL0,#0B0H
        DJNZ 50H,RETURN
        MOV  50H,#14H

        MOV  A,#01H
        ADD  A,32H
        DA   A
        MOV  32H,A
        CJNE A,#60H,RETURN
        MOV  32H,#00H

        MOV  A,#01H
        ADD  A,31H
        DA   A

        MOV  31H,A
        CJNE A,#60H,RETURN
        MOV  31H,#00H

        MOV  A,#01H
        ADD  A,30H
        DA   A
        MOV  30H,A
        CJNE A,#24H,RETURN
        MOV  30H,#00H

RETURN: ;POP ACC
		;POP PSW
		RETI

LED:    MOV  A,@R0
        SWAP A
        ANL  A,#0FH
        ACALL CTAB
        MOV  R2,A

        MOV  A,@R0
        ANL  A,#0FH
        LCALL CTAB
        MOV  R3,A

        MOV  DPTR,#0A002H
        MOV  A,R1
        MOVX @DPTR,A
        MOV  DPTR,#0A004H
        MOV  A,R2
        MOVX @DPTR,A
        MOV  A,R1
        RR   A
        MOV  R1,A
        LCALL DL1ms

        MOV  DPTR,#0A002H
        MOV  A,R1
        MOVX @DPTR,A
        MOV  DPTR,#0A004H
        MOV  A,R3
        MOVX @DPTR,A
        MOV  A,R1
        RR   A
        MOV  R1,A
        LCALL DL1ms

        INC  R0
        CJNE R0,#33H,LED
        LJMP SLED

CTAB:   PUSH DPH
        PUSH DPL
        MOV  DPTR,#TAB
        MOVC A,@A+DPTR
        POP  DPL
        POP  DPH
        RET

INPUT:  CLR  RI
        CLR  EA
        MOV  30H,SBUF
        JNB  RI,$
        CLR  RI
        MOV  31H,SBUF
        JNB  RI,$
        CLR  RI
        MOV  32H,SBUF
        SETB EA
        RETI

TAB:    DB 3FH,06H,5BH,4FH,66H,6DH,7DH,07H,7FH,6FH

DL1ms:  MOV  R7,#02H
DL:     MOV  R6,#0FFH
DL1:    DJNZ R6,DL1
        DJNZ R7,DL
        RET

END
