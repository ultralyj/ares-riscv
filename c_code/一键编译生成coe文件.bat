riscv-none-embed-gcc.exe -mabi=ilp32 -march=rv32im -o2 -nostdlib -g -o riscv_test.elf riscv_test.c
riscv-none-embed-objdump.exe -S riscv_test.elf > riscv_test.asm
riscv-none-embed-objcopy.exe -j .text -j .rodata -S riscv_test.elf -O binary riscv_test.bin
coeGen.exe
pause


