;LEXER
Lexer:
call getWord ;next word please
mov bx, 0 ;it has to start from 0

  ;GET NEXT COMMAND TO COMPARE
  compare:
    mov si, word savePoint[2] ;load the save
    lea ax, commands[si] ;ax points to table + si
    add si, 12 ;be ready for next table content
    mov savePoint[2], si ;save si
    mov si, ax ;si now points to commnd table + index
      lea di, [words] ;di points to word from main.g
      mov cx, 12 ;tell the loop to stop at 12 round
      inc bx ;what instruction it is if true
        repz cmpsb ;compare them
    je Parser ;parser handles what to do
    jne compare ;if not this then compare next
      
      
cmpCycle:
  jmp Lexer ;to compare with next imput word