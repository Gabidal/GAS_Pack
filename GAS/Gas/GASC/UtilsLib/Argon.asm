

%macro heapByte 2
  [section .data]
  %1 db %2
  db '$'
  [section .code]
%endmacro

%macro heapWord 2
  [section .data]
  %1 dw %2
  db '$'
  [section .code]
%endmacro

%macro heapDuo 2
  [section .data]
  %1 dd %2
  db '$'
  [section .code]
%endmacro

%macro heapQuad 2
  [section .data]
  %1 dq %2
  db '$'
  [section .code]
%endmacro

%macro heapTega 2
  [section .data]
  %1 dt %2
  db '$'
  [section .code]
%endmacro

%macro Array 2
  [section .data]
  %1: times %2 db ' '
  db '$'
  [section .code]
%endmacro