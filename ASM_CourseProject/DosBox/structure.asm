
Vector2 STRUC
    x dw ?
    y dw ?
Vector2 ENDS 

;------------------------------------------------------

Vector3 STRUC
    x dw ?
    y dw ?
    z dw ?
Vector3 ENDS 

;------------------------------------------------------

Line STRUC
    p1 Vector2 ?
    p2 Vector2 ?
Line ENDS 

;------------------------------------------------------

Transform STRUC
    pos   Vector3 ? ; position of object
    euler Vector3 ? ; euler angle of object (rotation)
Transform ENDS 

;------------------------------------------------------

CubeData STRUC
    trans Transform ?
    extend Vector3  ?
CubeData ENDS
