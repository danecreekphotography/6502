; Implements the long and inefficient "hello world" assembly
; program from https://www.youtube.com/watch?v=FY3zTUaykVo
E = %00000001
RW = %01000000
RS = %00100000

LCD_FUNCTION_SET        = %00100000 ; Set display functions
LCD_FUNCTION_1_LINE     = %00000000 ; 1-line display
LCD_FUNCTION_2_LINE     = %00001000 ; 2-line display
LCD_FUNCTION_5x8_FONT   = %00000000 ; 5x8 dots font
LCD_FUNCTION_5x10_FONT  = %00000100 ; 5x10 dots font
LCD_FUNCTION_8_BIT      = %00010000 ; 8-bit mode
LCD_FUNCTION_4_BIT      = %00000000 ; 4-bit mode

      .setcpu "65C02"
      .include "via.inc"

      .segment "VECTORS"

      .word   $eaea
      .word   init
      .word   $eaea

      .code

init:
      lda #(E | RW | RS) ; Set VIA2 Port A output pins to output
      sta VIA2_DDRA
      lda #%11111111     ; Set all pins on VIA2 Port B to output
      sta VIA2_DDRB

      lda #%00111000    ; Set 8-bit mode, 2-line display, 5x8 font
      sta VIA2_PORTB
      stz VIA2_PORTA    ; Clear RS/RW/E bits
      inc VIA2_PORTA    ; Toggle E bit
      dec VIA2_PORTA
      
      lda #%00001110    ; Display on; cursor on; blink off
      sta VIA2_PORTB
      stz VIA2_PORTA    ; Clear RS/RW/E bits
      inc VIA2_PORTA    ; Toggle E bit
      dec VIA2_PORTA

      lda #%00000110    ; Increment and shift cursor; don't shift display
      sta VIA2_PORTB
      stz VIA2_PORTA    ; Clear RS/RW/E bits
      inc VIA2_PORTA    ; Toggle E bit
      dec VIA2_PORTA

      lda #('H')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      inc VIA2_PORTA    ; Toggle E bit
      dec VIA2_PORTA

      lda #('e')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      inc VIA2_PORTA    ; Toggle E bit
      dec VIA2_PORTA

      lda #('l')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      inc VIA2_PORTA    ; Toggle E bit
      dec VIA2_PORTA

      lda #('l')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      inc VIA2_PORTA    ; Toggle E bit
      dec VIA2_PORTA

      lda #('o')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      inc VIA2_PORTA    ; Toggle E bit
      dec VIA2_PORTA

      lda #(',')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      inc VIA2_PORTA    ; Toggle E bit
      dec VIA2_PORTA

      lda #(' ')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      inc VIA2_PORTA    ; Toggle E bit
      dec VIA2_PORTA

      lda #('w')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      inc VIA2_PORTA    ; Toggle E bit
      dec VIA2_PORTA

      lda #('o')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      inc VIA2_PORTA    ; Toggle E bit
      dec VIA2_PORTA

      lda #('r')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      inc VIA2_PORTA    ; Toggle E bit
      dec VIA2_PORTA

      lda #('l')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      inc VIA2_PORTA    ; Toggle E bit
      dec VIA2_PORTA

      lda #('d')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      inc VIA2_PORTA    ; Toggle E bit
      dec VIA2_PORTA

      lda #('!')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      inc VIA2_PORTA    ; Toggle E bit
      dec VIA2_PORTA

loop:
      jmp loop