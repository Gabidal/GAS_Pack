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
	?debug	C E9DAA5374E066D61696E2E67
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
   ;	int gab(int abc)
   ;	
	assume	cs:_TEXT
_gab	proc	near
	push	bp
	mov	bp,sp
	push	si
   ;	
   ;	{
   ;	int e = abc;
   ;	
	mov	si,word ptr [bp+4]
   ;	
   ;	  return e;
   ;	
	mov	ax,si
	jmp	short @1@50
@1@50:
   ;	
   ;	}
   ;	
	pop	si
	pop	bp
	ret	
_gab	endp
   ;	
   ;	int main()
   ;	
	assume	cs:_TEXT
_main	proc	near
	push	bp
	mov	bp,sp
	sub	sp,6
	push	si
	push	di
   ;	
   ;	{
   ;	int a = 0;
   ;	
	xor	si,si
   ;	
   ;	int b = 32;
   ;	
	mov	di,32
   ;	
   ;	int c = a + b * 9 / 2;
   ;	
	mov	ax,di
	mov	dx,9
	imul	dx
	mov	bx,2
	cwd	
	idiv	bx
	mov	dx,si
	add	dx,ax
	mov	word ptr [bp-2],dx
   ;	
   ;	float d = 0.65f;
   ;	
	FLD	dword ptr DGROUP:s@
	FSTP	dword ptr [bp-6]
   ;	
   ;	d = d + 9.06f;
   ;	
	FLD	dword ptr [bp-6]
	FADD	dword ptr DGROUP:s@+4
	FSTP	dword ptr [bp-6]
   ;	
   ;	a = gab(c+a-b);
   ;	
	FWAIT	
	mov	ax,word ptr [bp-2]
	add	ax,si
	sub	ax,di
	push	ax
	call	near ptr _gab
	pop	cx
	mov	si,ax
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
	db	'ff&?'
	db	-61
	db	-11
	db	16
	db	'A'
_DATA	ends
_TEXT	segment byte public 'CODE'
_TEXT	ends
	public	_main
	public	_gab
	end
