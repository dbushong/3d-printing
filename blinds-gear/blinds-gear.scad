bottomShaftHeight = 58;
screwHeight = 9.5;
screwInnerDiameter = 8.75;
screwOuterDiameter = 12.5;
screwRotations = 3;
screwTaperRatio = 0.25;
topShaftHeight = 3.75;
bottomShaftDiameter = 5.85;
topShaftDiameter = 4;
collarDiameter = 8;
collarYPos = 45;
collarHeight = 1;
holeDiameter = 2;
holeYPos = 10.5;
$fn = 75;

use <threads.scad>;

difference() {
  union() {
    // main shaft
    cylinder(
      h = bottomShaftHeight,
      d = bottomShaftDiameter
    );

    // collar
    translate([0, 0, collarYPos])
    cylinder(
      h = collarHeight,
      d1 = bottomShaftDiameter,
      d2 = collarDiameter
    );

    // top peg
    cylinder(
      h = bottomShaftHeight + topShaftHeight,
      d = topShaftDiameter
    );

    // screw
    rotate([0, 0, 90])
    translate([0, 0, bottomShaftHeight - screwHeight])
    metric_thread(
      diameter = screwOuterDiameter,
      pitch = (screwOuterDiameter - screwInnerDiameter) / 1.082532,
      length = screwHeight
    );
  }

  // hole
  translate([0,  -bottomShaftDiameter / 2 - 1, holeYPos])
  rotate([-90, 0, 0])
  cylinder(
    h = bottomShaftDiameter + 2,
    d = holeDiameter
  );

  // slot for pin
  translate([0, -holeDiameter, -1])
  cylinder(
    h = holeYPos + 1,
    d = holeDiameter
  );

  // smooth out slot
  translate([-holeDiameter / 2, holeDiameter - bottomShaftDiameter, -1])
  cube([holeDiameter, holeDiameter, holeYPos + 1]);
}
