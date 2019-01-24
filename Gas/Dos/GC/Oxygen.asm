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
  getBetween oxyString, '(', ')'
  
  ;IF TRUE
  ;INSIDE OF PARENTHESIS ARE IN Xw
  ;NOT INSIDE ARE IN ORIGINAL oxyString
  
  getMath Yw, Xw
  noParenthesis:
  pop si
  
  getMath Yw, oxyString

