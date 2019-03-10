;GAS COMMAND TREE
tryCatch GTree, jmp


sumAB:
  add ax, bx
  cycle

subAB:
  sub ax, bx
  cycle

mulAB:
  clean dx
  mul bx
  cycle

divAB:
  clean dx
  div bx
  cycle
  
swichAB:
  xchg ax, bx
  cycle

ifAB:
  cmp ax, bx
  je trueAB
  jne falseAB
  cycle

trueAB:
  getFromGic
  jmp endCycle
  
falseAB:
  getFromGic
  getFromGic
  jmp endCycle
  
  

globalize:
  mov sv[0], word ax
  mov di, -1
  jmp quickCycle
  
externize:
  mov bx, word sv[0]
  mov di, -1
  jmp quickCycle
  
  
conEG:
  mov bx, word sv[0]
  mov di, 0
  jmp quickCycle
  
  
  
  
  
  
  
  
  
  
endGTree: