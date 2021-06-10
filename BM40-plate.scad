$fa = 1;
$fs = 0.4;

button_spacing = 19;
padding=1;
pcb_edge=padding / 2;
pcb=[226.5,73.3,10.5];
inside=[pcb[0]+padding, pcb[1]+padding, 1.4];


module button() {
	cube([14, 14, 4]);
}

module spacebar() {
	cube([33, 14, 4]);
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
	translate([button_spacing * 5, button_spacing*3, -2]) spacebar();
	translate([button_spacing * 7, button_spacing*3, 0]) buttons(1, 5);
}

module screw_mount(x, y , z) {
	translate([x, y, z]) cylinder(4, 1.6, 1.6);
}

difference() {
	cube(inside);
	translate([2.25, 1.65, 0]) grid();
//	translate([-10, -10, -4]) cube(143, 100, 10);
	screw_mount(pcb_edge + 18.6, pcb_edge + 17.3, -1);
	screw_mount(pcb_edge + 18.6, inside[1] - pcb_edge - 18.3, -1);
	screw_mount(inside[0] - pcb_edge - 17.6, pcb_edge + 17.3, -1);
	screw_mount(inside[0] - pcb_edge - 17.6, inside[1] - pcb_edge - 18.3, -1);
}