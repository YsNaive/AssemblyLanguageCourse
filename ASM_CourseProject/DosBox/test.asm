.486
IDEAL
MODEL small
STACK 256d
DATASEG	

CODESEG
    include "UtilLib.inc"
    include "GrLib.inc"   
start:
    mov ax, @data
    mov ds,ax

    ; Init library with double buffering flag on
    mov ax, TRUE
    ut_init_lib ax
  
    ; Allocate double buffering memory space
    call AllocateDblBuffer

    ; set display to VGA mode
    gr_set_video_mode_vga

    ; Set initial pen color
    gr_set_color GR_COLOR_GREEN

    ; your code here - we will draw a line...
    grm_DrawLine  10, 10, 200, 200

exit:
    call WaitForKeypress    
    call ReleaseDblBuffer
    gr_set_video_mode_txt
    return 0
END start    