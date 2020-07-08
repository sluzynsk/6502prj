CC=cl65

eprom: eprom.asm
	$(CC) -C eprom.cfg eprom.asm

flash: eprom
	minipro -p at28c256 -w eprom