section .data
  num1 dd 2
  num2 dd 1

segment .bss
  buffer resb 20

section .text
  global _start

  print_int:
    push ebp
    mov ebp, esp
    mov ecx, [ebp+8]
    xor edx, edx
    mov esi, 10
    mov edi, 18
    mov byte [buffer + 18], 0xA
    mov byte [buffer + 19], 0

    .loop:
      mov eax, ecx;
      xor edx, edx
      div esi
      mov ecx, eax;

    add edx, '0'
    dec edi
    mov byte [buffer+edi], dl
    cmp ecx, 0
    jne .loop

    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    add ecx, edi
    mov edx, 19
    sub edx, edi
    int 0x80

    leave
    ret

_start:
  mov ecx, [num1]
  cmp ecx, [num2]
  jb  _exit
  mov ecx, [num2]

_exit:
  push ecx
  call print_int

  mov eax, 1
  int 0x80


