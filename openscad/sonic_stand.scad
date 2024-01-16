/*
    sonic_stand.scad is the code to generate a case for a sonic
    screwdriver
    
    Copyright (C) 2023  C.Y. Tan
    Contact: cytan299@yahoo.com

    This file is part of the CP4 and CP5 dust cover distribution.

    sonic_stand.scad is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    sonic_stand.scad is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with sonic_stand.scad.  If not, see <http://www.gnu.org/licenses/>.

*/

$fn=100;

Top_cone_h = 20.4100; //mm
Top_cone_r1 = 47.4574; //mm
Top_cone_r2 = 34.9574; //mm
Top_cone_z = 28.41; //mm

Bot_cone_h = 20.41;
Bot_cone_r1 = 54.2426; //mm
Bot_cone_r2 = Top_cone_r1; //mm
Bot_cone_z = 8; //mm

wall_t = 2; //mm
//Bot_cone_inner_h = Bot_cone_h - wall_t; //mm
Bot_cone_inner_h = 23.41; //mm
//Bot_cone_inner_r1 = Bot_cone_r1 - wall_t; //mm
Bot_cone_inner_r1 = 54.1886; //mm
Bot_cone_inner_r2 = 46.9285; //mm

cone_screw_r = 0.75; //mm
cone_screw_rpos = 29.4624; //mm
cone_screw_zpos = 13.41; //mm
cone_screw_depth = 5; //mm

sonic_hole_r = 22.9574; //mm
wire_hole_r = 10.1074; //mm

skirt_outer_r = Bot_cone_r1; //mm
skirt_inner_r = Bot_cone_r1 - wall_t; //mm
skirt_h = 5; //mm
skirt_z = 3; //mm

display_disk_width = 9.2249; //mm
display_disk_outer_r = 34.1823; //mm
display_disk_inner_r = display_disk_outer_r - display_disk_width; //mm

led_hole_r = 2.5; //mm
led_hole_x = -29.355; //mm

led_space_h = 44.82; //mm
led_space_r = 4.6124; //mm

plug_wall_t = wall_t; //mm
plug_wall_w = 14; //24.8552; //mm
plug_wall_h = 16.205; //mm
plug_hole_r = 4.25;

plug_recess_r = 7; //mm
plug_z = 9.2050; //mm


mount_r = 2.5; //mm
mount_h = 18.41;//5.5; //mm
mount_wall_len = 2*5;
mount_radial_pos = 29.9460; //mm

mount_screw_h = 6; //mm
mount_screw_r = 0.75; //mm

pcb_mount_h = skirt_h + wall_t; // mm, note part of the mount is inside the thickness of the bottom cover
pcb_mount_r= 2.5; //mm
pcb_mount_radial_pos = 14.5; //mm
pcb_mount_screw_r = 0.75; //mm

badge_r = 9.5; //mm
badge_depth = 1.9688;

friction_island_r = 20; //mm approx diameter of pad is 1.5 inch = 38.1 mm

friction_island_h = skirt_z + (skirt_h - wall_t);
friction_pad_t = 1.5; //mm, in reality about 1.8 mm

top_plate_outer_r = 33.6; // mm, from measurement
top_plate_inner_r = sonic_hole_r + wall_t; //24.9574 mm; //24.85; // mm, from measurement


module make_display_disk_channel()
{
  translate([0,0,Top_cone_h-wall_t]){
    difference(){
      cylinder(h=2*wall_t, r=display_disk_outer_r, center=false);
      cylinder(h=4*wall_t, r=display_disk_inner_r, center=true);      
    }
  }
}

module make_led_hole()
{
  dr = 0.25; // tolerance
  translate([led_hole_x, 0, 0]){
    cylinder(h=4*Top_cone_h, r=led_hole_r + dr, center=true);
  }
}

module make_led_space()
{
  translate([led_hole_x, 0,0]){
    cylinder(h=led_space_h, r=led_space_r, center=false);
  }
}

module make_badge_space()
{
   translate([-39.3742,0, 36.4707]){
     rotate([0,-(90-31.4852),0]){
      cylinder(h=4*badge_depth, r=badge_r, center=false);
    }
  }
}

module make_cone_screw_holes()
{
  union(){
    translate([cone_screw_rpos, 0, 0]){
      cylinder(h=4*cone_screw_depth, r=cone_screw_r, center=false);
    }

    translate([0,cone_screw_rpos, 0]){
      cylinder(h=4*cone_screw_depth, r=cone_screw_r, center=false);
    }

    translate([0,-cone_screw_rpos, 0]){
      cylinder(h=4*cone_screw_depth, r=cone_screw_r, center=false);
    }    
    
  }
}


module make_top_cone()
{
  translate([0,0, Top_cone_z]){
    difference(){
      cylinder(h=Top_cone_h, r1=Top_cone_r1, r2=Top_cone_r2, center=false);
      union(){
	cylinder(h=4*Top_cone_h, r=sonic_hole_r, center=true);
	make_display_disk_channel();
	make_led_hole();
	make_cone_screw_holes();

      }
    }
  }
}


module make_power_plug_wall()
{

  translate([45.9285-1, 0, plug_z]){
    rotate([0,90,0]){

      difference(){
	difference(){
	  union(){
	    cylinder(h=plug_wall_t, r=plug_recess_r + 2, center=false);

            // make the tube that connects to the wall *without* the slant
	    difference(){
	      cylinder(h=8.1734, r=plug_recess_r +2, center = false);
	      cylinder(h=4*8.1734, r=7, center = true);
	    }
	  }

	  // make the hole for the plug
	  cylinder(h=20, r=plug_hole_r, center = true);
	}

        // make the slant
	translate([0,0, 5.0867]){
	  rotate([0,-18.9304,0]){
	    cylinder(h=20, r=20, center = false);
	  }
	}
      }
    }
  }
}


module make_plug_recess()
{
  translate([10,0,plug_z]){
    rotate([0,90,0]){
      cylinder(h=2*Bot_cone_r1, r=plug_recess_r, center=true);
    }
  }
}

module make_one_mount(x, y, theta)
{

  translate([x,y,0]){
    difference(){
      union(){
	cylinder(h=mount_h, r=mount_r, center=false);
	rotate([0,0,theta]){
	  translate([-mount_r, 0, 0]){
	    difference(){
	      cube([2*mount_r, mount_wall_len, mount_h], center=false);

	      // make the angled wedge
	      translate([-mount_r, mount_wall_len, 0]){
		rotate([18.9304,0,0]){;
		  cube([4*mount_r, 10, 2*mount_h], center = false);
		}
	      }
	    }
	  }
	}
      }
      cylinder(h=2*mount_screw_h, r=mount_screw_r, center=true);	
    }
  }  
}

module make_mounts()
{
  x=mount_radial_pos;
  y=x;

  //  make_one_mount(0,0, 0);  

  make_one_mount(x,y, 315);
  make_one_mount(-x,y, 45);
  make_one_mount(-x,-y, 135);
  make_one_mount(x,-y, 225);

}

module make_bottom_cone()
{
  translate([0,0, Bot_cone_z]){
    union(){
      difference(){
	cylinder(h=Bot_cone_h, r1=Bot_cone_r1, r2=Bot_cone_r2, center=false);

	union(){
	  translate([0,0,-5]){
	    cylinder(h=Bot_cone_inner_h, r1=Bot_cone_inner_r1, r2=Bot_cone_inner_r2, center=false);
	  }
	  
	  cylinder(h=4*Bot_cone_inner_h, r=wire_hole_r,  center=true);
	  make_plug_recess();	  
	}
      }
      make_power_plug_wall();
      
      make_mounts();

      
    }
  }  
}

module make_skirt_indent()
{
  translate([skirt_outer_r, 0, 0]){
    cube([2*plug_recess_r,2*plug_recess_r, wall_t], center=true);
  }  
}

module make_skirt()
{
  translate([0,0, skirt_z]){
    difference(){
      cylinder(h=skirt_h, r=skirt_outer_r, center=false);
      union(){
        cylinder(h=4*skirt_h, r=skirt_inner_r, center=true);
	make_skirt_indent();
      }
    }
  }
}

module make_top()
{
  difference(){
    union(){
      make_top_cone();
      make_bottom_cone();
      make_skirt();

      //      make_badge_space();      
    }
    
    union(){
      make_led_space();
      make_badge_space();
    }
      
  }
}

module make_cover_screw_holes()
{
  x=mount_radial_pos;
  y=x;  
  translate([x,y,0]){
    cylinder(h=32, r=mount_screw_r, center=false);
  }

  translate([-x,y,0]){
    cylinder(h=32, r=mount_screw_r, center=false);
  }

  translate([-x,-y,0]){
    cylinder(h=32, r=mount_screw_r, center=false);
  }

  translate([x,-y,0]){
    cylinder(h=32, r=mount_screw_r, center=false);
  }
  
}

module make_pcb_mount(x,y)
{
  tol = 0.25;
  translate([x,y, skirt_z + (skirt_h - tol - wall_t)]){
    difference(){
      cylinder(h=pcb_mount_h,r=pcb_mount_r, center=false);
      cylinder(h=4*pcb_mount_h, r = pcb_mount_screw_r, center=true);
    }
  }
}


module make_cover_friction_island()
{
  difference(){
    cylinder(h=friction_island_h , r = friction_island_r, center=false);
    cylinder(h=2*friction_pad_t , r = 2*friction_island_r, center=true);
  }
}

module make_cover_alignment_island()
{
  tol = 0.2;
  difference(){

    // make the cube first and move it to the edge
    translate([skirt_outer_r, 0, (wall_t/4)+skirt_z - tol]){
      cube([2*plug_recess_r -tol,2*plug_recess_r-tol, wall_t/2], center=true);
    }

    // then remove the outer edge to make a curve
    difference(){
      cylinder(h=20, r=skirt_outer_r + 10 , center=false);		
      cylinder(h=40, r=skirt_outer_r, center=true);	
    }
      
  }
}

module make_cover_indent()
{
  translate([skirt_outer_r, 0, 0]){
    cube([2*plug_recess_r,2*plug_recess_r, wall_t], center=true);
  }
}

module make_powerin_indent()
{
  indent_h = 1;
  translate([skirt_outer_r, 0, (wall_t/2+skirt_z +skirt_h)-indent_h]){
    cube([4*plug_recess_r,2*plug_recess_r, wall_t], center=true);
  }  

}


module make_cover()
{
  tol = 0.25;
  difference(){
    union(){
      translate([0,0, skirt_z]){
	difference(){
	  cylinder(h=skirt_h-tol, r=skirt_inner_r-tol, center = false);
	  cylinder(h=2*(skirt_h-tol-wall_t), r=skirt_outer_r-4*wall_t, center = true);
	}
	
      }
      
      difference(){
	cylinder(h=skirt_z, r=skirt_outer_r, center=false);
	cylinder(h=4*skirt_z, r=skirt_outer_r-4*wall_t, center=true);
      }

      make_cover_friction_island();
  //    make_cover_alignment_island();

      x=pcb_mount_radial_pos;
      y=x;
      make_pcb_mount(x,y);
      make_pcb_mount(-x,y);
      make_pcb_mount(-x,-y);
      make_pcb_mount(x,-y);
    }

    union(){
      make_cover_screw_holes();
      make_cover_indent();
//      make_powerin_indent();
    }
  }
}

/*
 This top plate is for testing and has the thickness without the laser
 cut gallefreyan laser cut plate.

 Use
	make_top_plate_with_laser_plate()

for production
 */
module make_top_plate()
{
  tol = 0.25;
  translate([0,0,Top_cone_z+Top_cone_h-wall_t]){
    difference(){
      union(){
	cylinder(h = wall_t, r=top_plate_outer_r, center=false);
      }
      
      union(){
	cylinder(h = 4*wall_t, r=top_plate_inner_r+tol, center=true);

	// LED
	translate([led_hole_x, 0, wall_t/2]){
	  //	  cylinder(h=4*wall_t, r=led_hole_r, center=true);
	  cylinder(h=2*wall_t, r=led_hole_r, center=false);	  
	}
	make_cone_screw_holes();
      }
    }
  }
}

/*
  
  A laser cut plate with gallefreyan that is 0.5 mm thick will be
  stuck on top of the top plate.  I call this the sticker.
  
 */

module make_led_window()
{

  sticker_t = 0.5; // thickness of the laser cut top plate
  led_tol = 0.2;

  difference(){
    translate([led_hole_x, 0, wall_t - sticker_t]){
      cylinder(h=sticker_t, r=led_hole_r- led_tol/2, center=false);
    }

    rotate([0,0,270]){
      translate([0,0,sticker_t + (wall_t - sticker_t) - sticker_t/2]){
	linear_extrude(sticker_t/2){
	  import(file = "top_plate_gallefreyan/top_plate_ponoko2.svg", center = true);      
	}

      }
    }    
  }
}  

module make_top_plate_with_laser_plate()
{

  sticker_t = 0.5; // thickness of the laser cut top plate
  
  tol = 0.25;
  led_tol = 0.2;
  translate([0,0,Top_cone_z+Top_cone_h-wall_t]){
    union(){
      difference(){
	union(){
	  cylinder(h = wall_t - sticker_t, r=top_plate_outer_r, center=false);
	}
      
	union(){
	  cylinder(h = 4*wall_t, r=top_plate_inner_r+tol, center=true);

	  // LED hole, which is smaller than the diameter of the LED
	  translate([led_hole_x, 0, wall_t/2]){
	    cylinder(h=2*wall_t, r=led_hole_r - led_tol, center=true);
	  }

	  make_cone_screw_holes();
	}
      } // difference

      // add in the window for the LED with a bit of gallefreyan

      make_led_window();
      
    } //union
  }  
}

module make_alignment_stand_bottom()
{


  stand_bottom_w = 7.7;
  stand_bottom_l = 39.4;
  stand_bottom_z = 2.1;

  rise_w = 7.7;
  rise_l = 25.8;
  rise_z = 6.8512;

  union(){
    difference(){
      union(){
        translate([9.8,-stand_bottom_l/2,0]){
          cube([stand_bottom_w, stand_bottom_l, stand_bottom_z ], center = false);
	}

	translate([9.8,-rise_l/2,0]){
          cube([rise_w, rise_l, rise_z ], center = false);
	}

        translate([-17.5,-stand_bottom_l/2,0]){
          cube([stand_bottom_w, stand_bottom_l, stand_bottom_z ], center = false);
	}

	translate([-17.5,-rise_l/2,0]){
          cube([rise_w, rise_l, rise_z ], center = false);
	}



      }

      union(){

	// make the BOTTOM gap to accommodate the usb connector and the jst connectors
	gap_w = 23; //rise_l - 2*wall_t + 1;	
	gap_h = rise_z + stand_bottom_z - 2*wall_t;
	
	cube([40, gap_w, 4*gap_h], center=true);	

        x=pcb_mount_radial_pos;
        y=x;
        translate([x,y,0]){
          cylinder(h=32, r=1.5*pcb_mount_screw_r, center=true);
        }
        translate([x,-y,0]){
	  cylinder(h=32, r=1.5*pcb_mount_screw_r, center=true);;
	}

        translate([-x,-y,0]){
	  cylinder(h=32, r=1.5*pcb_mount_screw_r, center=true);;
	}

        translate([-x,y,0]){
	  cylinder(h=32, r=1.5*pcb_mount_screw_r, center=true);;
	} 	
      }
    }
  }  
}

module make_alignment_platform()
{
  platform_offset_z = 4.8512;

  bottom_l = 35; //28.3;
  bottom_w = 25.8;
  bottom_z = 2.0;

  top_l = 35;
  top_w = bottom_w;
  top_z = 1.2012;
  top_offset_z = 5.65;

  difference(){
    union(){
      translate([-bottom_l/2,-bottom_w/2,  platform_offset_z]){
        // bottom part
        cube([bottom_l, bottom_w,bottom_z], center=false);
      }

    }

    // accommodate JST connectors connector
    jst_l = 8;
    jst_w = 23;
    translate([-18.3763,0,0]){
      cube([2*jst_l, jst_w, 4*top_offset_z], center = true);;
    }    

    // make holes for the spring connector
    union(){
      connector_mount_hole_r = 1.5;
      
      translate([0,6.9987,5]){
	cylinder(r=connector_mount_hole_r, h=10, center=true);
      }

      translate([0,-6.9987,5]){
	cylinder(r=connector_mount_hole_r, h=10, center=true);
      }      
    }

    connector_main_hole_r = 7.998/2;

    // make hole for the gold plated connectors
    cylinder(r=connector_main_hole_r, h=20, center=true);    
  }

}

module make_alignment_pegs()
{
  dtol = 0.5;
  bottom_r = 9.8;
  bottom_h = 6.9088;
  peg_z_offset = 6.8512;

  dw = 0+.25;
  spring_slot_w = 8.1862+dw;

  translate([0,0, peg_z_offset]){
    union(){
      difference(){
        cylinder(r=bottom_r, h = bottom_h, center=false);
        //make slot for the spring connector
        cube([spring_slot_w, 4* bottom_r,  4*bottom_h], center = true);
      }

      peg_z_offset = 6.9088;      
      // round peg
      round_peg_x = -7.0002;
      round_peg_r = 1.5;
      round_peg_z = 6;
      
      translate([round_peg_x, 0, peg_z_offset]){
	cylinder(r=round_peg_r, h = round_peg_z, center=false);
      }

      // "rectangle" peg
      union(){
	x=6.4674;
	y=2.1039;
	translate([x,y, peg_z_offset]){
	  cylinder(r=round_peg_r, h = round_peg_z, center=false);
	}

	translate([x,-y, peg_z_offset]){
	  cylinder(r=round_peg_r, h = round_peg_z, center=false);
	}

	rect_peg_l = 5.3578;
	translate([x-round_peg_r,-rect_peg_l/2,peg_z_offset]){
	  cube([2*round_peg_r, rect_peg_l, round_peg_z], center=false);
	}
      }
    }
  }
}

module make_alignment_stand()
{

  alignment_stand_z = 13.65;

  translate([0,0, alignment_stand_z]){	    
    union(){
      make_alignment_stand_bottom();
      make_alignment_platform();
      make_alignment_pegs();
    }
  }
}

/*************

Entry point

**************/


union(){
  //    make_top();
  //  make_cover();

  make_alignment_stand();

//  make_top_plate();

//  make_top_plate_with_laser_plate();
	      
	      
}





