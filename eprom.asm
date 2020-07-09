				.setcpu "6502"

				# Peripheral ports in groups of 32 ($20)

				# ACIA0 Ports start at $7f00
				ACIA_DATA = $7f00
				ACIA_STATUS = $7f01
				ACIA_COMMAND = $7f02
				ACIA_CONTROL = $7f03

				# VIA0 Ports start at $7f20
				VIA_PORTA = $7f21
				VIA_PORTB = $7f20
				VIA_DDRA = $7f23
				VIA_DDRB = $7f22

				# VIA Control words
				VIA_E  = %10000000
				VIA_RW = %01000000
				VIA_RS = %00100000 

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
