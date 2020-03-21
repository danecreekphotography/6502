      .setcpu "65C02"
      .include "via.inc"

      .segment "VECTORS"

      .word   $eaea
      .word   init
      .word   $eaea

      .code

init:
      lda #$ff
      sta VIA2_DDRB
      lda #%11110000
      sta VIA2_PORTB

loop:
      ror 
      sta VIA2_PORTB
      jmp loop
