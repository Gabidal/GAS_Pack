%include 'GInclude.asm'
main .code
;_-_-_-_-_-_-_-_-_-_-_-_-_-_
sout Check
openFile fileName
readFile buffer
displayBuffer
closeFile
jmp Lexer
;_-_-_-_-_-_-_-_-_-_-_-_-_-_
system 21h