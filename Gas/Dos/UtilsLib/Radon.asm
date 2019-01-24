;MANIPULATIONS OF MEMORY

%macro physicalGo 1
  mov si, %1 
  jmp [ds:si]
%endmacro

%macro getPhyMem 2
  mov si, %2
  lea di, [ds:si]
  mov %1, di
%endmacro

%macro modPhyMem 2
  mov di, %1
  mov si, %2
  mov [ds:di], si
%endmacro

%macro stackFrame 0
  mov bp, sp
%endmacro

%macro getFromStack 2
  mov sp, %2
  mov %1, [ss:sp]
%endmacro

%macro getMaxOf 3
  saveLocal
  mov bx, %3
  mov ax, %3
  %1:
    dec ax
    cmp ax, bx
    jb %1
mov [radSave], ax
  loadLocal
  mov %2, word [radSave]
%endmacro

stackManager:
  getMaxOf StMA, sp, sp
  mov [radSave], sp
  meMa:
    pop ax
    cmp ah, ' '
  je emptSpace
    cmp al, ' '
  je emptSpace
    cmp ax, 0
  je checkForVar
  stCon:
  dec cx
  mov bx, word [radSave]
  cmp cx, bx
  jb meMa
  jmp endStackManagment

emptSpace:
  jmp stCon

checkForVar:
  pop ax
  cmp ax, 0
  je stCon
  push ax
  mov bx, 0
  push bx
  dec sp
  dec sp
  jmp stCon

;-_-_-_-_-_-_-_-_-_-_-_-_-_

memManager:
  getMaxOf PhyMeMA, si, si
  mov [radSave], si
  phymeMa:
    mov ax, [si]
    cmp ah, ' '
  je phyemptSpace
    cmp al, ' '
  je phyemptSpace
    cmp ax, 0
  je phycheckForVar
  phystCon:
  inc si
  dec cx
  mov bx, word [radSave]
  cmp cx, bx
  jb phymeMa
  jmp endPhyManagment

phyemptSpace:
  jmp phystCon

phycheckForVar:
  mov ax, word [si]
  cmp ax, 0
  je phystCon
  mov [si], ax
  mov bx, 0
  mov [si+1], bx
  dec si
  dec si
  jmp phystCon

;-_-_-_-_-_-_-_-_-_-_-_-_-_

%macro sizeOffMem 1
  mov di, [buffer]
  clean bp
  clean eax
  mov eax, 0xE820
  clean ebx
  mov ecx, 24
  mov edx, 0x534D4150
  mov [es:di+20], dword 1
  int 0x15
  jc Error
%endmacro

%macro setRMode 0
  cli
  mov eax,  [buffer]
  mov ds, eax
  mov es, eax
  mov fs, eax
  mov gs, eax
  mov ss, eax
  mov eax, cr0
  mov [radSave], eax
  and eax, 0x7FFFFFFe
  mov cr0, eax
  
  mov sp, 0x8000
  mov ax, 0
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov ss, ax
  lidt [radSave+4]
  sti
%endmacro

%macro saveToRMA 2
;save to real mode address
  mov ds, 0xffff
  mov di, 0x10
  mov [ds:di+%1], %2
%endmacro

%macro loadFromRMA 3
;load from real mode address
  mov ds, 0xffff
  mov di, 0x10
  mov %1, %2 [ds:di+%3]
%endmacro

%macro addVar 2
  ;ax = x
  ;bx = y
  ;dx:cx = value
  
  ;Change String name to X,Y cords
  xToInt ah, byte [%1]
  xToInt al, byte [%1+1]
  xToInt bh, byte [%1+2]
  xToInt bl, byte [%1+3]
  ;Transfer parameter value to stack
  mov ch, byte [%2]
  mov cl, byte [%2+1]
  realInt ch, ch
  realInt cl, cl
  ;Check if bigger than 99
  mov dh, byte [%2+2]
  cmp dh, '0'
  jge %%bigger
  jmp %%noInt
  %%bigger:
    cmp dh, '9'
    jg %%noInt
    mov dl, byte [%2+3]
    realInt dl, dl
    realInt dh, dh
  %%noInt
  
  push cx ;lo
  push dx ;hi
  push bx
  push ax
  
%endmacro

%macro getVar 2
  
  
%endmacro