/*

    push_button.scad is the code to generate push button for the ultrasonic
    screwdriver
    
    Copyright (C) 2023  C.Y. Tan
    Contact: cytan299@yahoo.com

    This file is part of the ultrasonic screwdriver distribution.

    push_button.scad is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    push_button.scad is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with push_button.scad.  If not, see <http://www.gnu.org/licenses/>.

*/

$fn=100;

screw_r = 2.5; // mm, radius of the screw
//screw_len = 5.2976+1; // mm, length of the screw
screw_len = 5.2976+25; // mm, length of the screw
screw_pitch = 0.75; // pitch of the screw

interface_r = 9.8/2; // mm, the interface between the plunger radius
interface_h = 1; // mm, the height of the interface

plunger_h = 1.5125; // mm, the height of the plunger
plunger_r1 = 2.5; //mm, the part that touches the spring
plunger_r2 = interface_r; //mm, the part the touches the interface


button_r = 9.8/2; // mm, the radius of the button
button_h = 4.5; // mm, the height of the button
button_thread_len = 2.5; // mm, the length of the thread

module make_plunger()
{

  // make the screw threads
  translate([0,0,plunger_h]){
    RodStart(diameter=interface_r*2, height=interface_h, thread_len=screw_len, thread_diam=screw_r*2, thread_pitch= screw_pitch);
  }

  // make the plunger
  cylinder(r1=plunger_r1, r2 = plunger_r2, h=plunger_h, center=false);
}

module make_button()
{
  dtol = 0.0;
    
  RodEnd(diameter = button_r*2, height=button_h, thread_len = button_thread_len, thread_diam = 2*screw_r + dtol, thread_pitch=screw_pitch);  
}


/*
  Entry point
*/


 translate([0, -7, 0]){
   make_plunger();
 }
  
/*
  translate([0, 7, 0]){
    make_button();
  }
*/


include <libscrew.scad>



