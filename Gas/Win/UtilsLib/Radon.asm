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