#//;NOTE! USE THE
#//;ASSEMBLER THAT SUIT'S
#//;YOU'RE OS!
#//;THESE ARE THE ONES
#//;THAT U CAN USE:
#//;-YASM
#//;-MASM
#//;-TASM
#//;-NASM
#//;AND REMEMBER TO USE
#//;LINKER FOR YOU'RE OS
#//;TOO!

#//;INCLUDE YOU'RE
#//;DIRECTORY OS
cd Dos/
#//;SKIP THIS IF YOU DONT
#//;WANT TO MODIFY GAS
#//;COMPILER!
yasm -f elf -o Gas.o Gas.asm
#//;NOW IF YOU HAVE
#//;MODIFIED GAS OR NOT DO
#//;THIS!
linker -f bin -o Gas.exe Gas.o
#//;CONGRATULATION YOU
#//;HAVE NOW WORKING GAS
#//;COMPILER
#//;now Gas assumes that
#//;the main.g file is in the
#//;same directory as you're
#//;Gas compiler!
Gas.exe 
#//;AND THAT'S IT! YOU'RE
#//;CODE HAS NOW
#//;TRANSFORMED TO ASM
#//;SYNTAX FORMAT! 
yasm -f elf -o main.o main.asm
linker -f bin -o main.exe main.o
#//;NOW YOU'RE CODE IS IN
#//;MACHINE LEVEL AS
#//;EXECUTABLE!

#//;DIDN'T FIND ASSEMBLER
#//;FOR YOU'RE OS?
#//;DO THIS THEN!
#//;-FIND ASSEMBLER THAT
#//;COMPILES FOR YOU'RE OS
#//;BINARY FORMAT
#//;-FIND LINKER THAT MAKES
#//;THAT BINARY FORMAT TO
#//;EXECUTABLE
#//;-DO THE INSTRUCTIONS
#//;BUT WHIT PARAMETERS
#//;THAT YOU'RE OS SUPPORT'S