/* Parameterizable Vertical Laptop Holder */

/* [Inner Dimensions] */
// Thickness of laptop slot
laptopGap = 25;

/* [Outer Dimensions] */
// Length of entire holder
baseWidth = 140;
// Thickness of holder sides at bottom
baseDepth = 24;
// Thickness of floor
floorHeight = 7;
// Cutout radius along length of side
sideXRad = 69;
// Cutout radius horizontal in side
sideYRad = 61;
// Cutout radius vertical in side
sideZRad = 71;
// Height of entire holder
baseHeight = 45;

/* [Hidden] */
$fn = 400;

module sideXCylinder() {
  // FIXME - parameterize properly
  translate([-1, 72, 55])
    rotate([0, 90, 0])
      cylinder(h = baseWidth + 2, r = sideXRad);
}

module sideYCylinder() {
  translate([baseWidth / 2, -1, sideYRad + floorHeight])
    rotate([-90, 0, 0])
      cylinder(h = baseDepth + 2, r = sideYRad);  
}

module sideZCylinder() {
  translate([baseWidth / 2, sideZRad, -1])
    cylinder(h = baseHeight + 2, r = sideZRad);  
}

module side() {
  difference() {
    cube([baseWidth, baseDepth, baseHeight]);
    sideXCylinder();
    sideYCylinder();
    sideZCylinder();
  }
}

module bottom() {
  cube([baseWidth, laptopGap, floorHeight]);
}

side();
translate([baseWidth, -laptopGap, 0])
  rotate([0, 0, 180])
    side();
translate([0, -laptopGap, 0])
  bottom();