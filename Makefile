CC=cl65

eprom: eprom.asm
	$(CC) -C eprom.cfg eprom.asm
