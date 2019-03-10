%macro startCanvas 0
  mov ah, 0x00
  mov al, 0x13
  updateCanvas
%endmacro

%macro updateCanvas 0
  system 0x10
%endmacro

%macro drawPixel 3
  mov ah, 0ch
  mov bh, 0
  mov dx, %2
  mov cx, %1
  mov al, %3b
  updateCanvas
%endmacro

%macro rect 6
  mov cx, %2
  %1:
    mov bx, %3
    %1y:
      %1x:
        drawPixel cx, bx, %6
        inc cx
        cmp cx, %4
        jb %1x
      mov cx, %2
      inc bx
      cmp bx, %5
      jb %1y
%endmacro

%macro   VsyncStart 1
 ; wait for vertical sync. start
  push  ax
  push  dx
  mov   dx, 03dah
%1@@11:
   in    al,dx
   test  al,08h
   jnz   %1@@11
%1@@22:
   in   al,dx
   test  al,08h
   jz    %1@@22
   pop   dx
   pop   ax
%endmacro

%macro    VsyncEnd 1   
 ; wait for vert. sync end
   mov     dx,03dah
%1@@33:
   in    al,dx
   test  al,08h
   jz   %1@@33
%1@@44:
   in    al,dx
   test  al,08h
   jnz    %1@@44
%endmacro

%macro Zbuffer 4
  ;X, Y, Z, Color
  drawPixel %1 + %3, %2 - %3, %4
%endmacro
