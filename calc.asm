global _start 

section .data 
   message db 0dh,0ah,0dh,0ah, "******************** Welcome to the calculator! ******************** " , 0dh,0
   message_len equ $-message
   choice db "Make choice: " ,0dh , 0ah
   choice_len equ $-choice
   operator db "1.ADD" , 0dh,0ah,"2.SUBSTRACT" , 0dh,0ah,"3.MULTIPLY" , 0dh,0ah,"4. Divide" , 0dh,0ah,"5.EXIT" , 10
   operator_len equ $-operator
   tmp: db 0,0
   first_number db "Enter first number: " , 0dh,0ah
   first_number_len equ $-first_number
   second_number db "Enter first number: " , 0dh,0ah
   second_number_len equ $-second_number
   first_temp: db 0,0
   second_temp: db 0,0
   answer db " Answer of ", 0ah, 0dh
   answer_len equ $-answer
   plus db " + " , 0ah , 0dh
   plus_len equ $-plus
   equal db " = ", 0ah , 0dh
   equal_len equ $-equal

section .text

   _start:
     
 messageSend:
     mov rax , 0x1
     mov rdi , 1
     mov rsi , message
     mov rdx , message_len
     syscall
     ret
 choiceG:
     mov rax , 0x1
     mov rdi , 1
     mov rsi , choice
     mov rdx , choice_len
     syscall
     ret
 operatorG:
     mov rax , 0x1
     mov rdi , 1
     mov rsi , operator
     mov rdx , operator_len
     syscall
     ret
 ADD:
    mov rax , 0x1
    mov rdi, 1
    mov rsi , first_number
    mov rdi , first_number_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi , first_temp
    mov rdx , 2
    syscall
    mov r8 , first_temp

     mov rax , 0x1
    mov rdi, 1
    mov rsi , second_number
    mov rdi , second_number_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi , second_temp
    mov rdx , 2
    syscall
    mov r9, second_temp

    push r8
    push r9

    mov r8 , [first_temp]
    mov r9 , [second_temp]
    sub r8 , 48
    sub r9 , 48

    mov r10 , r8
    add r10, r9

    pop r9
    pop r8

    add r10, 48

    mov rax , 0x1
    mov rdi , 1 
    mov rsi , answer
    mov rdx , answer_len
    syscall

    mov rax , 0x1
    mov rdi , 1
    mov rsi, r8
    mov rdx, 1
    
    mov rax , 0x1
    mov rdi , 1 
    mov rsi , plus
    mov rdx ,plus_len
    syscall

     mov rax , 0x1
    mov rdi , 1
    mov rsi, r9
    mov rdx, 1

    mov rax , 0x1
    mov rdi , 1 
    mov rsi , equal
    mov rdx ,equal_len
    syscall

    mov [rsp+8], r10

    mov rax , 0x1
    mov rdi , 1
    mov rsi ,[rsp+8]
    mov rdx, 1
    syscall
    jmp LOOP

  EXIT: 
    mov rax , 60
    mov rdi ,0
    syscall
    sysexit

  get_input:
     mov rax , 0
     mov rdi , 0 
     mov rsi , tmp
     mov rdx, 2
     syscall  
  compare_input: 
     cmp byte[rsi] , '1'
     je ADD    
     cmp byte[rsi] , '2'
     je EXIT
 LOOP: 
     call messageSend
     call choiceG
     call operatorG
     call get_input
     call compare_input
     jmp LOOP
   
