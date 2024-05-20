FROM alpine:latest as build

WORKDIR /app

COPY ./main.asm .

RUN apk add --no-cache binutils nasm

RUN nasm -f elf main.asm
RUN ld -m elf_i386 -s -o main main.o

FROM scratch

WORKDIR /app

COPY --from=build /app/main .

ENTRYPOINT [ "./main" ] 