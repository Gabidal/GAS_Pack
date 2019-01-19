%macro String 2
  %1 db %2, ' $'
%endmacro

%macro getWord 2
 saveLocal
  lea si, [%2]
  lea di, [%1]
  %%gtwdLoop:
    mov al, byte [si]
    mov [di], al
    inc si
    inc di
    cmp al, ' '
    jne %%gtwdLoop
    push di
    push si
 loadLocal
 ;pop si and di
 ;for continue to
 ;next word in list
%endmacro

%macro getPreviusWord 2
 saveLocal
  lea si, [%2]
  lea di, [%1]
  %%gtwdLoop:
    mov al, byte [si]
    mov [di], al
    dec si
    dec di
    cmp al, ' '
    jne %%gtwdLoop
    push di
    push si
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
  lea si, %2[0]
  lea di, %1[0]
  %%costr:
    mov al, byte %2[si]
    inc si
  cmp al, 0
    je %%endcostr
    mov %1[di], al
    inc di
    mov bl, byte %1[di]
  cmp bl, 0
    je %%endcostr
    jmp %%costr
  %%endcostr:
%endmacro

%macro getLenght 2
  saveLocal
  lea si, [%2]
  %%glgcloop:
  mov al, byte [si]
  inc si
  cmp al , ' '
  jne %%glgcloop
  mov cx, si
  dec cx
  push cx
  loadLocal
  pop %1
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
  mov ax, word [hydSave]
  mov %1, ax
%endmacro

%macro toInt 2
  saveLocal
  mov ax, %2
  split ax, ch, dh
  mov bh, 48
  sub ch, bh
  sub dh, bh
  mov [hydSave], ch
  mov [hydSave+2], dh
  clearLocal
  mov ax, word [hydSave]
  mov %1, ax
%endmacro

%macro XtoInt 2
  saveLocal
  mov al, %2
  mov bl, 48
  sub al, bl
  mov [hydSave], al
  loadLocal
  mov ah, byte [hydSave]
  mov %1, ah
%endmacro


%macro lexString 1
  lea si, %1[0]
  mov hydSave[0], si
  lea di, lexVar[0]
  lea si, lexOp[0]
  mov hydSave[1], si
  ;CHECK FOR NUMBER 
  ;OR FOR STRING
 %%lexLoop:
  mov si, word hydSave[0]
  mov al, byte [si]
  cmp al, '$'
  jne %%lexCon
  jmp %%endLexing
  %%lexCon:
  inc si
  mov hydSave[0], si
  cmp al, '/' ; '/' == '-1'
  jg %%secondCheck
  jb %%itIsString
  jmp %%lexLoop
  
  %%secondCheck:
    cmp al, ':' ; ":"=="10"
    jb %%itIsNumber
    jmp %%itIsString
    
  %%itIsNumber:
    XtoInt al, al
    %%numSpace:
    mov [di], al
    inc di
    jmp %%lexLoop
  
  %%itIsString:
    cmp al, ' '
    je %%numSpace
    mov si, word hydSave[1]
    mov [si], al
    inc si
    mov hydSave[1], si
    jmp %%lexLoop

  %%endLexing:
%endmacro
    
%macro processString 2
  ;(2 + 3 - 66)
  lexString %2
  lea si, lexVar[0]
  lea di, lexOp[0] 
  mov al, byte [si] ;num
  inc si ;next byte
  ;CHECK IF NUMBER IS MORE
  ;THAN 9

  %%processLoop:
  saveLocal
  mov bl, byte [si] ;variables
  cmp bl, '$'
  je %%endProcess
  inc si
  cmp bl, ' '
  jne %%checkIfNum
  %%itIsOp:
    mov bl, byte [di] ;opecodes
    inc di
    cmp bl, '+'
    je %%isSum
    cmp bl, '-'
    je %%isSub
    cmp bl, '*'
    je %%isMul
    cmp bl, '/'
    je %%isDiv
    
  %%isSum:
    add al, bl
    jmp %%processLoop
  %%isSub:
    sub al, bl
    jmp %%processLoop
  %%isMul:
    mul bl
    jmp %%processLoop
  %%isDiv:
    div bl
    jmp %%processLoop


  %%checkIfNum:
    cmp bl, 0
    jge %%secondNumCheck
    jne %%itIsOp

  %%secondNumCheck:
    cmp bl, 9
    jbe %%itIs2Number
    jne %%itIsOp

  %%itIs2Number:
    mov cl, 10
    mul cl
    add al, bl
    jmp %%processLoop
  
  %%endProcess:
  mov matSave[0], al
  loadLocal
  mov %1, word matSave[0]
%endmacro