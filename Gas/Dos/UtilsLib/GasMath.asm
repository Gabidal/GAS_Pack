
%macro Mmul 2
  saveLocal
  clearLocal
  mov eax, %1
  mov ebx, %2
  imul ebx
  push eax
  loadLocal
  pop %1
%endmacro

%macro Mdiv 2
  saveLocal
  clearLocal
  mov eax, %1
  mov ebx, %2
  cwd
  idiv ebx
  push eax
  loadLocal
  pop %1
%endmacro

%macro Xdiv 2
  saveLocal
  clearLocal
  mov ax, %1
  mov bx, %2
  cwd
  idiv bx
  push ax
  loadLocal
  pop %1
%endmacro

%macro Xmul 2
  saveLocal
  clearLocal
  mov ax, %1
  mov bx, %2
  imul bx
  push ax
  loadLocal
  pop %1
%endmacro

%macro pot 2
  saveLocal
  clearLocal
  mov ecx, %2
  %%ll:
    imul %1, %1
    dec ecx
  cmp ecx, 0
    jne %%ll
  push %1
  loadLocal
  pop %1
%endmacro
 
%macro negate 1
  saveLocal
  mov ebx, 0
  sub ebx, %1
  push ebx
  loadLocal
  pop %1
%endmacro

%macro abs 1
  saveLocal
  mov ecx, %1
  cmp ecx, 0
  jb negative
  ;if positive
    jmp saveResult
  negative:
    Mmul ecx, -1
  saveResult:
  push ecx
  loadLocal
  pop %1
%endmacro

%macro Xpot 3
  saveLocal
  clearLocal
  mov cx, %2
  %%ll:
    imul %1, %1
    dec cx
  cmp cx, 0
    jne %%ll
  push %1
  loadLocal
  pop %1
%endmacro
 
%macro Xnegate 1
  saveLocal
  mov bx, 0
  sub bx, %1
  push bx
  loadLocal
  pop %1
%endmacro

%macro sin 3
  ;X - (X^3/3!)
  mov eax, %1 ; X
  mov ebx, %1
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax ;potense 3
  mov ecx, 6 ;3!
  Mdiv ebx, cx
  sub eax, ebx
; + (X^5/5!)
  mov ebx, %1
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax ;potense 5
  mov ecx, 120 ; 5!
  Mdiv ebx, cx
  sum eax, ebx
; - (X^7/7!)
  mov ebx, %1
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax ;potense 7
  mov ecx, 5040 ; 7!
  Mdiv ebx, cx
  sub eax, ebx
; +(X^9/9!)
  mov ebx, %1
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax ;potense 9
  mov ecx, 362880
  Mdiv ebx, cx
  sum eax, ebx
; -(X^11/11!)
  mov ebx, %1
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax ;potense 11
  mov ecx, 39916800
  Mdiv ebx, cx
  sub eax, ebx
  push eax
  loadLocal
  pop %2
%endmacro

%macro cos 3
  ;cos (x) = sin (pi/2)-x
  mov ecx, %1
  lea esi, piValue[0]
  mov ebx, dword [esi]
  Mdiv edx, 2 ;pi/2
  sin ebx, edx, %3 ;ebx=sin(ebx)
  Msub ebx, ecx; -x
  mov %2, ebx
%endmacro

%macro tan 3
  ;tan(x) = sin(x) / cos(x)
  sin %1, ebx, %3
  cos %1, ecx, %3%3
  Mdiv ebx, ecx
  mov %2, ebx
%endmacro

%macro rand 1
  saveLocal
  mov ah, 00h    ;timer in CX:DX 
  int 1AH
  mov bx, dx
  mov ax, 25173  ; LCG Multiplier
  mul bx
  add ax, 13849
  push ax
  loadLocal
  pop %1
%endmacro

%macro vec 4
  %1X: dw %2
  %1Y: dw %3
  %1Z: dw %4
%endmacro

%macro vec 1
  vec %1, 0, 0, 0
%endmacro

%macro addVec 3
  saveLocal
  vec %1
  mov ax, word [%2X]
  mov bx, word [%2Y]
  mov cx, word [%2Z]
  ;ADDING REGISTERS WITH B
  add ax, word [%3X]
  add bx, word [%3Y]
  add cx, word [%3Z]
  ;MOV REGISTERS TO C
  mov [%1X], ax
  mov [%1Y], bx
  mov [%1Z], cx
  loadLocal
%endmacro

%macro sqrt 2
  saveLocal
  mov eax, %2
  test eax, eax
  jnz %%sqrtpos
  jmp %%itIsZero
  %%sqrtpos:
  mov ecx, eax
  shl ecx, 1
  or eax, ecx
  bsr ecx, eax
  xor edx, edx
  %%sqrtlp:
  shr eax,2
  rcr dx, 1
  jnz %%sqrtlp
  shr cl, 1; Adjust for skipped bits
  inc cl
  rol dx, cl
  mov ecx, edx
  mov matSave[0], ecx
  %%itIsZero:
  clearLocal
  mov eax, dword matSave[0]
  mov %1, eax
  loadLocal
%endmacro