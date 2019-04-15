section .data
Array sv, 28*2
Array numOut, 4
Array savePoint, 20*2
heapByte Error, "  G:Error :: "
heapByte openError, "Cannot open input file."
heapByte readError, "cannot read. input file missing."
heapByte writeError, "no given buffer to write or missing handle."
heapByte closeError, "no files to close."

Array parnthesis, 256
Array secondParanthesis, 256
Array line, 256
Array junk, 256
Array variables, 256*12              ;if we assume that each variable name is 12 bytes long
Array lineOffset, 32                 ;32 bit address
Array ParanthesisAmount, 32          ;store here for parathesis amout in oe line.
Array mathL, 256
Array mathR, 256