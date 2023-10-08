# ESP32 Ultrasonic Screwdriver Software

by C.Y. Tan 2023

This is the source code for the ESP32-S3 Ultrasonic Screwdriver
software. This software has been successfully compiled under Arduino
IDE 2.2.1. Instructions for enabling the Arduino IDE for compiling the
ESP32 can be found
[here](https://learn.adafruit.com/esp32-s3-reverse-tft-feather/arduino-ide-setup-2). This
program utilizes the dual core of the ESP32-S3 by splitting the tasks
between a master and a slave on each CPU. Communications between
master and slave is with [FreeTOS](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/system/freertos.html):
* **ultrasonic_screwdriver.ino** is the master program. It directly
controls
    * **Menu** system and user input.
	* **TV** IR control
    * **Sound** of the Ultransonic Screwdriver.
From the user selection of the menu items, it send messages to the slave program. The
tasks that the slave program executes are listed  below. 
* **slave.ino** is the slave that listens to the master program and
  executes its commands for the following devices:
    * **Torch** on/off
	* **Thermal camera** display
	* **Sonic** ultrasound range finder display
	* **WIFI** scan and display
	* **Battery status** display.
	* **About** copyright and version display.
The following are the support programs used by both
_ultrasonic_screwdriver.ino_ and _slave.ino_:
* **IR_TX.cpp** and **IR_TX.hpp** are the IR transmitter class that
  utilizes the ESP32-S3 onboard RMT (remote control transceiver) to
  produce NEC codes for TV control. The code here is for VIZIO TVs
  other codes for your TV is easily found in this
  [database](https://github.com/probonopd/irdb/tree/master).
* **audio.io** is the audio program that contains the Ultrasonic
  Screwdriver sound bytes that were created by me.
  
The following are programs that have been copied from the web and are
copyright by their respective authors. Here are the two programs that
are used:
* **ring_meter.ino** for displaying the ultransonic range finder
  results.
* **wheel.ino** for displaying the rainbow colours on the NeoPixel
  ring.

## Copyright

All the software that I have written is
copyright 2023 C.Y. Tan.

All software is released under GPLv3.
