
;intialize

%macro gicStore 0
  push di ;variable
  push dx ;command
  push cx ;index
  push bx ;value
  push ax ;identifier
%endmacro

%macro gicLoad 0
  pop ax ;identifier
  pop bx ;value
  pop cx ;index
  pop dx ;command
  pop di ;variable
%endmacro

%macro gicSave 0
  lea esi, [buffer]
  mov esi, dword [gsave]
  mov [esi+0], eax
  mov [esi+16], ebx
  mov [esi+32], ecx
  mov [esi+48], edx
  mov [esi+64], edi
  add esi, 16
  mov [gsave], esi
%endmacro



gic:
  ;______________;
  gicLoad ;load 1 layer
  
  
  
  
  

  ;______________;
  endcycle:
cmp dx, '$'
jne gic
  jmp endGic