%macro body 2 
  %1:
  %2 end %1
%endmacro

%macro void 1
  %1:
%endmacro

%macro endVoid 1
  end %1:
%endmacro

%macro override 2 
  xor si, si
 fb%2i:
 mov al, %2[si]
 mov % 1[si], al
 inc si 
 lea ax, %2[si]
 lea bx, end % 2[0]
 cmp ax, bx jne fb%2i 
%endmacro
	 