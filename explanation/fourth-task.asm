section .data
  num: dd 133
  multiplier: dd 10
  summand: dd 10

section .bss
  buffer resb 20

section .text
  global _start

  scan_int:
    mov eax, 133
    ret

  ; ф-ция сложения
  add_ten_to_num:
    mov eax, [num]
    mov ebx, [multiplier]
    add eax, ebx
    ret

  ; ф-ция умножения
  multiply_ten_to_num:
    mov eax, [num]
    mov ebx, [summand]
    mul ebx
    ret

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
      mov eax, ecx
      xor edx, edx
      div esi
      mov ecx, eax
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
  call scan_int

  push eax
  call print_int

  mov eax, 1
  mov ebx, 0;
  int 0x80;