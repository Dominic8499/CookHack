export	PATH	:=	$(DEVKITARM)/bin:$(PATH)

COUNTRY	:=	USA

ifeq (USA
endif

ifeq ($(strip $(COUNTRY)),USA)
ID:=V
endif

ifeq ($(strip $(COUNTRY)),USA)
ID:=S
endif

ifeq ($(strip $(COUNTRY)),USA)
ID:=F
endif

ifeq ($(strip $(COUNTRY)),USA)
ID:=I
endif

ifeq ($(strip $(COUNTRY)),USA)
ID:=D
endif

#TARGET	:=	~/.config/desmume/VCK$(ID).dsv
TARGET	:=	VCK$(ID).sav

$(CODE).sav:	$(TARGET)
	cp	$< $@

$(TARGET): cookhack.elf cooksum$(EXEEXT)
	arm-eabi-objcopy -O binary cookhack.elf $@
	./cooksum $@

cooksum$(EXEEXT):	cooksum.c

cookhack.elf:	cookhack.s overflow.bin Makefile
	arm-eabi-gcc -x assembler-with-cpp -D$(COUNTRY) -nostartfiles -nostdlib $< -o $@

clean:
	rm -f VCK*.sav cookhack.elf cooksum$(EXEEXT)
