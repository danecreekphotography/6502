# Long and inefficient "Hello World"

This code implements the long and inefficient "hello world" example from
Ben's [Connecting an LCD to our computer - 6502 part 4](https://www.youtube.com/watch?v=FY3zTUaykVo) video.

To follow Ben's video the LCD must be connected using VIA2 instead of the LCD Connector.
Use an external breadboard and map the VIA2 pins to the LCD as follows:

| VIA2 Pin | LCD Pin  |
| -------- | -------- |
| PA GND   | 1 and 16 |
| PA +5V   | 2 and 15 |
| PA5      | 4        |
| PA6      | 5        |
| PA7      | 6        |
| PB0      | 7        |
| PB1      | 8        |
| PB2      | 9        |
| PB3      | 10       |
| PB4      | 11       |
| PB5      | 12       |
| PB6      | 13       |
| PB7      | 14       |

Additionally connect pin `V0` of the LCD connector to pin `3` of the LCD. This enables the LCD contrast potentiometer to control the contrast of the LCD.

The assembly code is functionally the same as Ben's version however the addresses used to write data to the VIA are slightly different. Thankfully defines from `via.inc` make it easy!
