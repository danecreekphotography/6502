      .include "via.inc"
      .include "zeropage.inc"
      .include "utils.inc"
      .export _keyboard_init
      .export _handle_keyboard_irq
      .export _keyboard_is_connected
      .export _keyboard_is_data_available
      .export _keyboard_read_char

KEYBOARD_BUFFER_SIZE = 64

; No parameters taken
; No registers changed
; No output values
_keyboard_init:
      pha
      ; Assume keyboard is disconnected
      lda #$00
      sta keyboard_conn
      ; Reset buffer pointers
      stz keyboard_rptr
      stz keyboard_wptr
      ; VIA1 PORTA is all input
      stz VIA1_DDRA
      ; Init PORTA
      stz VIA1_PORTA
      ; Setup read handshake on VIA2 CA1/CA2
      ; Clear CA1/CA2 flags first
      lda VIA1_PCR
      and #$0f
      ; Enable read handshake
      ora #(VIA_PCR_CA1_INTERRUPT_NEGATIVE | VIA_PCR_CA2_OUTPUT_PULSE | VIA_PCR_CB1_INTERRUPT_NEGATIVE | VIA_PCR_CB2_OUTPUT_HIGH)
      sta VIA1_PCR
      ; Enable interrupt from VIA2 on CA1 (Data ready)
      lda #(VIA_IER_SET_FLAGS | VIA_IER_CA1_FLAG)
      sta VIA1_IER
      ; Restore state of A register
      pla
      rts

; Writes data to keyboard buffer and updates pointers
; All registers preserved
_handle_keyboard_irq:
      pha
      ; Read code from keyboard controller
      lda VIA1_PORTA
      ; Handle connection signal
      cmp #$ff
      beq @keyboard_connected
      ; Handle disconnection signal
      cmp #$fe
      beq @keyboard_disconnected
      ; Handle regular scancode
      ; Preserve X register
      phx
      ; Load current pointer
      ldx keyboard_wptr
      ; Store character
      sta keyboard_buffer,x
      ; Increase pointer
      inx
      ; Check if overflow
      cpx #(KEYBOARD_BUFFER_SIZE)
      bne @store_new_pointer
      ; Move to beginning then
      ldx #$00
      ; Update pointer value
@store_new_pointer:
      stx keyboard_wptr
      ; Restore X register
      plx
      ; Handling completed
      bra @handling_done
      ; Store keyboard flag
@keyboard_connected:
      lda #$80
      sta keyboard_conn
      ; Handling completed
      bra @handling_done
      ; Store keyboard flag
@keyboard_disconnected:
      stz keyboard_conn
@handling_done:
      ; Restore A register
      pla
      ; Done, return
      rts

; Returns connection status in Carry flag
; 1 - connected
; 0 - disconnected
_keyboard_is_connected:
      clc
      bit keyboard_conn
      bmi @keyboard_connected
      rts
@keyboard_connected:
      sec
      rts

; Returns status in Carry flag
; 1 - new characters available
; 0 - no new characters available
_keyboard_is_data_available:
      pha
      lda keyboard_wptr
      cmp keyboard_rptr
      beq @no_data
      sec
      bra @check_completed
@no_data:
      clc
@check_completed:
      pla
      rts

; Returns single scancode in A register
; No other registers affected
_keyboard_read_char:
      ; Preserve X register
      phx
      ; Compare pointers
      ldx keyboard_rptr
      cpx keyboard_wptr
      bne @read_data
      ; No data
      lda #$00
      plx
      rts
@read_data:
      lda keyboard_buffer,x
      inx
      ; Check if overflow
      cpx #(KEYBOARD_BUFFER_SIZE)
      bne @store_new_pointer
      ; Move to beginning then
      ldx #$00
      ; Update pointer value
@store_new_pointer:
      stx keyboard_rptr
      ; Restore X register
      plx
      ; Handling completed
      rts

      .segment "BSS"
keyboard_buffer:
      .res KEYBOARD_BUFFER_SIZE