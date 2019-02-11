%macro openFile 1
    saveLocal
    mov ah,3Dh
    xor al,al
    lea dx,[%1]
    int 21h
    jc Error
    mov [handle],ax
    loadLocal
%endmacro

%macro createFile 1
    saveLocal
    mov ah,3ch 
    mov cx,00000000b 
    lea dx,[%1] 
    int 21h 
    jc Error 
    mov [handle],ax
    loadLocal
%endmacro

%macro readFile 1
    saveLocal
    mov ah,3fh
    mov bx,[handle]
    mov cx, 8192
    lea dx,[%1]
    int 21h
    jc Error
    loadLocal
%endmacro

%macro deleteFile 1
    saveLocal
    mov ah,41h
    lea dx,[%1]
    int 21h
    jc Error
    loadLocal
%endmacro

%macro displayBuffer 0
    saveLocal
    sout buffer
    loadLocal
%endmacro

%macro writeFile 1
    saveLocal
    mov ah,40h
    mov bx,[handle]
    mov cx, 8192
    lea dx,[%1]
    int 21h
    jc Error
    loadLocal
%endmacro

%macro closeFile 0
    saveLocal
    mov ah,3Eh
    mov bx,[handle]
    int 21h
    jc Error
    loafLocal
%endmacro