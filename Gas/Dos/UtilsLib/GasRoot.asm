;the G lib commands

%macro main 1
org 100h
section .%1
start:
%endmacro

%macro system 1
  int %1
%endmacro

%macro sout 1
  mov dx, %1
  mov ah,9
  int 21h
%endmacro

%macro nout 1
  toChar %1, %1
  mov [numOut], %1
  sout numOut
%endmacro

%macro clean 1
  xor %1, %1
%endmacro

%macro split 3
  lea si, splitbuffer[0]
  mov [si], word %1
  lea si, splitbuffer[0]
  mov %2, byte [si+0] ;hi-
  mov %3, byte [si+1] ;lo-
%endmacro

%macro shiftLeft 0
  mov [savp], eax
  mov eax, [edx]
  mov edx, ebx
  mov ebx, ecx
  mov ecx, dword [savp]
%endmacro

%macro shiftRight 0
  mov [savp], ecx
  mov ecx, ebx
  mov ebx, edx
  mov edx, eax
  mov eax, dword [savp]
%endmacro

%macro saveLocal 0
  mov savePoint[0], word ax
  mov savePoint[1], word bx
  mov savePoint[2], word cx
  mov savePoint[3], word dx
  mov savePoint[4], word si
  mov savePoint[5], word di
%endmacro

%macro loadLocal 0
  mov ax, word savePoint[0]
  mov bx, word savePoint[1]
  mov cx, word savePoint[2]
  mov dx, word savePoint[3]
  mov si, word savePoint[4]
  mov di, word savePoint[5]
%endmacro

%macro clearLocal 0
  clean ax
  clean dx
  clean bx
  clean cx
  clean si
  clean di
%endmacro

%macro tryCatch 2
  %2 end%1
%endmacro