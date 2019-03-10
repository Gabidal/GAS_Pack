;GAS INTERPRETER CORE

returnCycle:
  pop dx
  mov [savp], dx

mainCycle:
  ;LOAD FROM STACK
  getFromGic

quickCycle:

    cmp di, 1
    je externize

    cmp di, 2
    je conEG

  ;CX HAS COMMAND
  cmp cx, '+'
  je sumAB
  cmp cx, '-'
  je subAB
  cmp cx, '*'
  je mulAB
  cmp cx, '/'
  je divAB
  cmp cx, 'X'
  je swichAB
  cmp cx, '=='
  je ifAB

  
  

  endCycle:

    cmp di, 0
    je globalize

    cmp cx, 0
    jne  quickCycle
    
    cmp si, 0
    jne mainCycle
    
mov dx, word [savp]
push dx
ret