extern _GLOBAL_OFFSET_TABLE_  
extern __GLOBAL_OFFSET_TABLE_ 

%macro findGot 0
  call %%getgot
%%getgot: pop ebx
  add ebx,_GLOBAL_OFFSET_TABLE_+$$-%%getgot wrt ..gotpc
%endmacro

%macro getVarFromGot 2
  lea %1,[ebx+%2 wrt ..gotoff]
%endmacro