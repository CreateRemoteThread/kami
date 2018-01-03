# kami
he's a lot like me, that masterless little kami...

This code is designed for use with the Digilent Arty board. clk_wiz_0 is a
 clocking wizard at a speed of whatever you want.

* sw0 is to enable glitching
* sw1 enables sweeping for the length of the glitch (it loops to 5'b11111)
* sw2 off means the glitch output is 11111, on is for 10101
* ld4 toggles every time a glitch is fired (i.e. ctr[29] is 1)
* ld5 toggles every time you complete a glitch sweep (0 to 5'b11111)
* ld6 is wired to sw2 so i could glitch in the dark

use at your own discretion. good luck.