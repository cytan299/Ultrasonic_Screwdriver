// #########################################################################
//  Draw the meter on the screen, returns x coord of righthand side
// https://www.instructables.com/Arduino-analogue-ring-meter-on-colour-TFT-display/
// Modified on 19 Aug 2023 for ultrasonic_screwdriver
//
// The code was released under
// CC BY-NC-SA 4.0 Deed
// Copyright Bodmer
// #########################################################################
int ringMeter(int value, int vmin, int vmax, int x, int y, int r, char * units, byte scheme)
{
  // Minimum value of r is about 52 before value text intrudes on ring
  // drawing the text first is an option
  
  x += r; y += r;   // Calculate coords of centre of ring

  int w = r / 4;    // Width of outer ring is 1/4 of radius
  
  int angle = 150;  // Half the sweep angle of meter (300 degrees)

  int text_colour = 0; // To hold the text colour

  int v = map(value, vmin, vmax, -angle, angle); // Map the value to an angle v

  byte seg = 5; // Segments are 5 degrees wide = 60 segments for 300 degrees
  byte inc = 5; // Draw segments every 5 degrees, increase to 10 for segmented ring

  // Draw colour blocks every inc degrees
  for (int i = -angle; i < angle; i += inc) {

    // Choose colour from scheme
    int colour = 0;
    switch (scheme) {
      case 0: colour = ST77XX_RED; break; // Fixed colour
      case 1: colour = ST77XX_GREEN; break; // Fixed colour
      case 2: colour = ST77XX_BLUE; break; // Fixed colour
      case 3: colour = rainbow(map(i, -angle, angle, 0, 127)); break; // Full spectrum blue to red
      case 4: colour = rainbow(map(i, -angle, angle, 63, 127)); break; // Green to red (high temperature etc)
      case 5: colour = rainbow(map(i, -angle, angle, 127, 63)); break; // Red to green (low battery etc)
      default: colour = ST77XX_BLUE; break; // Fixed colour
    }

    // Calculate pair of coordinates for segment start
    float sx = cos((i - 90) * 0.0174532925);
    float sy = sin((i - 90) * 0.0174532925);
    uint16_t x0 = sx * (r - w) + x;
    uint16_t y0 = sy * (r - w) + y;
    uint16_t x1 = sx * r + x;
    uint16_t y1 = sy * r + y;

    // Calculate pair of coordinates for segment end
    float sx2 = cos((i + seg - 90) * 0.0174532925);
    float sy2 = sin((i + seg - 90) * 0.0174532925);
    int x2 = sx2 * (r - w) + x;
    int y2 = sy2 * (r - w) + y;
    int x3 = sx2 * r + x;
    int y3 = sy2 * r + y;

    if (i < v) { // Fill in coloured segments with 2 triangles
      gfx.fillTriangle(x0, y0, x1, y1, x2, y2, colour);
      gfx.fillTriangle(x1, y1, x2, y2, x3, y3, colour);
      text_colour = colour; // Save the last colour drawn
    }
    else // Fill in blank segments
    {
      gfx.fillTriangle(x0, y0, x1, y1, x2, y2, ST77XX_GRAY);
      gfx.fillTriangle(x1, y1, x2, y2, x3, y3, ST77XX_GRAY);
    }
  }


  // Set the text colour to default
  gfx.setTextColor(ST77XX_WHITE, ST77XX_BLACK);
  // Uncomment next line to set the text colour to the last segment value!
  // gfx.setTextColor(text_colour, ST77XX_BLACK);

  // clear the area first
  gfx.setCursor(50, 50);
  gfx.print("    ");
  
  // then print the number
  gfx.setCursor(50, 50);  
  gfx.print(value);
  
  gfx.setCursor(60, 70);    
  gfx.println(units);
  // Calculate and return right hand side x coordinate
  return x + r;
}

// #########################################################################
// Return a 16 bit rainbow colour
// #########################################################################
unsigned int rainbow(byte value)
{
  // Value is expected to be in range 0-127
  // The value is converted to a spectrum colour from 0 = blue through to 127 = red

  byte red = 0; // Red is the top 5 bits of a 16 bit colour value
  byte green = 0;// Green is the middle 6 bits
  byte blue = 0; // Blue is the bottom 5 bits

  byte quadrant = value / 32;

  if (quadrant == 0) {
    blue = 31;
    green = 2 * (value % 32);
    red = 0;
  }
  if (quadrant == 1) {
    blue = 31 - (value % 32);
    green = 63;
    red = 0;
  }
  if (quadrant == 2) {
    blue = 0;
    green = 63;
    red = value % 32;
  }
  if (quadrant == 3) {
    blue = 0;
    green = 63 - 2 * (value % 32);
    red = 31;
  }
  return (red << 11) + (green << 5) + blue;
}


