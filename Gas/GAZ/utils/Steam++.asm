

%macro loadSprite 2
  [section .data]
  %1:
  %include %2
  db '$'
  [section .code]
%endmacro

%macro drawSprite 3
  clean bp
  mov si, 4
  mov di, word %1[2]
  mov sp, word %1[0]
  
  %%drawSprt:
    mov cx, word %1[si]
    add si, 2
    mov dx, word %1[si]
    add si, 2

    mov ax, word %1[si]
    add si, 2
    mov bx, word %1[si]
    add si, 2

    add cx, %2
    add dx, %3
    add ax, %2
    add bx, %3

    line cx, dx, ax, bx, byte %1[si], byte %1[si+1], byte %1[si+2], byte %1[si+3]
    add si, 4
  inc bp
  cmp bp, di
  jb %%drawSprt
    cmp sp, 1
    je %%fillll
    jmp %%end
    %%fillll:
      fill %1
    %%end:
%endmacro

%macro fill 1
  clean bp ;clean the counter
  mov si, 4 ;skip the first 4 bytes (headers)
  mov di, word %1[2] ;maximum vectors thst input fike offers

  %%X:
    mov cx, word %1[si] ;get start X
    add si, 2 ;next double byte
    mov dx, word %1[si] ;start Y
    add si, 2 ; next
    mov ax, word %1[si] ;end X
    add si, 2 ;next 
    mov bx, word %1[si] ;end Y
    add si, 2 ;next

  %%Y:
    cmp cx, %1[si+4] ;next line cx
    jg %%CDown ;if now cx is bigger than next line cx: shrunk
    jb %%CUp ;here vice versa
    %%Cret: ;return point
    cmp dx, %1[si+6] ;next line dx
    jg %%DDown ;same for dx if bigger get smaller
    jb %%DUp ;vice versa
    %%Dret: ;return point
    cmp ax, %1[si+8] ;next line ax
    jg %%ADown ;and so on for ax too
    jb %%AUp ;vice versa
    %%Aret: ;return point
    cmp bx, %1[si+10] ;next line bx
    jg %%BDown ;if bigger get smaller dude
    jb %%BUp ;vice versa
    %%Bret: ;return point
  ;DRAW A LINE 
    line cx, dx, ax, bx, byte %1[si], byte %1[si+1], byte %1[si+2], byte %1[si+3]
    add si, 4 ;next set of verctors please
    inc bp ;tell our selves that we are going next round.
    cmp bp, di ;check if passed maximun amount of vectors.
    jb %%X ;if still too small, then get bigger.

    %%CDown:
      dec cx ;shrunk cx
      jmp %%Cret ;return
      
    %%CUp:
      inc cx ;increase cx
      jmp %%Cret ;go home (return)

    %%DDown:
      dec dx ;decrease dx
      jmp %%Dret ;its late go already 
      
    %%DUp:
      inc dx ;increase dx
      jmp %%Dret ;you can get the idea?
      
    %%ADown:
      dec ax ;no?
      jmp %%Aret ;so youre a dumm.
      
    %%AUp:
      inc ax ;confiused?
      jmp %%Aret ;then you can understand the power of nothing.
      
    %%BDown:
      dec bx ;yeas it mean nothing
      jmp %%Bret ;it still goes on ....
      
    %%BUp:
      inc bx ;so finally were here
      jmp %%Bret ;but noo, gotta go make some loops again.
      
%endmacro