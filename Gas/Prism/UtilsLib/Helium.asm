section .data
  filename db 'main.g'
  handle dw 0
  Array buffer, 1000

%macro openFile 0
  mov ax,3d02h 
  lea dx, [filename]
  int 21h 
  jc Error 
  mov [handle],ax
%endmacro

%macro readFile 0
  mov ah, 3fh 
  mov bx, [handle]
  mov cx, 1000
  lea dx, [buffer]
  int 21h 
  jc Error
%endmacro

%macro writeFile 1
  mov ah, 40h 
  mov bx, [handle]
  mov cx, 1000
  lea dx, [%1]
  int 21h 
  jc Error
%endmacro

%macro pointerFile 1
  mov ax,4200h 
  mov bx, [handle]
  mov cx, %1
  mov dx, %1
  int 21h 
  jc Error
%endmacro

%macro closeFile 0
  mov ah,3eh 
  mov bx, [handle]
  int 21h 
  jc Error
%endmacro