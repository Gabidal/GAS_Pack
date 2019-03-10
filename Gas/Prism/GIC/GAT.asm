intt:
  call getWord ; name
  call getWord ; =
  call getWord ; value
  mov ax, word [words]
  mov si, word savePoint[6]
  mov [variables+si], ax
  add si, 4
  mov savePoint[6], si
  jmp cmpCycle

summ:
  call operands
  mov cx, '+'
  call adToGic
  jmp cmpCycle
  
subb:
  call operands
  mov cx, '-'
  call adToGic
  jmp cmpCycle
  
divv:
  call operands
  mov cx, '/'
  call adToGic
  jmp cmpCycle
  
mull:
  call operands
  mov cx, '*'
  call adToGic
  jmp cmpCycle