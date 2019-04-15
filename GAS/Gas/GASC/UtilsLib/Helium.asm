section .data
  filename db 'main.g'
  handle dw 0
  Array buffer, 1000

%macro openFile 0
 [section .txt]
  mov ax,3d02h 
  lea dx, [filename]
  int 21h 
  jc openError 
  mov [handle],ax
 [section .code]
%endmacro

%macro readFile 0
 [section .txt]
  mov ah, 3fh 
  mov bx, [handle]
  mov cx, 1000
  lea dx, [buffer]
  int 21h 
  jc readError
 [section .code]
%endmacro

%macro writeFile 1
 [section .txt]
  mov ah, 40h 
  mov bx, [handle]
  mov cx, 1000
  lea dx, [%1]
  int 21h 
  jc writeError
 [section .code]
%endmacro

%macro pointerFile 1
 [section .txt]
  mov ax,4200h 
  mov bx, [handle]
  mov cx, %1
  mov dx, %1
  int 21h 
  jc openError
 [section .code]
%endmacro

%macro closeFile 0
 [section .txt]
  mov ah,3eh 
  mov bx, [handle]
  int 21h 
  jc closeError
 [section .code]
%endmacro