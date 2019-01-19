
%macro String 2
  %1 db %2, '$'
  %1len dw $-%1
%endmacro


%macro getWord 3
;fill's the array
;until reaches ' '(aka space)
  mov si, word [savp]
  %1fillLoop:
    mov bh, byte [%3+si]
    mov [%2+si], byte bh
    mov ah, byte %2[si]
    cmp ah, ' '
    inc si
    jne %1fillLoop
  mov [savp], word si
%endmacro

%Macro CompareString 3
  clearLocal
jmp %1cost
  %1isTrue:
    mov cx, 1
    jmp %1continue
  %1isFalse:
    mov cx, 0
    jmp %1continue
  %1cost:
    mov ah, byte [%2+si]
    mov bh, byte [%3+si]
    inc si
    cmp ah, bh
    je %1isTrue
    jne %1isFalse
    %1continue:
  cmp bh, '$'
  jne %1cost
  cmp cx, 1
%endMacro

%macro copyString 3
  ;1 = label
  ;2 = destination
  ;3 = source
  clean si
  %1cst:
    mov ch, byte [%3+si]
    mov [%2+si], byte ch
    inc si
    cmp ch, '$'
    jne %1cst
%endmacro

%macro getLenght 2
  mov %1, word [%2len]
%endmacro

%macro toChar 2
  saveLocal
  mov ax, %2
  split ax, ch, dh
  mov bh, 48
  add ch, bh
  add dh, bh
  mov [hydSave], ch
  mov [hydSave+2], dh
  clearLocal
  mov %1, word [hydSave]
%endmacro