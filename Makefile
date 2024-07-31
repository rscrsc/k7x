CFLAGS = -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles

all:
	aarch64-none-elf-gcc -c boot.s $(CFLAGS) -o build/boot.o
	aarch64-none-elf-ld -nostdlib build/boot.o -T link.ld -o build/k7x.elf
	aarch64-none-elf-objcopy -O binary build/k7x.elf build/k7x.img
	qemu-system-aarch64 -M raspi3b -kernel build/k7x.img -s -S

dbg:
	lldb --source gdb-remote.txt