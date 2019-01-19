ifSum:
  
  
  jmp nextInstruction
  
ifSub:
  
  
  jmp nextInstruction
  
ifDiv:
  
  
  jmp nextInstruction
  
ifMul:


  jmp nextInstruction
  
ifInt:
  cmp ax, 0

    
    
  jmp nextInstruction
  
ifChar:
  
  
  jmp nextInstruction
  
ifSetTo:
  
  
  
  jmp nextInstruction
  
  
  
  firstAsIdentity:
    strcmp nullPointer, oxyValue
      je IsZero
  jne IsNotZero
  IsZero:
    
  
  IsNotZero:
    
    
    
    
    