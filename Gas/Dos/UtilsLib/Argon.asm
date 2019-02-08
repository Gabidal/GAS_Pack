;extern _GLOBAL_OFFSET_TABLE_  
;extern __GLOBAL_OFFSET_TABLE_ 

;%macro findGot 0
;  call %%getgot
;%%getgot: pop ebx
;  add ebx,_GLOBAL_OFFSET_TABLE_+$$-%%getgot wrt ..gotpc
;%endmacro

;%macro getVarFromGot 2
;  lea %1,[ebx+%2 wrt ..gotoff]
;%endmacro

%macro HeapVar 2
  [section .data]
  %1 dw %2
  db '$'
  [section .code]
%endmacro

%macro Array 2
  [section .bss]
  %1: resb %2
  [section .data]
  db '$'
%endmacro