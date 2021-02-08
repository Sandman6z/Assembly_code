            ORG 0000H
            AJMP MAIN
            ORG 0100H
       MAIN:MOV A,#01H
       SUB1:MOV P1,A
            ACALL DEL
            MOV P1,#00H
            ACALL DEL
            RL A
            AJMP SUB1

        DEL:MOV R2,#200
       DEL1:MOV R3,#123
            NOP
       DEL2:DJNZ R3,DEL2
            DJNZ R2,DEL1
            RET
END
