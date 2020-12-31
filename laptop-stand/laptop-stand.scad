/* Parameterizable Vertical Laptop Holder */

/* [Inner Dimensions] */
// Thickness of laptop slot(s)
laptopGaps = [25, 19];

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
// Thickness of center support tabs
supportDepth = 6;

/* [Hidden] */
$fn = 400;

function sum(v, i = 0, total = 0) =
  i < len(v) ? sum(v, i + 1, total + v[i]) : total;

totalGapDepth = (len(laptopGaps) - 1) * supportDepth + sum(laptopGaps);
totalDepth = totalGapDepth + baseDepth * 2;

module sideXCylinder() {
  // FIXME - parameterize properly
  translate([-1, 72, 55])
    rotate([0, 90, 0])
      cylinder(h = baseWidth + 2, r = sideXRad);
}

module sideYCylinder() {
  translate([baseWidth / 2, baseDepth + 1, sideYRad + floorHeight])
    rotate([90, 0, 0])
      cylinder(h = totalDepth + 2, r = sideYRad);  
}

module sideZCylinder() {
  translate([baseWidth / 2, sideZRad, -1])
    cylinder(h = baseHeight + 2, r = sideZRad);  
}

module side() {
  difference() {
    cube([baseWidth, baseDepth, baseHeight]);
    sideXCylinder();
    sideZCylinder();
  }
}

module bottom() {
  cube([baseWidth, totalGapDepth, floorHeight]);
}

module separators() {
  for (i = [0 : len(laptopGaps)-2]) {
    gapDepth = sum([for (j = [0:i]) laptopGaps[j] + supportDepth]);
    translate([0, -gapDepth, 1])
      cube([baseWidth, supportDepth, baseHeight-1]);
  }
}

difference() {
  union() {
    side();
    
    translate([baseWidth, -totalGapDepth, 0])
      rotate([0, 0, 180])
        side();
   
    separators();
    
    translate([0, -totalGapDepth, 0])
      bottom();
  }
  
  sideYCylinder();
}