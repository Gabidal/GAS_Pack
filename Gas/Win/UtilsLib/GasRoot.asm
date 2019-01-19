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
  clean dx
  clean ah
%endmacro

%macro clean 1
  mov %1, 0
%endmacro

%macro split 3
  clean cx
  lea si, splitbuffer[0]
  mov [si], word %1
  lea si, splitbuffer[0]
  mov %2, byte [si+0] ;hi-
  mov %3, byte [si+1] ;lo-
%endmacro

%macro storeMap 1
  mov [100*%1], ax
  mov [132*%1], bx
  mov [164*%1], cx
  mov [196*%1], dx
%endmacro

%macro loadMap 1
  mov ax, [100*%1]
  mov bx, [132*%1]
  mov cx, [164*%1]
  mov dx, [196*%1]
%endmacro

%macro ByteMem 2
  ;these are in bytes
  %1reservedB times %2 db '0'
%endmacro

%macro KiloMem 2
  ;these are kilo bytes
  %1reservedKB times %2*1000 db '0'
%endmacro


%macro shiftLeft 0
  mov [40h], eax
  mov eax, [edx]
  mov edx, ebx
  mov ebx, ecx
  mov ecx, [40h]
%endmacro

%macro shiftRight 0
  mov [70h], ecx
  mov ecx, ebx
  mov ebx, edx
  mov edx, eax
  mov eax, [70h]
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