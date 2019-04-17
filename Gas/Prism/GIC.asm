 %include 'GInclude.asm'

main .code
;_-_-_-_-_-_-_-_-_-_-_-_-_
  ;openFile
  ;readFile
  ;closeFile
  ;jmp Lexer


func 1, '+', 0, 0, 1 ;get the return of the "8_pass".

;FUNC 8_pass()
;{
func 1, '*', 0, 1, 2 ; the result vill divide 5
func 1, '+', 0, 1, 2 ;get the return 7 and +1 and then pass it to next.
func 5, '+', 2, 1, 0 ;return 5+2.
;}

;_-_-_-_-_-_-_-_-_-_-_-_-_
endLexer:
call returnCycle
endGIC:
nout ax
endMain
