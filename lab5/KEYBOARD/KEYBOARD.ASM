        ORG 0000H
        LJMP MAIN
        ORG 1000H
        
MAIN:  ACALL KEY1
        AJMP MAIN
        
KEY1:   ACALL KEY14
        JNZ KEY3
KEY2:   ACALL KEY16
        AJMP KEY1
KEY3:   ACALL KEY16
        ACALL DELAY
        ACALL KEY14
        JNZ KEY4
        ACALL KEY16
        AJMP KEY1
KEY4:   MOV R2,#0FEH
        MOV R4,#00H
KEY5:   MOV DPTR,#8002H
        MOV A,R2
        MOVX @DPTR,A
        MOV DPTR,#8001H
        MOVX A,@DPTR
        JB ACC.0,KEY6
        MOV A,#00H
        AJMP KEY9
KEY6:   JB ACC.1,KEY7
        MOV A,#06H
        AJMP KEY9
KEY7:   JB ACC.2,KEY8
        MOV A,#0CH
        AJMP KEY9
KEY8:   JB ACC.3,KEY12
        MOV A,#12H
KEY9:   ADD A,R4
KEY10:  MOV R5,A
KEY11:  ACALL KEY14
        JNZ KEY11
        MOV A,R5
        ACALL KEY15
        RET
KEY12:  INC R4
        MOV A,R2
        JNB ACC.5,KEY13
        RL A
        MOV R2,A
        AJMP KEY5
KEY13:  AJMP KEY1
KEY14:  MOV DPTR,#8002H
        MOV A,#00H
        MOVX @DPTR,A
        MOV DPTR,#8001H
        MOVX A,@DPTR
        CPL A
        ANL A,#0FH
        RET
KEY15:  MOV DPTR,#TABLE
        MOVC A,@A+DPTR
        MOV R3,A
KEY16:  MOV DPTR,#8002H
        MOV A,#01H
        MOVX @DPTR,A
        MOV DPTR,#8004H
        MOV A,R3
        MOVX @DPTR,A
        ACALL DELAY
        RET
        
DELAY:  MOV R7,#12

LOOP:   MOV R6,#250
        DJNZ R6,$
        DJNZ R7,LOOP
        RET
        
TABLE:  DB 7EH,7EH,5EH,79H,71H,3FH,7EH,7EH,39H,4FH,5BH,06H,7EH,7EH,7CH,7DH,6DH,66H,7EH,7EH,77H,6FH,7FH,07H

END
