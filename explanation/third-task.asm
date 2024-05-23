section .data
  str1 db 'Here is string 1', 0x0A
  str1_len equ $ - str1

  pi dw 0x123d
  ksi dd 0x12345678
  ksi2 dd 'acde'

section .bss
  mem resb 12800

section .text
  global _start

  print_hex:
    push ebp
    mov ebp, esp
    sub esp, 8h
    mov ecx, [ebp+8]
    mov esi, 8

    .loop:
      mov eax, ecx
      and eax, 0xf
      cmp al, 9
      jle .print_decimal

    .print_hex:
      sub al, 10
      add al, 'a'
      jmp .print1

    .print_decimal:
      add al, '0'

    .print1:
      dec esi
      mov byte [esp+esi], al
      shr ecx, 4
      jz .ret
      jmp .loop
    
    .ret:
      mov eax, 4
      mov ebx, 1
      mov ecx, esp
      mov edx, 8
      int 80h
      leave
  
  ret

_start:
  mov eax, 4
  mov ebx, 1
  mov ecx, str1
  mov edx, str1_len
  int 80h

  mov ecx, str1_len
  
  .l:
    mov esi, ecx
    mov al, byte [str1+esi]
    mov byte [mem+esi], al
    
  loop .l
    mov eax, 4
    mov ebx, 1
    mov ecx, mem
    mov edx, str1_len
    int 80h
    push 1234abc1h
    call print_hex

    mov eax, 1
    mov ebx, 0
    int 80h
