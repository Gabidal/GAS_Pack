openErr:
  append Error, openError, 23
  sout Error
jmp endCompile

readErr:
  append Error, readError, 32
  sout Error
jmp endCompile

writeErr:
  append Error, writeError, 43
  sout Error
jmp endCompile


closeErr:
  append Error, closeError, 18
  sout Error
jmp endCompile