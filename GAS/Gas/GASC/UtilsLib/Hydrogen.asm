

%macro append 3
  saveLocal
  lea si, [%2]
  inc si
  lea di, [%1]
  mov cx, %3
  repz movsb
  loadLocal
%endmacro

%macro getByte 3
 saveLocal
   lea si, [%2]
   lea di, [%1]
   mov al, %3
   %%banana:
     mov bl, byte [si]
	 cmp bl, al
	 je %%end
	 mov [di], bl
	 sum si, 1         ;not sure if inc will increase si 2 not 1 byte.
	 sum di, 1         ;same here.
   %%endloop:
   push si             ;gives offset of the wanted char.
 loadLocal
%endmacro

%macro getReverse 4
 saveLocal
   lea si, [%2]
   lea di, [%1]
   mov al, %3
   %%banana:
     mov bl, byte [si]
	 cmp bl, al
	 %4 %%end          ;to have control what is, that is wanted.
	 mov [di], bl
	 sub si, 1         ;not sure if inc will increase si 2 not 1 byte.
	 sub di, 1         ;same here.
   %%endloop:
   push si             ;gives offset of the wanted char.
 loadLocal
%endmacro

%Macro strcmp 3
  lea si, [%2]
  lea di, [%1]
  mov cx, %3
  repz cmpsb
%endMacro

%macro copyString 3
  saveLocal
  lea si, %2
  lea di, %1
  mov ax, %3
  mov cx, 2
  div cx
  xchg ax, cx
  repz movsw
  loadLocal
%endmacro

%macro toChar 2
  saveLocal
  mov ax, %2
  mov bl, 48
  add ah, bl
  add al, bl
  push ax
  loadLocal
  pop %1
%endmacro

%macro toInt 2
  saveLocal
  mov ax, %2
  mov bl, 48
  sub ah, bl
  sub al, bl
  push ax
  loadLocal
  pop %1
%endmacro

%macro XtoInt 2
  saveLocal
  mov al, %2
  mov bl, 48
  sub al, bl
  push ax
  loadLocal
  pop ax
  mov %1, al
%endmacro
