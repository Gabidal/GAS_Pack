section .data
  fileName db 'main.g$'
  outFile db 'main.asm$'
  handle dw '0$'
  Debug db ' G::Error', '$'
  Check db  '  G::00', '$'
  String numOut, '00$'
  Gnotice db ' G: Error', '$'
  opFileE db ' G: File not found', '$'
  rdFileE db ' G: Buffer lenght invalid', '$'
  clFileE db ' G: File handle invalid', '$'
  wrFileE db ' G: Invalid input / Invalid String', '$'
  poFileE db ' G: Given pointer Invalid or out of bounds', '$'
  piValue dt 3.141592653589793238462, '$' ; pi
  splitbuffer db '1','1','1','1$'
  savp dw 0, '$' ;save point
  gsave dw 0, '$'
  seedVal dw 0
  db '$'
  nullPointer db 0
  db '$'
  Array savePoint, 12
  Array hydSave, 24
  Array radSave, 24
  Array matSave, 24
  Array oxSave, 24
  Array lexVar, 510
  Array lexOp, 510
  Array oxyString, 510
  Array variables, 8192
  Array endVariables, 1
  Array Yw, 255
  Array Xw, 255
  Array Zw, 255
  Array entities, 800
  Array ground, 600
  Array center, 400
  Array freeX, 200
  Array buffer, 8192
  Array outBuffer, 8192
  Array errorS, 64
;THIS MUST INCLUDE LAST
;BECAUSE THE DATA IS HERE