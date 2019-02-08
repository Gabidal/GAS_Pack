;THE GAS COMPILER READER TO TAKE AND MAKE THE TOKENS!


Lexer:
  mov si, word oxSave[0]
  getByte oxyString, buffer+si, ';'
  pop si
  pop di
  mov oxSave[0], si
  clean di
  find Yw, oxyString, '('
  jne noParenthesis
  ;GET PARENTHESIS

  find Yw, oxyString, '('
  je parenthesi
  jne nonoParentheis

  parenthesi:
    pop si
    inc si
    getByte Xw, oxyString+si, ')'
    pop si
    pop di
    clean di
    clean si
    fbgLop:
    find Yw, Xw, '('
    jne nonoParentheis
    pop si
    inc si
    getByte Xw, Xw+si, ')'
    pop si
    pop di
    clean di 
    jmp fbgLop
  nonoParentheis:
  
  ;IF TRUE
  ;INSIDE OF PARENTHESIS ARE IN Xw
  ;NOT INSIDE ARE IN ORIGINAL oxyString
  
  ;GET MUL
  find Yw, Xw, '*'
  jne nextDiv
  pop si
  getBoth Xw, si, si, di
  
  ;GET DIV
  nextDiv:
  find Yw, Xw, '/'
  jne nextSum
  pop si
  getBoth Xw, si, si, di
  
  
  ;GET SUM
  nextSum:
  find Yw, Xw, '+'
  jne nextSub
  pop si
  getBoth Xw, si, si, di
  
  ;GET SUB
  nextSub:
  find Yw, Xw, '-'
  jne nextSet
  pop si
  getBoth Xw, si, si, di
  
  ;SET TO
  nextSet:
  find Yw, Xw, '='
  pop si
  getBoth Xw, si, si, di
  
  ;IF NO PARENTHESIS
  noParenthesis:
  pop si
  
  ;GET MUL
  find Yw, oxyString, '*'
  jne nextDiv2
  pop si
  getBoth oxyString, si, si, di
  
  ;GET DIV
  nextDiv2:
  find Yw, oxyString, '/'
  jne nextSum2
  pop si
  getBoth oxyString, si, si, di
  
  ;GET SUM
  nextSum2:
  find Yw, oxyString, '+'
  jne nextSub2
  pop si
  getBoth oxyString, si, si, di
  
  ;GET SUB
  nextSub2:
  find Yw, oxyString, '-'
  jne nextSet2
  pop si
  getBoth oxyString, si, si, di
  
  ;SET TO
  nextSet2:
  find Yw, oxyString, '='
  pop si
  getBoth oxyString, si, si, di
  