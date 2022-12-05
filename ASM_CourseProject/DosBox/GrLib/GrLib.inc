;===================================================================================================
; Assembly Graphics Library
;
; Written By: Oded Cnaan (oded.8bit@gmail.com)
; Site: http://odedc.net 
; Licence: GPLv3 (see LICENSE file)
; Package: GrLib
;
; Description: 
; Include this file to get access to the graphics library
;===================================================================================================

; Common definitions
BMP_STRUCT_SIZE         equ         444h

; Includes
include GrLib\GrLib\dblbuf.asm
include GrLib\GrLib\colors.asm
include GrLib\GrLib\graphx.asm
include GrLib\GrLib\line.asm
include GrLib\GrLib\rect.asm
include GrLib\GrLib\poly.asm
include GrLib\GrLib\circle.asm
include GrLib\GrLib\bmp.asm
include GrLib\GrLib\image.asm
include GrLib\GrLib\anim.asm
