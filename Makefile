ASM_SOURCES = zeropage.s65 interrupt.s65 startup.s65 

%.o: %.s65
	ca65 --cpu 6502 -o $@ -l $(@:.o=.lst) $<

all: eprom

eprom: $(ASM_SOURCES:.s65=.o)
	cl65 -C eprom.cfg -m eprom.map -o $@ $^

flash: eprom
	minipro -p at28c256 -w eprom

clean: 
	rm eprom *.o *.map *.s *.lst