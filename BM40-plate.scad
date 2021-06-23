include <roundedCube.scad>

split=true;

$fa = 1;
$fs = 0.4;

button_spacing = 19;
padding=0.5;
pcb=[226.5,73.3,10.5];
inside=[pcb[0]+padding, pcb[1], 3];


module button() {
	union() {
		cube([14.1, 14.1, 10]);
		translate([-1, 1, 0]) cube([2, 3.2, 10]);
		translate([-1, 10, 0]) cube([2, 3.2, 10]);
		translate([13.2, 1, 0]) cube([2, 3.2, 10]);
		translate([13.2, 10, 0]) cube([2, 3.2, 10]);
	}
}

module button_2u() {
	union() {
		translate([(33 - 14) / 2, 0, 0]) button();
		translate([1, 0.5, 0]) roundedCube([7, 13, 10]);
		translate([33 - 7 - 1, 0.5, 0]) roundedCube([7, 13, 10]);
//		cube([33, 14, 4]);	
	}
}

module buttons(rows, cols) {
	for (i=[0:1:cols - 1]) {
		for (j=[0:1:rows - 1]) {
			translate([i*button_spacing,j*button_spacing, -2]) button();
		}
	}
}

module grid() {
	buttons(3, 12);
	translate([0, button_spacing*3, 0]) buttons(1, 5);
	translate([button_spacing * 7, button_spacing*3, 0]) buttons(1, 5);
	translate([button_spacing * 5, button_spacing*3, -2]) button_2u();
	translate([button_spacing * 7, button_spacing*3, 0]) buttons(1, 5);
}

module screw_mount(x, y , z) {
	translate([x, y, z]) cylinder(10, 1.9, 1.9);
}

module the_plate() {
	difference() {
		roundedCube(inside, 0.4);
		translate([2, 1.2, 0]) grid();
		screw_mount(2 + 16.5, 1.4 + 16, -1);
		screw_mount(2 + 16.5, 1.4 + 16 + 2 * 19, -1);
		screw_mount(2 + 16.5 + 10 * 19, 1.4 + 16, -1);
		screw_mount(2 + 16.5 + 10 * 19, 1.4 + 16 + 2 * 19, -1);
		screw_mount(2 + 16.5 + 5 * 19, 1.4 + 16 + 19, -1);
	}
}

module splitter() {
	translate([-1, -1, -1]) union() {
		cube([inside[0] / 2 - 18, inside[1] + 2, inside[2] + 2]);	
		translate([inside[0] / 2 - 18, 19, 0])cube([38, 38, inside[2] + 2]);
	}
}

module splitted_plate() {
	translate([-inside[0] / 2 + 20, 0, 0]) difference() {
		the_plate();
		splitter();
	}
	translate([0, inside[1] + 10, 0]) intersection() {
		the_plate();
		splitter();
	}
}

if(split)
	splitted_plate();
else
	the_plate();
