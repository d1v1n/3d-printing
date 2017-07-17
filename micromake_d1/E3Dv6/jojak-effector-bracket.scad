include <configuration.scad>


separation = 40;  // Distance between ball joint mounting faces.
offset = 20;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
hotend_radius = 8.1;  // Hole for the hotend (J-Head diameter is 16mm).
height = 8;


//Top
difference()
{
cylinder(40,offset-3,0, $fn=60);
translate([0,0,height]) cylinder(20,20,20);             //Cut off the top
translate([-20,-0.5,0]) cube ([40,20,10]);                //split in half. Moved -.5 to add .5mm distance
cylinder(40,hotend_radius,hotend_radius);					//Center for hotend
translate([-hotend_radius-3,-10,height/2]) rotate([0, 90, 90]) cylinder(r=m3_nut_radius, h=10, center=true, $fn=12);		//M3 Screw nuts ([-hotend_radius-4,-10,height/2]) -4 is distance to inner wall
translate([hotend_radius+3,-10,height/2]) rotate([0, 90, 90]) cylinder(r=m3_nut_radius, h=10, center=true, $fn=12);		//M3 Screw nuts //M3 Screw nuts ([-hotend_radius-4,-10,height/2]) -4 is distance to inner wall
for (a = [0:180:359]) rotate([0, 0, a]) {		//M3 screw hole
      translate([hotend_radius+3, 0, 4])		//M3 Screw nuts ([hotend_radius+4, 0, 4]) -4 is distance to center & 4 is distance to bottom
		rotate([90, 0, 0]) 
		cylinder(r=m3_wide_radius, h=50, center=true, $fn=12);
    }
}


//Lipp
difference()
{
translate([0,0,0])cylinder(5,hotend_radius,hotend_radius);	//5 so it lays flatt.  
translate([-20,-0.5,0]) cube ([40,20,10]);                //split in half. Moved -.5 to add .5mm distance
translate([0,0,-1])cylinder(10,hotend_radius-2,hotend_radius-2); //cut out center, -2 = 2mm lipp
}