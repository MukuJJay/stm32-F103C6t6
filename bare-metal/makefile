CC = arm-none-eabi-gcc
MACH = cortex-m4
CFLAGS = -c -mcpu=$(MACH) -mthumb -std=gnu2x -Wall -O0
LDFLAGS = -nostdlib -T stm32F401CC.ld -Wl,-Map=final.map

all:main.o led.o stm32F401CC_startup.o final.elf

main.o:main.c
	$(CC) $(CFLAGS) -o $@ $^

led.o:led.c
	$(CC) $(CFLAGS) -o $@ $^

stm32F401CC_startup.o:stm32F401CC_startup.c
	$(CC) $(CFLAGS) -o $@ $^

final.elf:main.o led.o stm32F401CC_startup.o
	$(CC) $(LDFLAGS) -o $@ $^

clean:
	rm -rf *o *elf *map

load:
	openocd -f /usr/share/openocd/scripts/interface/stlink-v2.cfg -f /usr/share/openocd/scripts/target/stm32f4x.cfg