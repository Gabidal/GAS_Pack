

%macro append 2
  saveLocal
  lea si, [%1]
  inc si
  mov al, %2
  mov [si], al
  loadLocal
%endmacro

%macro find 3
  saveLocal
  getByte %1, %2, %3
  pop si
  push si
  mov al, byte [si]
  cmp al, %3
  loadLocal
%endmacro

%macro getByte 3
 saveLocal
  lea si, [%2]
  lea di, [%1]
  %%gtwdLoop:
    mov al, byte [si]
    mov [di], al
    inc si
    inc di
    cmp al, %3
    jne %%gtwdLoop
    push si
 loadLocal
 ;pop si and di
 ;for continue to
 ;next word in list
%endmacro

%macro getReverse 4
 saveLocal
  lea si, [%2]
  lea di, [%1]
  %%gtwdLoop:
    mov al, byte [si]
    mov [di], al
    dec si
    dec di
    cmp al, %3
    %4 %%gtwdLoop
    push di
 loadLocal
 ;pop si and di
 ;for continue to
 ;previus word in list
%endmacro

%Macro strcmp 2
  saveLocal
  clean si
jmp %%cost
  %%isTrue:
    mov cx, 1
    jmp %%continue
  %%isFalse:
    mov cx, 0
    jmp %%endFalse
  %%cost:
    mov ah, byte [%1+si]
    mov bh, byte [%2+si]
    inc si
    cmp ah, bh
    je %%isTrue
    jne %%isFalse
    %%continue:
  cmp ah, 0
  jne %%cost
  %%endFalse:
  push cx
  loadLocal
  pop cx
  cmp cx, 1
%endMacro

%macro copyString 2
  saveLocal
  lea si, %2[0]
  lea di, %1[0]
  %%costr:
    mov al, byte [si]
    inc si
  cmp al, 0
    je %%endcostr
    mov [di], al
    inc di
    mov bl, byte [di]
  cmp bl, 0
    je %%endcostr
    jmp %%costr
  %%endcostr:
  loadLocal
%endmacro

%macro getLenght 2
  saveLocal
  lea si, [%2]
  clean cx
  %%glgcloop:
  mov al, byte [si]
  inc cx
  inc si
  cmp al , ' '
  jne %%glgcloop
  dec cx
  push cx
  loadLocal
  pop %1
%endmacro

%macro toChar 2
  saveLocal
  mov ax, %2
  mov bl, 48
  add ah, bl
  add al, bl
  push ax
  loadLocal
  pop %1
%endmacro

%macro toInt 2
  saveLocal
  mov ax, %2
  mov bl, 48
  sub ah, bl
  sub al, bl
  push ax
  loadLocal
  pop %1
%endmacro

%macro XtoInt 2
  saveLocal
  mov al, %2
  mov bl, 48
  sub al, bl
  push ax
  loadLocal
  pop ax
  mov %1, al
%endmacro

%macro realInt 2
  saveLocal
  mov al, %2
  cmp al, '0'
  jne %%nextOne
  xor al, al
  jmp %%endReal
  %%nextOne:
    cmp al, '1'
    jne %%nextTwo
    mov al, 1
    jmp %%endReal
  %%nextTwo:
    cmp al, '2'
    jne %%nextTree
    mov al, 2
    jmp %%endReal
  %%nextTree:
    cmp al, '3'
    jne %%nextFour
    mov al, 3
    jmp %%endReal
  %%nextFour:
    cmp al, '4'
    jne %%nextFive
    mov al, 4
    jmp %%endReal
  %%nextFive:
    cmp al, '5'
    jne %%nextSix
    mov al, 5
    jmp %%endReal
  %%nextSix:
    cmp al, '6'
    jne %%nextSev
    mov al, 6
    jmp %%endReal
  %%nextSev:
    cmp al, '7'
    jne %%nextEgt
    mov al, 7
    jmp %%endReal
  %%nextEgt:
    cmp al, '8'
    jne %%nextNine
    mov al, 8
    jmp %%endReal
  %%nextNine:
    cmp al, '9'
    jne %%endReal
    mov al, 9
  %%endReal:
  clean ah
  push ax
  loadLocal
  pop ax
  mov %1, al
%endmacro