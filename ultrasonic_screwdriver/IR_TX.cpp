/*$Id$*/
/*
    ir_tx is part of the controller code for the Adafruit ESP32-S3
    reverse TFT Feather
    Copyright (C) 2023 C.Y. Tan
    Contact: cytan299@yahoo.com

    This file is part of ultrasonic_screwdriver

    ir_tx is free software: you can redistribute it
    and/or modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation, either version 3 of
    the License, or (at your option) any later version.

    ir_tx is distributed in the hope that it will be
    useful, but WITHOUT ANY WARRANTY; without even the implied
    warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with ir_tx.  If not, see
    <http://www.gnu.org/licenses/>.

*/

/* operating system header files (use <> for make depend) */


// for memset
extern "C"{
#include <esp32-hal.h>
}

/* general system header files (use "" for make depend) */


/* local include files (use "") */

#include "IR_TX.hpp"

// Clock divisor (base clock is 80MHz)
#define CLK_DIV 80

/*
  NEC pulse widths.
  See
  https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/peripherals/rmt.html
*/

#define NEC_AGC	9000 // us
#define NEC_SPC	4500 // us
#define NEC_DOT	563 // us
#define NEC_DASH 1688 // us


/**********************************************************************
NAME

        IR_TX - This is the class that allows the user to send IR
        modulated signals to a TV. This class only transmits.

SYNOPSIS
	See IR_TX.hpp

                                                
PROTECTED FUNCTIONS

PRIVATE FUNCTIONS

	make_item(	- make the item to sent via rmt_write_items()
	  item		- the item to be made
	  high_us 	- high pulse duration in microseconds
	  low_us	- low pulse duration in microseconds
	)	

	encode(		- encode the hex value into NEC pulse format
	  x		- x is the hex value to be encoded
	  pdata		- the pointer to the array to be filled with encoded data
	)		



LOCAL TYPES AND CLASSES

AUTHOR

        C.Y. Tan

SEE ALSO

REVISION
	$Revision$

**********************************************************************/


IR_TX::IR_TX(const rmt_channel_t channel, const gpio_num_t pin):
  _channel(channel), _pin(pin)
{}  


void IR_TX::Init()
{
  rmt_config_t config;
  config.channel = _channel;
  config.gpio_num = _pin;
  config.mem_block_num = 7;  //memory blocks are 64 * N (0-7)

  /*
	See
	https://docs.espressif.com/projects/esp-idf/en/v4.4/esp32/api-reference/peripherals/rmt.html
	under Configure Driver -> Common Parameters:

	The RMT source clock is typically APB CLK, 80Mhz by default. But when RMT_CHANNEL_FLAGS_AWARE_DFS is set in flags, RMT source clock is changed to REF_TICK or XTAL.
  */
  config.flags = 0; // ensure that we use the 80 MHz APB clock
  config.clk_div = CLK_DIV;
  config.tx_config.loop_en = false;
  config.tx_config.carrier_duty_percent = 30; // 50;
  config.tx_config.carrier_freq_hz = 38000;
  config.tx_config.carrier_level = RMT_CARRIER_LEVEL_HIGH;
  config.tx_config.carrier_en = 1;
  config.tx_config.idle_level = RMT_IDLE_LEVEL_LOW;
  config.tx_config.idle_output_en = true;
  config.rmt_mode = RMT_MODE_TX;
  rmt_config(&config);
  /* see
     https://docs.espressif.com/projects/esp-idf/en/v3.3/api-reference/peripherals/rmt.html#_CPPv410rmt_mode_t

     rx_buf_size = 0 if RX ring buffer is not used.
     intr_alloc_flags = 0 for default flags
     
   */
  rmt_driver_install(config.channel, 0, 0);
}

void IR_TX::Send(uint16_t data[], const int data_len)
{
  rmt_config_t config;
  config.channel = _channel;
  
  
  size_t size = (sizeof(rmt_item32_t) * data_len);
  rmt_item32_t* item = (rmt_item32_t*) malloc(size); //allocate memory
  memset((void*) item, 0, size); //wipe current data in memory

  for(int i=0, j=0; j< data_len; j+=2){
    make_item(item[i++], data[j], data[j+1]);
  }
      
  //send data
  rmt_write_items(config.channel, item, data_len, true);
  // wait
  rmt_wait_tx_done(config.channel,1);

  free(item);
}

uint16_t IR_TX::_repeatData[] = {9000, 2250, 560};

void IR_TX::SendNEC(uint16_t data[], const int data_len, const int repeat)
{
  Send(data, data_len);

  delay(39);  
  for(int i=0; i< repeat; i++){
    Send(_repeatData, 3);
    delay(96);
  }
}

void IR_TX::SendNEC(const uint8_t address, const uint8_t command, const int repeat)
{
  /*
    This format comes from
    https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/peripherals/rmt.html
   */
  uint16_t* pdata = _data;

  *pdata++ = NEC_AGC; // AGC pulse
  *pdata++ = NEC_SPC; // space

  // encode the address
  encode(address, pdata);
  // encode !address
  encode(~address, pdata);
  // encode the command
  encode(command, pdata);
  // encode the !command
  encode(~command, pdata);
  // final burst
  *pdata = NEC_DOT;

  // Now send the data
  Send(_data, IR_DATA_SZ);

  // send repeat data
  delay(39);  
  for(int i=0; i< repeat; i++){
    Send(_repeatData, 3);
    delay(96);
  }
}

void IR_TX::Stop(){
  rmt_config_t config;
  config.channel = _channel;
  config.flags = RMT_CHANNEL_FLAGS_AWARE_DFS; // restore this flag for NeoPixel
  rmt_rx_stop(config.channel);
  rmt_driver_uninstall(config.channel);
}


void IR_TX::make_item(rmt_item32_t &item, uint16_t high_us, uint16_t low_us){
  item.level0 = 1;
  item.duration0 = high_us - 50; // /6 - 8; //(high_us / 10 * TICK_10_US);
  item.level1 = 0;
  item.duration1 =  low_us + 50; // /6 + 8; // (low_us / 10 * TICK_10_US);
}

void IR_TX::encode(const uint8_t x, uint16_t* &pdata)
{
  for(uint8_t a = 0x01; a != 0; a <<=1){
    *pdata++ = NEC_DOT; // whether it is zero or 1, first element is always 562.5 us
    *pdata++ = (a & x) ? NEC_DASH: NEC_DOT; // 1: 1.6875 ms, 0: 562.5 ms
  }  
}

