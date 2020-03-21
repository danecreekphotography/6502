; Implements the long and inefficient "hello world" assembly
; program from https://www.youtube.com/watch?v=FY3zTUaykVo
E = %10000000
RW = %01000000
RS = %00100000

      .setcpu "65C02"
      .include "via.inc"

      .segment "VECTORS"

      .word   $eaea
      .word   init
      .word   $eaea

      .code

init:
      lda #%11100000    ; Set top three pins on VIA2 Port A to output
      sta VIA2_DDRA
      lda #%11111111    ; Set all pins on VIA2 Port B to output
      sta VIA2_DDRB

      lda #%00111000    ; Set 8-bit mode, 2-line display, 5x8 font
      sta VIA2_PORTB
      lda #0            ; Clear RS/RW/E bits
      sta VIA2_PORTA
      lda #E            ; Set E bit to send instruction
      sta VIA2_PORTA
      lda #0            ; Clear RS/RW/E bits
      sta VIA2_PORTA
      
      lda #%00001110 ; Display on; cursor on; blink off
      sta VIA2_PORTB
      lda #0         ; Clear RS/RW/E bits
      sta VIA2_PORTA
      lda #E         ; Set E bit to send instruction
      sta VIA2_PORTA
      lda #0         ; Clear RS/RW/E bits
      sta VIA2_PORTA

      lda #%00000110 ; Increment and shift cursor; don't shift display
      sta VIA2_PORTB
      lda #0         ; Clear RS/RW/E bits
      sta VIA2_PORTA
      lda #E         ; Set E bit to send instruction
      sta VIA2_PORTA
      lda #0         ; Clear RS/RW/E bits
      sta VIA2_PORTA

      lda #('H')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      lda #(RS | E)   ; Set E bit to send instruction
      sta VIA2_PORTA
      lda #RS         ; Clear E bits
      sta VIA2_PORTA

      lda #('e')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      lda #(RS | E)   ; Set E bit to send instruction
      sta VIA2_PORTA
      lda #RS         ; Clear E bits
      sta VIA2_PORTA

      lda #('l')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      lda #(RS | E)   ; Set E bit to send instruction
      sta VIA2_PORTA
      lda #RS         ; Clear E bits
      sta VIA2_PORTA

      lda #('l')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      lda #(RS | E)   ; Set E bit to send instruction
      sta VIA2_PORTA
      lda #RS         ; Clear E bits
      sta VIA2_PORTA

      lda #('o')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      lda #(RS | E)   ; Set E bit to send instruction
      sta VIA2_PORTA
      lda #RS         ; Clear E bits
      sta VIA2_PORTA

      lda #(',')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      lda #(RS | E)   ; Set E bit to send instruction
      sta VIA2_PORTA
      lda #RS         ; Clear E bits
      sta VIA2_PORTA

      lda #(' ')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      lda #(RS | E)   ; Set E bit to send instruction
      sta VIA2_PORTA
      lda #RS         ; Clear E bits
      sta VIA2_PORTA

      lda #('w')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      lda #(RS | E)   ; Set E bit to send instruction
      sta VIA2_PORTA
      lda #RS         ; Clear E bits
      sta VIA2_PORTA

      lda #('o')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      lda #(RS | E)   ; Set E bit to send instruction
      sta VIA2_PORTA
      lda #RS         ; Clear E bits
      sta VIA2_PORTA

      lda #('r')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      lda #(RS | E)   ; Set E bit to send instruction
      sta VIA2_PORTA
      lda #RS         ; Clear E bits
      sta VIA2_PORTA

      lda #('l')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      lda #(RS | E)   ; Set E bit to send instruction
      sta VIA2_PORTA
      lda #RS         ; Clear E bits
      sta VIA2_PORTA

      lda #('d')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      lda #(RS | E)   ; Set E bit to send instruction
      sta VIA2_PORTA
      lda #RS         ; Clear E bits
      sta VIA2_PORTA

      lda #('!')
      sta VIA2_PORTB
      lda #RS         ; Set RS; Clear RW/E bits
      sta VIA2_PORTA
      lda #(RS | E)   ; Set E bit to send instruction
      sta VIA2_PORTA
      lda #RS         ; Clear E bits
      sta VIA2_PORTA

loop:
      jmp loop