# Ultrasonic Screwdriver

by C.Y. Tan 2023


The Ultrasonic Screwdriver is built in the spirit of a Dr Who Sonic
Screwdriver. I made this screw driver that actually does actual, real
measurements rather than simply a prop.

![Ultrasonic Scewdriver](https://github.com/cytan299/Ultrasonic_Screwdriver/blob/main//pics/ultrasonic_screwdriver.jpg)

In my design, the heart of the ultrasonic screwdriver is the [ESP32-S3 reverse TFT
Feather](https://www.adafruit.com/product/5691) made by Adafruit. The
ESP32-S3 contains dual cores running at 240 MHz and it  has 4 MB Flash
and 2 MB PSRAM of memory. Adafruit also added a colour 1.14 inch TFT
with 240x130 pixels. This makes the ESP-32 reverse TFT the ideal
microcontroller for the Ultrasonic Screwdriver.  The devices that the
Ultrasonic Screwdriver contains are as follows which are all availalble
from Adafruit:
* **Ultrasonic** range finder which makes it possible for me to call
  my screwdriver the Ultrasonic. The ultrasonic range finder is made
  by [MaxBotix](https://www.adafruit.com/product/983).
* **Torch** to light up the darkness. Torch uses the [Neopixel 12x5050
  RGBW LEDs](https://www.adafruit.com/product/2851).
* **Thermal camera** which measures the temperature of objects using
  IR. The thermal camera is made by
  [Melexis](https://www.adafruit.com/product/4469). _It's great for
  scanning hot alien devices_.
* **WIFI** scanner that uses the built in [WIFI circuitry](https://learn.adafruit.com/esp32-s3-reverse-tft-feather/wifi-test) in the
  ESP32-S3 to _"smell" the air_.
* **IR TV transmitter** uses the [RMT (remote control
  transceiver)](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/peripherals/rmt.html)
   built into the ESP32-S3 for controlling the TV using NEC codes. _Or
  to open alien doors_.
* **Sound** ESP32-S3 sends sound bytes to the [I2S 3W class D
  amplifer](https://www.adafruit.com/product/3006) for sound generation.
* **Animal zapper** combines the ultrasonic range finder that transmits
  ultrasound at 42 kHz in free-run mode, the rainbox lights from
  the Neopixel Ring and the Ultrasonic Screwdriver sound to scare
  animals or _blow up Daleks_ :)
  
The Ultrasonic Screwdriver can also be flcked or slid open to reveal the
user screen and control buttons. 

The only thing the Ultrasonic Screwdriver cannot do is that it is
definitely **not** a screwdriver :)

## Copyright

All the software, documentation, hardware designs that I have written is
copyright 2023 C.Y. Tan.

All software is released under GPLv3




