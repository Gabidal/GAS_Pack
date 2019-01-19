section .data
  errorS times 32 db 0
  db '$'
  String Gnotice, ' G: Error'
  String opFileE, ' G: File not found'
  String rdFileE, ' G: Buffer lenght invalid'
  String clFileE, ' G: File handle invalid'
  String wrFileE, ' G: Invalid input / Invalid String'
  String poFileE, ' G: Given pointer Invalid or out of bounds'
  piValue dt 3.141592653589793238462 ; pi
  splitbuffer db '1','1','1','1'
  savePoint times 6 dw 0
  Yw times 32 db '0'
  Xw times 32 db '0'
  String Debug, ' G::Error'
  String Check, '  G::00'
  savp dw 0 ;save point
  gsave dw 0
  fileName db 'main.g'
  buffer times 4096 db 0
  db '$'
  handle times 5 dw 0
  hydSave times 16 db 0
  seedVal dw 0
 Tree:
  db 'int'
  db 'String'
  db 'static'
  db 'dynamic'
  db 'void'
  db 'func'
  db 'class'
  db 'template' 
  db '<'
  db '>'
  db '{'
  db '}'
  db '['
  db ']'
  db '('
  db ')'
  db '+'
  db '-'
  db '='
  db '=='
  db '+='
  db '-='
  db '/' 
  db '*'


;THIS MUST INCLUDE LAST
;BECAUSE THE DATA IS HERE