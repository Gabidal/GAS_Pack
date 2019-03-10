;GAS INTERPRETER FUNCTION'S

getWord:
  pop dx ;ignore for calling purposes
    mov si, word savePoint[0] ;load the last save
  UNTILSPACE:
    mov ax, buffer[si] ;get a bit from buffer
    cmp al, ' ' ;check lower byte
    je ENDSPACE ;if found space
    cmp ah, ' ' ;check higher byte
    je ENDSPACE ;if found space
    mov words[di], ax ;if not then move it to words
    add di, 2 ;get ready for next 2 bytes
    cmp ah, ';' ;if end of line
    je ENDSPACE ;if yeas
    cmp al, ';' ;if end of line
    je ENDSPACE ;if yeas 
    cmp si, 1000 ;if end of file
    jge endLexer ;if true
    add si, 2 ;for next 2 bytes to get from buffer
    jmp UNTILSPACE ;else 
  
  ENDSPACE:
  mov savePoint[0], si ;save where we got
  push dx ;ignore calling purposes
ret ;good old return


    
adToGic:
  pop dx
  push ax
  push bx
  push cx
  push di
  push si
  push dx
ret

geFromGic:
  pop dx
  pop si
  pop di
  pop cx
  pop bx
  pop ax
  push dx
ret

operands:
  pop dx
  mov ax, word [preWord]
  mov savePoint[6], ax
  call getWord ; a
  mov si, word [words]
  mov ax, word [variables+si]
  call getWord ; +-*/ (ignore it)
  call getWord ; b
  mov si, word [words]
  mov bx, word [variables+si]
  push dx
  ret
  

  
%macro addToGic 0
  call adToGic
%endmacro

%macro getFromGic 0
  call geFromGic
%endmacro

%macro cycle 0
  clean cx
  jmp endCycle
%endmacro

%macro func 5
  mov ax, %1
  mov cx, %2
  mov bx, %3
  mov si, %4
  mov di, %5
  addToGic
%endmacro