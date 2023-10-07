/*$Id$*/

#ifndef IR_TX_H
#define IR_TX_H

extern "C"{
#include <driver/rmt.h>
#include <soc/rmt_struct.h>
}

/**********************************************************************
NAME

        IR_TX - This is the class that allows the user to send IR
        modulated signals to a TV. This class only transmits.


SYNOPSIS

	IR_TX is the class that allows the user to send IR modulated
	signals to a TV.

CONSTRUCTOR

        IR_TX(			- constructor
	  channel		- RMT channel to use
	  pin			- GPIO pin used for the IR diode
	)	

        
INTERFACE
	Init()			- initialize the RMT before sending


	Send(			- send the data
	  data[]		- given here which is the a series of
				  on/off time pairs
	  data_len		- length of the data[]
	)

	SendNEC(		- send the data in NEC format
	  data[]		- the data to send which is a series
				  of on/off time pairs
	  data_len		- the length of the data
	  repeat		- number of times to repeat the
				  command in NEC format
	)

	SendNEC(		- send the data in NEC format
	  address		- the TV receiver address
	  command		- the command to be ent
	  repeat		- number of times to repeat the
				  command in NEC format
        )

	Stop()			- restore the RMT flags back to before
				  Init() is called.


AUTHOR                                          

        C.Y. Tan

SEE ALSO

REVISION
	$Revision$

**********************************************************************/


#define IR_DATA_SZ	67

class IR_TX
{
public:  
  IR_TX(const rmt_channel_t channel, const gpio_num_t pin);

public:  
  void Init();
  void Send(uint16_t data[], const int data_len);
  void SendNEC(uint16_t data[], const int data_len, const int repeat = 0);
  void SendNEC(const uint8_t address, const uint8_t command, const int repeat = 0);  
  void Stop();

private:
  void make_item(rmt_item32_t &item, uint16_t high_us, uint16_t low_us);
  void encode(uint8_t x, uint16_t*&padata);

private:
  const rmt_channel_t _channel;
  const gpio_num_t _pin;

private:
  uint16_t _data[IR_DATA_SZ];

  static uint16_t _repeatData[];
  
};

#endif
