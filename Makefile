CFLAGS = -Wall -O0 -ffreestanding -nostdinc -nostdlib -nostartfiles
SESSION_NAME = k7x

all:
	aarch64-none-elf-gcc -c boot.s $(CFLAGS) -o build/boot.o
	aarch64-none-elf-gcc -c main.c $(CFLAGS) -o build/main.o
	aarch64-none-elf-ld -nostdlib build/boot.o build/main.o -T link.ld -o build/k7x.elf
	aarch64-none-elf-objcopy -O binary build/k7x.elf build/k7x.img

dbg:
	@screen -dmS $(SESSION_NAME)  qemu-system-aarch64 -M raspi3b -kernel build/k7x.img -s -S
	@screen -S $(SESSION_NAME) -X screen lldb --source gdb-remote.txt
	@screen -r $(SESSION_NAME)
