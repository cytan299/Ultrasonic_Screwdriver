/*
    spring.scad is the code to generate a spring for the ultrasonic
    screwdriver
    
    Copyright (C) 2023  C.Y. Tan
    Contact: cytan299@yahoo.com

    This file is part of the CP4 and CP5 dust cover distribution.

    spring.scad is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    spring.scad is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with spring.scad.  If not, see <http://www.gnu.org/licenses/>.

*/

$fn=100;


/***************************************
  Spring definitions
****************************************/

spring_outer_r = 2.2562; //mm
spring_inner_r = 1.2562; // mm
spring_len_x = 14.1469; //mm
spring_insertion_len= 31.3297 - spring_outer_r; //mm, less the outer radius of the spring
spring_top_len = 11.9735; //mm

spring_stopper_len_x = 10.05; //mm


spring_thickness = 1; //mm

// croosbar
crossbar_thickness = 2; //mm
crossbar_len_y = 4; //mm


//screw holes
screw_r = 0.5; //mm



pushbutton_stem_r = 2.5; //mm, radius of the push button stem

module make_curved_part()
{
  difference(){
    cylinder(r = spring_outer_r, h = spring_len_x, center = false);
    // make the hole
    union(){
      cylinder(r = spring_inner_r, h = 4*spring_len_x, center = true);
      // then remove half the cylindrical part
      translate([0, spring_outer_r, 0]){
	cube([4*spring_outer_r, 2*spring_outer_r, 4*spring_len_x], center=true);
      }
    }
  }
}

module make_insertion_part()
{
  dr = 0.1;//mm, tolerance


  // make the insertion part
  difference(){
    union(){
      translate([-spring_thickness-spring_inner_r, 0,0]){;
	cube([spring_thickness, spring_insertion_len, spring_len_x], center=false);;
      };
    }

    // make the slot
    union(){
      hole_y_pos = 7.0735; // mm, the hole y position measured from the end of the curved part.
      
      // make the hole first
      translate([-2*spring_thickness,hole_y_pos, spring_len_x/2]){
	rotate([0,-90, 0]){
	  cylinder(r=pushbutton_stem_r + dr, h=4*spring_thickness, center=true);
	}
      }
      // then the slot below the hole
      
      translate([-3*spring_thickness, hole_y_pos, hole_y_pos - pushbutton_stem_r - dr]){
	cube([4*spring_thickness, spring_insertion_len*2, 2*(pushbutton_stem_r + dr)]);
      }            
    }
  }
}

// this is the top part of the spring that hosts the stopper
module make_top_part()
{
  translate([spring_inner_r, 0, 0]){
    cube([spring_thickness, spring_top_len, spring_len_x], center=false);
  }
}

module make_stopper()
{
  // The stopper is linearly extruded from this shape

  hole_y_pos = 7.0735; // mm, the hole y position measured from the end of the curved part.
  difference(){
    translate([spring_outer_r,hole_y_pos, (spring_len_x - spring_stopper_len_x)/2.0]){
      linear_extrude(height = spring_stopper_len_x,center=false){
	polygon(points=[[0,0],[0,-6.7297],[3.7149,-19.2297],[4.0622,-21.1993],[6.0622,-21.1933],[5.7149,-19.2297]]);
      }
    }


    translate([10,-14.1259, spring_len_x/2]){
      rotate([0,-90,0]){
	cylinder(r=2.5, h=20, center=false);
      }
    }
  }
}


module make_stopper2()
{
    hole_y_pos = 7.0735; // mm, the hole y position measured from the end of the curved part.
  difference(){
    translate([spring_outer_r,hole_y_pos, (spring_len_x - spring_stopper_len_x)/2.0]){
      linear_extrude(height = spring_stopper_len_x,center=false){
	/*
	  // long
	polygon(points=[[0,0],[-0.9208,5.2219],[-2.3024,4.9783],
			[-1,-2.4078], [-1,-7.0735], [0,-7.0735],[0,0.3437],
			[0,-6.7297],[3.7149,-19.2297],[4.4148,-23.1993],
			[6.9148,-21.1993],[6.2149,-19.2297],[5.7149,-19.2297]]);
	*/

	/* //4 mm foot
	polygon(points=[[0,0],[-0.9208,5.2219],[-2.3024,4.9783],
			[-1,-2.4078], [-1,-7.0735], [0,-7.0735],[0,0.3437],
			[0,-6.7297],[3.7149,-19.2297],[6.2149,-19.2297],
			[5.5149,-15.2601],[4.5351,-15.2601]]);
	*/

	/* //8 mm foot
	polygon(points=[[0,0],[-0.9208,5.2219],[-2.3024,4.9783],
			[-1,-2.4078], [-1,-7.0735], [0,-7.0735],[0,0.3437],
			[0,-6.7297],
			[4.8946,-23.1993],
			[6.9148,-23.1993],
			[5.5149,-15.2601],[4.5351,-15.2601]]);
	*/
	// 8 mm foot with a lip
	/*
	polygon(points=[[0,0],[-0.9208,5.2219],[-2.3024,4.9783],
			[-1,-2.4078], [-1,-7.0735], [0,-7.0735],[0,0.3437],
			[0,-6.7297],
			[4.8946,-23.1993],
			[6.9148,-23.1993],
			[6.0062,-18.0465],
			[6.9859,-17.8457],
			[6.7579,-16.5529],
			[4.5351,-15.2601],
			[5.5149,-15.2601],[4.5351,-15.2601]]);
	*/

	// 9 mm foot with lip
	polygon(points=[[0,0],[-0.7717,5.2150],[-2.1595,5.0097],
			[-1.0661,-2.3792],
			[-1.1809,-6.7297],
			[-0.1904,-7.0735],			
			[-0.1013,-7.0431],
			[4.2522,-23.3256],
			[6.2761,-23.4117],
			[5.2464,-17.2357],
			[6.2357,-17.0924],
			[6.0390,-15.7635],
			[3.8573,-14.4401]
			]);
	
	
      }
    }
    
    //    translate([10,-14.1259, spring_len_x/2]){
    translate([10,-10.1259, spring_len_x/2]){    
      rotate([0,-90,0]){
	union(){
	  cylinder(r=2.5, h=20, center=false);
	  /* //for 4 mm foot
	  translate([0,-2.5,0]){
	    cube([5,5,40], center=true);
	  */

	  translate([0,-5,0]){
	    cube([5,10,40], center=true);	  
	  }
	}
      }
    }
  }
}

module make_screw_holes()
{

  // position of hole 1
  hole_x_pos1 = 2.3361; //mm
  hole_y_pos1 = 26.4624;

  // position of hole 2
  hole_x_pos2 = hole_x_pos1 + 9.4747; //mm
  hole_y_pos2 = 26.4624;

  // holes for the slot
  translate([-3*spring_thickness,hole_y_pos1, hole_x_pos1]){
    rotate([0,-90,0]){
      cylinder(r=screw_r, h=4*spring_thickness, center=true);
    }
  }

  translate([-3*spring_thickness,hole_y_pos2, hole_x_pos2]){
    rotate([0,-90,0]){
      cylinder(r=screw_r, h=4*spring_thickness, center=true);
    }
  }

  // holes for the crossbar
  translate([spring_thickness - 0.275,hole_y_pos1, hole_x_pos1]){
    rotate([0,-90,0]){
      cylinder(r=2*screw_r, h=4*spring_thickness, center=true);
    }
  }

  translate([spring_thickness -.275,hole_y_pos2, hole_x_pos2]){
    rotate([0,-90,0]){
      cylinder(r=2*screw_r, h=4*spring_thickness, center=true);
    }
  }    
}

module make_crossbar()
{
  crossbar_y_pos = 24.4828;

  
  translate([-spring_inner_r,crossbar_y_pos,0]){
    cube([crossbar_thickness, crossbar_len_y, spring_len_x], center=false);
  }
}

difference(){
  union(){
    /*
    make_curved_part();
    make_insertion_part();

    // this is version 1
    //    make_top_part();
    //    make_stopper();

    // this is version 2
    make_stopper2();
    */
        make_crossbar();

  }

  union(){
    make_screw_holes();            
  }
}





