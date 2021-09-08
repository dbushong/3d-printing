diameter = 64.5;
height = 5.8;
thickness = 1.4;

$fn = 300;

difference() {
  cylinder(d = diameter, h = height);
  translate([0, 0, -1])
    cylinder(d = diameter - 2 * thickness, h = height + 2);
}