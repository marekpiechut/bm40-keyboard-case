include <roundedCube.scad>

$fa = 1;
$fs = 0.4;

thickness=3;
padding=1;
pcb_edge=thickness + padding / 2;
pcb=[226.5,73.3,10.5];
inside=[pcb[0]+padding, pcb[1]+padding, pcb[2]+padding + 10];
outside=[inside[0]+thickness*2, inside[1]+thickness*2, pcb[2]+2];
usb_depth=10;
pcb_depth=8.4;
hex_diameter=29;

module screw_mount(x, y , z) {
	translate([x, y, z])
	difference(){
		union() {
			cylinder(2.5, 3, 3);
			translate([0, 0, -3]) cylinder(3, 5, 5);
		}
		translate([0, 0, 1]) cylinder(4, 1, 1);
	}
}

module leg_hole(x, y) {
	translate([x, y, -1]) cylinder(2, 4.3, 4.3);
}

module usb_connector(x) {
	translate([x, 1, 2]) cube([13, 9, 2]);
	translate([x, -1, 2]) roundedCube([13, thickness + 2, 5.5], 1, false, true, true);
}

module reset_button(x, y) {
	 translate([x, y, -1]) cube([4, 7, 5]);
}

module extender_leg_hole(x, y) {
	translate([x, y, -1]) union() {
		cylinder(5, 1.5, 1.5);
		translate([0, 0, 3]) cylinder(1.3, 1.5, 3);
	}
}

module logo() {
	linear_extrude(height = 1, center = true)
	mirror([1, 0, 0])
	rotate([180, 0, 0])
	resize([10, 12.5, 0])
	import("dayone-logo.svg", center = true);
}

module button_row(cols, height) {
	for (i=[0:1:4]) {
		translate([i*19,0,0]) cube(14, 14, height);
	}
}




module box() {
	difference()
	{
		roundedCube(outside, 2);
		translate([thickness, thickness, 3]) cube(inside);
		usb_connector(outside[0] - pcb_edge - 42.8);
		reset_button(175.5, 47);
		extender_leg_hole(outside[0]-26, 12);
		extender_leg_hole(26, 12);
		translate([20, outside[1] / 2, 0]) led_holes();
		translate([outside[0] - 20, outside[1] / 2, 0]) mirror([1, 0, 0]) led_holes();
	};
}

module splitter() {
	union() {
		translate([0, -10, -10]) cube([170, 120, 50]);
		translate([150, 30, -10]) cube(30);
	}
}

module hex(diameter, height) {
	cylinder(d = diameter, h = height, center = true, $fn = 6);
}

module led_holes() {
	translate([0, -15/2, 0]) {
		translate([0, 0, 0]) hex(hex_diameter, 10);
		translate([25, 15, 0]) hex(hex_diameter, 10);
		translate([50, 0, 0]) hex(hex_diameter, 10);
		translate([75, 15, 0]) hex(hex_diameter, 10);
	}
}

module screw_mounts() {
	screw_mount(pcb_edge + 18.6, pcb_edge + 17.3, 3);
	screw_mount(pcb_edge + 18.6, outside[1] - pcb_edge - 18.3, 3);
	screw_mount(outside[0] - pcb_edge - 17.6, pcb_edge + 17.3, 3);
	screw_mount(outside[0] - pcb_edge - 17.6, outside[1] - pcb_edge - 18.3, 3);
	screw_mount(pcb_edge + 113.8, pcb_edge + 31.3, 3);
}

module leg_holes() {
	leg_hole(10, 15);
	leg_hole(15, outside[1]-15);
	leg_hole(outside[0]-10, 15);
	leg_hole(outside[0]-15, outside[1]-15);
}

module the_case() {
	difference() {
		union() {
			box();
			screw_mounts();
		}
		leg_holes();
		translate([outside[0] / 2, 20, 0]) logo();
	}
}


module splitter() {
	translate([-1, -1, -1]) cube([outside[0] / 2 - 9, outside[1] + 2, outside[2] + 2]);
}
module splitted_case() {
	translate([-outside[0] / 2 + 10, 0, 0]) difference() {
		the_case();
		splitter();
	}
	translate([0, outside[1] + 10, 0]) intersection() {
		the_case();
		splitter();
	}
}

the_case();
