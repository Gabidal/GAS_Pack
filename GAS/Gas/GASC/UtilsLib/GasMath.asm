
%macro Mmul 2
  saveLocal
  clearLocal
  mov eax, %1
  mov ebx, %2
  mul ebx
  push eax
  loadLocal
  pop %1
%endmacro

%macro Mdiv 2
  saveLocal
  clearLocal
  mov eax, %1
  mov ebx, %2
  cwd
  div ebx
  push eax
  loadLocal
  pop %1
%endmacro

%macro Xdiv 2
  saveLocal
  clearLocal
  mov ax, %1
  mov bx, %2
  cwd
  div bx
  push ax
  loadLocal
  pop %1
%endmacro

%macro Xmul 2
  saveLocal
  clean dx
  mov ax, %1
  mov bx, %2
  mul bx
  push ax
  loadLocal
  pop %1
%endmacro
 
%macro negate 1
  saveLocal
  mov ebx, 0
  sub ebx, %1
  push ebx
  loadLocal
  pop %1
%endmacro

%macro rand 1
  saveLocal
  mov ah, 00h    ;timer in CX:DX 
  int 1AH
  mov bx, dx
  mov ax, 25173  ; LCG Multiplier
  mul bx
  add ax, 13849
  push ax
  loadLocal
  pop %1
%endmacro

%macro vec 4
  [section .data]
  %1X: dw %2
  %1Y: dw %3
  %1Z: dw %4
  [section .code]
%endmacro

%macro vec 1
  vec %1, 0, 0, 0
%endmacro

%macro addVec 3
  saveLocal
  vec %1
  mov ax, word [%2X]
  mov bx, word [%2Y]
  mov cx, word [%2Z]
  ;ADDING REGISTERS WITH B
  add ax, word [%3X]
  add bx, word [%3Y]
  add cx, word [%3Z]
  ;MOV REGISTERS TO C
  mov [%1X], ax
  mov [%1Y], bx
  mov [%1Z], cx
  loadLocal
%endmacro