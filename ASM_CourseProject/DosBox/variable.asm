TRUE  equ "T"
FALSE equ "F"

BF dw 0 ; Bool Flag
GR_START_ADDR dw 0a000h ; Start Address of VGA Video memory

color db 0

ttst dd 0

i dw 0
j dw 0
k dw 0
word1 dw 0
word2 dw 0
word3 dw 0
word4 dw 0
tt transform <,,>
point1 Vector2 <,>
point2 Vector2 <,>
point3 Vector2 <,>
point4 Vector2 <,>

line1 Line <,>
line2 Line <,>

camera Transform <,>