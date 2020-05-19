// Blind Rotating Screw Part

/* [Bottom Shaft] */
bottomShaftHeight = 58;
bottomShaftDiameter = 5.85;

/* [Top Shaft] */
topShaftHeight = 3.75;
topShaftDiameter = 4;

/* [Screw] */
screwHeight = 9.5;
screwInnerDiameter = 8.75;
screwOuterDiameter = 12.5;
// to account for wear
widthPadding = 1; // [0:0.25:2]
screwPitch = (screwOuterDiameter - screwInnerDiameter) / 1.082532;

/* [Collar] */
collarDiameter = 8;
collarYPos = 45;
collarHeight = 1;

/* [Pin Hole] */
holeDiameter = 2;
holeYPos = 10.5;

/* [Hidden] */
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
      diameter = screwOuterDiameter + widthPadding,
      pitch = screwPitch,
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
