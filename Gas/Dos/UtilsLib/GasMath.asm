%macro Msum 2
  mov eax, %1
  push eax
  mov eax, %2
  push eax ;load to stack all
  
  pop ax ;second tail
  pop bx ;head
  
  pop cx ;first tail
  pop dx ;head
  
  add dx, bx ;tail to tail
  add cx, ax ;head to head
  
  push dx
  push cx
  
  pop eax
  mov %1, eax
%endmacro

%macro Msub 2
  mov eax, %1
  push eax
  mov eax, %2
  push eax ;load to stack all
  
  pop ax ;second tail
  pop bx ;head
  pop cx ;first tail
  pop dx ;head
  
  sub dx, bx ;tail to tail
  sub cx, ax ;head to head
  push dx
  push cx
  
  pop eax
  mov %1, eax
%endmacro

%macro Xsum 2
  mov ax, %1
  mov bx, %2
  add ax, bx
  mov %1, ax
%endmacro

%macro Xsub 2
  mov ax, %1
  mov bx, %2
  sub ax, bx
  mov %1, ax
%endmacro

%macro Mmul 2
  push eax
  push ebx
  push ecx
  push edx
  clean edx
  mov cx, %2
  mov eax, %1
  shl eax, cl
  mov ebx, ecx
  div ebx
  pop edx
  pop ecx
  pop ebx
  mov %1, eax
  pop eax
%endmacro

%macro Mdiv 2
  clean edx
  mov cx, %2
  mov eax, %1
  shr eax, cl
  mov ebx, ecx
  mul ebx
  mov %1, eax
%endmacro

%macro Xdiv 2
  clean edx
  mov ax, %1
  mov bx, %2
  
  div bx
  
  mov %1, dx ;hi-
  mov %1, ax ;lo-
%endmacro

%macro Xmul 2
  clean edx
  mov ax, %1
  mov bx, %2

  mul bx

  mov %1, dx ;hi-
  mov %1, ax ;lo-
%endmacro

%macro pot 3
  clean edx
  mov cx, %2
  mov ebx, %1
  %3pot:
    mul ebx
    add %1, eax
  dec cx
  cmp cx, 0
  jg %3pot
%endmacro
 
%macro negate 1
  mov ebx, 0
  Msub ebx, %1
  mov %1, ebx
%endmacro

%macro abs 1
  mov ecx, %1
  cmp ecx, 0
  jb negative
  ;if positive
    jmp saveResult
  negative:
    Mmul ecx, -1
  saveResult:
    mov %1, ecx
%endmacro

%macro Xpot 3
  mov cx, %2
  %3xpot:
    Xmul %1, %1
  dec cx
  cmp cx, 0
  jne %3xpot
%endmacro
 
%macro Xnegate 1
  mov bx, 0
  Xsub bx, %1
  mov %1, bx
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
  Msub eax, ebx
; + (X^5/5!)
  mov ebx, %1
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax
  Mmul ebx, ax ;potense 5
  mov ecx, 120 ; 5!
  Mdiv ebx, cx
  Msum eax, ebx
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
  Msub eax, ebx
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
  Msum eax, ebx
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
  Msub eax, ebx
  mov %2, eax
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


%macro Xsin 3
  ;X - (X^3/3!)
  mov ax, %1 ; X
  mov bx, ax
  Xpot bx, 3, %3firstpot
  mov cx, 6 ;3!
  Xdiv bx, cx
  Xsub ax, bx
; + (X^5/5!)
  mov bx, %1
  Xpot bx, 5, %3secondpot
  mov cx, 120 ; 5!
  Xdiv bx, cx
  Xsum ax, bx
; - (X^7/7!)
  mov bx, %1
  Xpot bx, 7, %3tirdpot
  mov cx, 5040 ; 7!
  Xdiv bx, cx
  Xsub ax, bx
  mov %2, ax
%endmacro

%macro Xcos 3
  ;Xcos (x) = Xsin (pi/2)-x
  lea si, piValue[0]
  mov ax, word [si]
  Xdiv ax, 2 ;pi/2
  Xsin ax, ax, %3 ;ax=sin(ax)
  Xsub ax, %1; -x
  mov %2, ax
%endmacro

%macro Xtan 3
  ;Xtan(x) = Xsin(x) / cos(x)
  Xsin %1, ax, %3
  Xcos %1, cx, %3%3
  Xdiv ax, cx
  mov %2, ax
%endmacro

%macro rand 1
  saveLocal
  mov ah, 00h    ;timer in CX:DX 
  int 1AH
  mov bx, dx
  mov ax, 25173  ; LCG Multiplier
  mul bx
  add ax, 13849
  mov %1, ax
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
%endmacro

%macro sqrt 2
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
%endmacro