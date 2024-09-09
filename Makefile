all: firmware.elf
hello.txt:
	echo "hello world!" > hello.txt

CPP=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-cpp



main.i: main.c
	$(CPP) main.c > main.i
second.i: second.c
	$(CPP) second.c > second.i

clean:
	rm -f main.i hello.txt
	rm -f main.s main.o
	rm -f main.exe
	rm -f main.i
	rm -f main.s
	rm -f second.i
	rm -f second.s
	rm -f second.o
	#rm -f firmware.elf

CC=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-gcc
AS=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-as

main.s: main.i
	$(CC) -S main.i

main.o: main.s 
	$(AS) main.s -o main.o
	
second.s: second.i
	$(CC) -S second.i

second.o: second.s
	$(AS) second.s -o second.o

#%.o: %.s
#	$(AS) $< -o $@

LD=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-ld
SRC=main.c second.c
OBJS=$(patsubst %.c,%.o,$(SRC))

firmware.elf: $(OBJS)
	$(LD) -o $@ $^


.PHONY: all clean
