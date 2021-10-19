; multi-segment executable file template.

data segment
    ; add your data here!
    CHAR_X DW 14
    CHAR_Y DW 59
    CHAR_SIZE DW 10
    MOVES DW 0
    STRING DB "STEP: ","$"
    SCORE_0 DB '0'
    SCORE_1 DB '0'
    SCORE_2 DB '0'
    MIN_SCORE DB "MIN STEP:","$"
    MIN_SCORE_NUM DB "110","$"
    bool db 0
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
CALL SHOW_SCORE
CALL SHOW_MINSCORE
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
CALL DRAW_CHAR


CALL INPUT

ret
      
MAIN ENDP
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
        SUB DX,9
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
        ADD DX,11
        call check 
        cmp bool,1  
        je exit
        CALL CALC_SCORE
        CALL DELETE_CHAR
        ADD CHAR_Y,10
        CALL DRAW_CHAR
        JMP INP
    ESCAPE:
        RET
    exit: 
        mov bool,0 
        jmp inp
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
    MOV AL,'1'
    INT 10H
    MOV AL,'0'
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
    cmp al,0DH             ;reads the pixel colour to b used for boundry check 
    jne ex 
    mov bool,1 
    ex: 
    pop bx 
    ret 
check endp
        
ends

end start ; set entry point and stop the assembler.
