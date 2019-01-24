section .data
  buffer times 4096 db '0'
  db '$'
  outBuffer times 4096 db '0'
  db '$'
  fileName db 'main.g'
  outFile db 'main.asm'
  handle dw '0'
  String Debug, ' G::Error'
  String Check, '  G::00'
  String numOut, '0000'
  errorS times 64 db 0
  Gnotice db ' G: Error', '$'
  opFileE db ' G: File not found', '$'
  rdFileE db ' G: Buffer lenght invalid', '$'
  clFileE db ' G: File handle invalid', '$'
  wrFileE db ' G: Invalid input / Invalid String', '$'
  poFileE db ' G: Given pointer Invalid or out of bounds', '$'
  piValue dt 3.141592653589793238462 ; pi
  splitbuffer db '1','1','1','1'
  savePoint times 6 dw 0
  Yw times 255 db ';'
  db '$'
  Xw times 20 db ';'
  db '$'
  Zw db '3(665(*6))'
  db '$'
  savp dw 0 ;save point
  gsave dw 0
  hydSave times 16 db 0
  radSave times 16 dw 0
  matSave times 16 dw 0
  oxSave times 16 dw 0
  lexVar times 128 dw 0
  lexOp times 128 dw 0
  oxyString times 256 db '0'
  variables times 4096 dw '00'
  endVariables db '0'
  seedVal dw 0
  nullPointer db 0
;THIS MUST INCLUDE LAST
;BECAUSE THE DATA IS HERE