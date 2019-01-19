section .data
%include 'UtilsLib\GasRoot.asm' ;tool
%include 'UtilsLib\Hydrogen.asm';string
%include 'UtilsLib\Helium.asm';I/O
%include 'UtilsLib\GasMath.asm'
%include 'UtilsLib\GasWord.asm'
%include 'UtilsLib\Steam.asm'
%include 'UtilsLib\Radon.asm'
%include 'GC\Oxygen.asm';token
%include 'GC\Gic.asm';parser
%include 'Assets\Nimble.asm';errors

main code
  endOxygen:
  endGic:
  modPhyMem [Debug], 1
  physicalGo 5h
  
tryCatch Error, jmp
  EOccurred:
    clearLocal
    sout Debug
endError:

tryCatch SameS, jmp
stringaresame:
  clearLocal
  sout Check
endSameS:

system 21h

%include 'Assets\Oxide.asm';variabled