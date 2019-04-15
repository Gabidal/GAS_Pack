%include "GInclude.asm"

main .text
  openFile
  readFile
  closeFile
;IF THE READ OF FILE IS SUCCESSFULL.
;THE LEXER WILL SATRT UP.

jmp Lexer
  
endCompile: