/*$Id$*/
/*
    slave part of the controller code for the Adafruit ESP32-S3
    reverse TFT Feather
    Copyright (C) 2023 C.Y. Tan
    Contact: cytan299@yahoo.com

    This file is part of ultrasonic_screwdriver

    slave is free software: you can redistribute it
    and/or modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation, either version 3 of
    the License, or (at your option) any later version.

    slave is distributed in the hope that it will be
    useful, but WITHOUT ANY WARRANTY; without even the implied
    warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with slave.  If not, see
    <http://www.gnu.org/licenses/>.

*/

/* operating system header files (use <> for make depend) */

#include <Arduino.h>
#include <queue.h>

#include <Adafruit_NeoPixel.h>

#include <Adafruit_GFX.h> 
#include <Adafruit_ST7789.h>

#include <Adafruit_MLX90640.h>

/* general system header files (use "" for make depend) */

#include "Adafruit_MAX1704X.h"

#include "WiFi.h"

#include "AudioTools.h"


// for torch
extern Adafruit_NeoPixel neopixel_ring;


// the graphics card
extern Adafruit_ST7789 gfx;

// the thermal camera
extern Adafruit_MLX90640 mlx;
float frame[32*24]; // buffer for full frame of temperatures

//low range of the sensor (this will be blue on the screen)
#define MINTEMP 20.0

//high range of the sensor (this will be red on the screen)
#define MAXTEMP 35.0


//the colors we will be using
const uint16_t camColors[] = {0x480F,
0x400F,0x400F,0x400F,0x4010,0x3810,0x3810,0x3810,0x3810,0x3010,0x3010,
0x3010,0x2810,0x2810,0x2810,0x2810,0x2010,0x2010,0x2010,0x1810,0x1810,
0x1811,0x1811,0x1011,0x1011,0x1011,0x0811,0x0811,0x0811,0x0011,0x0011,
0x0011,0x0011,0x0011,0x0031,0x0031,0x0051,0x0072,0x0072,0x0092,0x00B2,
0x00B2,0x00D2,0x00F2,0x00F2,0x0112,0x0132,0x0152,0x0152,0x0172,0x0192,
0x0192,0x01B2,0x01D2,0x01F3,0x01F3,0x0213,0x0233,0x0253,0x0253,0x0273,
0x0293,0x02B3,0x02D3,0x02D3,0x02F3,0x0313,0x0333,0x0333,0x0353,0x0373,
0x0394,0x03B4,0x03D4,0x03D4,0x03F4,0x0414,0x0434,0x0454,0x0474,0x0474,
0x0494,0x04B4,0x04D4,0x04F4,0x0514,0x0534,0x0534,0x0554,0x0554,0x0574,
0x0574,0x0573,0x0573,0x0573,0x0572,0x0572,0x0572,0x0571,0x0591,0x0591,
0x0590,0x0590,0x058F,0x058F,0x058F,0x058E,0x05AE,0x05AE,0x05AD,0x05AD,
0x05AD,0x05AC,0x05AC,0x05AB,0x05CB,0x05CB,0x05CA,0x05CA,0x05CA,0x05C9,
0x05C9,0x05C8,0x05E8,0x05E8,0x05E7,0x05E7,0x05E6,0x05E6,0x05E6,0x05E5,
0x05E5,0x0604,0x0604,0x0604,0x0603,0x0603,0x0602,0x0602,0x0601,0x0621,
0x0621,0x0620,0x0620,0x0620,0x0620,0x0E20,0x0E20,0x0E40,0x1640,0x1640,
0x1E40,0x1E40,0x2640,0x2640,0x2E40,0x2E60,0x3660,0x3660,0x3E60,0x3E60,
0x3E60,0x4660,0x4660,0x4E60,0x4E80,0x5680,0x5680,0x5E80,0x5E80,0x6680,
0x6680,0x6E80,0x6EA0,0x76A0,0x76A0,0x7EA0,0x7EA0,0x86A0,0x86A0,0x8EA0,
0x8EC0,0x96C0,0x96C0,0x9EC0,0x9EC0,0xA6C0,0xAEC0,0xAEC0,0xB6E0,0xB6E0,
0xBEE0,0xBEE0,0xC6E0,0xC6E0,0xCEE0,0xCEE0,0xD6E0,0xD700,0xDF00,0xDEE0,
0xDEC0,0xDEA0,0xDE80,0xDE80,0xE660,0xE640,0xE620,0xE600,0xE5E0,0xE5C0,
0xE5A0,0xE580,0xE560,0xE540,0xE520,0xE500,0xE4E0,0xE4C0,0xE4A0,0xE480,
0xE460,0xEC40,0xEC20,0xEC00,0xEBE0,0xEBC0,0xEBA0,0xEB80,0xEB60,0xEB40,
0xEB20,0xEB00,0xEAE0,0xEAC0,0xEAA0,0xEA80,0xEA60,0xEA40,0xF220,0xF200,
0xF1E0,0xF1C0,0xF1A0,0xF180,0xF160,0xF140,0xF100,0xF0E0,0xF0C0,0xF0A0,
0xF080,0xF060,0xF040,0xF020,0xF800,};

extern uint16_t displayPixelWidth, displayPixelHeight;

/*
  For lipo battery
*/

Adafruit_MAX17048 lipo;

/*
  For zapper
*/

#define ZAP_X	30
#define ZAP_Y	60

uint16_t ZAP_colours[] = {
  ST77XX_WHITE, ST77XX_RED, ST77XX_GREEN, 
  ST77XX_BLUE, ST77XX_CYAN, ST77XX_MAGENTA,
  ST77XX_YELLOW, ST77XX_ORANGE};

int zap_i = 0;

/*
  For sonic screwdriver sound
*/

extern GeneratorFromArray<int16_t> sonicdriver_wave;
extern AudioInfo info;
extern StreamCopy copier;



/**********************************************************************
 Setting up for FreeTOS
 **********************************************************************/  


extern TaskHandle_t master_task; // Master task runs on core 1
extern TaskHandle_t slave_task;  // slave task runs on core 0

extern QueueHandle_t m2s_queue;
extern QueueHandle_t s2m_queue;



/**********************************************************************
NAME

	slave is slave program for the ultrasonic
	screwdriver.

		   
SYNOPSIS
	
	slave is the slave program that acts on the commands issued by
	the ultrasonic_screwdriver. Presently, the slave controls the
	following:

	(1) Torch
	(2) Thermal camera
	(3) Ultrasound device
	(4) WIFI scanner

	
AUTHOR
	C.Y. Tan

REVISION
	$Revision$

SEE ALSO

**********************************************************************/



void slave(void* p)
{
#ifdef DEBUG  
  Serial.print("Slave is running on core ");
  Serial.println(xPortGetCoreID());
#endif

  int num_bytes;
  char buf[6];
  int buf_pos = 0;
  bool is_got_data = false;
 
  int zap_x = ZAP_X;
  uint16_t neopixel_i = 0;

  bool is_got_battery = false;
  int battery_j = 0;
  
  while(1){

    QueueMessage m2s; // master to slave
    QueueMessage s2m; // slave to master
    
    if(xQueueReceive(m2s_queue, &m2s, 10) == pdPASS){    

      switch(m2s.id){
        case M_TORCH:
	  for(int i=0; i< NEOPIXEL_NUM_PIXELS; i++){
	    // RGBW, // white = 255, black = 0
	    neopixel_ring.setPixelColor(i, neopixel_ring.Color(0,0,0,m2s.message==1? 255: 0));
	  }

	  neopixel_ring.show();	  

          #ifdef DEBUG      
          Serial.print("slave2: Torch state = ");
          Serial.println(m2s.message);
          #endif

	  m2s.id = M_DONE;
	  
	  break;

	case M_THERMAL:

          #ifdef DEBUG      
          Serial.print("slave2a: thermal ");
	  Serial.println(m2s.message == 1? "ON":"OFF");
          #endif


          // set up graphics
	  gfx.setRotation(3);
	  gfx.fillScreen(ST77XX_BLACK);

	  while(1){

	    if (mlx.getFrame(frame) != 0) {
	      #ifdef DEBUG
	      Serial.println("Failed");
	      #endif
	      return;
	    }
	    
	    for (int16_t h=0; h<24; h++) {
	      for (int16_t w=0; w<32; w++) {
		float t = frame[h*32 + w];
		const float min_t = MINTEMP;
		const float max_t = MAXTEMP;

		t = min(t, max_t);
		t = max(t, min_t);       

		uint16_t colorIndex = map(t, MINTEMP, MAXTEMP, 0, 255);
      
		gfx.fillRect(displayPixelWidth * w, displayPixelHeight * h,
			     displayPixelHeight, displayPixelWidth, 
			     camColors[colorIndex]);
	      }
	    }

	    if(xQueueReceive(m2s_queue, &m2s, 10) == pdPASS){    	    

	      if(m2s.message == 0){
		m2s.id = M_DONE;
		gfx.setRotation(4); // rotate screen back to where it was
		gfx.fillScreen(ST77XX_BLACK);

		s2m.id = M_DONE;
		xQueueSend(s2m_queue, &s2m, portMAX_DELAY);
		break;
	      }
	    }
	  }	  

	  break;

        case M_SONIC:

          // set up graphics
	  gfx.setRotation(4);
	  gfx.fillScreen(ST77XX_BLACK);
	  gfx.setTextColor(ST77XX_YELLOW);
	  gfx.setTextSize(2);

	  
  	  while(1){

	    digitalWrite(ULTRASONIC_EN, HIGH);	  
	    
	    
	    if(num_bytes=Serial1.available()){
	      char ch = Serial1.read();

	      if(!is_got_data){ // check that is an 'R'
		if(ch =='R'){
		  memset(buf, '\0', sizeof(buf));
		  buf_pos = 0;
		  is_got_data = true;
		}
	      }
	      else {
                // construct the buffer
		buf[buf_pos]=ch;

		if(buf_pos == 4){

		  Serial1.flush(); // kill anything else in the buffer
		  
		  int dist = atoi(buf);
#ifdef DEBUG
		  Serial.print("buf = ");
		  Serial.print(buf);
		  Serial.print(" dist = ");
		  Serial.println(dist, DEC);
#endif


// Meter colour schemes
#define RED2RED 0
#define GREEN2GREEN 1
#define BLUE2BLUE 2
#define BLUE2RED 3
#define GREEN2RED 4
#define RED2GREEN 5

		  // according to the manual, min is really 300 mm. max is 5000 mm
		  ringMeter(dist, 0, 5000, 0, 5, GFX_WIDTH/2, const_cast<char*>("mm"), BLUE2RED);
		  
		  buf_pos = 0;
		  is_got_data = false; // reset flag

		  // manual: sleep for 100 ms before getting next data
		  delay(100);

		}

		buf_pos++;
	      }
	    }

	    if(xQueueReceive(m2s_queue, &m2s, 10) == pdPASS){    	    

	      if(m2s.message == 0){
		m2s.id = M_DONE;
		
		#ifdef DEBUG
		Serial.println("sonic done");
		#endif

		digitalWrite(ULTRASONIC_EN, LOW);	  // disable ultrasonic		
		
		gfx.fillScreen(ST77XX_BLACK);		  
		gfx.setTextSize(1);		

		s2m.id = M_DONE;
		xQueueSend(s2m_queue, &s2m, portMAX_DELAY);		
		break;
	      }	    
	    }
	  }
	  break;

        case M_ZAPPER:
	  #ifdef DEBUG
          Serial.print("slave2a: zapper ");
	  Serial.println(m2s.message == 1? "ON":"OFF");
	  #endif


          // set up graphics
	  gfx.setRotation(1);
	  gfx.fillScreen(ST77XX_BLACK);
	  gfx.setTextColor(ST77XX_YELLOW);
	  gfx.setTextSize(4);


	  
	  // enable ultrasonic
	  digitalWrite(ULTRASONIC_EN, HIGH);	  	  
  	  while(1){

	    gfx.fillScreen(ST77XX_BLACK);
	    //	    gfx.setTextColor(ST77XX_RED);

	    // cycle the text colour
	    gfx.setTextColor(ZAP_colours[zap_i++]);

	    if(zap_i >= sizeof(ZAP_colours)/sizeof(uint16_t)){
	      zap_i = 0;
	    }

	    // move the text across the screen
	    gfx.setCursor(0 + (--zap_x)*5, ZAP_Y);
	    gfx.print(F("<ZAP!"));
	    if(zap_x <= 0)
	      zap_x = ZAP_X;
	    
	    // flash the neopixel
	    for(int q = 0; q<3; q++){
	      for(uint16_t i=0; i<NEOPIXEL_NUM_PIXELS; i+=3){
		neopixel_ring.setPixelColor(i+q, Wheel((i+neopixel_i)%255));		
	      }

	      neopixel_ring.show();

              //sleep for 20 ms
	      
	      delay(20);

	      for(uint16_t i=0; i<NEOPIXEL_NUM_PIXELS; i+=3){
		neopixel_ring.setPixelColor(i+q, 0);
	      }

	      neopixel_ring.show();	      
	    }

	    if((neopixel_i+=2) >= 256){
	      neopixel_i = 0;
	    }	    	    


	    if(xQueueReceive(m2s_queue, &m2s, 10) == pdPASS){    	    

	      if(m2s.message == 0){
		m2s.id = M_DONE;
		
		#ifdef DEBUG
		Serial.println("zapper done");
		#endif

		digitalWrite(ULTRASONIC_EN, LOW);	  // disable ultrasonic

		//turn off all the neopixels
		for(int i = 0; i < NEOPIXEL_NUM_PIXELS; i++){
		  neopixel_ring.setPixelColor(i, neopixel_ring.Color(0,0,0,0));
		}
		neopixel_ring.show();

		gfx.setRotation(4); // rotate screen back to where it was		
		gfx.fillScreen(ST77XX_BLACK);
		gfx.setTextSize(1);

		s2m.id = M_DONE;
		xQueueSend(s2m_queue, &s2m, portMAX_DELAY);		
		break;
	      }	    
	    }
	  }	  
	  break;

        case M_WIFI:
	  // disconnect if previously connected

	  WiFi.mode(WIFI_STA);
	  WiFi.disconnect();
	  delay(100);

	  // clear screen
	  gfx.fillScreen(ST77XX_BLACK);
	  gfx.setTextColor(ST77XX_YELLOW);
	  gfx.setTextSize(1);
	  
	  gfx.setCursor(0,0);
	  gfx.println(F("WIFI Scanning ..."));
	  

	  /*
	    set this flag that slave is busy because WIFI scanning is
	    very slow and the slave might print the SSIDs even after
	    the master is tells the slave to stop
	   */
	  s2m.id=M_BUSY;
	  while(1) {
	    int n = WiFi.scanNetworks();

	    /*
	      WIFI scanning is really slow.
	      So, once this returns, I have to check that the master
	      hasn't told the slave to stop
	    */ 

	    if(xQueueReceive(m2s_queue, &m2s, 10) == pdPASS){    	    

	      if(m2s.message == 0){
		m2s.id = M_DONE;

		WiFi.scanDelete();
		WiFi.disconnect();		
		
		#ifdef DEBUG
		Serial.println("WIFI done");
		#endif

		s2m.id = M_DONE;
		xQueueSend(s2m_queue, &s2m, portMAX_DELAY);		
		
		break;
	      }	    
	    }	    

	    if(s2m.id == M_BUSY){
	      gfx.fillScreen(ST77XX_BLACK);
	      gfx.setCursor(0,0);	    
	      if(n==0){
		gfx.println(F("no networks found"));	      
	      }
	      else {
		gfx.print(F("networks found = "));
		gfx.println(n);

		for(int i=0; i<n; i++){
		  gfx.println(WiFi.SSID(i).c_str());
		}
	      }
	    }

	  }

	  break;

        case M_BATTERY:
	  #ifdef DEBUG
          Serial.print("slave2a: battery ");
	  Serial.println(m2s.message == 1? "ON":"OFF");
	  #endif

          // set up graphics
	  gfx.setRotation(1);	  
	  gfx.fillScreen(ST77XX_BLACK);
	  gfx.setTextSize(2);

	  gfx.setCursor(0,0);
	  gfx.println(F("Battery: "));

	  if(lipo.begin()){
	    is_got_battery = true;
  	  }
	  else {
	    is_got_battery=false;
	    gfx.println(F("No battery found"));	    
	  }

   
	  battery_j = 0;

	  while(1){

	    // print once a second
	    if(is_got_battery && (battery_j-- <= 0)){
	      //clear screen
	      gfx.fillScreen(ST77XX_BLACK);

	      gfx.setTextColor(ST77XX_YELLOW);

	      gfx.setCursor(0,0);
	      gfx.println(F("Found MAX17048"));
	      gfx.print(F("Chip ID: 0x"));	    
	      gfx.println(lipo.getChipID(), HEX);
	      gfx.println();

	      gfx.setTextColor(ST77XX_WHITE);	  	      
	      gfx.print(lipo.cellVoltage());
	      gfx.print(F("V / "));
	      gfx.print(lipo.cellPercent());
	      gfx.print(F("%"));

	      battery_j=10;
	    }

	    delay(100); // sleep for 100 ms.
	    
	    if(xQueueReceive(m2s_queue, &m2s, 10) == pdPASS){    	    

	      if(m2s.message == 0){
		m2s.id = M_DONE;
		
		#ifdef DEBUG
		Serial.println("battery done");
		#endif

		gfx.setRotation(4);		
		gfx.fillScreen(ST77XX_BLACK);		  
		gfx.setTextSize(1);		

		s2m.id = M_DONE;
		xQueueSend(s2m_queue, &s2m, portMAX_DELAY);		
		break;
	      }	    
	    }	    

	  }

	  break;

        case M_ABOUT:

	  #ifdef DEBUG
          Serial.print("slave2a: about ");
	  Serial.println(m2s.message == 1? "ON":"OFF");
	  #endif

          // set up graphics
	  gfx.setRotation(1);	  
	  gfx.fillScreen(ST77XX_BLACK);
	  gfx.setTextColor(ST77XX_YELLOW);
	  gfx.setTextSize(2);

	  gfx.setCursor(0,0);
	  gfx.setTextColor(ST77XX_RED);	  
	  gfx.println(F("Ultrasonic"));
	  gfx.println(F("Screwdriver"));
	  gfx.setTextColor(ST77XX_BLUE);	  
	  gfx.print(F("Version: ")); gfx.println(1.00);
	  gfx.println(F("by C.Y. Tan"));
	  gfx.println(F("2023"));
	  

	  // wait for master to tell us that we are done
	  while(1){
	    if(xQueueReceive(m2s_queue, &m2s, 10) == pdPASS){    	    

	      if(m2s.message == 0){
		m2s.id = M_DONE;
		
		#ifdef DEBUG
		Serial.println("version done");
		#endif

		gfx.setRotation(4);		
		gfx.fillScreen(ST77XX_BLACK);		  
		gfx.setTextSize(1);		

		s2m.id = M_DONE;
		xQueueSend(s2m_queue, &s2m, portMAX_DELAY);		
		break;
	      }	    
	    }	    

	  }	  

	  break;
	  
        default:
	  break;
      } // switch
    } // if xQueueReceive()
  } // while
}

