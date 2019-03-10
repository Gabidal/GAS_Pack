
%macro mapFloor 2
  mov si, word freeX[0]
  mov ax, %1
  mov bx, %2
  mov center[si], ax
  mov center[si+1], bx
  inc si
  mov freeX[0], si
%endmacro

%macro createEntity 3
  mov ax, %1
  mov bx, %2
  mov cx, %3
  mov si, word freeX[1]
  mov entities[si], si
  inc si
  mov entities[si], ax
  inc si
  mov entities[si], bx
  inc si
  mov entities[si], cx
  inc si
  mov freeX[1], si
%endmacro

%macro findEnt 1
  saveLocal
  mov bx, %1
  mov ax, 4
  imul bx
  push ax
  loadLocal
%endmacro

%macro findCenter 1
  saveLocal
  mov bx, %1
  mov ax, 2
  imul bx
  push ax
  loadLocal
%endmacro

%macro createGround 3
  mov ax, %1
  mov bx, %2
  mov cx, %3
  mov si, word freeX[2]
  mov ground[si], ax
  inc si
  mov ground[si], bx
  inc si
  mov ground[3], cx
  inc si
  mov freeX[2], si
%endmacro

%macro createCenter 2
  mov ax, %1
  mov bx, %2
  mov si, word freeX[3]
  mov center[si], ax
  inc si
  mov center[si], bx
  inc si
  mov freeX[3], si
%endmacro

%macro drag 2
  findEnt %1
  pop si
  ;ent X
  inc si
  mov ax, word entities[si]
  ;ent Y
  inc si
  mov bx, word entities[si]
  ;center X
  findCenter %2
  pop si
  mov cx, word center[si]
  ;center Y
  inc si
  mov dx, word center[si]

  %%tesnex:
  nout ax
  cmp ax, cx
  jb %%toRight
  jg %%toLeft
  cmp bx, dx
  jb %%down
  jg %%rise
  
  %%toRight:
    inc ax
  jmp %%tesnex
  %%toLeft:
    dec ax
  jmp %%tesnex
  %%down:
    inc bx
  jmp %%tesnex
  %%rise:
    dec bx
  jmp %%tesnex

  findEnt %1
  pop si
  ;ent X
  inc si
  mov entities[si], ax
  ;ent Y
  inc si
  mov entities[si], bx
%endmacro