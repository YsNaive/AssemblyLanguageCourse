Vector Struct
	x DWORD ?
	y DWORD ?
	z DWORD ?
Vector EndS

Line Struct
    b Vector < > ; begin point
    e Vector < > ; end point
Line EndS 

Transform Struct
    pos   Vector < > ; position of object
    euler Vector < > ; euler angle of object (rotation)
Transform EndS

SphereData Struct
    pos Vector < >
    r DWORD ?
SphereData EndS

Matrix3 Struct
    n00 DWORD ?      ; n00, n01, n02
    n01 DWORD ?      ; n10, n11, n12
    n02 DWORD ?      ; n20, n21 ,n22
    n10 DWORD ?
    n11 DWORD ?
    n12 DWORD ?
    n20 DWORD ?
    n21 DWORD ?
    n22 DWORD ?
Matrix3 EndS