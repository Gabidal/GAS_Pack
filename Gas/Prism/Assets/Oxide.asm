section .data
  heapByte Debug, ' G::Error'
  heapByte numOut, '  '
  heapTega piValue, 3.141592653589793238462
  heapDuo savp, 0
  heapDuo seedVal, 0
  Array words, 12
  Array preWord, 12
  savePoint times 24 db 0
  Array variables, 160
  Array sv, 20
  Array hydSave, 24
  Array matSave, 24

  commands:
  db 'int         '
  db '+          '
  db '-           '
  db '/           '
  db '*           '

  
  db '$'

;THIS MUST INCLUDE LAST
;BECAUSE THE DATA IS HERE