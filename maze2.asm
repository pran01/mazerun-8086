; multi-segment executable file template.

data segment
    ; add your data here!
    CHAR_X DW 5
    CHAR_Y DW 54
    CHAR_SIZE DW 10
    STRING DB "STEP: ","$"
    SCORE_0 DB '0'
    SCORE_1 DB '0'
    SCORE_2 DB '0'
    MIN_SCORE DB "MIN STEP:","$"
    LV DB "LV.","$"
    QUIT_MSG DW "DO YOU WANT TO QUIT?","$"
    CONFIRMATION DB "(PRESS y TO CONFIRM)","$"
    LVL_UP_MSG DB "DO YOU WANT TO MOVE TO NEXT LEVEL?","$"   
    GAMECOMPLETE DW "YOU HAVE COMPLETED ALL 3 MAZE RUNS SUCCESSSFULLY","$" 
    CONG DW "CONGRATULATIONS!!!" ,"$"
    bool db 0
    LV2_DOWN_BOUND DW 16
    LV2_UP_BOUND DW 4
    LV2_LEFT_BOUND DW 5
    LV2_RIGHT_BOUND DW 15
    LV3_DOWN_BOUND DW 16
    LV3_UP_BOUND DW 4
    LV3_LEFT_BOUND DW 5
    LV3_RIGHT_BOUND DW 15
    CURR_LV DB 1
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
MAIN PROC
    ; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ;add your code here
    MOV AH,00H;SET VIDEO MODE
    MOV AL,12H;RESOLUTION
    INT 10H
    CALL LEVEL1
    ret     
MAIN ENDP
;------------------------------------------------------

CLEAR_SCR PROC
    MOV CX,0
    MOV DX,0
    MOV AH,0CH
    MOV AL,00H
    CLEAR:
    INT 10H
    INC CX
    CMP CX,500
    JNG CLEAR
    MOV CX,0
    INC DX
    CMP DX,500
    JNG CLEAR
    RET
CLEAR_SCR ENDP

;----------------------------------------------------

LEVEL1 PROC
    CALL SHOW_SCORE
    CALL SHOW_MINSCORE1
    CALL SHOW_LEVEL
    CALL CREATE_MAZE1
    CALL DRAW_CHAR
    CALL INPUT
    RET
LEVEL1 ENDP

;-----------------------------------------------------

LEVEL3 PROC
    CALL SHOW_SCORE
    CALL SHOW_MINSCORE3
    CALL SHOW_LEVEL
    CALL CREATE_MAZE3
    CALL DRAW_CHAR
    CALL INPUT
    RET
LEVEL3 ENDP

;---------------------------------------------------

LEVEL2 PROC
    CALL SHOW_SCORE
    CALL SHOW_MINSCORE2
    CALL SHOW_LEVEL
    CALL CREATE_MAZE2
    CALL DRAW_CHAR
    CALL INPUT
    RET
LEVEL2 ENDP

;-----------------------------------------------------------------------
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
    CMP BX,CHAR_SIZE;(CX-char_x<char_size)
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
        INT 16H ;AH CONTAINS SCAN CODE AND AL CONTAINS ASCII
        CMP AH,48H ;IF ARROW UP IS PRESSSED
        JE UP
        CMP AH,50H ;DOWN KEY
        JE DOWN
        CMP AH,4BH ;LEFT
        JE LEFT
        CMP AH,4DH ;RIGHT
        JE RIGHT
        CMP AL,1BH;esc
        JE ESCAPE
        JMP INP
    RIGHT:
        MOV CX,CHAR_X;COLUMN NUMBER
        ADD CX,LV3_RIGHT_BOUND
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
        SUB DX,LV3_UP_BOUND
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
        SUB CX,LV3_LEFT_BOUND
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
        ADD DX,LV3_DOWN_BOUND
        call check 
        cmp bool,1  
        je exit
        MOV DX,CHAR_Y
        ADD DX,10
        CMP DX,350
        JA LVCOMPLETE
        CALL CALC_SCORE
        CALL DELETE_CHAR
        ADD CHAR_Y,10
        CALL DRAW_CHAR
        JMP INP
    ESCAPE:
        CALL CLEAR_SCR
        MOV DL,25
        MOV DH,5
        MOV AH,02
        INT 10H
        LEA DX,QUIT_MSG
        MOV AH,09H
        INT 21H
        MOV DL,25
        MOV DH,6
        MOV AH,02
        INT 10H
        LEA DX,CONFIRMATION
        MOV AH,09H
        INT 21H
        CHECKAGAIN:
        MOV AH,07H
        INT 21H
        CMP AL,79H
        JE ENDGAME
        JMP CHECKAGAIN
        RET
    exit:
        mov ah,02h
        mov dl,07h
        int 21h 
        mov bool,0 
        jmp inp
    LVCOMPLETE:
        CALL CLEAR_SCR
        MOV DL,25
        MOV DH,5
        MOV AH,02
        INT 10H
        LEA DX,LVL_UP_MSG
        MOV AH,09H
        INT 21H
        MOV DL,25
        MOV DH,6
        MOV AH,02
        INT 10H
        LEA DX,CONFIRMATION
        MOV AH,09H
        INT 21H
        CHECKAGAINLVL:
        MOV AH,07H
        INT 21H
        CMP AL,79H
        JE COMPLETE
        JMP CHECKAGAINLVL
        COMPLETE:
            CALL CLEAR_SCR
            MOV CHAR_X,5
            MOV CHAR_Y,54
            CMP CURR_LV,1
            JE LV2
            CMP CURR_LV,2
            JE LV3
            CMP CURR_LV,3
            JE ENDGAME
        LV2:
            MOV CURR_LV,2
            MOV SCORE_0,'0'
            MOV SCORE_1,'0'
            MOV SCORE_2,'0'
            CALL LEVEL2
            RET
        LV3:
            MOV CURR_LV,3
            MOV SCORE_0,'0'
            MOV SCORE_1,'0'
            MOV SCORE_2,'0'
            CALL LEVEL3
            RET
        ENDGAME:
            MOV CURR_LV,1
            CALL ENDGAMEP
            RET
        RET
INPUT ENDP
;--------------------------------------------------

ENDGAMEP PROC
    ;PUSH AX
    ;POP AX
     CALL CLEAR_SCR
        MOV DL,20
        MOV DH,5
        MOV AH,02
        INT 10H
        LEA DX,GAMECOMPLETE
        MOV AH,09H
        INT 21H 
        MOV DL,25
        MOV DH,8
        MOV AH,02
        INT 10H
        LEA DX,CONG
        MOV AH,09H
        INT 21H 
        RET
ENDGAMEP ENDP

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
    INT 10H;setting cursor position
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
    mov  bl, 0Ch  ;Color is red
    mov  bh, 0    ;Display page
    mov  ah, 0Eh  ;Teletype
    int  10h
    mov al,SCORE_1
    int 10h
    MOV AL,SCORE_2
    INT 10H
    RET
SHOW_SCORE ENDP
;--------------------------------------------------------
SHOW_MINSCORE1 PROC
    MOV DL,25
    MOV DH,1
    MOV AH,02
    INT 10H;setting cursor position
    LEA DX,MIN_SCORE
    MOV AH,09H
    INT 21H
    MOV DL,35
    MOV DH,1
    MOV AH,02
    INT 10H
    MOV BL,0CH
    MOV AH,0EH
    MOV AL,'0'
    INT 10H
    MOV AL,'8'
    INT 10H
    MOV AL,'2'
    INT 10H
    RET
SHOW_MINSCORE1 ENDP
;-----------------------------------------------------
SHOW_MINSCORE2 PROC
    MOV DL,25
    MOV DH,1
    MOV AH,02
    INT 10H;setting cursor position
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
    MOV AL,'1'
    INT 10H
    MOV AL,'1'
    INT 10H
    RET
SHOW_MINSCORE2 ENDP
;--------------------------------------------------------
SHOW_MINSCORE3 PROC
    MOV DL,25
    MOV DH,1
    MOV AH,02
    INT 10H;setting cursor position
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
    MOV AL,'4'
    INT 10H
    MOV AL,'0'
    INT 10H
    RET
SHOW_MINSCORE3 ENDP
;--------------------------------------------------------
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
    CMP CURR_LV,1
    JE LV1CHAR
    CMP CURR_LV,2
    JE LV2CHAR
    CMP CURR_LV,3
    JE LV3CHAR
    LV1CHAR:
    MOV AL,'1'
    JMP PRINT
    LV2CHAR:
    MOV AL,'2'
    JMP PRINT
    LV3CHAR:
    MOV AL,'3'
    PRINT:
    INT 10H
    RET
SHOW_LEVEL ENDP
;--------------------------------------------------------
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
;---------------------------------------------------------
check proc 
    MOV AH,0DH 
    MOV BH,0 
    INT 10H;reads the pixel  
    cmp al,0DH;al contains the colour 
    jne ex 
    mov bool,1
    ex:
    ret 
check endp
;------------------------------------------------------

CREATE_MAZE1 PROC
    MOV AL,0DH ;MAGENTA
    MOV AH,0CH ;WRITE PIXEL
    
    MOV DX,50
    MOV CX,0 
    ;INT 10H
    L1V1:
    INC DX
    INT 10H
    CMP DX,350
    JB L1V1
    
    MOV DX,50
    MOV CX,300
    L1V2:
    INC DX
    INT 10H
    CMP DX,350
    JB L1V2
    
    MOV DX,50
    MOV CX,0
    L1H1:
    INC CX 
    INT 10H
    CMP CX,300
    JB L1H1
    
    
    MOV DX,350
    MOV CX,0
    L1H3:
    INC CX 
    INT 10H
    CMP CX,150
    JB L1H3
    
    MOV DX,350
    MOV CX,180
    L1H4:
    INC CX 
    INT 10H
    CMP CX,300
    JB L1H4
    
    MOV DX,110
    MOV CX,0
    L1H5:
    INC CX
    INT 10H
    CMP CX,30
    JB L1H5
    
    MOV DX,260
    MOV CX,0
    L1H6:
    INC CX 
    INT 10H
    CMP CX,60
    JB L1H6
    
    MOV DX,320
    MOV CX,0
    L1H7:
    INC CX
    INT 10H
    CMP CX,30
    JB L1H7
    
    MOV DX,320
    MOV CX,30
    L1V3:
    DEC DX
    INT 10H
    CMP DX,290
    JA L1V3
    
    MOV DX,170
    MOV CX,30
    L1V4:
    INC DX 
    INT 10H
    CMP DX,230
    JB L1V4
    
    MOV DX,80
    MOV CX,30
    L1H8:
    INC CX 
    INT 10H
    CMP CX,60
    JB L1H8
    
    MOV DX,80
    MOV CX,60
    L1V5:
    INC DX
    INT 10H
    CMP DX,110
    JB L1V5
    
    MOV DX,110
    MOV CX,60
    L1H9:
    INC CX
    INT 10H
    CMP CX,210
    JB L1H9
    
    MOV DX,140
    MOV CX,30
    L1H10:
    INC CX
    INT 10H
    CMP CX,90
    JB L1H10
    
    MOV DX,200
    MOV CX,30
    L1H11:
    INC CX
    INT 10H
    CMP CX,90
    JB L1H11
    
    MOV DX,230
    MOV CX,30
    L1H12:
    INC CX
    INT 10H
    CMP CX,120
    JB L1H12
    
    MOV DX,350
    MOV CX,60
    L1V6:
    DEC DX
    INT 10H
    CMP DX,320
    JA L1V6
    
    MOV DX,80
    MOV CX,90
    L1V7:
    INC DX 
    INT 10H
    CMP DX,170
    JB L1V7
    
    MOV DX,170
    MOV CX,60
    L1H13:
    INC CX
    INT 10H
    CMP CX,120
    JB L1H13
    
    MOV DX,170
    MOV CX,120
    L1V8:
    INC DX
    INT 10H
    CMP DX,230
    JB L1V8
    
    MOV DX,230
    MOV CX,90
    L1V9:
    INC DX
    INT 10H 
    CMP DX,260
    JB L1V9
    
    MOV DX,290
    MOV CX,60
    L1H14:
    INC CX
    INT 10H
    CMP CX,120
    JB L1H14
    
    MOV DX,290
    MOV CX,90
    L1V10:
    INC DX
    INT 10H
    CMP DX,320
    JB L1V10
    
    MOV DX,50
    MOV CX,120
    L1V11:
    INC DX
    INT 10H
    CMP DX,80
    JB L1V11
    
    MOV DX,110
    MOV CX,120
    L1V12:
    INC DX
    INT 10H
    CMP DX,140
    JB L1V12
    
    MOV DX,140
    MOV CX,120
    L1H15:
    INC CX
    INT 10H
    CMP CX,150
    JB L1H15
    
    MOV DX,140
    MOV CX,150
    L1V13:
    INC DX
    INT 10H
    CMP DX,260
    JB L1V13
    
    MOV DX,260
    MOV CX,150
    L1H16:
    DEC CX
    INT 10H
    CMP CX,120
    JA L1H16 
    
    MOV DX,260
    MOV CX,120
    L1V14:
    INC DX
    INT 10H
    CMP DX,350
    JB L1V14
    
    MOV DX,80
    MOV CX,150
    L1V15:
    INC DX
    INT 10H
    CMP DX,110
    JB L1V15
    
    MOV DX,80
    MOV CX,150
    L1H17:
    INC CX
    INT 10H
    CMP CX,180
    JB L1H17
    
    MOV DX,80
    MOV CX,210
    L1V16:
    INC DX
    INT 10H
    CMP DX,110  
    JB L1V16
    
    MOV DX,110
    MOV CX,180
    L1V17:
    INC DX
    INT 10H
    CMP DX,170
    JB L1V17
    
    MOV DX,200
    MOV CX,150
    L1H18:
    INC CX
    INT 10H
    CMP CX,210
    JB L1H18
    
    MOV DX,140
    MOV CX,180
    L1H19:
    INC CX
    INT 10H
    CMP CX,240
    JB L1H19
    
    MOV DX,80
    MOV CX,240 
    L1H20:
    INC CX
    INT 10H 
    CMP CX,270
    JB L1H20
    
    MOV DX,80
    MOV CX,270
    L1V18:
    INC DX
    INT 10H
    CMP DX,110
    JB L1V18
    
    MOV DX,110
    MOV CX,270
    L1H21:
    DEC CX
    INT 10H
    CMP CX,240
    JA L1H21
    
    MOV DX,110
    MOV CX,240
    L1V19:
    INC DX
    INT 10H
    CMP DX,230
    JB L1V19
    
    MOV DX,170
    MOV CX,210
    L1H22:
    INC CX
    INT 10H
    CMP CX,240
    JB L1H22
    
    MOV DX,200
    MOV CX,240
    L1H23:
    INC CX
    INT 10H
    CMP CX,270
    JB L1H23
    
    MOV DX,200
    MOV CX,270
    L1V20:
    INC DX
    INT 10H
    CMP DX,320
    JB L1V20
    
    MOV DX,320
    MOV CX,270
    L1H24:
    DEC CX
    INT 10H
    CMP CX,240
    JA L1H24
    
    MOV DX,350
    MOV CX,180
    L1V21:
    DEC DX
    INT 10H
    CMP DX,320
    JA L1V21
    
    MOV DX,320
    MOV CX,180
    L1H25:
    DEC CX
    INT 10H
    CMP CX,150
    JB L1H25
    
    MOV DX,320
    MOV CX,150
    L1V22:
    DEC DX
    INT 10H
    CMP DX,290
    JA L1V22
    
    MOV DX,290
    MOV CX,150
    L1H26:
    INC CX
    INT 10H
    CMP CX,180
    JB L1H26
    
    MOV DX,290
    MOV CX,180
    L1V23:
    DEC DX
    INT 10H
    CMP DX,230
    JA L1V23
    
    MOV DX,230
    MOV CX,180
    L1H27:
    INC CX
    INT 10H
    CMP CX,210
    JB L1H27
    
    MOV DX,230
    MOV CX,210
    L1V24:
    INC DX
    INT 10H
    CMP DX,260
    JB L1V24
    
    MOV DX,260
    MOV CX,210
    L1H28:
    INC CX
    INT 10H
    CMP CX,240
    JB L1H28
    
    MOV DX,290
    MOV CX,210
    L1V25:
    INC DX
    INT 10H
    CMP DX,350
    JB L1V25
    RET
CREATE_MAZE1 ENDP

;------------------------------------------------------
   
CREATE_MAZE2 PROC
    MOV AL,0DH ;MAGENTA
    MOV AH,0CH ;WRITE PIXEL
    
    ;HORIZONTAL LINES
    MOV CX,0
    MOV DX,50
    INT 10H
    H1:
    INC CX
    INT 10H
    CMP CX,300
    JB H1
    
    MOV DX,80
    MOV CX,20
    INT 10H
    H3:
    INC CX
    INT 10H
    CMP CX,240
    JB H3
    
    MOV CX,260
    INT 10H
    H4:
    INC CX
    INT 10H
    CMP CX,300
    JB H4
    
    MOV DX,110
    MOV CX,0
    INT 10H
    H5:
    INC CX
    INT 10H
    CMP CX,160
    JB H5
    
    MOV CX,180
    INT 10H
    H6:
    INC CX
    INT 10H
    CMP CX,280
    JB H6
    
    MOV DX,140
    MOV CX,20
    INT 10H
    H7:
    INC CX
    INT 10H
    CMP CX,260
    JB H7
    
    MOV CX,280
    INT 10H
    H8:
    INC CX
    INT 10H
    CMP CX,300
    JB H8
    
    MOV DX,170
    MOV CX,0
    INT 10H
    H9:
    INC CX
    INT 10H
    CMP CX,40
    JB H9
    
    MOV CX,60
    INT 10H
    H10:
    INC CX
    INT 10H
    CMP CX,300
    JB H10
    
    MOV DX,200
    MOV CX,0
    INT 10H
    H11:
    INC CX
    INT 10H
    CMP CX,20
    JB H11
    
    MOV CX,40
    INT 10H
    H12:
    INC CX
    INT 10H
    CMP CX,260
    JB H12
    
    MOV CX,280
    INT 10H
    H13:
    INC CX
    INT 10H
    CMP CX,300
    JB H13
    
    MOV DX,230
    MOV CX,20
    INT 10H
    H14:
    INC CX
    INT 10H
    CMP CX,220
    JB H14
    
    MOV CX,240
    INT 10H
    H15:
    INC CX
    INT 10H
    CMP CX,300
    JB H15
    
    MOV DX,270
    MOV CX,0
    INT 10H
    H16:
    INC CX
    INT 10H
    CMP CX,60
    JB H16
    
    MOV CX,80
    INT 10H
    H17:
    INC CX
    INT 10H
    CMP CX,280
    JB H17
    
    MOV DX,310
    MOV CX,20
    INT 10H
    H18:
    INC CX
    INT 10H
    CMP CX,60
    JB H18
    
    MOV CX,80
    INT 10H
    H19:
    INC CX
    INT 10H
    CMP CX,300
    JB H19
    
    MOV DX,350
    MOV CX,0
    INT 10H
    H20:
    INC CX
    INT 10H
    CMP CX,260
    JB H20
    
    MOV CX,280
    INT 10H
    H21:
    INC CX
    INT 10H
    CMP CX,300
    JB H21
    
    ;VERTICAL LINES
    MOV DX,50
    MOV CX,0
    INT 10H
    V1:
    INC DX
    INT 10H
    CMP DX,350
    JB V1
    
    MOV DX,50
    MOV CX,300
    INT 10H
    V2:
    INC DX
    INT 10H
    CMP DX,350
    JB V2
    
    MOV DX,80
    MOV CX,120
    INT 10H
    V3:
    INC DX
    INT 10H
    CMP DX,110
    JB V3
    
    MOV DX,110
    MOV CX,220
    INT 10H
    V4:
    INC DX
    INT 10H
    CMP DX,140
    JB V4
    
    MOV DX,140
    MOV CX,180
    INT 10H
    V5:
    INC DX
    INT 10H
    CMP DX,170
    JB V5
    
    MOV DX,200
    MOV CX,120
    INT 10H
    V6:
    INC DX
    INT 10H
    CMP DX,230
    JB V6
    
    MOV DX,230
    MOV CX,180
    INT 10H
    V7:
    INC DX
    INT 10H
    CMP DX,270
    JB V7
    
    MOV DX,270
    MOV CX,260
    INT 10H
    V8:
    INC DX
    INT 10H
    CMP DX,310
    JB V8
    
    MOV DX,310
    MOV CX,20
    INT 10H
    V9:
    INC DX
    INT 10H
    CMP DX,350
    JB V9
    RET
CREATE_MAZE2 ENDP

;---------------------------------------------------------

CREATE_MAZE3 PROC
    MOV AL,0DH ;MAGENTA
    MOV AH,0CH ;WRITE PIXEL
    
    MOV DX,50
    MOV CX,0 
    ;INT 10H
    L2V1:
    INC DX
    INT 10H
    CMP DX,350
    JB L2V1
    
    MOV DX,50
    MOV CX,300
    L2V3:
    INC DX
    INT 10H
    CMP DX,350
    JB L2V3  
    
    MOV DX,50
    MOV CX,0
    L2H1:
    INC CX
    INT 10H
    CMP CX,300
    JB L2H1
    
    MOV DX,350
    MOV CX,0 
    L2H2:
    INC CX
    INT 10H
    CMP CX,200
    JB L2H2
    
    MOV DX,350
    MOV CX,220
    L3H2:
    INC CX
    INT 10H
    CMP CX,300
    JB L3H2
    
    MOV DX,50
    MOV CX,80
    L2V5:
    INC DX
    INT 10H
    CMP DX,90
    JB L2V5
    
    MOV DX,90
    MOV CX,80
    L2H3:
    DEC CX
    INT 10H
    CMP CX,20
    JA L2H3
    
    MOV DX,90
    MOV CX,20
    L2V6:
    DEC DX
    INT 10H 
    CMP DX,70
    JA L2V6
    
    MOV DX,70
    MOV CX,20
    L2H4:
    INC CX
    INT 10H
    CMP CX,40  
    JB L2H4 
    
    MOV DX,70
    MOV CX,60
    L2H5:
    INC CX
    INT 10H
    CMP CX,80
    JB L2H5
    
    MOV DX,50
    MOV CX,140
    L2V7:
    INC DX
    INT 10H
    CMP DX,70
    JB L2V7  
    
    MOV DX,70
    MOV CX,140
    L2H6:
    INC CX
    INT 10H
    CMP CX,160
    JB L2H6
    
    MOV DX,50
    MOV CX,240
    L2V8: 
    INC DX
    INT 10H  
    CMP DX,70
    JB L2V8
    
    MOV DX,70
    MOV CX,240
    L2H7:
    DEC CX
    INT 10H
    CMP CX,200
    JA L2H7
    
    MOV DX,70
    MOV CX,200
    L2V9:
    INC DX
    INT 10H
    CMP DX,90
    JB L2V9
    
    MOV DX,90
    MOV CX,200
    L2H8:
    INC CX
    INT 10H
    CMP CX,280
    JB L2H8
    
    MOV DX,90
    MOV CX,280
    L2V10:
    DEC DX
    INT 10H
    CMP DX,70
    JA L2V10
    
    MOV DX,70
    MOV CX,280
    L2H9:
    DEC CX
    INT 10H 
    CMP CX,260
    JA L2H9
    
    MOV DX,70
    MOV CX,100
    L2V11:
    INC DX
    INT 10H
    CMP DX,110
    JB L2V11
    
    MOV DX,110
    MOV CX,100
    L2H10:
    DEC CX
    INT 10H
    CMP CX,80
    JA L2H10
    
    MOV DX,70
    MOV CX,100
    L2H11:
    INC CX
    INT 10H
    CMP CX,120
    JB L2H11
    
    MOV DX,90
    MOV CX,100
    L2H12:
    INC CX
    INT 10H
    CMP CX,140
    JB L2H12
    
    MOV DX,90
    MOV CX,140
    L2V12:
    INC DX
    INT 10H
    CMP DX,110
    JB L2V12
    
    MOV DX,110
    MOV CX,140
    L2H13:
    DEC CX
    INT 10H
    CMP CX,120
    JA L2H13
    
    MOV DX,110
    MOV CX,120
    L2V13:
    INC DX
    INT 10H
    CMP DX,130
    JB L2V13
    
    MOV DX,90
    MOV CX,160
    L2V14:
    INC DX
    INT 10H
    CMP DX,110
    JB L2V14
    
    MOV DX,110
    MOV CX,160
    L2H14:
    INC CX
    INT 10H
    CMP CX,240
    JB L2H14
    
    MOV DX,110
    MOV CX,200
    L2V15:
    INC DX
    INT 10H 
    CMP DX,130
    JB L2V15
    
    MOV DX,130
    MOV CX,200
    L2H15:
    DEC CX
    INT 10H
    CMP CX,80
    JA L2H15
    
    MOV DX,130
    MOV CX,80
    L2V16:
    INC DX
    INT 10H
    CMP DX,230
    JB L2V16 
    
    MOV DX,210
    MOV CX,80
    L2H16:
    DEC CX
    INT 10H
    CMP CX,60
    JA L2H16
    
    MOV DX,130
    MOV CX,20
    L2V17:
    INC DX
    INT 10H
    CMP DX,210
    JB L2V17
    
    MOV DX,210
    MOV CX,20
    L2H17:
    INC CX
    INT 10H
    CMP CX,40
    JB L2H17
    
    MOV DX,210
    MOV CX,40
    L2V18:
    DEC DX
    INT 10H
    CMP DX,190
    JA L2V18
    
    MOV DX,170
    MOV CX,0
    L2H18:
    INC CX
    INT 10H
    CMP CX,20
    JB L2H18
    
    MOV DX,90
    MOV CX,60
    L2V19:
    INC DX
    INT 10H
    CMP DX,110
    JB L2V19
    
    MOV DX,110
    MOV CX,60
    L2H19:
    DEC CX
    INT 10H
    CMP CX,40
    JA L2H19
    
    MOV DX,110
    MOV CX,40
    L2V20:
    INC DX
    INT 10H
    CMP DX,170
    JB L2V20
    
    MOV DX,170
    MOV CX,40
    L2H20:
    INC CX
    INT 10H
    CMP CX,60
    JB L2H20
    
    MOV DX,130
    MOV CX,60
    L2V21:
    INC DX
    INT 10H
    CMP DX,190
    JB L2V21 
    
    MOV DX,250
    MOV CX,0
    L2H21:
    INC CX
    INT 10H
    CMP CX,20
    JB L2H21
    
    MOV DX,250
    MOV CX,20
    L2V22:
    DEC DX
    INT 10H
    CMP DX,230
    JA L2V22
    
    MOV DX,230
    MOV CX,20
    L2H22:
    INC CX
    INT 10H
    CMP CX,120
    JB L2H22
    
    MOV DX,230
    MOV CX,120
    L2V23:
    INC DX
    INT 10H
    CMP DX,250
    JB L2V23 
    
    MOV DX,230
    MOV CX,40  
    L2V24:
    INC DX
    INT 10H
    CMP DX,270
    JB L2V24
    
    MOV DX,270
    MOV CX,20
    L2V25:
    INC DX
    INT 10H
    CMP DX,290
    JB L2V25
    
    MOV DX,290
    MOV CX,20
    L2H23:
    INC CX
    INT 10H
    CMP CX,60
    JB L2H23
    
    MOV DX,290
    MOV CX,60
    L2V26:
    DEC DX
    INT 10H
    CMP DX,250
    JA L2V26
    
    MOV DX,250
    MOV CX,60
    L2H24:
    INC CX
    INT 10H
    CMP CX,100
    JB L2H24
    
    MOV DX,250
    MOV CX,100
    L2V27:
    INC DX
    INT 10H
    CMP DX,270
    JB L2V27 
    
    MOV DX,350
    MOV CX,100
    L2V28:
    DEC DX
    INT 10H
    CMP DX,330
    JA L2V28
    
    MOV DX,330
    MOV CX,100
    L2H25:
    DEC CX
    INT 10H
    CMP CX,80
    JA L2H25
    
    MOV DX,330
    MOV CX,80
    L2V29:
    DEC DX
    INT 10H
    CMP DX,310
    JA L2V29 
    
    MOV DX,270
    MOV CX,100
    L2H26:
    INC CX
    INT 10H
    CMP CX,140
    JB L2H26
    
    MOV DX,250
    MOV CX,140
    L2V30:
    INC DX
    INT 10H
    CMP DX,330
    JB L2V30
    
    MOV DX,330
    MOV CX,120
    L2H27:
    INC CX
    INT 10H
    CMP CX,160
    JB L2H27
           
    MOV DX,330
    MOV CX,160
    L2V31:
    DEC DX
    INT 10H
    CMP DX,230
    JA L2V31
    
    MOV DX,230
    MOV CX,140
    L2H28:
    INC CX
    INT 10H
    CMP CX,200
    JB L2H28
    
    MOV DX,270
    MOV CX,160
    L2H29:
    INC CX
    INT 10H
    CMP CX,200
    JB L2H29
    
    MOV DX,230
    MOV CX,140
    L2V32:
    DEC DX
    INT 10H
    CMP DX,190
    JA L2V32
    
    MOV DX,190
    MOV CX,140
    L2H30:
    INC CX
    INT 10H
    CMP CX,160
    JB L2H30
    
    MOV DX,190
    MOV CX,160
    L2V33:
    DEC DX
    INT 10H
    CMP DX,170
    JA L2V33
    
    MOV DX,170
    MOV CX,140
    L2H31:
    INC CX
    INT 10H
    CMP CX,180
    JB L2H31
    
    MOV DX,210
    MOV CX,140
    L2H32:
    DEC CX
    INT 10H
    CMP CX,100
    JA L2H32
    
    MOV DX,210
    MOV CX,100
    L2V34:
    DEC DX
    INT 10H
    CMP DX,150
    JA L2V34
    
    MOV DX,150
    MOV CX,100
    L2H33:
    INC CX
    INT 10H
    CMP CX,140
    JB L2H33
    
    MOV DX,150
    MOV CX,140
    L2V35:
    INC DX
    INT 10H
    CMP DX,130
    JB L2V35
    
    MOV DX,130
    MOV CX,140
    L2H34:
    DEC CX
    INT 10H
    CMP CX,120
    JA L2H34
    
    MOV DX,90
    MOV CX,260
    L2V36:
    INC DX
    INT 10H
    CMP DX,130
    JB L2V36
    
    MOV DX,130
    MOV CX,260
    L2H35:
    DEC CX
    INT 10H
    CMP CX,220
    JA L2H35
    
    MOV DX,130
    MOV CX,220
    L2V37:
    INC DX
    INT 10H
    CMP DX,150
    JB L2V37
    
    MOV DX,130
    MOV CX,220
    L2V38:
    INC DX
    INT 10H
    CMP DX,170
    JB L2V38
    
    MOV DX,170
    MOV CX,220
    L2H36:
    DEC CX
    INT 10H
    CMP CX,180
    JA L2H36
    
    MOV DX,330
    MOV CX,200
    L2H37:
    INC CX
    INT 10H
    CMP CX,280
    JB L2H37
    
    MOV DX,330
    MOV CX,260
    L2H38:
    INC CX
    INT 10H
    CMP CX,300
    JB L2H38
    
    MOV DX,330
    MOV CX,240
    L2V39:
    DEC DX
    INT 10H
    CMP DX,210
    JA L2V39   
    
    MOV DX,210
    MOV CX,240
    L2H39:
    INC CX
    INT 10H
    CMP CX,280
    JB L2H39 
    
    MOV DX,210
    MOV CX,280
    L2V40:
    INC DX
    INT 10H
    CMP DX,270
    JB L2V40 
    
    MOV DX,150
    MOV CX,300
    L2H40:
    DEC CX
    INT 10H
    CMP CX,260
    JA L2H40
    
    MOV DX,150 
    MOV CX,260
    L2V41:
    INC DX
    INT 10H
    CMP DX,190
    JB L2V41
    
    MOV DX,310
    MOV CX,240
    L2H41:
    DEC CX
    INT 10H
    CMP CX,200
    JA L2H41
    RET
CREATE_MAZE3 ENDP
        
ends

end start ; set entry point and stop the assembler.
