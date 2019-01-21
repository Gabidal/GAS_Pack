;THE GAS COMPILER READER TO TAKE AND MAKE THE TOKENS!

;make buffer content(words)
;into 2 byte command for
;the Gic

%macro addVar 3
  mov cx, %3
  push cx
  mov di, word oxSave[2]
  lea di, [variables+di]
  lea si, [%1]
  repz movsb
  pop cx
  mov si, word oxSave[2]
  add si, cx
  inc si
  mov al, ' '
  mov [variables+si], al
  mov bx, %2
  push bx
  inc si
  mov [variable+si], sp
  mov bp, sp
%endmacro

%macro getVar 2
  %%gtvr:
    getByte Yw, variables+si, ' '
    strcmp Yw, %2
    je %%foundIt
    pop si
    pop di
    lea di, [endVariables]
    cmp si, [endVariables]
  jne %%gtvr
  %%foundIt:
    pop si
    pop di
    clean di
    getWord Zw, variables, ' '
    mov ax, word [Zw]
    dec ax
    mov sp, ax
    mov bp, sp
  pop ax
  mov %1, ax
%endmacro


Lexer:
  mov si, word oxSave[0]
  getByte oxyString, buffer+si, ';'
  pop si
  pop di
  mov oxSave[0], si
  clean di

OY:
  find Yw, oxyString, '('
  je parenthesis
  jne noParenthesis

  parenthesis:
    pop si
    inc si
    getByte Xw, oxyString, ')'
    pop si
    pop di
    clean di
    clean si
    jmp OY

  noParenthesis:
    
    
    


    OX:
      
      
      
      nextInstruction:
%include 'OxyPump.asm'