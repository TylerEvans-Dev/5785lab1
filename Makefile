hello.txt:
	echo "hello world!" > hello.txt

CPP=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-cpp

all: firmware.elf

main.i: main.c
	$(CPP) main.c > main.i

clean:
	rm -f main.i hello.txt
	rm -f main.s main.o
	rm -f main.exe
	rm -f second.c
	rm -f second.o

CC=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-gcc
AS=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-as

%.o: %.s
	$(AS) $< -o $@

LD=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-gcc
SRC=main.c second.c
OBJS=$(patsubst %.c,%.o,$(SRC))

firmware.elf: $(OBJS)
	$(CC) -o $@ $^

.PHONY: all clean
