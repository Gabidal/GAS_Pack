%include 'GasTable.asm'
;intialize

%macro gicStore 0
  push di ;variable
  push dx ;command
  push cx ;index
  push bx ;value
  push ax ;String ptr
%endmacro

%macro gicLoad 0
  pop ax ;String ptr
  pop bx ;value
  pop cx ;index
  pop dx ;command
  pop di ;variable
%endmacro

gic:
  ;______________;
  gicLoad ;load 1 layer
  ;______________;
  endcycle:
cmp dx, '$'
jne gic
  jmp endGic