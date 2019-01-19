%include 'GInclude.asm'
main .code
;_-_-_-_-_-_-_-_-_-_-_-_-_-_
openFile fileName
readFile buffer
displayBuffer
closeFile
createFile outFile
openFile outFile
call Lexer
;_-_-_-_-_-_-_-_-_-_-_-_-_-_
system 21h