
%macro getBetween 3
  find Yw, %1, %2
  je %%parenthesis
  jne %%nonoParenthesis

  %%parenthesis:
    pop si
    inc si
    getByte Xw, %1+si, %3
    pop si
    pop di
    clean di
    clean si
    %%fbgLoop:
    find Yw, Xw, %2
    jne %%nonoParenthesis
    pop si
    inc si
    getByte Xw, Xw+si, %3
    pop si
    pop di
    clean di 
    jmp %%fbgLoop
  %%nonoParenthesis:
%endmacro

%macro getMath 2
  ;GET MUL
  find %1, %2, '*'
  jne nextDiv
  pop si
  
  ;GET DIV
  nextDiv:
  find %1, %2, '/'
  jne nextSum
  pop si
  
  ;GET SUM
  nextSum:
  find %1, %2, '+'
  jne nextSub
  pop si
  
  ;GET SUB
  nextSub:
  find %1, %2, '-'
  jne nextSet
  pop si
  
  ;SET TO
  nextSet:
  find %1, %2, '='
  pop si
%endmacro