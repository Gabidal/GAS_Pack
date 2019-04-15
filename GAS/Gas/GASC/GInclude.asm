%include "UtilsLib/GasRoot.asm"
tryCatch Include, jmp

%include "Lexer/Lexer.asm"
%include "Parser/Parser.asm"

%include "UtilsLib/Argon.asm"
%include "UtilsLib/GasMath.asm"
%include "UtilsLib/Helium.asm"
%include "UtilsLib/Hydrogen.asm"
%include "DB/DB.asm"
%include "UtilsLib/Errors.asm"


endInclude: