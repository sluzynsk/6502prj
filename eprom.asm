	.setcpu "6502"
	.segment "VECTORS"

	.word loop
	.word loop
	.word loop

	.code
loop:	lda #$12
	jmp loop
