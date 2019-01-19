;THE GAS COMPILER READER TO TAKE AND MAKE THE TOKENS!

;make buffer content(words)
;into 2 byte command for
;the Gic

%macro writeAsmOp 1
  saveLocal
  mov si, word oxSave[4]
  %%weam:
    getWord outBuffer+si, %1+si
    pop si
    pop di
    mov ax, '\n'
    cmp [%1+si], ax
    jne %%weam
    mov oxSave[4], si
  loadLocal
%endmacro


Lexer:
  saveLocal
  
  OY:
    ;Load next Line
    mov si, word oxSave[0]
    getWord oxyReturner, buffer+si
    pop si
    pop di
    clean di
    getWord oxyOperand, buffer+si
    pop si
    pop di
    clean di
    getWord oxyValue, buffer+si
    pop si
    pop di
    clean di
    getWord oxyNext, buffer+si
    pop si
    pop di
    mov oxSave[0], si
    clean di
    ;CHECK FOR INSTRUCTIOS
    getWord Yw, oxyReturner
    pop si
    pop di
    clean si
    clean di
    clean ax
    call OX
    getWord Yw, oxyOperand
    pop si
    pop di
    clean si
    clean di
    mov ax, 1
    call OX
    getWord Yw, oxyValue
    pop si
    pop di
    clean si
    clean di
    mov ax, 2
    call OX
    getWord Yw, oxyNext
    pop si
    pop di
    clean si
    clean di
    mov ax, 3
    call OX
    ret
    
    OX:
      ;Compare the two words
      strcmp Yw, setTo
      je ifSetTo
      strcmp Yw, Char
      je ifChar
      strcmp Yw, Integer
      je ifInt
      
      
      
      nextInstruction:
      ret
%include 'OxyPump.asm'