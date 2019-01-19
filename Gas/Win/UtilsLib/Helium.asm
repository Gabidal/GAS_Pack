%macro openFile 1
  ;1 = file name
  mov ax,3d02h 
  lea dx, [%1]
  int 21h 
  copyString %1, errorS, opFileE
  sout Debug
  jc Error
  mov [handle],ax
%endmacro

%macro readFile 1
  ;1 = buffer
  mov ah, 3fh 
  mov bx, [handle]
  getLenght cx, %1
  lea dx, [%1]
  int 21h 
  copyString %1%1, errorS, rdFileE
  jc Error
%endmacro

%macro writeFile 1
  mov ah, 40h 
  mov bx, [handle]
  getLenght cx, %1
  lea dx, [%1]
  int 21h 
  copyString %1, errorS, wrFileE
  jc Error
%endmacro

%macro pointerFile 1
  mov ax,4200h 
  mov bx, [handle]
  mov cx, %1
  mov dx, %1
  copyString %1, errorS, poFileE
  int 21h 
  jc Error
%endmacro

%macro closeFile 1
  mov ah,3eh 
  mov bx, [handle]
  int 21h 
  copyString close%1close, errorS, clFileE
  jc Error
%endmacro