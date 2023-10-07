/*$Id$*/
/*
    ultrasonic_screwdriver is the controller code for the Adafruit
    ESP32-S3 reverse TFT Feather
    Copyright (C) 2023 C.Y. Tan
    Contact: cytan299@yahoo.com

    This file is part of ultrasonic_screwdriver

    ultrasonic_screwdriver is free software: you can redistribute it
    and/or modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation, either version 3 of
    the License, or (at your option) any later version.

    ultrasonic_screwdriver is distributed in the hope that it will be
    useful, but WITHOUT ANY WARRANTY; without even the implied
    warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with ultrasonic_screwdriver.  If not, see
    <http://www.gnu.org/licenses/>.

*/

/* operating system header files (use <> for make depend) */


#include  <Arduino.h>
#include <queue.h>

/* general system header files (use "" for make depend) */


/*

   For the graphics display
*/

#include <Adafruit_GFX.h>
#include <Adafruit_ST7789.h>
#include <Adafruit_MLX90640.h>
#include <Adafruit_NeoPixel.h>

#include "AudioTools.h"

#include <menu.h>
#include <menuIO/adafruitGfxOut.h>



/*
  For the menu
*/

#include <menuIO/altKeyIn.h>
#include <menuIO/chainStream.h>

#ifdef MENU_DEBUG
#include <menuIO/serialOut.h>
#include <menuIO/serialIn.h>
#endif 

using namespace Menu;

#define BTN_SEL 1	// Select button
#define BTN_UP 0 // Up
#define BTN_DOWN 2 // Down


/*
  Neopixel ring
*/


#define NEOPIXEL_PIN	13
#define NEOPIXEL_NUM_PIXELS	12
Adafruit_NeoPixel neopixel_ring = Adafruit_NeoPixel(NEOPIXEL_NUM_PIXELS,
						    NEOPIXEL_PIN,
						    NEO_RGBW);



/*
  The TFT
*/

Adafruit_ST7789 gfx = Adafruit_ST7789(TFT_CS, TFT_DC, TFT_RST);

uint16_t displayPixelWidth, displayPixelHeight;

/*
 The thermal camera
*/

Adafruit_MLX90640 mlx;

/*
  The ultrasound sonic
*/

#define ULTRASONIC_EN	A1

/*
  The IR diode
*/

#include "IR_TX.hpp"

IR_TX ir_tx(RMT_CHANNEL_0, GPIO_NUM_12);

/*
  For sonic screwdriver sound
*/

extern GeneratorFromArray<int16_t> sonicdriver_wave;
extern AudioInfo info;
extern StreamCopy copier;



/*
  Setting up the menu
*/

bool is_poll_BTN_SEL = false;
bool is_poll_BTN_DESEL = false;

bool is_torch_on = false;
bool is_sound_on = true;


typedef enum {M_TORCH, M_THERMAL, M_SONIC,
	      M_ZAPPER, M_TV, M_WIFI, M_BATTERY,
	      M_SOUND, M_ABOUT, M_DONE,
	      M_BUSY} MessageID;

MessageID s_state = M_DONE;

/**********************************************************************
  Defines
 **********************************************************************/  
//#define DEBUG

/**********************************************************************
  Setting up the colour definitions of the TFT
 **********************************************************************/  


#define ST77XX_GRAY RGB565(128,128,128)

const colorDef<uint16_t> colors[6] MEMMODE={
  {{(uint16_t)ST77XX_BLACK,(uint16_t)ST77XX_BLACK}, {(uint16_t)ST77XX_BLACK, (uint16_t)ST77XX_BLUE,  (uint16_t)ST77XX_BLUE}},//bgColor
  {{(uint16_t)ST77XX_GRAY, (uint16_t)ST77XX_GRAY},  {(uint16_t)ST77XX_WHITE, (uint16_t)ST77XX_WHITE, (uint16_t)ST77XX_WHITE}},//fgColor
  {{(uint16_t)ST77XX_WHITE,(uint16_t)ST77XX_BLACK}, {(uint16_t)ST77XX_YELLOW,(uint16_t)ST77XX_YELLOW,(uint16_t)ST77XX_RED}},//valColor
  {{(uint16_t)ST77XX_WHITE,(uint16_t)ST77XX_BLACK}, {(uint16_t)ST77XX_WHITE, (uint16_t)ST77XX_YELLOW,(uint16_t)ST77XX_YELLOW}},//unitColor
  {{(uint16_t)ST77XX_WHITE,(uint16_t)ST77XX_GRAY},  {(uint16_t)ST77XX_BLACK, (uint16_t)ST77XX_BLUE,  (uint16_t)ST77XX_WHITE}},//cursorColor
  {{(uint16_t)ST77XX_WHITE,(uint16_t)ST77XX_YELLOW},{(uint16_t)ST77XX_BLUE,  (uint16_t)ST77XX_RED,    (uint16_t)ST77XX_RED}},//titleColor
};


/**********************************************************************
NAME

	menu_item_* - All the callbacks used by the Menu system
		   
SYNOPSIS

	menu_item_* are all the callbacks used by the Menu system.
	
AUTHOR
	C.Y. Tan

REVISION
	$Revision$

SEE ALSO

**********************************************************************/


result menu_item_camera_status(){

  is_poll_BTN_SEL = !is_poll_BTN_SEL;
  
  
#ifdef DEBUG
  Serial.print("Camera ");
  Serial.println(is_poll_BTN_SEL? "activated": "de-activated");
#endif

  if(is_poll_BTN_SEL){
    s_state = M_THERMAL;
  }
  else {
    s_state = M_DONE;
  }

  return proceed;
}


result menu_item_sonic_status(){

  is_poll_BTN_SEL = !is_poll_BTN_SEL;
  
  
#ifdef DEBUG
  Serial.print("Sonic ");
  Serial.println(is_poll_BTN_SEL? "activated": "de-activated");
#endif

  if(is_poll_BTN_SEL){
    s_state = M_SONIC;
  }
  else {
    s_state = M_DONE;
  }

  return proceed;
}

result menu_item_zapper_status(){

  is_poll_BTN_SEL = !is_poll_BTN_SEL;
  
  
#ifdef DEBUG
  Serial.print("Zapper ");
  Serial.println(is_poll_BTN_SEL? "activated": "de-activated");
#endif

  if(is_poll_BTN_SEL){
    s_state = M_ZAPPER;
  }
  else {
    s_state = M_DONE;
  }

  return proceed;
}

result menu_item_WIFI_status(){

  is_poll_BTN_SEL = !is_poll_BTN_SEL;
  
  
#ifdef DEBUG
  Serial.print("WIFI scan ");
  Serial.println(is_poll_BTN_SEL? "activated": "de-activated");
#endif

  if(is_poll_BTN_SEL){
    s_state = M_WIFI;
  }
  else {
    s_state = M_DONE;
  }

  return proceed;
}


result menu_item_tv_power_on_off()
{
  ir_tx.Init();
  ir_tx.SendNEC(0x04, 0x08, 1);
  ir_tx.Stop();
    
  return proceed;
}

result menu_item_tv_channel_up()
{
  ir_tx.Init();
  ir_tx.SendNEC(0x04, 0x00, 1);
  ir_tx.Stop();
    
  return proceed;  
}

result menu_item_tv_channel_down()
{
  ir_tx.Init();
  ir_tx.SendNEC(0x04, 0x01, 1);
  ir_tx.Stop();
    
  return proceed;  
}

result menu_item_tv_volume_up()
{
  ir_tx.Init();
  ir_tx.SendNEC(0x04, 0x02, 1);
  ir_tx.Stop();
    
  return proceed;
}

result menu_item_tv_volume_down()
{
  ir_tx.Init();
  ir_tx.SendNEC(0x04, 0x03, 1);
  ir_tx.Stop();
    
  return proceed;
}

result menu_item_sound_status()
{
  return proceed;
}


result menu_item_battery_status()
{

  is_poll_BTN_SEL = !is_poll_BTN_SEL;
  
#ifdef DEBUG
  Serial.print("Battery: ");
  Serial.println(is_poll_BTN_SEL? "activated": "de-activated");
#endif

  if(is_poll_BTN_SEL){
    s_state = M_BATTERY;
  }
  else {
    s_state = M_DONE;
  }

  return proceed;  
}

result menu_item_about_status()
{

  is_poll_BTN_SEL = !is_poll_BTN_SEL;
  
  
#ifdef DEBUG
  Serial.print("About: ");
  Serial.println(is_poll_BTN_SEL? "activated": "de-activated");
#endif

  if(is_poll_BTN_SEL){
    s_state = M_ABOUT;
  }
  else {
    s_state = M_DONE;
  }

  return proceed;  

}

void set_torch_state();
void set_sound_state();


/**********************************************************************
 Setting up the menu sytem. This menu system comes from

  see https://github.com/neu-rah/ArduinoMenu/wiki/Menu-definition
 **********************************************************************/  


TOGGLE(is_torch_on,setTorchOnOff,"Torch: ",doNothing,noEvent,noStyle//,doExit,enterEvent,noStyle
  ,VALUE("On",true,set_torch_state,noEvent)
  ,VALUE("Off",false,set_torch_state,noEvent)
);

TOGGLE(is_sound_on,setSoundOnOff,"Sound: ",doNothing,noEvent,noStyle//,doExit,enterEvent,noStyle
  ,VALUE("On",true,set_sound_state,noEvent)
  ,VALUE("Off",false,set_sound_state,noEvent)
);



MENU(TVMenu, "TV menu", doNothing,noEvent,wrapStyle,
     OP("Power", menu_item_tv_power_on_off, enterEvent),
     OP("CH+", menu_item_tv_channel_up, enterEvent),
     OP("CH-", menu_item_tv_channel_down, enterEvent),     
     OP("Vol+", menu_item_tv_volume_up, enterEvent),
     OP("Vol-", menu_item_tv_volume_down, enterEvent),     
     EXIT("<BACK")
);



// good  
MENU(GenMenu, "General", doNothing,noEvent,wrapStyle,
     OP("Sound", menu_item_sound_status, enterEvent),
     OP("Battery", menu_item_battery_status, (eventMask)(focusEvent | blurEvent)),
     OP("About", menu_item_about_status, (eventMask)(focusEvent | blurEvent)),
     EXIT("<BACK")
     );


/*
//broke
MENU(GenMenu, "General", doNothing,noEvent,wrapStyle,
     OP("Battery", menu_item_battery_status, (eventMask)(focusEvent | blurEvent)),
     OP("About", menu_item_about_status, (eventMask)(focusEvent | blurEvent)),
     EXIT("<BACK")
     );

 */

// Main Menu

MENU(mainMenu,"MAIN menu",doNothing,noEvent,wrapStyle,
     SUBMENU(setTorchOnOff),
     SUBMENU(setSoundOnOff),
     OP("Thermal",menu_item_camera_status,(eventMask)(focusEvent | blurEvent)),
     OP("Sonic", menu_item_sonic_status,(eventMask)(focusEvent | blurEvent)),
     OP("Zapper", menu_item_zapper_status,(eventMask)(focusEvent | blurEvent)),
     OP("WIFI scan", menu_item_WIFI_status,(eventMask)(focusEvent | blurEvent)),
     SUBMENU(TVMenu),
     SUBMENU(GenMenu)
     //   EXIT("<Back")
);



#ifdef MENU_DEBUG
serialIn serial(Serial);
#endif

keyMap controlBtn_map[]={
 {BTN_SEL, defaultNavCodes[enterCmd].ch,INPUT_PULLDOWN} ,
 {BTN_UP, defaultNavCodes[upCmd].ch,INPUT_PULLUP} ,
 {BTN_DOWN, defaultNavCodes[downCmd].ch,INPUT_PULLDOWN}  ,
};
keyIn<3> controlBtns(controlBtn_map);

#ifdef MENU_DEBUG
MENU_INPUTS(in,&controlBtns,&serial);
#endif

MENU_INPUTS(in,&controlBtns);

#define GFX_WIDTH	135
#define GFX_HEIGHT	240

#define MAX_DEPTH 4
#define FONT_WIDTH 6
#define FONT_HEIGHT 12
#define TEXT_SCALE 1

// note MENU_OUTPUTS must have at least 2 items. Last item can be NONE
// See https://registry.platformio.org/libraries/neu-rah/ArduinoMenu%20library


// gfx, colors, width, height,
	     // the two vectors look like
	     // menu position and size {x, y, panel x size, panel y size (number of rows?)}
	     // submenu position and size


#ifndef MENU_DEBUG
MENU_OUTPUTS(out,MAX_DEPTH,
	     ADAGFX_OUT(gfx,colors,
		FONT_WIDTH*TEXT_SCALE,FONT_HEIGHT*TEXT_SCALE,
		{0,0,14,12},{16,1,14,8}),
	        NONE
	     );

#else
MENU_OUTPUTS(out,MAX_DEPTH,
	     ADAGFX_OUT(gfx,colors,FONT_WIDTH*TEXT_SCALE,FONT_HEIGHT*TEXT_SCALE,
		{0,0,14,8},{16,1,14,8}),
	        SERIAL_OUT(Serial)
	     );
#endif


NAVROOT(nav,mainMenu,MAX_DEPTH,in,out);

//when menu is suspended
result idle(menuOut& o,idleEvent e) {
  if (e==idling) {
    o.println(F("suspended..."));
    o.println(F("press [select]"));
    o.println(F("to continue"));
  }
  return proceed;
}


/**********************************************************************
 Setting up for FreeTOS
 **********************************************************************/  

TaskHandle_t master_task; // Master task runs on core 1
TaskHandle_t slave_task;  // slave task runs on core 0

QueueHandle_t m2s_queue;
QueueHandle_t s2m_queue;

void slave(void* p);
void audio_setup();


struct QueueMessage{
  MessageID id;
  int message;
};


/**********************************************************************
NAME

	ultrasonic_screwdriver is master program for the ultrasonic
	screwdriver.

		   
SYNOPSIS
	
	ultrasonic_screwdriver is the master program that communicates
	with the slave by issuing commands to it.

	The user interacts with the displayed menus controlled by the
	ultrasonic_screwdriver while most of the onboard devices are
	controlled by the the slave.

	The following are the onboard devices controlled by the
	ultrasonic_screwdriver:

	(1) IR remote
	(2) Sound
	
AUTHOR
	C.Y. Tan

REVISION
	$Revision$

SEE ALSO

**********************************************************************/


void setup() {

  // for the neopixel ring
  neopixel_ring.begin();
  neopixel_ring.setBrightness(50);
  neopixel_ring.show(); // initialize all pixels to off

  #ifdef DEBUG
    Serial.begin(115200);
    while(!Serial);
    Serial.println("Sonic Screwdriver button pressed test");
    Serial.flush();
  #endif  
  nav.idleTask=idle;//point a function to be used when menu is suspended

  //outGfx.usePreview=true;//reserve one panel for preview?
  //nav.showTitle=false;//show menu title?

  controlBtns.begin();

  // turn on backlite
  pinMode(TFT_BACKLITE, OUTPUT);
  digitalWrite(TFT_BACKLITE, HIGH);

  // Init ST7789 240x135. Note in Adafruit_ST7789.h, first argument is width, second is height
  gfx.init(GFX_WIDTH, GFX_HEIGHT);           
  gfx.setRotation(4);
  gfx.setTextSize(TEXT_SCALE);//test scalling
  gfx.setTextWrap(false);
  gfx.fillScreen(ST77XX_BLACK);
  gfx.setTextColor(ST77XX_RED,ST77XX_BLACK);

  // initialize for thermal camera

  displayPixelWidth =  GFX_HEIGHT / 32;
  displayPixelHeight = GFX_WIDTH / 32;
#ifdef DEBUG
  Serial.println("Adafruit MLX90640 Camera");
#endif  
  if (! mlx.begin(MLX90640_I2CADDR_DEFAULT, &Wire)) {
#ifdef DEBUG    
    Serial.println(F("MLX90640 not found!"));
#endif    
  }
#ifdef DEBUG  
  Serial.println("***Found Adafruit MLX90640");
#endif  
  
  mlx.setMode(MLX90640_CHESS);
  mlx.setResolution(MLX90640_ADC_18BIT);
  mlx.setRefreshRate(MLX90640_8_HZ);
  
  Wire.setClock(800000); // max 1 MHz doesn't work. Set to 800 kHz

  // initialize the ultrasonic

  // setup the ultrsonic enable/disable pin
  pinMode(ULTRASONIC_EN, OUTPUT);
  digitalWrite(ULTRASONIC_EN, LOW); // disable ultrasonic
  
  // setup the ultrasonic transducer
  #ifdef DEBUG  
  Serial.println("000Getting Serial1:");
  #endif
  Serial1.begin(9600, SERIAL_8N1); // for the ultrasonic
  while(!Serial1);

  #ifdef DEBUG
  Serial.println("Got Serial1");
  #endif

  // setup audio

  audio_setup();

  // initialize multi-core tasks on the two cores

  // make a master to slave queue

  m2s_queue = xQueueCreate(10, // queue depth
			   sizeof(struct QueueMessage));

  // and a slave to master queue
  s2m_queue = xQueueCreate(10, // queue depth
			   sizeof(struct QueueMessage));


  if(m2s_queue && s2m_queue){
    xTaskCreatePinnedToCore(master,"Master",10000,NULL,1,&master_task,1);
    delay(500);
    xTaskCreatePinnedToCore(slave,"Slave",10000,NULL,1,&slave_task,0);
    delay(500);
  }
}

void set_torch_state()
{
  QueueMessage m2s; // master to slave message
  
  m2s.id = M_TORCH;
  m2s.message = is_torch_on;
      
  xQueueSend(m2s_queue, &m2s, portMAX_DELAY);	      

  s_state = is_torch_on? M_TORCH: M_DONE;
}

void set_sound_state()
{
  s_state = is_sound_on? M_SOUND: M_DONE;
}


void poll_BTN_SEL(const int id){

  MessageID m_id = static_cast<MessageID>(id);
  QueueMessage m2s; // master to slave message
  QueueMessage s2m; // master to slave message    

  // check whether poll button is pressed
  if(is_poll_BTN_SEL){
    if(digitalRead(BTN_SEL) == HIGH){ // yes, button is pressed

      m2s.id = m_id;
      m2s.message = 1; // tell device to turn on	
      xQueueSend(m2s_queue, &m2s, portMAX_DELAY);
	
      // once I have a high here, I have to set is_poll_BTN_DESEL=true
      // so that I will now poll for deselection

      is_poll_BTN_SEL = false;
      is_poll_BTN_DESEL = true;

      // suspend the menu navigation
      nav.idleOn();
    }
  }

  if(is_poll_BTN_DESEL){

    if(digitalRead(BTN_SEL) == LOW){

      m2s.id = m_id;
      m2s.message = 0; // tell device to turn off	
      xQueueSend(m2s_queue, &m2s, portMAX_DELAY);

      // reset the poll flag
      is_poll_BTN_DESEL=false;
      is_poll_BTN_SEL=true; // continue waiting to make sure that I really exit the menu selection
      //      delay(100);

      // wait for the slave to tell me to restart
      s2m.id = M_BUSY;
      do{
	if(xQueueReceive(s2m_queue, &s2m, 10) == pdPASS){
	  if(s2m.id == M_DONE)
	    break;
	}
      } while(1);
      
      // tell the menu to restart
      nav.idleOff();

      // force a redraw of the menu
      mainMenu.dirty = true;
      nav.doOutput();
	
    }
    else {
      if(is_sound_on){
	copier.copy();
	if(sonicdriver_wave.isRunning() == false){
	  sonicdriver_wave.begin();
	}
      }
    }
  }  
}


void master(void* p)
{
#ifdef DEBUG
  Serial.print("Master is running on core ");
  Serial.println(xPortGetCoreID());
#endif

  while(1){

    nav.poll();//this device only draws when needed

    poll_BTN_SEL(s_state);

  } // while

}



void loop()
{}
  
