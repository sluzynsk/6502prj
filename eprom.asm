				.setcpu "6502"

				ACIA_DATA = $7f00
				ACIA_STATUS = $7f01
				ACIA_COMMAND = $7f02
				ACIA_CONTROL = $7f03

				.segment "VECTORS"

				.word nmi
				.word reset
				.word irq

				.data
string_data:

				.code

reset:			jmp main

nmi:			rti

irq:			rti

main:
init_acia:		lda #%00001011
				sta ACIA_COMMAND
				lda #%00011111
				sta ACIA_CONTROL

				ldx #$ff
copy_string:	inx
				lda text,x
				sta string_data,x
				bne copy_string

write:			ldx #0
next_char:	
wait_txd_empty:	lda ACIA_STATUS
				and #$10
				beq wait_txd_empty
				lda string_data,x
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
