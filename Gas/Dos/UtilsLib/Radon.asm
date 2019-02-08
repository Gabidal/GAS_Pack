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
