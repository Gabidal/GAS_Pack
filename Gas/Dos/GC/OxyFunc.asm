
%macro getBetween 3
  find Yw, %1, %2
  je %%parenthesi
  jne %%nonoParentheis

  %%parenthesi:
    pop si
    inc si
    getByte Xw, %1+si, %3
    pop si
    pop di
    clean di
    clean si
    %%fbgLop:
    find Yw, Xw, %2
    jne %%nonoParentheis
    pop si
    inc si
    getByte Xw, Xw+si, %3
    pop si
    pop di
    clean di 
    jmp %%fbgLop
  %%nonoParentheis:
%endmacro

%macro getMath 2
  ;GET MUL
  find %1, %2, '*'
  jne %%nextDiv
  pop si
  
  ;GET DIV
  %%nextDiv:
  find %1, %2, '/'
  jne %%nextSum
  pop si
  
  ;GET SUM
  %%nextSum:
  find %1, %2, '+'
  jne %%nextSub
  pop si
  
  ;GET SUB
  %%nextSub:
  find %1, %2, '-'
  jne %%nextSet
  pop si
  
  ;SET TO
  %%nextSet:
  find %1, %2, '='
  pop si
%endmacro


%macro addVar 1
  saveLocal
  clearLocal
  ;ax = xy
  ;dx:cx = value
  
  mov cx, word radSave[16]
  inc cx
  inc cx
  mov radSave[16], word cx
  push cx ;value
  mov ax, ' '
  push ax
  
  ;Change String name to X,Y cords
  %%adloop:
  mov al, byte [%1+si]
  cmp al, '$'
  je %%adend
  cmp al, ' '
  je %%adend
  inc si
  mov ah, byte [%1+si]
  cmp ah, '$'
  je %%adend
  cmp ah, ' '
  je %%adend
  push ax
  inc si
  cmp si, 30
  jb %%adloop
  %%adend:
  
  loadLocal
%endmacro

%macro getVar 2
  saveLocal
  clearLocal
  mov bp, sp
  clean si
  clean cx
  
  %%adst:
  mov ax, [bp]
  cmp ah, ' '
  je %%fista
  cmp al, ' '
  je %%fista
  mov variables[si], word ax
  inc si
  inc bp
  inc cx
  jmp %%adst

  %%fista:
  lea si, variables[0]
  lea di, [%2]
  
  repz cmpsw
  
  jne %%fista
  inc bp ;to get the value
  
  loadLocal
  mov %1, bp
%endmacro

%macro getPrevious 1
  saveLocal
  getReverse Yw, %1, ' ', jne
  pop si
  add si, di
  getReverse Yw, si, ' ', je
  pop di
  ;pop index to get
  ;position of
  ;previous statement
  loadLocal
%endmacro

%macro getNext 1
  saveLocal
  getByte Yw, %1, ' '
  pop si
  add si, di
  getByte Yw, si, ' '
  pop di
  pop di
  ;pop index to get
  ;position of
  ;next statement
  loadLocal
%endmacro

%macro getBoth 4
  ;1 = array
  ;2 = start index
  ;3 = out1
  ;4 = out2
  saveLocal
  mov si, %2
  mov ax, si
  lea di, [%1+si]
  getPrevious di
  pop bx
  ;BX = X <- *
  mov si, ax
  lea di, [%1+si]
  getNext di
  pop si
  ;SI = * -> X
  push si
  push bx
  loadLocal
  pop %3
  pop %4
%endmacro