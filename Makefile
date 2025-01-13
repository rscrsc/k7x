#CFLAGS = -Wall -O0 -ffreestanding -nostdinc -nostdlib -nostartfiles
CFLAGS := -no-pie -v -Wall -Wextra
CFLAGS += -ffreestanding -nostdlib
LDFLAGS := -Wl,--fatal-warnings
#LDFLAGS += -Wl,-T link.ld
SESSION_NAME = k7x

all:
	docker run --rm -v "$$PWD":/root -w /root llvmasm /bin/bash -c '\
	as boot.s -o build/boot.o; \
	as init.S -o build/init.o; \
	clang $(CFLAGS) $(LDFLAGS) build/boot.o build/init.o -o build/k7x.elf; \
	objcopy -O binary -j .text -j .data build/k7x.elf build/k7x.img'

dbg:
	@screen -dmS $(SESSION_NAME)  qemu-system-aarch64 -M raspi3b -kernel build/k7x.img -s -S
	@screen -S $(SESSION_NAME) -X screen lldb --source gdb-remote.txt
	@screen -r $(SESSION_NAME)
