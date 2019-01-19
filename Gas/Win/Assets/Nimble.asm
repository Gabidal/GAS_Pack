tryCatch NotError, jmp
Error:
  sout Gnotice
  sout errorS
  jmp EOccurred
endNotError: