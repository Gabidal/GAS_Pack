%macro openFile 1
  ;1 = file name
  mov eax, 5
  lea edx, [%1]
  int 0x80
  mov ecx, 4096
  mov [handle], eax
%endmacro

%macro readFile 1
  ;1 = buffer
  mov eax, 3
  mov ebx, [handle]
  mov ecx, 4096
  lea edx, [%1]
  int  0x80
%endmacro

%macro writeFile 1
  mov eax, 4
  mov ebx, [handle]
  mov ecx, 4096
  lea edx, [%1]
  int  0x80
%endmacro

%macro pointerFile 1
  mov eax, 
  mov ebx, [handle]
  mov ecx, %1
  mov edx, %1
  int  0x80
%endmacro

%macro closeFile 1
  mov eax, 6
  mov ebx, [handle]
  int  0x80
%endmacro