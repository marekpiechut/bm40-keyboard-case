$fa = 1;
$fs = 0.4;

height = 5;

module leg_extender() {
	difference(){
		union() {
			cylinder(2, 9, 9);
			translate([0, 0, 2]) cylinder(height - 2, 9, 5);
		}
		translate([0, 0, -1]) cylinder(height - 1, 2, 2);
		translate([0, 0, height - 1]) cylinder(2, 4.3, 4.3);
	}
}

leg_extender();
translate([24, 0, 0]) leg_extender();
