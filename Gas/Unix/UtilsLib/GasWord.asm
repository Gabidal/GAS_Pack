;THIS IS THE HARD PART!

%macro createMatrix 1
  %1 times 16  dd 1
%endmacro

%macro getFromMatrix 4
  %assign location %2+(%3*4)
  lea esi, %1[location]
  mov eax,dword [esi]
  mov %4, eax
%endmacro

%macro editMatrix 4
  %assign location1 %2+(%3*4)
  lea esi, %1[location1]
  mov [esi], dword %4
%endmacro

%macro multiplyMatrix 4
  %assign vecX %2
  %assign vecY %3
  %assign vecZ %4
  ;FIRST ROW
  getFromMatrix %1, 0, 0, eax
  Mmul eax, %2
  mov ecx, eax
  getFromMatrix %1, 0, 1, eax
  Mmul eax, %2
  add ecx, eax
  getFromMatrix %1, 0, 2, eax
  Mmul eax, %2
  add ecx, eax
  getFromMatrix %1, 0, 3, eax
  Mmul eax, %2
  add ecx, eax
  push ecx
  ;SECOND ROW
  getFromMatrix %1, 1, 0, eax
  Mmul eax, %3
  mov ecx, eax
  getFromMatrix %1, 1, 1, eax
  Mmul eax, %3
  add ecx, eax
  getFromMatrix %1, 1, 2, eax
  Mmul eax, %3
  add ecx, eax
  getFromMatrix %1, 1, 3, eax
  Mmul eax, %3
  add ecx, eax
  push ecx
  ;TIRD ROW
  getFromMatrix %1, 2, 0, eax
  Mmul eax, %4
  mov ecx, eax
  getFromMatrix %1, 2, 1, eax
  Mmul eax, %4
  add ecx, eax
  getFromMatrix %1, 2, 2, eax
  Mmul eax, %4
  add ecx, eax
  getFromMatrix %1, 2, 3, eax
  Mmul eax, %4
  add ecx, eax
  push ecx
  editMatrix %1, 3, 3, 1
%endmacro

%macro rotateMatrixX 3
  editMatrix %1, 0, 0, 1
  cos %2, eax, %3
  editMatrix %1, 1, 1, eax
  sin %2, eax, %3%3
  negate eax
  editMatrix %1, 2, 1, eax
  sin %2, eax, %3%3%3
  editMatrix %1, 1, 2, eax
  cos %2, eax, %3%3%3%3
  editMatrix %1, 2, 2, eax
  editMatrix %1, 3, 3, 1
%endmacro

%macro rotateMatrixY 3
  cos %2, eax, %3
  editMatrix %1, 0, 0, eax
  sin %2, eax, %3%3
  negate eax
  editMatrix %1, 2, 0, eax
  editMatrix %1, 1, 1, 1
  sin %1, eax, %3%3%3
  editMatrix %1, 0, 2, eax
  cos %2, eax, %3%3%3%3
  editMatrix %1, 2, 2, eax
  editMatrix %1, 3, 3, 1
%endmacro

%macro rotateMatrixZ 3
  cos %2, eax, %3
  editMatrix %1, 0, 0, eax
  sin %2, eax, %3%3
  negate eax
  editMatrix %1, 1, 0, eax
  sin %2, eax, %3%3%3
  editMatrix %1, 0, 1, eax
  cos %2, eax, %3%3%3%3
  editMatrix %1, 1, 1, eax
  editMatrix %1, 2, 2, 1
  editMatrix %1, 3, 3, 1
%endmacro

%macro scaleMatrix 4
  ;name, x, y, z
  editMatrix %1, 0, 0, %2
  editMatrix %1, 1, 1, %3
  editMatrix %1, 2, 2, %4
  editMatrix %1, 3, 3, 1
%endmacro

%macro translateMatrix 4
  scaleMatrix %1, 1, 1, 1
  editMatrix %1, 3, 0, %2; x
  editMatrix %1, 3, 1, %3; y
  editMatrix %1, 3, 2, %4; z
%endmacro

%macro identifyMatrix 1
  scaleMatrix %1, 1, 1, 1
%endmacro

%macro combineMatrix 3
  getFromMatrix %1, 0, 0, eax
  getFromMatrix %2, 0, 0, ebx
  Mmul eax, bx
  getFromMatrix %2, 1, 0, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 2, 0, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 3, 0, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  editMatrix %3, 0, 0, eax
;next
  getFromMatrix %1, 1, 0, eax
  getFromMatrix %2, 0, 0, ebx
  Mmul eax, bx
  getFromMatrix %2, 1, 0, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 2, 0, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 3, 0, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  editMatrix %3, 1, 0, eax
;next
  getFromMatrix %1, 2, 0, eax
  getFromMatrix %2, 0, 0, ebx
  Mmul eax, bx
  getFromMatrix %2, 1, 0, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 2, 0, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 3, 0, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  editMatrix %3, 2, 0, eax
;next
  getFromMatrix %1, 3, 0, eax
  getFromMatrix %2, 0, 0, ebx
  Mmul eax, bx
  getFromMatrix %2, 1, 0, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 2, 0, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 3, 0, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  editMatrix %3, 3, 0, eax
;NEXT ROW
  getFromMatrix %1, 0, 1, eax
  getFromMatrix %2, 0, 1, ebx
  Mmul eax, bx
  getFromMatrix %2, 1, 1, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 2, 1, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 3, 1, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  editMatrix %3, 0, 1, eax
;next
  getFromMatrix %1, 1, 1, eax
  getFromMatrix %2, 0, 1, ebx
  Mmul eax, bx
  getFromMatrix %2, 1, 1, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 2, 1, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 3, 1, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  editMatrix %3, 1, 1, eax
;next
  getFromMatrix %1, 2, 1, eax
  getFromMatrix %2, 0, 1, ebx
  Mmul eax, bx
  getFromMatrix %2, 1, 1, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 2, 1, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 3, 1, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  editMatrix %3, 2, 1, eax
;next
  getFromMatrix %1, 3, 1, eax
  getFromMatrix %2, 0, 1, ebx
  Mmul eax, bx
  getFromMatrix %2, 1, 1, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 2, 1, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 3, 1, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  editMatrix %3, 3, 1, eax
;NEXT ROW
  getFromMatrix %1, 0, 2, eax
  getFromMatrix %2, 0, 2, ebx
  Mmul eax, bx
  getFromMatrix %2, 1, 2, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 2, 2, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 3, 2, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  editMatrix %3, 0, 2, eax
;next
  getFromMatrix %1, 1, 2, eax
  getFromMatrix %2, 0, 2, ebx
  Mmul eax, bx
  getFromMatrix %2, 1, 2, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 2, 2, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 3, 2, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  editMatrix %3, 1, 2, eax
;next
  getFromMatrix %1, 2, 2, eax
  getFromMatrix %2, 0, 2, ebx
  Mmul eax, bx
  getFromMatrix %2, 1, 2, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 2, 2, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 3, 2, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  editMatrix %3, 2, 2, eax
;next
  getFromMatrix %1, 3, 2, eax
  getFromMatrix %2, 0, 2, ebx
  Mmul eax, bx
  getFromMatrix %2, 1, 2, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 2, 2, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 3, 2, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  editMatrix %3, 3, 2, eax
;NEXT ROW
  getFromMatrix %1, 0, 3, eax
  getFromMatrix %2, 0, 3, ebx
  Mmul eax, bx
  getFromMatrix %2, 1, 3, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 2, 3, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 3, 3, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  editMatrix %3, 0, 3, eax
;next
  getFromMatrix %1, 1, 3, eax
  getFromMatrix %2, 0, 3, ebx
  Mmul eax, bx
  getFromMatrix %2, 1, 3, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 2, 3, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 3, 3, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  editMatrix %3, 1, 3, eax
;next
  getFromMatrix %1, 2, 3, eax
  getFromMatrix %2, 0, 3, ebx
  Mmul eax, bx
  getFromMatrix %2, 1, 3, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 2, 3, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 3, 3, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  editMatrix %3, 2, 3, eax
;next
  getFromMatrix %1, 3, 3, eax
  getFromMatrix %2, 0, 3, ebx
  Mmul eax, bx
  getFromMatrix %2, 1, 3, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 2, 3, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  getFromMatrix %2, 3, 3, ebx
  Mmul ecx, bx
  Msum eax, ecx
  clean ecx
  editMatrix %3, 3, 3, eax
;NEXT ROW
%endmacro