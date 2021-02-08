        ORG 0000H
        LJMP ST
        ORG 000BH
        LJMP TT0
        ORG 0050H
ST:  MOV 50H,#0
        MOV 51H,#0
        MOV 52H,#0
        MOV 53H,#0
        MOV 54H,#0
        MOV 55H,#0
        MOV TMOD,#01H
        MOV TH0£¬#4CH
        MOV TL0£¬#00H
        SETB EA
        SETB ET0
        SETB IT1
        MOV R1£¬#50H
        MOV R5£¬#20

        CLR F0
        CLR C
        CLR TR0
KT:     LCALL KEY
        CJNE R2£¬#0FFH,L
        JB TR0£¬KS
        JNB IE1£¬SO
        LCALL DEL10MS
        JNB IE1£¬SO
        CLR IE1
        INC R1
        CLR C
        CJNE R1£¬#56H,ZY
        MOV R1£¬#50H
        SJMP KT
ZY:     JNC SO
        CLR C

SO:     LCALL DIR
        SJMP KT
L:      CJNE R2£¬#0BH,LL
        CLR TR0
        LJMP KT
LLL:    LJMP LLLS
LL:     CJNE R2£¬#0AH,LLL
        SETB TR0
KS:     JB F0,JS
        LCALL DIR
        LJMP KT
JS:     CLR F0
        MOV A,55H
        INC A
        CJNE A,#0AH,M1
        MOV 55H,#0
        MOV A,54H
        INC A
        CJNE A,#06H,M12
        MOV 54H,#0
        MOV A,53H
        INC A
        CJNE A,#0AH,M13
        MOV 53H,#0
        MOV A,52H
        INC A
        CJNE A,#06H,M14
        MOV 52H,#0
        MOV A,51H
        INC A
        CJNE A,#0AH,M15
        MOV 51H,#0
        MOV A,50H
        INC A
        CJNE A,#03H,M16
        MOV 50H,#0
        SJMP KB5
M16:    JNC KB5
        MOV 50H,A
        CLR C
KB5:    LCALL DIR
        LJMP KT
M15:    JNC TW
        MOV 51H,A
        CLR C
        MOV A,50H
        CJNE A,#02H,TW
        MOV A,51H                        
