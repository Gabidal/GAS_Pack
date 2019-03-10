;the G lib commands

[section .data]
savePoint times 25 dw 0
[section .code]

%macro tryCatch 2
  %2 end%1
%endmacro

%macro main 1
org 100h
section .%1
start:
%endmacro

%macro system 1
  int %1
%endmacro

%macro sout 1
  saveLocal
  mov dx, %1
  mov ah,9
  int 21h
  loadLocal
%endmacro

%macro clean 1
  xor %1, %1
%endmacro

tryCatch SkipSaveA, jmp
  sveAlu:
  mov savePoint[0], word ax
  mov savePoint[1], word bx
  mov savePoint[2], word cx
  mov savePoint[3], word dx
  mov savePoint[4], word si
  mov savePoint[5], word di
  ret
  ladAlu:
  mov ax, word savePoint[0]
  mov bx, word savePoint[1]
  mov cx, word savePoint[2]
  mov dx, word savePoint[3]
  mov si, word savePoint[4]
  mov di, word savePoint[5]
  ret
  cearAlu:
  clean ax
  clean dx
  clean bx
  clean cx
  clean si
  clean di
  ret
endSkipSaveA:

%macro saveLocal 0
  call sveAlu
%endmacro

%macro loadLocal 0
  call ladAlu
%endmacro

%macro clearLocal 0
  call cearAlu
%endmacro