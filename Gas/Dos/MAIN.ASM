	ifndef	??version
?debug	macro
	endm
$comm	macro	name,dist,size,count
	comm	dist name:BYTE:count*size
	endm
	else
$comm	macro	name,dist,size,count
	comm	dist name[size]:BYTE:count
	endm
	endif
	?debug	S "main.g"
	?debug	C E9178D334E066D61696E2E67
_TEXT	segment byte public 'CODE'
_TEXT	ends
DGROUP	group	_DATA,_BSS
	assume	cs:_TEXT,ds:DGROUP
_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
_DATA	ends
_BSS	segment word public 'BSS'
b@	label	byte
b@w	label	word
_BSS	ends
_TEXT	segment byte public 'CODE'
   ;	
   ;	int main()
   ;	
	assume	cs:_TEXT
_main	proc	near
	push	bp
	mov	bp,sp
	sub	sp,8
	push	si
	push	di
   ;	
   ;	{
   ;	  int a = 0;
   ;	
	xor	di,di
   ;	
   ;	  int b = 32;
   ;	
	mov	si,32
   ;	
   ;	  int lol = 5;
   ;	
	mov	word ptr [bp-2],5
   ;	
   ;	  int llol = 6;
   ;	
	mov	word ptr [bp-4],6
   ;	
   ;	  int lllol = 7;
   ;	
	mov	cx,7
   ;	
   ;	  int llllol = 7 + lol / llol * lllol;
   ;	
	mov	ax,word ptr [bp-2]
	cwd	
	idiv	word ptr [bp-4]
	imul	cx
	add	ax,7
	mov	word ptr [bp-6],ax
   ;	
   ;	  int c = a + b;
   ;	
	mov	ax,di
	add	ax,si
	mov	bx,ax
   ;	
   ;	  int d = c * b - a;
   ;	
	mov	ax,bx
	imul	si
	sub	ax,di
	mov	word ptr [bp-8],ax
   ;	
   ;	  return 0;
   ;	
	xor	ax,ax
	jmp	short @1@50
@1@50:
   ;	
   ;	};
   ;	
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	
_main	endp
	?debug	C E9
_TEXT	ends
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
_TEXT	segment byte public 'CODE'
_TEXT	ends
	public	_main
	end
