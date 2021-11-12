DATA SEGMENT
    CHAR_X DW 4
    CHAR_Y DW 54
    CHAR_SIZE DW 10
    MOVES DW 0
    STRING DB "STEP: ","$"
    SCORE_0 DB '0'
    SCORE_1 DB '0'
    SCORE_2 DB '0'
    MIN_SCORE DB "MIN STEP:","$"
    LV DB "LV:","$"
    bool db 0
ENDS
STACK SEGMENT
    DW 128 DUP(0)
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
V3:
INC DX
INT 10H
CMP DX,290
JB V3

MOV DX,310
MOV CX,300
V4:
INC DX
INT 10H
CMP DX,350
JB V4  

MOV DX,50
MOV CX,0
H1:
INC CX
INT 10H
CMP CX,300
JB H1

MOV DX,350
MOV CX,0 
H2:
INC CX
INT 10H
CMP CX,300
JB H2

MOV DX,50
MOV CX,80
V5:
INC DX
INT 10H
CMP DX,90
JB V5

MOV DX,90
MOV CX,80
H3:
DEC CX
INT 10H
CMP CX,20
JA H3

MOV DX,90
MOV CX,20
V6:
DEC DX
INT 10H 
CMP DX,70
JA V6

MOV DX,70
MOV CX,20
H4:
INC CX
INT 10H
CMP CX,40  
JB H4 

MOV DX,70
MOV CX,60
H5:
INC CX
INT 10H
CMP CX,80
JB H5

MOV DX,50
MOV CX,140
V7:
INC DX
INT 10H
CMP DX,70
JB V7  

MOV DX,70
MOV CX,140
H6:
INC CX
INT 10H
CMP CX,160
JB H6

MOV DX,50
MOV CX,240
V8: 
INC DX
INT 10H  
CMP DX,70
JB V8

MOV DX,70
MOV CX,240
H7:
DEC CX
INT 10H
CMP CX,200
JA H7

MOV DX,70
MOV CX,200
V9:
INC DX
INT 10H
CMP DX,90
JB V9

MOV DX,90
MOV CX,200
H8:
INC CX
INT 10H
CMP CX,280
JB H8

MOV DX,90
MOV CX,280
V10:
DEC DX
INT 10H
CMP DX,70
JA V10

MOV DX,70
MOV CX,280
H9:
DEC CX
INT 10H 
CMP CX,260
JA H9

MOV DX,70
MOV CX,100
V11:
INC DX
INT 10H
CMP DX,110
JB V11

MOV DX,110
MOV CX,100
H10:
DEC CX
INT 10H
CMP CX,80
JA H10

MOV DX,70
MOV CX,100
H11:
INC CX
INT 10H
CMP CX,120
JB H11

MOV DX,90
MOV CX,100
H12:
INC CX
INT 10H
CMP CX,140
JB H12

MOV DX,90
MOV CX,140
V12:
INC DX
INT 10H
CMP DX,110
JB V12

MOV DX,110
MOV CX,140
H13:
DEC CX
INT 10H
CMP CX,120
JA H13

MOV DX,110
MOV CX,120
V13:
INC DX
INT 10H
CMP DX,130
JB V13

MOV DX,90
MOV CX,160
V14:
INC DX
INT 10H
CMP DX,110
JB V14

MOV DX,110
MOV CX,160
H14:
INC CX
INT 10H
CMP CX,240
JB H14

MOV DX,110
MOV CX,200
V15:
INC DX
INT 10H 
CMP DX,130
JB V15

MOV DX,130
MOV CX,200
H15:
DEC CX
INT 10H
CMP CX,80
JA H15

MOV DX,130
MOV CX,80
V16:
INC DX
INT 10H
CMP DX,230
JB V16 

MOV DX,210
MOV CX,80
H16:
DEC CX
INT 10H
CMP CX,60
JA H16

MOV DX,130
MOV CX,20
V17:
INC DX
INT 10H
CMP DX,210
JB V17

MOV DX,210
MOV CX,20
H17:
INC CX
INT 10H
CMP CX,40
JB H17

MOV DX,210
MOV CX,40
V18:
DEC DX
INT 10H
CMP DX,190
JA V18

MOV DX,170
MOV CX,0
H18:
INC CX
INT 10H
CMP CX,20
JB H18

MOV DX,90
MOV CX,60
V19:
INC DX
INT 10H
CMP DX,110
JB V19

MOV DX,110
MOV CX,60
H19:
DEC CX
INT 10H
CMP CX,40
JA H19

MOV DX,110
MOV CX,40
V20:
INC DX
INT 10H
CMP DX,170
JB V20

MOV DX,170
MOV CX,40
H20:
INC CX
INT 10H
CMP CX,60
JB H20

MOV DX,130
MOV CX,60
V21:
INC DX
INT 10H
CMP DX,190
JB V21 

MOV DX,250
MOV CX,0
H21:
INC CX
INT 10H
CMP CX,20
JB H21

MOV DX,250
MOV CX,20
V22:
DEC DX
INT 10H
CMP DX,230
JA V22

MOV DX,230
MOV CX,20
H22:
INC CX
INT 10H
CMP CX,120
JB H22

MOV DX,230
MOV CX,120
V23:
INC DX
INT 10H
CMP DX,250
JB V23 

MOV DX,230
MOV CX,40  
V24:
INC DX
INT 10H
CMP DX,270
JB V24

MOV DX,270
MOV CX,20
V25:
INC DX
INT 10H
CMP DX,290
JB V25

MOV DX,290
MOV CX,20
H23:
INC CX
INT 10H
CMP CX,60
JB H23

MOV DX,290
MOV CX,60
V26:
DEC DX
INT 10H
CMP DX,250
JA V26

MOV DX,250
MOV CX,60
H24:
INC CX
INT 10H
CMP CX,100
JB H24

MOV DX,250
MOV CX,100
V27:
INC DX
INT 10H
CMP DX,270
JB V27 

MOV DX,350
MOV CX,100
V28:
DEC DX
INT 10H
CMP DX,330
JA V28

MOV DX,330
MOV CX,100
H25:
DEC CX
INT 10H
CMP CX,80
JA H25

MOV DX,330
MOV CX,80
V29:
DEC DX
INT 10H
CMP DX,310
JA V29 

MOV DX,270
MOV CX,100
H26:
INC CX
INT 10H
CMP CX,140
JB H26

MOV DX,250
MOV CX,140
V30:
INC DX
INT 10H
CMP DX,330
JB V30

MOV DX,330
MOV CX,120
H27:
INC CX
INT 10H
CMP CX,160
JB H27
       
MOV DX,330
MOV CX,160
V31:
DEC DX
INT 10H
CMP DX,230
JA V31

MOV DX,230
MOV CX,140
H28:
INC CX
INT 10H
CMP CX,200
JB H28

MOV DX,270
MOV CX,160
H29:
INC CX
INT 10H
CMP CX,200
JB H29

MOV DX,230
MOV CX,140
V32:
DEC DX
INT 10H
CMP DX,190
JA V32

MOV DX,190
MOV CX,140
H30:
INC CX
INT 10H
CMP CX,160
JB H30

MOV DX,190
MOV CX,160
V33:
DEC DX
INT 10H
CMP DX,170
JA V33

MOV DX,170
MOV CX,140
H31:
INC CX
INT 10H
CMP CX,180
JB H31

MOV DX,210
MOV CX,140
H32:
DEC CX
INT 10H
CMP CX,100
JA H32

MOV DX,210
MOV CX,100
V34:
DEC DX
INT 10H
CMP DX,150
JA V34

MOV DX,150
MOV CX,100
H33:
INC CX
INT 10H
CMP CX,140
JB H33

MOV DX,150
MOV CX,140
V35:
INC DX
INT 10H
CMP DX,130
JB V35

MOV DX,130
MOV CX,140
H34:
DEC CX
INT 10H
CMP CX,120
JA H34

MOV DX,90
MOV CX,260
V36:
INC DX
INT 10H
CMP DX,130
JB V36

MOV DX,130
MOV CX,260
H35:
DEC CX
INT 10H
CMP CX,220
JA H35

MOV DX,130
MOV CX,220
V37:
INC DX
INT 10H
CMP DX,150
JB V37

MOV DX,130
MOV CX,220
V38:
INC DX
INT 10H
CMP DX,170
JB V38

MOV DX,170
MOV CX,220
H36:
DEC CX
INT 10H
CMP CX,180
JA H36

MOV DX,330
MOV CX,200
H37:
INC CX
INT 10H
CMP CX,280
JB H37

MOV DX,330
MOV CX,260
H38:
INC CX
INT 10H
CMP CX,300
JB H38

MOV DX,330
MOV CX,240
V39:
DEC DX
INT 10H
CMP DX,210
JA V39   

MOV DX,210
MOV CX,240
H39:
INC CX
INT 10H
CMP CX,280
JB H39 

MOV DX,210
MOV CX,280
V40:
INC DX
INT 10H
CMP DX,270
JB V40 

MOV DX,150
MOV CX,300
H40:
DEC CX
INT 10H
CMP CX,260
JA H40

MOV DX,150 
MOV CX,260
V41:
INC DX
INT 10H
CMP DX,190
JB V41

MOV DX,310
MOV CX,240
H41:
DEC CX
INT 10H
CMP CX,200
JA H41
     
CALL DRAW_CHAR

CALL INPUT

ret
     
MAIN ENDP  
;-------------------------------------------------- 

     DRAW_CHAR PROC
    MOV CX,CHAR_X
    MOV DX,CHAR_Y
    MOV AH,0CH
    MOV AL,0FH
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
        CMP AL,1BH
        JE ESCAPE
        JMP INP
    RIGHT:
        MOV CX,CHAR_X
        ADD CX,20
        CMP CX,300
        JA LV2COMPLETE
        MOV CX,CHAR_X;COLUMN NUMBER
        ADD CX,16
        MOV DX,CHAR_Y
        ADD DX,4
        call check 
        cmp bool,1  
        je exit
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
        call check 
        cmp bool,1  
        je exit 
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
        call check 
        cmp bool,1  
        je exit
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
        call check 
        cmp bool,1  
        je exit
        CALL CALC_SCORE
        CALL DELETE_CHAR
        ADD CHAR_Y,10
        CALL DRAW_CHAR
        JMP INP
    ESCAPE:
        MOV AH,00H;SET VIDEO MODE
        MOV AL,12H;RESOLUTION 320x200
        INT 10H
        ret
    exit:
        mov ah,02h
        mov dl,07h
        int 21h 
        mov bool,0 
        jmp inp
     LV2COMPLETE:
        MOV AH,00H;SET VIDEO MODE
        MOV AL,12H;RESOLUTION 320x200
        INT 10H
        ret
INPUT ENDP

;-------------------------------------------------
DELETE_CHAR PROC
    MOV CX,CHAR_X
    MOV DX,CHAR_Y
    MOV AH,0CH
    MOV AL,00H
    DELETE:
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
    JNG DELETE
    RET
DELETE_CHAR ENDP

;--------------------------------------------------------------------

SHOW_SCORE PROC
    MOV DL,1;column
    MOV DH,1;row
    MOV AH,02
    INT 10H
LEA DX,STRING 
  
 ;output the string
 ;loaded in dx 
 MOV AH,09H
 INT 21H
 MOV DL,8
 MOV DH,1
 MOV AH,02
 INT 10H
 mov  al, SCORE_0
mov  bl, 0Ch  ;Color is orange
mov  bh, 0    ;Display page
mov  ah, 0Eh  ;Teletype
int  10h
mov al,SCORE_1
int 10h
MOV AL,SCORE_2
INT 10H
    RET
SHOW_SCORE ENDP

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

check proc 
    push  bx 
    MOV AH,0DH 
    MOV BH,0 
    INT 10H  
    cmp al,0DH
    jne ex 
    mov bool,1 
    ex: 
    pop bx 
    ret 
check endp
        
ENDS

END START 

