DATA SEGMENT
    CHAR_X DW 4
    CHAR_Y DW 54
    CHAR_SIZE DW 10
    STRING DB "STEP: ","$"
    SCORE_0 DB '0'
    SCORE_1 DB '0'
    SCORE_2 DB '0'
    MIN_SCORE DB "MIN STEP:","$"
    LV DB "LV:","$"
    bool db 0
ENDS
STACK SEGMENT
    DW 128 DUP(0)   ;initializes stack
ENDS

CODE SEGMENT
    START:
    MAIN PROC
    MOV AX,DATA
    MOV DS,AX
    MOV ES,AX

MOV AH,00H;SET VIDEO MODE
MOV AL,12H;RESOLUTION 320x200
INT 10H
CALL SHOW_SCORE
CALL SHOW_MINSCORE
CALL SHOW_LEVEL
MOV AL,0DH ;MAGENTA
MOV AH,0CH ;WRITE PIXEL

MOV DX,50
MOV CX,0 
;INT 10H
V1:
INC DX
INT 10H
CMP DX,350
JB V1

MOV DX,50
MOV CX,300
V2:
INC DX
INT 10H
CMP DX,350
JB V2

MOV DX,50
MOV CX,0
H1:
INC CX 
INT 10H
CMP CX,120
JB H1

MOV DX,50
MOV CX,150
H2:
INC CX
INT 10H
CMP CX,300
JB H2

MOV DX,350
MOV CX,0
H3:
INC CX 
INT 10H
CMP CX,150
JB H3

MOV DX,350
MOV CX,180
H4:
INC CX 
INT 10H
CMP CX,300
JB H4

MOV DX,110
MOV CX,0
H5:
INC CX
INT 10H
CMP CX,30
JB H5

MOV DX,260
MOV CX,0
H6:
INC CX 
INT 10H
CMP CX,60
JB H6

MOV DX,320
MOV CX,0
H7:
INC CX
INT 10H
CMP CX,30
JB H7

MOV DX,320
MOV CX,30
V3:
DEC DX
INT 10H
CMP DX,290
JA V3

MOV DX,170
MOV CX,30
V4:
INC DX 
INT 10H
CMP DX,230
JB V4

MOV DX,80
MOV CX,30
H8:
INC CX 
INT 10H
CMP CX,60
JB H8

MOV DX,80
MOV CX,60
V5:
INC DX
INT 10H
CMP DX,110
JB V5

MOV DX,110
MOV CX,60
H9:
INC CX
INT 10H
CMP CX,210
JB H9

MOV DX,140
MOV CX,30
H10:
INC CX
INT 10H
CMP CX,90
JB H10

MOV DX,200
MOV CX,30
H11:
INC CX
INT 10H
CMP CX,90
JB H11

MOV DX,230
MOV CX,30
H12:
INC CX
INT 10H
CMP CX,120
JB H12

MOV DX,350
MOV CX,60
V6:
DEC DX
INT 10H
CMP DX,320
JA V6

MOV DX,80
MOV CX,90
V7:
INC DX 
INT 10H
CMP DX,170
JB V7

MOV DX,170
MOV CX,60
H13:
INC CX
INT 10H
CMP CX,120
JB H13

MOV DX,170
MOV CX,120
V8:
INC DX
INT 10H
CMP DX,230
JB V8

MOV DX,230
MOV CX,90
V9:
INC DX
INT 10H 
CMP DX,260
JB V9

MOV DX,290
MOV CX,60
H14:
INC CX
INT 10H
CMP CX,120
JB H14

MOV DX,290
MOV CX,90
V10:
INC DX
INT 10H
CMP DX,320
JB V10

MOV DX,50
MOV CX,120
V11:
INC DX
INT 10H
CMP DX,80
JB V11

MOV DX,110
MOV CX,120
V12:
INC DX
INT 10H
CMP DX,140
JB V12

MOV DX,140
MOV CX,120
H15:
INC CX
INT 10H
CMP CX,150
JB H15

MOV DX,140
MOV CX,150
V13:
INC DX
INT 10H
CMP DX,260
JB V13

MOV DX,260
MOV CX,150
H16:
DEC CX
INT 10H
CMP CX,120
JA H16 

MOV DX,260
MOV CX,120
V14:
INC DX
INT 10H
CMP DX,350
JB V14

MOV DX,80
MOV CX,150
V15:
INC DX
INT 10H
CMP DX,110
JB V15

MOV DX,80
MOV CX,150
H17:
INC CX
INT 10H
CMP CX,180
JB H17

MOV DX,80
MOV CX,210
V16:
INC DX
INT 10H
CMP DX,110  
JB V16

MOV DX,110
MOV CX,180
V17:
INC DX
INT 10H
CMP DX,170
JB V17

MOV DX,200
MOV CX,150
H18:
INC CX
INT 10H
CMP CX,210
JB H18

MOV DX,140
MOV CX,180
H19:
INC CX
INT 10H
CMP CX,240
JB H19

MOV DX,80
MOV CX,240 
H20:
INC CX
INT 10H 
CMP CX,270
JB H20

MOV DX,80
MOV CX,270
V18:
INC DX
INT 10H
CMP DX,110
JB V18

MOV DX,110
MOV CX,270
H21:
DEC CX
INT 10H
CMP CX,240
JA H21

MOV DX,110
MOV CX,240
V19:
INC DX
INT 10H
CMP DX,230
JB V19

MOV DX,170
MOV CX,210
H22:
INC CX
INT 10H
CMP CX,240
JB H22

MOV DX,200
MOV CX,240
H23:
INC CX
INT 10H
CMP CX,270
JB H23

MOV DX,200
MOV CX,270
V20:
INC DX
INT 10H
CMP DX,320
JB V20

MOV DX,320
MOV CX,270
H24:
DEC CX
INT 10H
CMP CX,240
JA H24

MOV DX,350
MOV CX,180
V21:
DEC DX
INT 10H
CMP DX,320
JA V21

MOV DX,320
MOV CX,180
H25:
DEC CX
INT 10H
CMP CX,150
JB H25

MOV DX,320
MOV CX,150
V22:
DEC DX
INT 10H
CMP DX,290
JA V22

MOV DX,290
MOV CX,150
H26:
INC CX
INT 10H
CMP CX,180
JB H26

MOV DX,290
MOV CX,180
V23:
DEC DX
INT 10H
CMP DX,230
JA V23

MOV DX,230
MOV CX,180
H27:
INC CX
INT 10H
CMP CX,210
JB H27

MOV DX,230
MOV CX,210
V24:
INC DX
INT 10H
CMP DX,260
JB V24

MOV DX,260
MOV CX,210
H28:
INC CX
INT 10H
CMP CX,240
JB H28

MOV DX,290
MOV CX,210
V25:
INC DX
INT 10H
CMP DX,350
JB V25

     
CALL DRAW_CHAR

CALL INPUT

ret
     
MAIN ENDP  
;-------------------------------------------------- 

    DRAW_CHAR PROC
    MOV CX,CHAR_X
    MOV DX,CHAR_Y
    MOV AH,0CH ;write a pixel
    MOV AL,0FH ;white colour
    DRAW:
    INT 10H
    INC CX
    MOV BX,CX
    SUB BX,CHAR_X
    CMP BX,CHAR_SIZE
    JNG DRAW
    MOV CX,CHAR_X
    INC DX
    MOV BX,DX
    SUB BX,CHAR_Y
    CMP BX,CHAR_SIZE
    JNG DRAW
    RET    
    DRAW_CHAR ENDP

;--------------------------------------------------
INPUT PROC
    INP:
        MOV AH,00H
        INT 16H
        CMP AH,48H ;IF ARROW UP IS PRESSSED
        JE UP
        CMP AH,50H ;DOWN KEY
        JE DOWN
        CMP AH,4BH ;LEFT
        JE LEFT
        CMP AH,4DH ;RIGHT
        JE RIGHT
        CMP AL,1BH ;ESCAPE
        JE ESCAPE
        JMP INP
    RIGHT:
        MOV CX,CHAR_X;COLUMN NUMBER
        ADD CX,16
        MOV DX,CHAR_Y
        ADD DX,4  
        CMP CX,300
        JA LV2COMPLETE
        CALL CHECK 
        CMP BOOL,1  
        JE EXIT
        CALL CALC_SCORE
        CALL DELETE_CHAR
        MOV CX,CHAR_X
        ADD CX,10
        MOV CHAR_X,CX
        CALL DRAW_CHAR
        JMP INP
    UP:
        MOV CX,CHAR_X
        MOV DX,CHAR_Y
        SUB DX,4
        CALL CHECK 
        CMP BOOL,1  
        JE EXIT 
        CALL CALC_SCORE
        CALL DELETE_CHAR
        SUB CHAR_Y,10
        CALL DRAW_CHAR
        JMP INP
    LEFT:
        MOV CX,CHAR_X
        SUB CX,4
        MOV DX,CHAR_Y
        ADD DX,4
        CALL CHECK 
        CMP BOOL,1  
        JE EXIT 
        CALL CALC_SCORE
        CALL DELETE_CHAR
        SUB CHAR_X,10
        CALL DRAW_CHAR
        JMP INP
    DOWN:
        MOV CX,CHAR_X
        ADD CX,5
        MOV DX,CHAR_Y
        ADD DX,16
        CALL CHECK 
        CMP BOOL,1  
        JE EXIT 
        CALL CALC_SCORE
        CALL DELETE_CHAR
        ADD CHAR_Y,10
        CALL DRAW_CHAR
        JMP INP
    ESCAPE:
        MOV AH,00H
        MOV AL,12H
        INT 10H
    EXIT:
        MOV AH,02H
        MOV DL,07H ;beep sound
        INT 21H 
        MOV BOOL,0
        JMP INP
    LV2COMPLETE:
        MOV AH,00H
        MOV AL,12H
        INT 10H
INPUT ENDP

;-------------------------------------------------
DELETE_CHAR PROC
    MOV CX,CHAR_X
    MOV DX,CHAR_Y
    MOV AH,0CH
    MOV AL,00H;black colour
    DELETE:
    INT 10H
    INC CX
    MOV BX,CX
    SUB BX,CHAR_X
    CMP BX,CHAR_SIZE
    JNG DELETE
    MOV CX,CHAR_X
    INC DX
    MOV BX,DX
    SUB BX,CHAR_Y
    CMP BX,CHAR_SIZE
    JNG DELETE
    RET
DELETE_CHAR ENDP

;--------------------------------------------------------------------

SHOW_SCORE PROC
    MOV DL,1;column
    MOV DH,1;row
    MOV AH,02  ;setting cursor position
    INT 10H
LEA DX,STRING 
  
 ;output the string
 ;loaded in dx 
 MOV AH,09H
 INT 21H
 MOV DL,8 ;for 000
 MOV DH,1
 MOV AH,02
 INT 10H
 MOV AL, SCORE_0
 MOV BL, 0Ch  ;Color is orange
 MOV BH, 0    ;Display page
 MOV AH, 0Eh  ;Teletype
 INT 10H
 MOV AL,SCORE_1
 INT 10H
 MOV AL,SCORE_2
 INT 10H
    RET
SHOW_SCORE ENDP
;--------------------------------------------------------------------
SHOW_LEVEL PROC
    MOV DL,15
    MOV DH,1
    MOV AH,02
    INT 10H
    LEA DX,LV
    MOV AH,09
    INT 21H
    MOV DL,20
    MOV DH,1
    MOV AH,02
    INT 10H
    MOV BL,0CH;RED
    MOV AH,0EH
    MOV AL,'2'
    INT 10H
    RET
SHOW_LEVEL ENDP
;--------------------------------------------------------------------
SHOW_MINSCORE PROC
    MOV DL,25
    MOV DH,1
    MOV AH,02
    INT 10H
    LEA DX,MIN_SCORE
    MOV AH,09H
    INT 21H
    MOV DL,35
    MOV DH,1
    MOV AH,02
    INT 10H
    MOV BL,0CH
    MOV AH,0EH
    MOV AL,'1'
    INT 10H
    MOV AL,'7'
    INT 10H
    MOV AL,'3'
    INT 10H
    RET
SHOW_MINSCORE ENDP
;--------------------------------------------------------------------
CALC_SCORE PROC
    CMP SCORE_2,'9'
    JE TENTH_PLACE
    INC SCORE_2
    JMP LAST
    TENTH_PLACE:
        CMP SCORE_1,'9'
        JE HUNDREDTH_PLACE
        INC SCORE_1
        MOV SCORE_2,'0'
        JMP LAST
    HUNDREDTH_PLACE:
        INC SCORE_0
        MOV SCORE_1,'0'
        MOV SCORE_2,'0'
        JMP LAST
   LAST:
   CALL SHOW_SCORE
   RET
CALC_SCORE ENDP
;--------------------------------------------------------------------
CHECK PROC 
    MOV AH,0DH ;reading pixel
    MOV BH,0 
    INT 10H  
    CMP AL,0DH
    JNE EX 
    MOV BOOL,1 
    EX: 
    RET 
CHECK ENDP
;--------------------------------------------------------------------        
ENDS

END START 