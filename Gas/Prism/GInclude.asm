
%include 'UtilsLib\GasRoot.asm'
tryCatch Include, jmp
%include 'GIC\GIL.asm'
%include 'GIC\GIA.asm'
%include 'GIC\GAT.asm'
%include 'GIC\GIF.asm'
%include 'GIC\GICO.asm'
%include 'GIC\GIT.asm'
%include 'UtilsLib\Hydrogen.asm';string
%include 'UtilsLib\GasMath.asm'
%include 'UtilsLib\Argon.asm'
%include 'UtilsLib\Helium.asm';I/O
%include 'Assets\Oxide.asm';variabled
%include 'Assets\Nimble.asm';errors
  endInclude
  