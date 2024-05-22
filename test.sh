nasm -f elf main-float.asm
ld -m elf_i386 -s -o main main-float.o
rm main-float.o
./main
rm main