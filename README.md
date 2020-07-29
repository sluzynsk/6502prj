# 6502prj
Firmware for my hand built 6502 based 8 bit microcomputer

(C) 2020 Steven Luzynski <steve@luzynski.net>

The beginnings of this are taken with appreciation from Dirk Grappendorf's excellent [devblog]: https://www.grappendorf.net/projects/6502-home-computer/.

Quite some divergence will occur along the road as I intend to figure out a
USB keyboard and a video display system of some sort and avoid all the
serial I/O business so popular in homebrew 8 bit micros.

Real project name will come when I'm inspired.

```
Memory Map:
$0000 - 00FF: Zero Page
$0100 - 01ff: Stack
$0200 - 020f: IO Device 1
$0210 - 021f: IO Device 2
$0220 - 022f: IO Device 3
$0230 - 023f: IO Device 4
$0240 - 02ff: empty
$0300 - 7fff: RAM
$8000 - ffff: ROM
```

Utilizing Daryl Rictors's [memory decoder]: http://sbc.rictor.org/decoder.html
 SPLD design to map memory without needing eleventy billion 74xx chips. One ATF22V10C is a much better option.


