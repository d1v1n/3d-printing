include <configuration.scad>
use <effector.scad>;

offset = 20;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
hotend_radius = 8.1;  // Hole for the hotend, added .1 for clearence.
height = 8;

difference(){
lip();
lip_remove();
}


original();
top();


//Johanns original effector modifierad
module original() {
difference()
{
rotate([0,0,60]) translate([0,0,-height/2]) effector();		//rotate([0,0,60])  Rotade 60 degrees to allign.
hull() {
translate([0,0,-height/2]) cylinder(height+1,hotend_radius,hotend_radius, center=true, $fn=60);		//Center hole for hotend.
translate([0,hotend_radius/2,-height/2]) cylinder(height+1,hotend_radius,hotend_radius, center=true, $fn=60);		//Center hole #2 to fit hotend.
}
}
difference()		//Removes unused screw holes.
{
translate([0,0,height/-2])cylinder(r=offset-3, h=height, center=true, $fn=60);
hull() {
translate([0,0,-height/2]) cylinder(height+1,hotend_radius,hotend_radius, center=true, $fn=60);		//Center hole for hotend.
translate([0,hotend_radius/2,-height/2]) cylinder(height+1,hotend_radius,hotend_radius, center=true, $fn=60);		//Center hole #2 to fit hotend.
 }
}
}


module top() {
//Change "hotend_radius+4" to add distance to center
difference()
{
cylinder(40,offset-3,0, $fn=60);
translate([-20,-20,height]) cube ([100,100,100]);		//Cut off the top
translate([-50,0,-2]) cube ([100,100,100]);		//split in half
translate([0,0,-1]) cylinder(40,hotend_radius,hotend_radius);		//Center for hotend
translate([-hotend_radius-3,-10,height/2]) rotate([0, 90, 90]) cylinder(r=m3_nut_radius, h=10, center=true, $fn=6);		//M3 Screw nuts, -hotend_radius-3 give 3mm distance to inner wall
translate([hotend_radius+3,-10,height/2]) rotate([0, 90, 90]) cylinder(r=m3_nut_radius, h=10, center=true, $fn=6);		//M3 Screw nuts //M3 Screw nuts, hotend_radius+3 gives 3mm distance to inner wall
for (a = [0:180:359]) rotate([0, 0, a]) {
      translate([hotend_radius+3, 0, 4])		//M3 Screw hole, hotend_radius+3 & 3 gives 3mm distance to inner wall & 4mm bottom
		rotate([90, 0, 0]) 
		cylinder(r=m3_wide_radius, h=50, center=true, $fn=12);
    }
}
}


module lip() {
translate([0,0,-8])cylinder(h = 13 , r1 = hotend_radius+1 , r2 = hotend_radius+1); // h = 13 gives 3mm to top. radius +1 for manifold error
}


module lip_remove() {
difference() {			//Remove material to create half ring for support during print. Break off after print done
translate([0,0,-8])cylinder(7.5,hotend_radius+1,hotend_radius+1);
translate([0,0,-8])cylinder(8.5,hotend_radius-1.1,hotend_radius-1.1);	//-1.2 = ca 0.4mm support.
}
difference() {		//Diagnoal to make insertion easier
translate([0,3,0]) rotate([-20,0,0]) cylinder(height+20,hotend_radius,hotend_radius, center=true, $fn=60);
translate([-15,-15,-20.5])cube([30,30,20]);
translate([-10,-24,-.5]) cube ([20,20,10]);		//remove unneeded support
}

translate([-10,0,-9]) cube ([20,20,20]);		//split in half
translate([-10,-4,-10.5]) cube ([20,20,10]);		//remove unneeded support
translate([0,0,-8])cylinder(16,hotend_radius-1.5,hotend_radius-1.5);		// center
}


