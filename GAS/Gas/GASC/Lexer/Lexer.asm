Lexer:
  getByte line, buffer, ";"          ;first we want to find end of line and add all inside of it to line Array
  pop cx                             ;cx == line it is in.
  mov [lineOffset], cx               ;save line offset
  getByte paranthesis, line, ")"     ;the end paranthesis tells us where is the most inside start paranthesis.
  pop bx                             ;bx == what paranthesis is it.
  mov [paranthesisAmount], bx        ;save paranthesis amount
  
  getReverse secondParanthesis, paranthsis, "(", jne
  pop bx
  
  getByte math, secondParanthesis, "+"
  pop bx
  
  
  