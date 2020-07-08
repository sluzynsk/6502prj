				.setcpu "6502"

				ACIA_DATA = $0000
				ACIA_STATUS = $0001
				ACIA_COMMAND = $0002
				ACIA_CONTROL = $0003

				.segment "VECTORS"

				.word nmi
				.word reset
				.word irq

				.code

reset:			jmp main

nmi:			rti

irq:			rti

main:
init_acia:		lda #%00001011
				sta ACIA_COMMAND
				lda #%00011111
				sta ACIA_CONTROL

write:			ldx #0
next_char:	
wait_txd_empty:	lda ACIA_STATUS
				and #$10
				beq wait_txd_empty
				lda text,x
				beq read
				sta ACIA_DATA
				inx
				jmp next_char

read:
wait_rxd_full:	lda ACIA_STATUS
				and #$08
				beq wait_rxd_full
				lda ACIA_DATA
				jmp write

text:			.byte "Hello, World!", $0d, $0a, $00
