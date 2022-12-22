main EQU start@0

T EQU 1
F EQU 0

; last 3 digit is float
;==============================================================
PI equ 3141       ; pi = 3.1415
N_PI equ -3141
CONST_E equ 02710        ;  e = 2.71
Rad2Deg equ 57295 ; 1 radians = 57.2957795 degrees
Deg2Rag equ 00017 ; 1 degrees =  0.0174532 radians
;==============================================================

; Console and layout
;=============================================================================
consoleHandle DWORD ?
cursorPos COORD < 0,0 >
screenSize COORD < 160,100 >			; 160*100 pixel
windowRect SMALL_RECT < 0,0,159,99 >	; display start from 0
layoutAttributes WORD 32000 DUP(010h)	; things to layout, used by repaint proc (100*160*2(byte))

; System Object
;=============================================================================
camera Transform << 0,0,-25000 >,< 0,0,0 >> ; facing (0,0,1.000)
cameraFacing Vector <>
cameraRotMat Matrix3 <>
neg_cameraRotMat Matrix3 <>
cameraRotMatX Matrix3 <>
cameraRotMatY Matrix3 <>
cameraRotMatZ Matrix3 <>
cameraDepth DWORD 240
moveSpeed DWORD 500
keyDownCode WORD 0 ; change when key press

; flag and temp variable
;=============================================================================
BF BYTE 0 ; bool flag
i DWORD ?
j DWORD ?
n DWORD ?
m DWORD ?