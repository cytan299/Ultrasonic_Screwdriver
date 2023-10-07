/*
    sonic_case.scad is the code to generate a case for a sonic
    screwdriver
    
    Copyright (C) 2023  C.Y. Tan
    Contact: cytan299@yahoo.com

    This file is part of the CP4 and CP5 dust cover distribution.

    sonic_case.scad is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    sonic_case.scad is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with sonic_case.scad.  If not, see <http://www.gnu.org/licenses/>.

*/

$fn=100;

/***************************************
	Inner tube definitions
****************************************/

// inside dimensions of the lower case
IBox_len_x = 23.26; // mm

IBox_total_y = 127.1558; //mm, total length of the internal size
IBox_len_y1a = 40.6; // mm, length of case closest to wall
IBox_len_y0a = 77.7558;//86.5558; // mm, length of case closest to USB

IBox_len_y0 = 109.0558;// mm, distance from ref (0,0) to the bottom of the wing
IBox_len_y1 = IBox_total_y - IBox_len_y0; //18.1 //mm, remining distance


IBox_len_y = IBox_total_y; // mm

IBox_len_z = 5.825; //mm

// inside dimensions of the lower case

IBox_len_z0 = IBox_len_z; //mm
IBox_len_z1 = 11.65; //mm

/*********/

// inside dimensions of the upper case
IUBox_len_x = IBox_len_x; // mm

IUBox_len_y0 = IBox_len_y0; // mm
IUBox_len_y1 = IBox_len_y1; //mm

IUBox_len_y = IUBox_len_y0 + IUBox_len_y1; // mm

IUBox_len_z = IBox_len_z;//2*IBox_len_z1-IBox_len_z; //mm, (total inside z = 2*IBox_len_z1) - (lower box z = IBox_len_z)

// inside dimensions of the upper case
IUBox_len_z0 = IUBox_len_z; //mm
IUBox_len_z1 = IBox_len_z1;

IUBox_total_y = IBox_total_y;
IUBox_len_y0a = IBox_len_y0a; // mm, length of case closest to USB
IUBox_len_y1a = IBox_len_y1a; // mm, length of case closest to LED


// outside dimensions of lower box

Box_wall_t = 2; //mm, wall thickness

Box_len_x = IBox_len_x + 2*Box_wall_t; //mm
Box_len_y = IBox_len_y + Box_wall_t; //mm
Box_len_z = IBox_len_z + 1*Box_wall_t; //mm

Box_len_z0 = IBox_len_z0 + Box_wall_t; //mm
Box_offset_z0 = IBox_len_z1 - IBox_len_z; //mm, the box at the USB end has a z offset

Box_len_y1 = IBox_len_y1 + Box_wall_t; //mm
Box_len_z1 = IBox_len_z1 + Box_wall_t; //mm

Box_mid_x_pos = Box_len_x/2.0;



// outside dimensions of the upper

UBox_wall_t = 2; //mm, wall thickness

UBox_len_x = IUBox_len_x + 2*UBox_wall_t; //mm
UBox_len_y = IUBox_len_y + UBox_wall_t; //mm
UBox_len_z = IUBox_len_z + 1*UBox_wall_t; //mm

UBox_len_z0 = IUBox_len_z0 + 1*Box_wall_t; // mm
UBox_len_z1 = IUBox_len_z1 + 1*Box_wall_t; // mm


UBox_offset_z0 = Box_offset_z0; //IUBox_len_z1 - IUBox_len_z; //mm, the box at the USB end has a z offset

UBox_mid_x_pos = UBox_len_x/2.0;



//end wall
End_Wall_len_z = 22.84;  //mm

//screw holes
screw_r = 1.0; //mm

// pillar definitions
  // A is for feather

  pillarA_len_z = 9.51; //mm
  pillarA_width  = 3.6; // mm
  pillarA_hole_r = 0.5; //mm

  // B is for the camera
  pillarB_len_z = 4.26; //mm
  pillarB_r = 2.5; // mm
  pillarB_hole_r = 0.5; //mm

  // C is for audio amp
  pillarC_len_z = 1.5; //mm
  pillarC_r = 2.5; // mm
  pillarC_hole_r = 0.5; //mm

  // D is for sonic
  pillarD_len_z = 4.26; //mm
  pillarD_r = 2.5; // mm
  pillarD_hole_r = screw_r; //mm

  //E is for i2s
  pillarE_len_z = 3.75; //mm
  pillarE_r = 2.5; // mm
  pillarE_hole_r = 0.5; //mm
  



// camera hole radius
camera_r = 5.1; //4.80; //mm

// ultrasound hole radius
ultrasound_r = 8.5; //mm
ultrasound_h = 8.9; //mm, height of the tube
ultrasound_tube_r = 10.66;
ultrasound_z_pos = IBox_len_z1;


// LED ring
LED_outer_r = 18.56; //mm
LED_inner_r = 11.6; //mm
LED_inner_h = 3.35; //mm
LED_top_r = 20.76; // mm the top transparent cover
LED_top_h = 1; // mm thickness of the transparent cover

LED_pcboard_h = 3.35; //mm


// wing thickness
wing_thickness = 5; // mm

// Screen size
Screen_len_x =17.7; //mm
Screen_len_y = 41.6; //36.794; //mm


// 3 button access hole size
button3_len_dx = 1; // small correction for strength
button3_len_x = 23.36-button3_len_dx; //mm
button3_len_y = 11.343; //mm

// push button hole size
pushbutton_r = 5; // mm
pushbutton_z = 67.1679; //mm

// spring holder size
spring_holder_len_x = 23.2588; // mm
spring_holder_len_y = 24.9735; // mm




/***************************************
	Outer tube definitions
****************************************/


// inside dimensions of outer tube
O_IBox_r0 = 33.7/2; //mm, closest to the USB port
O_IBox_r1 = 22.05/2; //mm, closes to the ultrasonic

O_IBox_y0 = 108.9558; // mm, the longest part closest to the USB port to the start of the cone
O_IBox_y1 = 8.8; // mm, the shortest part closest to ultrasonic
O_IBox_total_y = O_IBox_y0 + O_IBox_y1;

// outside dimensions of outer tube
O_Box_r0 = O_IBox_r0 + Box_wall_t; //mm, closest to the USB port
O_Box_r1 = O_IBox_r1 + Box_wall_t; //mm, closes to the ultrasonic

O_Box_y0 = O_IBox_y0 + 0*Box_wall_t; //mm, the longest part closest to USB port. Note no wall at the USB end.
O_Box_y1 = O_IBox_y1 + Box_wall_t;// mm, the shortest part closest to ultrasonic

// battery compartment
battery_r = 17/2.0;//mm
battery_wall_t = Box_wall_t; //mm

battery_tilt_angle = 12.8835; // deg. rotation angle for battery compartment

/****
  Cone definitions
*****/
cone_tab_len_z = 8.0979;

/******
  End cap
 *****/

// end cap

endcap_thread_r = O_Box_r0 + 1; // mm, radius of the thread
endcap_thread_h = 10; //mm, height of the thread
endcap_thread_p = 2; // mm, thread pitch
endcap_outer_dr = 0.5; //mm, move in the outer radius a little for the vertical wings
endcap_outer_r = endcap_thread_r+Box_wall_t - endcap_outer_dr; //mm, outer radius of the endcap

endcap_slip_r = O_IBox_r0 + Box_wall_t;
endcap_slip_hole_r = 14; //mm, outer radius of the slip adapter
endcap_slip_h = 7.91/2; //mm height of the tube

endcap_hole_r = 1;
endcap_pos_z = 5;


/***************************************
	tail
****************************************/

Tail_total_len_y = 30.7558;  // mm, totail length  of the tail including tab
Tail_tab_len = 6.2776; // mm


module make_lower_box0()
{
  // this is the box that is closest to the USB port

  Box_len_y0a = IBox_len_y0a;

  translate([0,0,Box_offset_z0]){
    difference(){  
      union(){
	difference(){
          // make outside cube
	  union(){
	    cube([Box_len_x, Box_len_y0a, Box_len_z], center= false);

	  }

	  // remove the edge to that I can round it later
	  union(){
	    translate([-Box_wall_t, -Box_wall_t, 0])	  
	      cube([2*Box_wall_t, Box_len_y + 2*Box_wall_t, Box_wall_t], center=false);
	    translate([IBox_len_x+Box_wall_t, -Box_wall_t, 0])
	      cube([2*Box_wall_t, Box_len_y + 2*Box_wall_t, Box_wall_t], center=false);
	  }
	}

        // add in the round edges
        translate([Box_wall_t, 0, Box_wall_t]){
	  rotate([-90,0,0]){
            cylinder(h=Box_len_y0a,r=2, center=false);
	  }
        }
      
        translate([IBox_len_x+Box_wall_t, 0, Box_wall_t]){
	  rotate([-90,0,0]){
            cylinder(h=Box_len_y0a,r=2, center=false);
	  }
	}
      }

      // remove inside
      translate([Box_wall_t, -Box_wall_t, Box_wall_t])
        cube([IBox_len_x , IBox_len_y+4*Box_wall_t , IBox_len_z + 4*Box_wall_t],
	     center=false);

    }
  }
  
}

module make_lower_middle_box()
{
  union(){
    // make angled wall
    translate([Box_len_x/2.0,IBox_len_y0a,Box_offset_z0+Box_wall_t/2.0]){
      //get the angled slide to be into the correct orientation
      rotate([0,-90,0]){
	translate([-6.825,0,-Box_len_x/2.0]){
	  linear_extrude(height=Box_len_x, center=false){
	    polygon(points=[[5.825,0.00],[7.825, 0.0],[2.00,8.80],[0,8.8]]);
	  }
	}
      }
    }

    //make left side walls
    translate([Box_wall_t,IBox_len_y0a,Box_len_z1]){
      rotate([0,-90,0]){
        translate([-13.65//-10.7375,0
		   ,-0*Box_wall_t/2.0]){
          linear_extrude(height=Box_wall_t, center=false){
	    polygon(points=[[7.825,0.00],[13.65, 0.0],[13.65,8.80],[0,8.8]]);  

	  }
        }
      }
    }


    //make left side walls
    translate([Box_len_x,IBox_len_y0a,Box_len_z1]){
      rotate([0,-90,0]){
        translate([-13.65//-10.7375,0
		   ,-0*Box_wall_t/2.0]){
          linear_extrude(height=Box_wall_t, center=false){
	    polygon(points=[[7.825,0.00],[13.65, 0.0],[13.65,8.80],[0,8.8]]);  

	  }
        }
      }
    }

  }


}

  


module make_lower_box1()
{
  // this is the box that is closest to the end wall

  sidewall_len = 8.8; //mm
  Box_len_y1a = IBox_len_y1a + Box_wall_t;
  
  difference(){  
    union(){
      difference(){
        // make outside cube
	union(){
	  translate([0, IBox_total_y - IBox_len_y1a]){
	    	    cube([Box_len_x,  Box_len_y1a, IBox_len_z1 + Box_wall_t], center= false);
	    }

	}

	// remove the edge to that I can round it later
	union(){
	  translate([-Box_wall_t, -Box_wall_t, 0])	  
	    cube([2*Box_wall_t, Box_len_y + 2*Box_wall_t, Box_wall_t], center=false);
	  translate([IBox_len_x+Box_wall_t, -Box_wall_t, 0])
	    cube([2*Box_wall_t, Box_len_y + 2*Box_wall_t, Box_wall_t], center=false);
	}
      }

      // add in the round edges
      translate([Box_wall_t, IBox_total_y - IBox_len_y1a, Box_wall_t]){
	rotate([-90,0,0]){
          cylinder(h=Box_len_y1a,r=2, center=false);
	}
      }
      

      translate([IBox_len_x+Box_wall_t, IBox_total_y - IBox_len_y1a, Box_wall_t]){
	rotate([-90,0,0]){
          cylinder(h=Box_len_y1a,r=2, center=false);
	}
      }


    }

    // remove inside
    translate([Box_wall_t, -Box_wall_t, Box_wall_t])
      cube([IBox_len_x , IBox_len_y+4*Box_wall_t , IBox_len_z + 4*Box_wall_t],
	   center=false);

   }  
  
}

module make_upper_box0()
{
  // this is the box that is closest to the USB port

  UBox_len_y0a = IUBox_len_y0a;

  translate([0,0,UBox_offset_z0]){  
    difference(){  
      union(){
        difference(){
          // make outside cube
	  union(){
            cube([UBox_len_x, UBox_len_y0a, UBox_len_z], center= false);
	  	  
	  }
	

	  // remove the edge to that I can round it later
	  union(){
	    translate([-UBox_wall_t, -UBox_wall_t, 0])	  
	      cube([2*UBox_wall_t, UBox_len_y + 2*UBox_wall_t, UBox_wall_t], center=false);
	    translate([IUBox_len_x+UBox_wall_t, -UBox_wall_t, 0])
	      cube([2*UBox_wall_t, UBox_len_y + 2*UBox_wall_t, UBox_wall_t], center=false);
	  }
        }

        // add in the round edges
        translate([UBox_wall_t, 0, UBox_wall_t]){
	  rotate([-90,0,0]){
            cylinder(h=UBox_len_y0a,r=2, center=false);
	  }
        }

        translate([IUBox_len_x+UBox_wall_t, 0, UBox_wall_t]){
	  rotate([-90,0,0]){
            cylinder(h=UBox_len_y0a,r=2, center=false);
	  }
        }
      
      
      }

      // remove inside
      translate([UBox_wall_t, -UBox_wall_t, UBox_wall_t])
        cube([IUBox_len_x , IUBox_len_y+4*UBox_wall_t , IUBox_len_z + 2*UBox_wall_t],
	     center=false);

     }
  }
  
}

module make_upper_middle_box()
{
  union(){
    // make angled wall
    translate([UBox_len_x/2.0,IUBox_len_y0a,UBox_offset_z0+UBox_wall_t/2.0]){
      //get the angled slide to be into the correct orientation
      rotate([0,-90,0]){
	translate([-6.825,0,-UBox_len_x/2.0]){
	  linear_extrude(height=UBox_len_x, center=false){
	    polygon(points=[[5.825,0.00],[7.825, 0.0],[2.00,8.80],[0,8.8]]);
	  }
	}
      }
    }

    //make left side walls
    translate([UBox_wall_t,IUBox_len_y0a,UBox_len_z1]){
      rotate([0,-90,0]){
        translate([-13.65,0,0]){
          linear_extrude(height=UBox_wall_t, center=false){
	    polygon(points=[[7.825,0.00],[13.65, 0.0],[13.65,8.80],[0,8.8]]);  

	  }
        }
      }
    }


    //make left side walls
    translate([UBox_len_x,IUBox_len_y0a,UBox_len_z1]){
      rotate([0,-90,0]){
        translate([-13.65//-10.7375,0
		   ,-0*Box_wall_t/2.0]){
          linear_extrude(height=UBox_wall_t, center=false){
	    polygon(points=[[7.825,0.00],[13.65, 0.0],[13.65,8.80],[0,8.8]]);  

	  }
        }
      }
    }

  }


}

module make_upper_box1()
{
  // this is the box that is closest to the USB port

  sidewall_len = 8.8; //mm  
  UBox_len_y1a = IUBox_len_y1a;// + Box_wall_t;

   difference(){  
    union(){
      difference(){
        // make outside cube
	union(){
	  translate([0,IBox_total_y - IUBox_len_y1a,0]){
	    cube([UBox_len_x, UBox_len_y1a, IUBox_len_z1 + UBox_wall_t], center= false);
	    }
	}

	// remove the edge to that I can round it later
	union(){
	  translate([-UBox_wall_t, -UBox_wall_t, 0])	  
	    cube([2*UBox_wall_t, UBox_len_y + 2*UBox_wall_t, UBox_wall_t], center=false);
	  translate([IUBox_len_x+UBox_wall_t, -UBox_wall_t, 0])
	    cube([2*UBox_wall_t, UBox_len_y + 2*UBox_wall_t, UBox_wall_t], center=false);
	}
      }

      // add in the round edges
      translate([UBox_wall_t, IUBox_total_y - IUBox_len_y1a, UBox_wall_t]){
	rotate([-90,0,0]){
          cylinder(h=UBox_len_y1a,r=2, center=false);
	}
      }

      translate([IUBox_len_x+UBox_wall_t, IUBox_total_y - IUBox_len_y1a, UBox_wall_t]){
	rotate([-90,0,0]){
          cylinder(h=UBox_len_y1a,r=2, center=false);
	}
      }
      
      
    }

    // remove inside
    translate([UBox_wall_t, -UBox_wall_t, UBox_wall_t])
      cube([IUBox_len_x , IUBox_len_y+4*UBox_wall_t , IUBox_len_z + 4*UBox_wall_t],
	   center=false);

   }
  
}




module make_end_wall(){
  
  translate([0,(IBox_len_y+0*Box_wall_t),Box_wall_t]){

    difference(){
      union(){
	cube([Box_len_x, Box_wall_t, End_Wall_len_z], center=false);

	// add in circle for led outer ring
	translate([Box_mid_x_pos, 0, ultrasound_z_pos ]){
	  rotate([-90, 0, 0]){
	    cylinder(h=Box_wall_t, r=LED_outer_r, center=false);
	  }
	}
	/*
    translate([Box_mid_x_pos,-Box_wall_t/2,ultrasound_z_pos]){
      rotate([0,0,0]){
	cylinder(h=4*ultrasound_r, r=0.5, center=false);
      }
    }

    translate([Box_mid_x_pos,-Box_wall_t/2,ultrasound_z_pos]){
      rotate([0,-90,0]){
	cylinder(h=4*ultrasound_r, r=0.5, center=false);
      }
    }	
	*/	

         // add in the cylinder mounts
	translate([5.17,-3,5.17]){
	  rotate([-90,0,0]){      
	    make_one_pillar(0,0,0, 3, 2.5, screw_r);
	  }
	}

	translate([22.41,-3,17.77]){
	  rotate([-90,0,0]){      
	    make_one_pillar(0,0,0, 3, 2.5, screw_r);
	  }
	}	  	
      }

      union(){
	translate([5.17,-Box_wall_t/2,5.17]){
	  //screw hole bottom
	  rotate([-90,0,0]){
	    cylinder(h=4*Box_wall_t, r=screw_r, center=false);
	  }
	}

        //screw hole top
	translate([22.41,-Box_wall_t/2,17.77]){
	  rotate([-90,0,0]){
	    cylinder(h=4*Box_wall_t, r=screw_r, center=false);
	  }
	}

        // ultrasound hole 
	translate([Box_mid_x_pos,-Box_wall_t/2,ultrasound_z_pos]){
	  rotate([-90,0,0]){
	    cylinder(h=4*Box_wall_t, r=ultrasound_r, center=false);
	  }
	}

	//holes for LED wires
	translate([8.6145,-Box_wall_t/2,18.5125]){
	  rotate([-90,0,0]){
	    cylinder(h=4*Box_wall_t, r=2.5, center=false);
	  }
	}

	translate([18.6455,-Box_wall_t/2,4.7875]){
	  rotate([-90,0,0]){
	    cylinder(h=4*Box_wall_t, r=2.5, center=false);
	  }
	}
	

	
      }
    }
  }
}

module make_ultrasound_cover_whole()
{
  translate([Box_mid_x_pos, IBox_len_y + Box_wall_t, ultrasound_z_pos+Box_wall_t]){
    
    union(){

      us_x_offset = 9.16 + 0*3.1; //mm
      us_y_offset = 5;//mm
      us_r = ultrasound_r+3.1; //mm

      // left wing
      translate([-us_r, 0, 0]){
        make_ultrasound_wing(-us_x_offset,-us_y_offset,-wing_thickness/2,0);
      }

      // bottom wing

      rotate([0, 90, 0]){
        translate([-us_r, 0, 0]){
          make_ultrasound_wing(-us_x_offset,-us_y_offset,-wing_thickness/2,0);
        }
      }

      // right wing

      rotate([0, 180, 0]){
        translate([-us_r, 0, 0]){
          make_ultrasound_wing(-us_x_offset,-us_y_offset,-wing_thickness/2,0);
        }
      }

      // top wing
      rotate([0, -90, 0]){
        translate([-us_r, 0, 0]){
          make_ultrasound_wing(-us_x_offset,-us_y_offset,-wing_thickness/2,0);
        }
      }
  

      // the ultrasound tube
      translate([0, ultrasound_h, 0]){
        rotate([90,0,0]){
          difference(){
	    cylinder(h=(ultrasound_h + LED_top_h)/2 , r=ultrasound_tube_r+0*LED_inner_r, center=false);
	    translate([0,0, -ultrasound_h]){
	      cylinder(h=4*ultrasound_h, r=ultrasound_r, center=true);
	    }
          }
        }
      }

      // the LED top transparent ring
      translate([0, LED_pcboard_h+LED_top_h/2, 0]){
        rotate([90,0,0]){
          difference(){
	    cylinder(h=LED_top_h, r=LED_top_r, center=true);
	    translate([0,0, -Box_wall_t]){
	      cylinder(h=4*Box_wall_t, r=ultrasound_r, center=true);
	    }
          }
        }
      }


      // make ring to centre the LED ring
      translate([0,LED_inner_h/2,0]){
        rotate([90,0,0]){
          difference(){
	    cylinder(h=LED_inner_h, r=LED_inner_r, center=true);
	    translate([0,0, -LED_inner_h]){
	      cylinder(h=4*LED_inner_h, r=ultrasound_r, center=true);
	    }
          }
        }
      }

    }
  }
}

module make_ultrasound_cover()
{
  difference(){
    // make the entire cover first
    make_ultrasound_cover_whole();
    // now I have to remove LED centring ring parts to accomoodate neopixel wires

      // make ring to centre the LED ring

    translate([Box_mid_x_pos, IBox_len_y + Box_wall_t, ultrasound_z_pos+Box_wall_t]){      
      translate([0,LED_inner_h,0]){
	rotate([90,45,0]){
	  translate([4,0, 5]){
	    cube([1.75*LED_inner_r, 2*LED_inner_r, 10], center=true);
	  }
	}
      }
    }

  }    
}

module make_one_hole(x,y)
{
  translate([x,y,-Box_wall_t/2])
    cylinder(h=2*Box_wall_t, r=screw_r, center=false);
  
}

module make_one_pillar(x,y,z, p_len, p_r, hole_r)
{
  difference(){
    translate([x,y,z]){
      cylinder(h=p_len, r=p_r, center=false);
    }

    translate([x,y,z-2*Box_wall_t]){
      cylinder(h=p_len + 4*Box_wall_t, r=hole_r, center=false);
    }
    
  }
}

module make_one_rect_pillar(x,y,z, p_h, p_len, xr, yr, hole_r)
{
  difference(){
    translate([x,y,z + p_h/2.0]){
      cube([p_len, p_len, p_h], center=true);
    }

    translate([xr,yr,z-2*Box_wall_t]){
      cylinder(h=p_h + 4*Box_wall_t, r=hole_r, center=false);
    }
    
  }
}



module make_camera_hole()
{
  union(){
    translate([Box_mid_x_pos,104.2558,-Box_wall_t/2])
      cylinder(h=2*Box_wall_t, r=camera_r, center=false);
  }
 
}

module make_tail_section_holes()
{
  x0 = 5.5; //mm
  y0 = 27.6170; //mm

  dx = 17.26; // horizontal distance between holes

  union(){
        translate([x0,y0,2*Box_wall_t]){
          cylinder(h=30, r=screw_r/2.0, center=false);
    }

    translate([x0+dx-screw_r,y0,2*Box_wall_t]){    
      cylinder(h=30, r=screw_r/2.0, center=false);
    }
  }
}

module make_battery_gap()
{
  translate([Box_wall_t, -10, 0]){
        cube([16.655,2*10, 2*Box_offset_z0],center=false);
    //    cube([IBox_len_x,2*10, 2*Box_offset_z0],center=false);
  }

}

module make_led_compartment()
{
  led_outershell_r = 3.1; //mm
  led_outershell_len = 9.7785; //mm

  led_hole_r = 2; //mm, radius of LED hole in the cone wall
  led_hole_dy = 0.5; // hole is not concentric with the outershell

    translate([0, O_IBox_r0 - led_outershell_r,107.9773-0]){
    difference(){
      cylinder(r=led_outershell_r, h=led_outershell_len, center=false);
      union(){

	// make the offset hole
	translate([0,-led_hole_dy, -2*led_outershell_len]){
	  cylinder(r=led_hole_r, h=4*led_outershell_len, center=false);
	}

	// make the inclined plane that shaves off the top of the led_compartment

	translate([0,8.445,0]){ // translate the cutting block
	  rotate([123.5018-90,0,0]){
	    dw = 3.5;
	    dL = 20;
	    translate([-2*dw,-dw,0]){
	      cube([4*dw, 2*dw, dL], center = false);
	    }
	  }
	}
	
      }
    }
  }
}

module make_led_hole()
{
  led_hole_r = 1.2; //mm, radius of LED hole
  translate([0,13.25,O_IBox_total_y - 2*Box_wall_t]){
    cylinder(h=4*Box_wall_t, r= led_hole_r, center=false );
  }  
}

module make_cone_mounting_holes(screw_hole_r)
{
  tube_len_no_cone = O_Box_y0 - cone_tab_len_z;
  tab_len = 12.2387; //mm
  dz = tube_len_no_cone + tab_len/4;

  hole_angle = 60; // deg

  translate([0,0,dz]){  
    union(){
      rotate([0,90,hole_angle]){
	cylinder(r=screw_hole_r/2.0, h=4*O_Box_r0, center = true);
      }

      rotate([0,90,-hole_angle]){
	cylinder(r=screw_hole_r/2.0, h=4*O_Box_r0, center = true);
      }
    }
  }
}

/*
 make_switch_tab_hole_big is for the larger ADAFRUIT switch that I bought.

*/

module make_switch_tab_hole_big()
{
  delta_x = 0.0; //mm give some tolarance to the printer error
		 // see make_switch_bay() as well. 
  // make the hole for the toggle 
  translate([20.9575-delta_x,5.3,-2*IBox_len_z]){
    cube([4, 5, 4*IBox_len_z], center=false );
  }

  // and make the bottom wall thinner as well
  translate([20.6550,1.7,Box_offset_z0+Box_wall_t/2]){
    cube([4.605+delta_x, 11.9, IBox_len_z], center=false );
  }

}

module make_switch_tab_hole()
{
  dtolx = 0.25; //mm give some tolarance to the printer error
		 // see make_switch_bay() as well.
  dtoly = 0.2; //mm
  // make the hole for the toggle 
  translate([22.4950-dtolx,5.6225 - dtoly/2.0,-2*IBox_len_z]){
    cube([1.7+dtolx, 4.355 + dtoly, 4*IBox_len_z], center=false );
  }

  // and make the bottom wall thinner as well  
  translate([21.330-dtolx,3.39 - dtoly/2.0,Box_offset_z0+Box_wall_t/2]){
    cube([3.93+dtolx, 8.82+dtoly, IBox_len_z], center=false );
  }
}

module make_switch_leads_gap()
{
  translate([Box_wall_t,-2,0]){
      cube([4.695, 15.6, 2*Box_len_z], center=false );    
  }
}




module make_feather_pillars()
{

  // coordinate of the pillars w.r.t. (0,0)
  x0 = 3.8; //mm
  y0 = 33.2958; //mm

  dx = 19.66; // horizontal distance between pillars
  dy = 45.72; // vertical distance between  pillars

  dx0_hole = 0.305;
  
  make_one_rect_pillar(x0, y0, Box_offset_z0+Box_wall_t, pillarA_len_z,
		       pillarA_width, x0+dx0_hole, y0,pillarA_hole_r);

  
  make_one_rect_pillar(x0+dx, y0, Box_offset_z0+Box_wall_t, pillarA_len_z,
		       pillarA_width, x0+dx-dx0_hole, y0,pillarA_hole_r);

  make_one_rect_pillar(x0,y0+dy, Box_offset_z0+Box_wall_t, pillarA_len_z,
		       pillarA_width, x0+dx0_hole,  y0+dy, pillarA_hole_r);

  make_one_rect_pillar(x0+dx, y0 + dy, Box_offset_z0+Box_wall_t, pillarA_len_z,
		       pillarA_width, x0+dx-dx0_hole, y0 + dy,pillarA_hole_r);

}

module make_lower_cover_pillars()
{
  // coordinate of the pillars w.r.t. (0,0)
  x0 = 3.8; //mm
  y0 = 17.4; //mm

  dx = 19.66; // horizontal distance between pillars

  dx0_hole = 0.305;
  
  make_one_rect_pillar(x0, y0, Box_offset_z0+Box_wall_t, 2*IBox_len_z,
		       pillarA_width, x0+dx0_hole, y0,pillarA_hole_r);

  make_one_rect_pillar(x0+dx, y0, Box_offset_z0+Box_wall_t, 2*IBox_len_z,
		       pillarA_width, x0+dx-dx0_hole, y0,pillarA_hole_r);  
  
}

module make_camera_pillars()
{

  // coordinate of the pillars w.r.t. (0,0)
  x0 = 7.28; //mm
  y0 = 94.0958; //mm

  dx = 12.7; // horizontal distance between pillars
  dy = 20.32; // vertical distance between  pillars
  

  make_one_pillar(x0, y0, Box_wall_t, pillarB_len_z,
		  pillarB_r, pillarB_hole_r);

  make_one_pillar(x0+dx, y0, Box_wall_t, pillarB_len_z,
		  pillarB_r, pillarB_hole_r);

  make_one_pillar(x0, y0+dy, Box_wall_t, pillarB_len_z,
		  pillarB_r, pillarB_hole_r);

  make_one_pillar(x0+dx, y0+dy, Box_wall_t, pillarB_len_z,
		  pillarB_r, pillarB_hole_r);      
  
}

module make_lower_lips()
{
  Box_len_y0a = IBox_len_y0a;
  lip_thickness = Box_wall_t/2.0;
  wing_len = 18.1;
  
  translate([lip_thickness,0,Box_offset_z0+Box_len_z]){
    cube([lip_thickness, IBox_total_y-wing_len, lip_thickness], center=false);
  }

  translate([Box_len_x-2*lip_thickness,0,Box_offset_z0+Box_len_z]){
    cube([lip_thickness, IBox_total_y-wing_len, lip_thickness], center=false);
  }  
}

module make_upper_lips()
{
  Box_len_y0a = IBox_len_y0a;
  lip_thickness = Box_wall_t/2.0;
  lip_height = 1.2*lip_thickness;
  wing_len = 18.1;
  dy = 1; // mm, add 1 mm to the length of the lip so to accommodate small length difference with lower lip
  
  translate([lip_thickness,0,Box_offset_z0+Box_len_z-lip_height]){
    cube([2*lip_thickness, IBox_total_y-wing_len + dy, 2*lip_thickness], center=false);
  }

  translate([Box_len_x-2*lip_thickness-lip_thickness,0,Box_offset_z0+Box_len_z-lip_height]){
    cube([2*lip_thickness, IBox_total_y-wing_len + dy, 2*lip_thickness], center=false);
  }  
}

// put more material at the bottom of the cover
module make_badge_bottom()
{
  badge_r = 9+2; // mm
  badge_z = 3;  //mm, depth of bottom

  badge_ypos = IBox_total_y - IUBox_len_y1a + badge_r + 2.2712;
  
  translate([UBox_len_x/2, badge_ypos, 0]){
    cylinder(r=badge_r, h=badge_z, center=false);
  }  
}

module make_badge_indent()
{
  badge_r = 9; // mm
  badge_z = 1.5; //mm, depth of indent

  badge_ypos = IBox_total_y - IUBox_len_y1a + badge_r + 2.2712;
  
  translate([UBox_len_x/2, badge_ypos, -1]){
    cylinder(r=badge_r, h=badge_z+1, center=false);
  }
}


/*
 make_switch_bay_big is for the larger ADAFRUIT switch that I bought.

*/

module make_switch_bay_big()
{
  // I have to add some tolerance to this because the width of the upper wall be slightly
  // wider than 2 mm
  dtol = 0; //mm, this is to give a tolerance to the printer error
  translate([18.655,0,Box_offset_z0+Box_wall_t]){
    difference(){
    // outside walls of the switch bay
      cube([6.605, 15.6, Box_len_z], center=false );


    // make the space for the switch      
      translate([2-dtol,1.7,0]){
	cube([4.605, 12.2, 2*IBox_len_z], center=false );
      }
      
    }
  }
}


module make_switch_bay()
{
  // I have to add some tolerance to this because the width of the upper wall be slightly
  // wider than 2 mm
  dtolx = 0.25; //mm, this is to give a tolerance to the printer error
  dtoly= 0.2; // mm

  union(){
    // make the bay with the thin wall
    translate([20.565,0,Box_offset_z0+Box_wall_t]){
      difference(){
        // outside walls of the switch bay
	cube([4.695, 15.6, Box_len_z], center=false );

        // make the space for the switch      
	translate([0.7650-dtolx,3.39 - dtoly/2.0,0]){
	  cube([3.93+dtolx, 8.82+dtoly, 2*IBox_len_z], center=false );
	}
      }

      // add in a step to strengthen the wall
      translate([-1.91,0,0]){
	cube([1.91, 15.6, Box_wall_t], center=false);
      }
      
    }
  }
}

module make_switch_plug()
{
  dtolx = 0*0.25; //mm, this is to give a tolerance to the printer error
  dtoly= 0*0.2; // mm
  
  // switch depth is about 11.25 mm from the top of the case
  sw_depth = 11.25; //mm
  // outside walls of the top plate of the switch plug
  translate([15+20.565,0,Box_offset_z0+Box_wall_t]){ // move the plug to the right so that I can see it way from the switch bay   
    translate([0.7650-dtolx,3.39 - dtoly/2.0,0]){
      difference(){
	wall_t = 1.5; //mm, wall thickness of the plug
	plug_z = 0.75*sw_depth; // mm height of the plug
	cube([3.93+dtolx, 8.82+dtoly, plug_z], center=false );
	union(){
	  // make the hole for the leads 
	  translate([wall_t/2, wall_t/2, -3*plug_z/2]){
	    cube([3.93+dtolx -wall_t, 8.82+dtoly-wall_t, 3*plug_z]);
	  }
	  // make holes in the wall to help lift the plug
	  translate([(3.93+dtolx)/2, 0, plug_z-2]){
	    rotate([90,0,0]){
	      cylinder(r=0.75,h=20, center=true );
	    }
	  }
	}
      }
    }
  }
}

module make_wing(x,y,z, angle)
{
  translate([x,y,z]){
    rotate([0,angle,0]){
      
      difference(){
	linear_extrude(height=wing_thickness, center=false){
	  polygon(points=[[0,0],[7.13,15.1],[4.93,15.1],[4.93,18.1],[0,18.1]]);
	}

	translate([-Box_wall_t,16.6, wing_thickness/2]){
	  rotate([0,90,0]){
	    cylinder(h=5*Box_wall_t, r=0.5, center=false);
	  }
	}
      }
    }
  }
}

module make_ultrasound_wing(x,y,z, angle)
{
  translate([x,y,z]){
    rotate([0,angle,0]){
      
      difference(){
	linear_extrude(height=wing_thickness, center=false){
	  polygon(points=[[0,0],[2.1,0],[2.1,8.35],[9.16,8.35],[9.16,5],[12.26, 5],[12.26,13.9],[10.1,13.9],[0,9.35]]);
	}

	translate([-Box_wall_t,1.5, wing_thickness/2]){
	  rotate([0,90,0]){
	    cylinder(h=5*Box_wall_t, r=1.1, center=false);
	  }
	}
      }
    }
  }
}

module make_3_wings()
{
  translate([Box_mid_x_pos, IBox_len_y, ultrasound_z_pos+Box_wall_t]){
    union(){
    // right
      make_wing(LED_outer_r - wing_thickness,-IBox_len_y1,-wing_thickness/2,0);

    // bottom
      rotate([0,90,0]){
	make_wing(LED_outer_r - wing_thickness,-IBox_len_y1,-wing_thickness/2,0);
      }

    // left
      rotate([0,180,0]){
	make_wing(LED_outer_r - wing_thickness,-IBox_len_y1,-wing_thickness/2,0);
      }
      
      /*
    // top
      rotate([0,-90,0]){
	make_wing(LED_outer_r - wing_thickness,-IBox_len_y1,-wing_thickness/2,0);
      }
      */
      
    }

  }
}

module make_top_wing()
{
  translate([Box_mid_x_pos, IBox_len_y, ultrasound_z_pos+Box_wall_t]){
    union(){

    // top
      rotate([0,-90,0]){
	make_wing(LED_outer_r - wing_thickness,-IBox_len_y1,-wing_thickness/2,0);
      }

      
    }

  }
}

module make_guide_wings()
{
  dtol = 0.0; //mm delta thickness so that the wings can slide within the guides
  wing_t = wing_thickness + dtol;
  dx = 0.5;
  translate([-3.02,0,Box_offset_z0+Box_len_z0-wing_t/2]){
    linear_extrude(height=wing_t, center=false){
      // add in a little dx for x so that during slicing, the wing is
      // attached a lot more strongly
      polygon(points=[[0,0],[3.02+dx,0.00],[3.020+dx, 24.4782],[0.00,19.9158]]);
    }
  }

  translate([Box_len_x,0,Box_offset_z0+Box_len_z0-wing_t/2]){  
    linear_extrude(height=wing_t, center=false){
      polygon(points=[[0,0],[3.02,0.00],[3.020, 19.9158],[0.00,24.4782]]);		
    };
  }  
  
}

module make_top_cover()
{
  union(){
    
    translate([UBox_mid_x_pos,0,UBox_wall_t+ultrasound_z_pos+LED_top_r-7.13]){
      rotate([0,180,0]){
	translate([-UBox_mid_x_pos,0,0]){
	  difference(){
	    union(){
	      make_upper_box0();
	      make_upper_middle_box();
	      make_upper_box1();

	      make_badge_bottom();	      
	    }
	    

	    union(){
              // make screen hole
	      translate([4.78, 36.2928-1, 0]){
		cube([Screen_len_x, Screen_len_y+1, 7*Box_wall_t], center=false);
	      }

		// make 3 button access hole
	      //	      translate([2, 10, 0]){
	      translate([2+button3_len_dx/2, 30.7558, 0]){	      
		cube([button3_len_x, button3_len_y, 7*Box_wall_t], center=false);
	      }

	      /*******/
	      
	      // make wall a little thinner to accomodate the upper screws

	      translate([4.105,79.0158,3.3*Box_wall_t]){
		cylinder(h=2*Box_wall_t, r=2, center = false);
	      }

	      translate([23.1550,79.0158,3.3*Box_wall_t]){
		cylinder(h=2*Box_wall_t, r=2, center = false);
	      }	      

	      // thin out the top sides to accommodate the solder on the pins

	      translate([UBox_wall_t,36.2928-.5,UBox_offset_z0 +UBox_wall_t/2]){
		cube([IUBox_len_x, Screen_len_y+.5, IUBox_len_z1], center = false);
	      }

	      // remove some of the cover to accommodate the switch leads
	      make_switch_leads_gap();

              // make holes for the standoffs for the upper and lower covers
	      make_tail_section_holes();

	      // make lips

	      make_upper_lips();

	      // make badge indent
	      make_badge_indent();
		
	    }	    
	  }
	}
      }
    }
    make_top_wing();

  }
}


module make_lower_cover()
{

  difference(){
    union(){
      make_lower_box0();
      make_lower_middle_box();
      make_lower_box1();
      
      make_end_wall();
      make_3_wings();
      //      make_guide_wings();
    
      make_feather_pillars();
      make_camera_pillars();

      make_lower_lips();

      make_switch_bay();

      

    }

    union(){
      make_camera_hole();

      // make holes for the standoffs for the upper and lower covers
      make_tail_section_holes();

      // make the battery gap
      make_battery_gap();

      // make the hole for the switch tab
      make_switch_tab_hole();
    

    }
  }

}

module remove_tail_section()
{
  translate([-Box_len_x, -5, 0]){
    cube([4*Box_len_x, Tail_total_len_y - Tail_tab_len + 5, 4*Box_len_z], center=false);
  }
}

module make_tail_section_tab()
{
  tab_len = Tail_tab_len + 8.8782; //mm
  difference(){
    difference(){
      translate([Box_wall_t, 15.6, Box_offset_z0+Box_wall_t ]){
	cube([IBox_len_x, tab_len, 2*IBox_len_z], center=false);
      }
      translate([2*Box_wall_t, 15.6-2, Box_offset_z0+2*Box_wall_t]){
	cube([IBox_len_x - 2*Box_wall_t, 2*tab_len, 2*IBox_len_z - 2*Box_wall_t], center=false);
      }
    }

    // shave the tabs to take into account errors

    dx = 0.1;
    dz = 0.1;
    
    difference(){
      translate([Box_wall_t, Tail_total_len_y - Tail_tab_len, Box_offset_z0+Box_wall_t ]){
	cube([IBox_len_x, tab_len, 2*IBox_len_z], center=false);
      }
      translate([Box_wall_t + 2*dx , Tail_total_len_y - Tail_tab_len-2, Box_offset_z0+Box_wall_t +2*dz]){
	cube([IBox_len_x - 4*dx, 2*tab_len, 2*IBox_len_z - 4*dz], center=false);
      }
    }
  }
}

module make_tail_section()
{
  union(){
    difference(){
      union(){
        // for the lower
        make_lower_box0();
        make_guide_wings();
        make_switch_bay();
        make_i2s_standoffs();	

        // for the upper
        translate([UBox_mid_x_pos,0,UBox_wall_t+ultrasound_z_pos+LED_top_r-7.13]){
	  rotate([0,180,0]){
	    translate([-UBox_mid_x_pos,0,0]){
	      difference(){
	        union(){
		  make_upper_box0();

	        }
	        union(){
	          // remove some of the cover to accommodate the switch leads
		  make_switch_leads_gap();
	        }
	      }
	    }
	  }
        }
      }
      // make the battery gap
      make_battery_gap();
      
      // make the hole for the switch tab
      make_switch_tab_hole();      

      //remove excess
      remove_excess_tail_section();

      // open up a hole for a a 2-56 (drill diameter is 0.073" =
      // 1.8542 mm, radius = 0.9271 
      translate([22.9575,3*Box_wall_t,Box_offset_z0+4.7]){
	rotate([90,0,0]){
	  cylinder(r=0.9, h = 4*Box_wall_t, center=false);
	}
      }
    }

    difference(){
    
      // for the tail section tab
      make_tail_section_tab();
      // make holes for the standoffs for the upper and lower covers
      make_tail_section_holes();
    }
  }
}

module remove_excess_tail_section()
{
  translate([-Box_len_x, Tail_total_len_y-Tail_tab_len ,0]){
    cube([4*Box_len_x, IBox_total_y, 4*Box_len_z], center=false);
  }
}

/*
  Outer tube definitions
 */

module make_cone()
{
  union(){
    difference(){ 
      // make the upper cone
      translate([0,0,O_IBox_y0]){
	difference(){ 
          // make a cone. Note that r2=11.7011 is measured in acad
	  cylinder(h=O_Box_y1,r1=O_Box_r0,r2=11.7011, center=false);
	  translate([0,0,-5.4933]){
	    //add a small error tolerance
	    dr=0.4;
	    cylinder(h=14.2933,r1=20.4862+dr,r2=11.0250+dr, center=false);
	  }
	}
      }

      // make the hole for the inner tube
      dtol = 1; // add in some tolerance so that I can actually slide the tube
      edge_len_x = 27.26 + dtol; //mm 27.65
      edge_len_y = 15.65 + dtol; //mm 15.78

      edge_len_z = 40;//mm
      edge_r = 2.1; //mm

      translate([-edge_len_x/2,-edge_len_y/2,O_IBox_y0]){      
	union(){
	  difference(){ 
	    cube([edge_len_x,edge_len_y,edge_len_z], center=false);
		
            //kill off the edges
	    translate([-edge_r,-edge_r,-edge_len_z]){
	      cube([2*edge_r, 2*edge_r, 4*edge_len_z], center=false);
	    }

	    translate([edge_len_x-edge_r,-edge_r,-edge_len_z]){
	      cube([2*edge_r, 2*edge_r, 4*edge_len_z], center=false);
	    }

	    translate([edge_len_x-edge_r,edge_len_y-edge_r,-edge_len_z]){
	      cube([2*edge_r, 2*edge_r, 4*edge_len_z], center=false);
	    }

	    translate([-edge_r,edge_len_y-edge_r,-edge_len_z]){
	      cube([2*edge_r, 2*edge_r, 4*edge_len_z], center=false);
	    }
	  }

          // add in the round edges
	  translate([edge_r, edge_r, 0]){
	    cylinder(h=edge_len_z, r=edge_r, center=false);
	  }

	  translate([edge_len_x-edge_r, edge_r, 0]){
	    cylinder(h=edge_len_z, r=edge_r, center=false);
	  }

	  translate([edge_len_x-edge_r, edge_len_y-edge_r, 0]){
	    cylinder(h=edge_len_z, r=edge_r, center=false);
	  }

	  translate([edge_r, edge_len_y-edge_r, 0]){
	    cylinder(h=edge_len_z, r=edge_r, center=false);
	  }
	}
      }      
    }

    // add in the cone tab
    translate([0,0,O_IBox_y0-cone_tab_len_z]){
      difference(){
	cylinder(r=O_Box_r0, h=cone_tab_len_z, center=false);
	translate([0,0, -cone_tab_len_z]){
	  dr = 0.4; // add a little bit of tolerance 
	  cylinder(r=O_Box_r0 - Box_wall_t +dr, h=4*cone_tab_len_z, center=false);
	}
      }
    }
  }
}

module make_cone_parts()
{
  /*
  translate([Box_mid_x_pos, -(O_IBox_total_y-IBox_total_y)-Box_wall_t-51, Box_len_z1]){
    rotate([-90,0,0]){
  */  
  difference(){
    union(){
      make_cone();
      make_led_compartment();
    }

    union(){
      make_led_hole();
      make_cone_mounting_holes(1.5);
    }
    
  }
  /*  
    }
  }
  */
}
  




module make_upper_outer_tube()
{
  tube_len_no_cone = O_Box_y0 - cone_tab_len_z;
  
  union(){
   // make the upper cylinder
    difference(){
      union(){
	// cylinder that makes the outer wall
	cylinder(h=tube_len_no_cone, r=O_Box_r0, center=false);


	//make the skirt
	translate([0,0,10]){
	  cylinder(h=4.5332, r1=endcap_outer_r, r2=O_Box_r0, center=false);
	}
	

		// make the screw threads
	translate([0,0,10]){
	  rotate([180,0,0]){ // flip the screws by 180 deg which is r
			     //equired to screw into the cap
	    difference(){    
	      RodStart(2*endcap_thread_r, 0, endcap_thread_h, 2*endcap_thread_r, endcap_thread_p);	      
	      union(){

		// make a circular hole in the screw
		cylinder(r=O_IBox_r0, h=30, center=true);

		// then remove 1/2 the screw threads longitudinally
		translate([25,0,15]){
		  cube([50,10,30], center=false);

		}

	      }
	    }
	  }
	}
      }
      

      union(){
	cylinder(h=4*O_Box_y0, r=O_IBox_r0, center=true);

	translate([0,2*O_Box_r0, 0]){
	  cube([3*O_Box_r0, 2*2*O_Box_r0, 3*O_Box_y0], center=true);
	}

      }

    }

    // add the tab for attaching the cone

    tab_len = 12.2387; // mm
    tab_outer_r = O_IBox_r0;
    tab_inner_r = tab_outer_r - 1.5;
    tab_z_pos = 94.7385;

    translate([0,0, tab_z_pos]){
      difference(){
	cylinder(h=tab_len, r=tab_outer_r, center=false);
	union(){
	  // make the cylinder hole
	  translate([0,0, -tab_len]){
	    cylinder(h=4*tab_len, r=tab_inner_r, center=false);

	    // remove the everything below the rails
	    translate([-2*tab_outer_r,-(wing_thickness+0.5)/2.0,0]){
	      cube([4*tab_outer_r, 2*tab_outer_r, 4*tab_len], center = false);
	    }
	  }
	}
      }
    }    
  }    

}

module make_lower_outer_tube()
{
  tube_len_no_cone = O_Box_y0 - cone_tab_len_z;
  
  union(){
    // make the lower cylinder
    difference(){
      union(){
	cylinder(h=tube_len_no_cone, r=O_Box_r0, center=false);

	//make the skirt
	translate([0,0,10]){
	  cylinder(h=4.5332, r1=endcap_outer_r, r2=O_Box_r0, center=false);
	}
	
	
	// make the screw threads
	translate([0,0,endcap_thread_h]){
	  rotate([180,0,0]){ // flip the screws by 180 deg which is r
			     //equired to screw into the cap
	    difference(){    
	      RodStart(2*endcap_thread_r, 0, endcap_thread_h, 2*endcap_thread_r, endcap_thread_p);	      
	      union(){
		// make a circular hole in the screw
		cylinder(r=O_IBox_r0, h=30, center=true);

		// then remove 1/2 the screw threads longitudinally
		translate([-25,0,-15]){
		  cube([50,10,30], center=false);
		}
	      }
	    }
	  }
	}
      }

    
      union(){
	cylinder(h=4*O_Box_y0, r=O_IBox_r0, center=true);

	translate([0,-2*O_Box_r0, 0]){
	  cube([3*O_Box_r0, 2*2*O_Box_r0, 3*O_Box_y0], center=true);
	}

      }
    }

    // make the tab for attaching the cone
    // add the tab for attaching the cone

    tab_len = 12.2387; // mm
    tab_outer_r = O_IBox_r0; 
    tab_inner_r = tab_outer_r - 1.5;
    tab_z_pos = 94.7385; 

    translate([0,0, tab_z_pos]){
      difference(){
	cylinder(h=tab_len, r=tab_outer_r, center=false);
	union(){
	  // make the cylinder hole
	  translate([0,0, -tab_len]){
	    cylinder(h=4*tab_len, r=tab_inner_r, center=false);

	    // remove the everything below the rails
	    translate([-2*tab_outer_r,-2*tab_outer_r + (wing_thickness+0.5)/2,-tab_len]){
	      cube([4*tab_outer_r, 2*tab_outer_r, 4*tab_len], center = false);
	    }
	  }
	}
      }
    }
    
    
  }
}

module make_upper_rails()
{
  rail_pos_z = 42;
  rail_thickness = 3.02;
  wing_thickness1 = wing_thickness + 0.5; // give 0.5 mm tolerance  
  
  union(){
    translate([-O_IBox_r0, -wing_thickness1/2, rail_pos_z]){
      rotate([90,0,0]){    
	linear_extrude(height=Box_wall_t, center=false){
	  //polygon(points=[[0,0],[rail_thickness, 0],[rail_thickness,71.7803],[0,66.9158]]);
	  polygon(points=[[0,0],[rail_thickness, 0],[rail_thickness,66.9158],[0,66.9158]]);	  
	}
      }
    }
  

    translate([O_IBox_r0 - rail_thickness,-wing_thickness1/2,rail_pos_z]){    
      rotate([90,0,0]){    
	linear_extrude(height=Box_wall_t, center=false){
	  //	  polygon(points=[[0,0],[rail_thickness, 0],[rail_thickness,66.9158],[0,71.7803]]);
	  	  polygon(points=[[0,0],[rail_thickness, 0],[rail_thickness,66.9158],[0,66.9158]]);
	}
      }      
    }
  
  }
  
}

module make_lower_rails()
{
  rail_pos_z = 42;
  rail_thickness = 3.02;
  wing_thickness1 = wing_thickness + 0.5; // give 0.5 mm tolerance
  
  union(){
    //    translate([-O_IBox_r0, 0*wing_thickness1/2, rail_pos_z]){
    translate([-O_IBox_r0, Box_wall_t+wing_thickness1/2, rail_pos_z]){    
      rotate([90,0,0]){    
	linear_extrude(height=Box_wall_t, center=false){
	  //	  polygon(points=[[0,0],[rail_thickness, 0],[rail_thickness,71.7803],[0,66.9158]]);
	  polygon(points=[[0,0],[rail_thickness, 0],[rail_thickness,66.9158],[0,66.9158]]);	  
	}
      }
    }
  
    translate([O_IBox_r0-rail_thickness, Box_wall_t+wing_thickness1/2, rail_pos_z]){
      rotate([90,0,0]){    
	linear_extrude(height=Box_wall_t, center=false){
	  //	  polygon(points=[[0,0],[rail_thickness, 0],[rail_thickness,66.9158],[0,71.7803]]);
	  polygon(points=[[0,0],[rail_thickness, 0],[rail_thickness,66.9158],[0,66.9158]]);	  
	}
      }      
    }
  }
}

module make_usb_wall()
{
  difference(){
    cylinder(h=Box_wall_t, r=O_Box_r0, center=false);
    cylinder(h=4*Box_wall_t, r=21/2, center=true);
  }
}

module make_battery_compartment_wall(height)
{
  rotate([0,0,battery_tilt_angle]){
    difference(){
      cylinder(h=battery_wall_t, r=O_IBox_r0, center=false);
      // remove left and right side of the cylinder
      union(){

	//right side 
	translate([O_IBox_r0/2 + 8.5, 0, 0]){;
	  cube([O_IBox_r0, 4*O_IBox_r0, 4*battery_wall_t], center=true);
	}

	 // left side
	translate([-(O_IBox_r0/2 + 8.5), 0, 0]){
	  cube([O_IBox_r0, 4*O_IBox_r0, 4*battery_wall_t], center=true);
	}

	 // top side
	translate([0, -height, 0]){
	  cube([4*O_IBox_r0,2*O_IBox_r0,  4*battery_wall_t], center=true);
	}
      }
    }
  }  
}

module make_battery_compartment()
{
  union(){

    // wall closest to USB end
    translate([0,0,2]){
      union(){
	// make the overhang and the side
	translate([-1.7947, 7.8463, 7.4/2.0]){
	  rotate([-90,0,battery_tilt_angle]){
	    cube([17,7.4, Box_wall_t], center=true); // over hang
	  // the side
	    translate([-17/2-Box_wall_t/2,0,(7.5-Box_wall_t)/2]){
	      cube([Box_wall_t,7.4,7.5], center=true);
	    }
	  
	  }
	}
	make_battery_compartment_wall(9.8010);
      }
    }

    // wall at the other end
    translate([0,0,42]){
      make_battery_compartment_wall(6.0510);
    }
  }
}

module make_switch_tabs()
{
  translate([7.0250,9.575, 48.155]){  
    linear_extrude(height=Box_wall_t, center=false){
      polygon(points=[[0,0],[4.605,0],[4.605,3.39553],[0,6.8345]]);
    }
  }

  translate([7.0250,9.575, 93.8462	]){
    linear_extrude(height=Box_wall_t, center=false){
      polygon(points=[[0,0],[4.605,0],[4.605,3.39553],[0,6.8345]]);
    }
  }  
}

module make_irdiode_block()
{
  irdiode_x_len = 1.5;
  irdiode_y_len = 4.7; //mm
  irdiode_z_len = 3.25; //mm
  dy = 0.5; //mm, add a little ylen to embed it into the wall
  translate([-irdiode_x_len/2,O_IBox_r0-(irdiode_y_len+Box_wall_t/2.0) ,102.9773]){
    cube([irdiode_x_len, irdiode_y_len+dy , irdiode_z_len]);
  }
}

module make_upper_mounting_tabs()
{
  hole_pos_y = 5; //mm, length of the tab 
  hole_pos_z = 36.6865; //mm

  tab_height = 9; // mm, not radial height but the chord height
  tab_width = 5; // mm width of the tab


  difference(){
    // make the a ring 
    translate([0,0, hole_pos_z]){
      difference(){
        cylinder(r=O_IBox_r0 + Box_wall_t/2, h=tab_width, center = true);
        union(){
	  cylinder(r=O_IBox_r0 - Box_wall_t/2, h=2*tab_width, center = true);

	}
      }
    }
    // holes for the screws    
    translate([0,hole_pos_y,hole_pos_z]){
      rotate([0,90,0]){
	cylinder(r=0.9/2, h = 4*O_Box_r0, center=true);
      }
    }

    union(){

      // kill off the arcs to get the tabs
      translate([0, O_IBox_r0 + tab_height, hole_pos_z]){
	cube([2*O_IBox_r0, 2*O_IBox_r0, O_IBox_r0 ], center=true);
      }

      // kill off the bottom of the tabs
      translate([0, O_IBox_r0 - 3.5*tab_height, hole_pos_z]){
	cube([2*O_IBox_r0, O_IBox_r0, O_IBox_r0 ], center=true);
      }
    }
  }
}

module make_outer_upper_mounting_holes()
{
  union(){
    // holes for the end cap
    translate([0,0,endcap_pos_z]){
      rotate([0,90,45]){
	cylinder(r=endcap_hole_r, h = 4*O_Box_r0, center=true);
      }
    }    
    
  }
}

module make_upper_outer_lips()
{
  tube_len_no_cone = O_Box_y0 - cone_tab_len_z;
  // make the upper lips
  difference(){
    // cylinder that makes the lip
    lip_thickness = 1; //mm
    cylinder(h=tube_len_no_cone, r=O_Box_r0-lip_thickness, center=false);

      union(){
	cylinder(h=4*O_Box_y0, r=O_IBox_r0, center=true);

	translate([0,2*O_Box_r0 + lip_thickness, 0]){
	  cube([3*O_Box_r0, 2*2*O_Box_r0, 3*O_Box_y0], center=true);
	}    

      }
  }
}

module make_lower_outer_anti_lips()
{
  tube_len_no_cone = O_Box_y0 - cone_tab_len_z;
  // make the upper lips
  difference(){
    // cylinder that makes the lip
    lip_thickness = 1.2; //mm
    cylinder(h=tube_len_no_cone, r=O_Box_r0-lip_thickness, center=false);

      union(){
	cylinder(h=4*O_Box_y0, r=O_IBox_r0, center=true);

	translate([0,2*O_Box_r0 + lip_thickness, 0]){
	  cube([3*O_Box_r0, 2*2*O_Box_r0, 3*O_Box_y0], center=true);
	}    

      }
  }  
}

module make_outer_lower_mounting_holes()
{
  hole_pos_y = 5; //mm, length of the tab 
  hole_pos_z = 36.6865; //mm

  union(){
    // holes for the screws
    translate([0,hole_pos_y,hole_pos_z]){
      rotate([0,90,0]){
	cylinder(r=screw_r, h = 4*O_Box_r0, center=true);
      }
    }
/*
    // holes for the end cap
    translate([0,0,endcap_pos_z]){
      rotate([0,90,45]){
	cylinder(r=endcap_hole_r, h = 4*O_Box_r0, center=true);
      }
    }    
*/
    tab_height = 11; // mm, not radial height but the chord height
    tab_width = 5+2; // mm, added 2 mm to make it bigger than the tab width in make_upper_mounting_tabs()
    // shave down the wall for the tabs
    translate([0,0, hole_pos_z]){
      difference(){
	cylinder(r=O_IBox_r0 + Box_wall_t/2, h=tab_width, center = true);
	translate([0,tab_height*2, 0]){
	  cube([2*(O_IBox_r0 + Box_wall_t/2),tab_height*2, (O_Box_r0-tab_height)*2], center=true);
	}
      }
    }
  }
}


module make_i2s_standoffs()
{
    translate([4.9325,7.46, -pillarE_len_z/2+ultrasound_z_pos+IUBox_len_z+UBox_wall_t]){
      make_one_pillar(0,0,-pillarE_len_z/2, pillarE_len_z, pillarE_r, pillarE_hole_r);
  }

  translate([12.7 + 4.9325,7.46, -pillarE_len_z/2+ultrasound_z_pos+IUBox_len_z+UBox_wall_t]){
      make_one_pillar(0,0,-pillarE_len_z/2, pillarE_len_z, pillarE_r, pillarE_hole_r);
  }  
}

module make_speaker_platform()
{
  speaker_len_x = 21.2896;
  speaker_len_y = 30;
  
  translate([0,-14.0618,speaker_len_y/2 + 9.4]){
    difference(){
      cube([speaker_len_x, Box_wall_t,speaker_len_y], center=true);
      translate([0, 0, 0]){
      cube([speaker_len_x-6, 3*Box_wall_t,speaker_len_y-6], center=true);
      }
    }
  }
}

module make_speaker_holder_standoffs()
{
  speaker_holder_len = 19.41; //mm
  difference(){
    union(){
      // the two mounting bars
      translate([-15.2059,-9.0618,14.795]){  
	linear_extrude(height=speaker_holder_len, center=false){
	  polygon(points=[[0,0],[4.5611,0],[4.5611,-5.0]]);      
	}
      }
      translate([15.2059,-9.0618,14.795]){  
	linear_extrude(height=speaker_holder_len, center=false){
	  polygon(points=[[0,0],[-4.5611,0],[-4.5611,-5.0]]);      
	}
      }
    }

    //make the screw holes
    screw_hole_r = 0.75; 
    union(){
      translate([12.4253,0,16.5755]){
	rotate([90,0,0]){
	  cylinder(r= screw_hole_r, h = 10, center=false);
	}
      }
      translate([12.4253,0,32.4245]){
	rotate([90,0,0]){
	  cylinder(r= screw_hole_r, h = 10, center=false);
	}	
      }

      translate([-12.4253,0,16.5755]){
	rotate([90,0,0]){
	  cylinder(r= screw_hole_r, h = 10, center=false);
	}
      }
      translate([-12.4253,0,32.4245]){
	rotate([90,0,0]){
	  cylinder(r= screw_hole_r, h = 10, center=false);
	}	
      }      

    }
  }
}

module make_speaker_holes()
{
  hole_dist = 3; //mm
  hole_angle = 10.8995; //deg
  hole_r = 0.75; //mm
  hole_z_start = 15.5+0*5.7603; //start position of the first row of holes

  union(){
    for(j=[-2:2]){
      for(i=[0:7]){
	rotate([0,0,j*hole_angle]){
          translate([0,-O_Box_r0,i*hole_dist + hole_z_start]){
	    rotate([90,0,0]){
	      cylinder(r=hole_r, h=4*Box_wall_t, center=true);
	    }
	  }
	}
      }
    }
  }
}

module make_speaker_holder()
{
  holder_len_x = 28.4117; //mm
  holder_len_y =  19.41;//mm
  holder_thickness = Box_wall_t;
  dx = 0.4; //mm tolerance

  difference(){
    translate([0,-9.0618, 14.7950]){
      difference(){
       // make the main speaker holder without screw holes
	translate([-(holder_len_x -dx)/2, 0, 0]){
	  cube([holder_len_x - dx, Box_wall_t, holder_len_y ], center=false);
	}
        // hole for the disk on the speaker      
	translate([0,0, holder_len_y/2]){
	  rotate([90,0,0]){
	    cylinder(r=7.9050, h = 4*Box_wall_t, center=true);
	  }
	}
      }
    }
    
    //make the screw holes
    screw_hole_r = 0.75; 
    union(){
      translate([12.4253,0,16.5755]){
	rotate([90,0,0]){
	  cylinder(r= screw_hole_r, h = 10, center=false);
	}
      }
      translate([12.4253,0,32.4245]){
	rotate([90,0,0]){
	  cylinder(r= screw_hole_r, h = 10, center=false);
	}	
      }

      translate([-12.4253,0,16.5755]){
	rotate([90,0,0]){
	  cylinder(r= screw_hole_r, h = 10, center=false);
	}
      }
      translate([-12.4253,0,32.4245]){
	rotate([90,0,0]){
	  cylinder(r= screw_hole_r, h = 10, center=false);
	}	
      }      	
    }
  }
}






module make_pushbutton_hole()
{
  translate([0,-2*Box_wall_t - 15,pushbutton_z]){
    rotate([-90,0,0]){
      dr = 0.1;
      cylinder(r=pushbutton_r + dr, h = 4*Box_wall_t, center=true);
    }
  }
}

module make_spring_holder()
{
  difference(){
    translate([0, -Box_wall_t/2-11.6294, spring_holder_len_y/2 + 50.1679]){
      cube([spring_holder_len_x, Box_wall_t, spring_holder_len_y], center = true);
    }

    dr = 0.1;
    translate([0,-2*Box_wall_t - 7,pushbutton_z]){
      rotate([-90,0,0]){
	cylinder(r= pushbutton_r+ dr, h = 4*Box_wall_t, center=true);
      }
    }    
  }
  
}

module make_upper_outer_cover()
{
  difference(){
    union(){
      make_upper_outer_tube();
      make_upper_rails();
      //      make_i2s_standoffs();
      make_speaker_platform();
      make_speaker_holder_standoffs();      

      make_spring_holder();

      make_upper_mounting_tabs();

      // make the lips to match the anti-lips of the lower outer cover
      make_upper_outer_lips();

    }

    union(){
      make_speaker_holes();
      make_cone_mounting_holes(screw_r);
      make_pushbutton_hole();

      //not used    
      //make_outer_upper_mounting_holes();      
    }
  }
}

module make_lower_outer_cover()
{
  /*
  translate([Box_mid_x_pos, -(O_IBox_total_y-IBox_total_y)-Box_wall_t-51, Box_len_z1]){
    rotate([-90,0,0]){
  */
  difference(){
      union(){
	make_lower_outer_tube();
	make_lower_rails();
	make_battery_compartment();
	make_switch_tabs();
	make_irdiode_block();
      }
      union(){
	make_cone_mounting_holes(screw_r);
	make_outer_lower_mounting_holes();
	make_lower_outer_anti_lips();
      }
  }
  /*
    }
  }
  */
}

module make_endcap_one_wing()
{
  dtol = 0.2;//mm
  wing_h = 6.41;
  union(){
    // the triangle
    translate([(endcap_slip_hole_r+dtol),-Box_wall_t/2,-wing_h]){    
      rotate([90,-90*0,180]){
	linear_extrude(height=Box_wall_t, center=false){
	  polygon(points=[[0,0],[0,wing_h],[-8.35+dtol,wing_h],[-1.5 ,0]]);
	}
      }
    }

      //straight piece. Need to move in by 0.5 mm so that the straight
      //piece is sliced in such a way that it is _within_ the side walls
    translate([endcap_outer_r-.5, -Box_wall_t/2, 0*Box_wall_t]){
      cube([endcap_outer_dr*2.0 + .5, Box_wall_t, endcap_thread_h + 2*Box_wall_t]);
    }
  }
}


module make_endcap()
{
  dtol = 0.5;// mm have to have the thread radius a little bit larger to accommodate the halves

  union(){

    translate([0,0, 0*Box_wall_t/2]){
      RodEnd(2*endcap_outer_r, endcap_thread_h, endcap_thread_h, 2*(endcap_thread_r)+dtol, endcap_thread_p);
    }

    // make the ring between the threads and the end wall
    dtol1 = 0.2; //mm
    translate([0,0,-Box_wall_t]){
      difference(){
	cylinder(r=endcap_outer_r, h=Box_wall_t, center=false);
	cylinder(r=endcap_outer_r - Box_wall_t +dtol1, h=4*Box_wall_t, center=true);
      }
    }

    
    // make the end wall with a hole
    
    translate([0,0,-2*Box_wall_t]){
      difference(){
	cylinder(r=endcap_outer_r, h=Box_wall_t, center=false);
	cylinder(r=endcap_slip_hole_r + dtol1, h=4*Box_wall_t, center=true);
      }
    }

    //    translate([0,0,-0*3*Box_wall_t]){
    translate([0,0,-2*Box_wall_t]){    
      for(i=[0:7]){
	rotate([0,0,i*45]){
	  make_endcap_one_wing();
	}
      }
    }
  }
}

module make_slip_bracket()
{
  bracket_w1 = 4.5; //mm
  bracket_w2 = 6.5; //mm  
  bracket_h = 10 + Box_wall_t; //mm

  union(){

    // vertical wall closest to the battery compartment
    translate([7.6891,8.9897,0]){
      rotate([0,0, battery_tilt_angle]){
	cube([bracket_w1, Box_wall_t, bracket_h]);
      }
    }

    // second vertical wall 

    translate([9.8359,-4.8808,0]){
      rotate([0,0, battery_tilt_angle]){
	cube([bracket_w2, Box_wall_t, bracket_h]);
      }
    }
    // make bridge between the walls
    bridge_len = 12; //mm length of the bridge
    bridge_z =5; //mm distance vertically from base
    translate([10.3648,-2.7082, 0]){
      rotate([0,0,battery_tilt_angle]){
	difference(){
	  cube([bracket_w1, bridge_len, bridge_z+2+0*Box_wall_t]);
	  translate([-bracket_w1/2,Box_wall_t,2*Box_wall_t]){
	    cube([bracket_w1, bridge_len/2, bridge_z*4]);
	  }
	}
      }
    }

    // make PCB holder, first bar
    PCB_len = 9.5; //mm
    PCB_width = 2;
    translate([-.6798,2.9722, bridge_z]){
      rotate([0,0,battery_tilt_angle]){
	cube([PCB_len, PCB_width, Box_wall_t ]);
      }
    }

    // make PCB holder, second bar
    translate([1.1039,-4.8264,bridge_z]){
      rotate([0,0,battery_tilt_angle]){
	cube([PCB_len, PCB_width, Box_wall_t ]);
      }
    }

    // make first PCB support
    translate([1.5499,-6.7760,00000000]){
      rotate([0,0,battery_tilt_angle]){
	cube([PCB_width, PCB_width, bridge_z + Box_wall_t]);
      }
    }

    // make second PCB support
    translate([-1.1258,4.9219,00000000]){
      rotate([0,0,battery_tilt_angle]){
	cube([PCB_width, PCB_width, bridge_z + Box_wall_t]);
      }
    }    

    
  }  
}

module make_slip_power_hooks()
{
  hook_outer_r = 7;
  hook_inner_r = 5;

  translate([0,0,2-0.91+2]){
    rotate([0,-90,0]){
      difference(){
	cylinder(r=hook_outer_r, h=Box_wall_t, center =false);            
	union(){
	  cylinder(r=hook_inner_r, h=4*Box_wall_t, center =true);
	  translate([-2,-hook_outer_r,-hook_inner_r]){
	    cube([2*hook_outer_r,2*hook_outer_r,2*hook_inner_r], center=false);
	  }
	}
      }
    }
  }
}

module make_slip_skirt()
{
  dtolr = 0.2;//mm
  skirt_h = 6;//mm
  battery_w = 17 + Box_wall_t; // width of battery compartment. Note: only 1 wall!
  dtolw = .5; // put in some tolerance for the width of the compartment

  difference(){
    cylinder(r=endcap_slip_r-Box_wall_t - dtolr, h=skirt_h, center=false);
    union(){
      cylinder(r=endcap_slip_r-2*Box_wall_t, h=4*skirt_h, center=true);
      // make gap  for the battery compartment

      rotate([0,0,battery_tilt_angle]){
	translate([-(battery_w+ Box_wall_t+dtolw)/2, 0, 0]){	  
	  cube([battery_w + dtolw ,2*endcap_slip_r,4*Box_wall_t], center=false);	  
	}
      }

    }
  }
}

module make_slip_adapter()
{
  dtol = 0.2;
  dtolr= 0.2;
  translate([0,0,-Box_wall_t]){
    union(){
      /*
      translate([0,14,-(endcap_slip_h+Box_wall_t)])
        cube([1,5,endcap_slip_h+Box_wall_t]);
      */
      difference(){
	cylinder(r=endcap_slip_r, h=Box_wall_t - dtol, center=false);
        // make hole for the power plug
        cylinder(r=5, h=4*Box_wall_t , center=true);
      }

      // make the tube
      screw_pitch = 1; // pitch of the screw      
      translate([0,0, -(endcap_slip_h+Box_wall_t)]){

	RodEnd(diameter = (endcap_slip_hole_r - dtolr)*2, height=endcap_slip_h+Box_wall_t, thread_len = endcap_slip_h+Box_wall_t, thread_diam = 2*(endcap_slip_hole_r - Box_wall_t), thread_pitch=screw_pitch);
  
      }

      // make bracket for securing the circuit board
      make_slip_bracket();

      // make power hooks
      make_slip_power_hooks();

      // make the skirt
      make_slip_skirt();

      /*
      translate([-10,-1,-endcap_slip_h+4]){
	cube([40,2,2], center=false);
      }
      */
    }
  }  
}

module make_slip_cap()
{
  screw_pitch = 1; // pitch of the screw
  screw_h = 3.5;//mm
  screw_base = 2.455; //mm, this is the non threaded part of the screw
  clear_r = 21/2.0; //mm the radius of the empty space of the endcap
  turning_hole_r = 1; // mm radius of turning holes
  translate([0,0,-15]){
    difference(){

      union(){
	difference(){
	  RodStart(diameter=2*(endcap_slip_hole_r - Box_wall_t), height=screw_base, thread_len=screw_h, thread_diam=2*(endcap_slip_hole_r - Box_wall_t), thread_pitch= screw_pitch);
	  cylinder(r=clear_r, h=4*(screw_h + screw_base), center=true);

	}

	lid_thickness = 1.5; // mm, thickness of the lid
	knob_height = 3.955; //mm height of the knob
	translate([0,0,-lid_thickness]){	
	  difference(){
	    dtolr = 0.2;//mm
	    cylinder(r=(endcap_slip_hole_r - dtolr), h=knob_height, center=false);

	    translate([0,0,lid_thickness]){
	      cylinder(r=clear_r, h=4*(screw_h + screw_base), center=false);
	    }
	  }
	}
	
      }

      // make 2 turning holes
      union(){
	translate([0.75*(endcap_slip_hole_r - Box_wall_t), 0, 0]){
	  cylinder(r=turning_hole_r, h=4*screw_h, center=true);
	}

	translate([-0.75*(endcap_slip_hole_r - Box_wall_t), 0, 0]){
	  cylinder(r=turning_hole_r, h=4*screw_h, center=true);
	}	
      }
    }
  }
}

/*************

Entry point

**************/


union(){

  /*
  // make the inner tube    
  difference(){
    union(){
      //make the inner tube
    
      //  make_lower_cover();
      //  make_ultrasound_cover();
         make_top_cover();
    }

    // remove the tail section
        remove_tail_section();    
  }
  */

  //      make_tail_section();
  // make_switch_plug();


  
  // make the handle tube
  //make_cone_parts();
  make_upper_outer_cover();
  make_lower_outer_cover();

      
  // make the end cap parts      
  //make_endcap();
  //  make_slip_adapter();
  //  make_slip_cap();

  // make the speaker holder
  //    make_speaker_holder();
}


include <libscrew.scad>


