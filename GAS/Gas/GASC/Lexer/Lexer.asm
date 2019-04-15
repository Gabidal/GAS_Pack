Lexer:
  getByte line, buffer, ";"          ;first we want to find end of line and add all inside of it to line Array
  pop cx                             ;cx == line it is in.
  mov [lineOffset], cx               ;save line offset
  getByte paranthesis, line, ")"     ;the end paranthesis tells us where is the most inside start paranthesis.
  pop si                             ;bx == what paranthesis is it.
  mov [paranthesisAmount], si        ;save paranthesis amount
  
  getReverse secondParanthesis, paranthsis+si, "(", jne
  pop bx
  
  getByte mathL, secondParanthesis, "*"
  pop di
  
  getReverse mathR, secondParanthesis+di, "*"
  pop bx
  
  call mulMathParser