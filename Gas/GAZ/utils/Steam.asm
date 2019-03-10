%macro startCanvas 0
  mov ah, 0x00
  mov al, 0x13
  updateCanvas
%endmacro

%macro updateCanvas 0
  int 0x10
%endmacro

%macro drawPixel 3
  mov ah, 0ch
  mov bh, 0
  mov dx, %2
  mov cx, %1
  mov al, %3
  updateCanvas
%endmacro


%macro line 8
  saveLocal
  mov cx, %1 ;SX
  mov dx, %2 ;SY
  mov bp, %3 ;EX
  mov bx, %4 ;EY
  %%X:
    cmp cx, bp
    jb %%XtoG
    jg %%XtoB
    %%Y:
      cmp dx, bx
      jb %%YtoG
      jg %%YtoB
      %%C:
        cmp cx, bp
        jne %%X
        cmp dx, bx
        jne %%Y
      jmp %%endXY
      
  %%XtoG:
    inc cx
  drawPixel cx, dx, %5
    jmp %%Y
  %%XtoB:
    dec cx
  drawPixel cx, dx, %6
    jmp %%Y
  %%YtoG:
    inc dx
  drawPixel cx, dx, %7
    jmp %%C
  %%YtoB:
    dec dx
  drawPixel cx, dx, %8
    jmp %%C
  %%endXY:
  loadLocal
%endmacro

%macro   syncStart 0
 ; wait for vertical sync. start
  push  ax
  push  dx
  mov   dx, 03dah
%%avv:
   in    al,dx
   test  al,08h
   jnz   %%avv
%%abv:
   in   al,dx
   test  al,08h
   jz    %%abv
   pop   dx
   pop   ax
%endmacro

%macro    syncEnd 0
   mov     dx,03dah
%%acv:
   in    al,dx
   test  al,08h
   jz   %%acv
%%adv:
   in    al,dx
   test  al,08h
   jnz    %%adv
%endmacro

%macro Zbuffer 4
  ;X, Y, Z, Color
  drawPixel %1 + %3, %2 - %3, %4
%endmacro