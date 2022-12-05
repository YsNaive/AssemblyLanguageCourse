INCLUDE Irvine32.inc
main	EQU start@0
BoxWidth = 5
BoxHeight = 5
 
.data
boxTop    BYTE 0DAh, (BoxWidth - 2) DUP(0C4h), 0BFh   ; ¢z ¢w ¢w ¢w ¢{
boxBody   BYTE 0B3h, (BoxWidth - 2) DUP(" ") , 0B3h   ; ¢x       ¢x
boxBottom BYTE 0C0h, (BoxWidth - 2) DUP(0C4h), 0d9h   ; ¢| ¢w ¢w ¢w ¢}
 
outputHandle DWORD 0
bytesWritten DWORD 0
count DWORD 0
xyPosition COORD <10,5>
 
cellsWritten DWORD ?
attributes0 WORD BoxWidth DUP(0Ah)         ; Green Color
attributes1 WORD (BoxWidth-1) DUP(0Ch),0Bh ; Red & Blue
attributes2 WORD BoxWidth DUP(0Eh)         ; Yellow
          
.code
main PROC
 
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE ; Get the console ouput handle
    mov outputHandle, eax                  ; save console handle
    call Clrscr

    ; ¢z¢w¢w¢w¢{ ------------------------------------------------------------------------
    INVOKE WriteConsoleOutputAttribute, ; change cell setting
       outputHandle,
       ADDR attributes0,
       BoxWidth,
       xyPosition,
       ADDR bytesWritten
 
    INVOKE WriteConsoleOutputCharacter,
       outputHandle, ; console output handle
       ADDR boxTop , ; pointer to the top box line
       BoxWidth    , ; size of box line
       xyPosition  , ; coordinates of first char
       ADDR count    ; output count
 
    ; ¢x   ¢x ------------------------------------------------------------------------
    inc xyPosition.y        ; new line
    mov ecx, (BoxHeight-2)  ; number of lines in body
L1: 
    push ecx                ; save ecx
    INVOKE WriteConsoleOutputAttribute,
       outputHandle,
       ADDR attributes1,
       BoxWidth,
       xyPosition,
       ADDR bytesWritten
   
    INVOKE WriteConsoleOutputCharacter,
       outputHandle,
       ADDR boxBody,   ; pointer to the box body
       BoxWidth    ,
       xyPosition  ,
       ADDR count 
 
    inc xyPosition.y   ; new line
    pop ecx            ; load ecx
    loop L1
 
    ; ¢|¢w¢w¢w¢} ------------------------------------------------------------------------
    INVOKE WriteConsoleOutputAttribute,
       outputHandle    ,
       ADDR attributes2,
       BoxWidth        ,
       xyPosition      ,
       ADDR bytesWritten
 
    ; draw bottom of the box
    INVOKE WriteConsoleOutputCharacter,
       outputHandle  ,
       ADDR boxBottom,   ; pointer to the bottom of the box
       BoxWidth      ,
       xyPosition    ,
       ADDR count 
 
    call WaitMsg
    call Clrscr
    exit
main ENDP
END main
