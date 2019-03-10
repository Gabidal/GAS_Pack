%macro put 2
  lea si, [reuse]
  lea di, [%1]
  mov cx, 10
  repz movsb
  lea si, [%2]
  mov cx, 10
  repz movsb
%endmacro