roundRectRad = 0.5;
thickness = 3;
bigCircleDiam = 50;
smallCircleDiam = 10;
bagNeckGap = 5;
bagNeckLength = 50;
neckCircleFudge = 0.35;

/* [Hidden] */
$fa = 1;
$fs = 0.1;

module roundedSquare(w) {
  for (rot = [0:90:270]) {
    rotate([0, 0, rot]) {
      difference() {
        square([w/2, w/2]);
        translate([w/2-roundRectRad, w/2-roundRectRad, 0])
          square([roundRectRad+1, roundRectRad+1]);
      }
      translate([w/2-roundRectRad, w/2-roundRectRad, 0])
        circle(r = roundRectRad);
    }
  }
}

module rsCorner(w) {
  rotate_extrude(angle=90) {
    difference() {
      roundedSquare(w);
      translate([0, -w, 0]) square([w*2, w*2]);
    }
  }
}

module rsCylinder(w, h) {
  linear_extrude(height=h) {
    roundedSquare(w);
  }
}

module ring(d, angle=360) {
  rotate_extrude(angle = angle) {
    translate([(d + thickness) / 2, 0, 0])
      roundedSquare(w = thickness);
  }  
}

module slot() {
  rotate([-90, 0, 0]) {
    for (rot = [0, 180]) {
      rotate([0, 0, rot]) {
        translate([-(bagNeckGap + thickness)/2, 0, 0]) {
          rsCylinder(w = thickness, h = bagNeckLength);
          translate([0, 0, bagNeckLength])
          rotate([-90, 0, -180])
          rsCorner(w = thickness);
        }
        rotate([-90, 90, 0])
          ring(d = bagNeckGap, angle=90);
      }
    }
  } 
}

module bigCircleHole() {
  translate([0, -(bigCircleDiam+thickness)/2, 0])
  cube([
    bagNeckGap+thickness,
    thickness+2,
    thickness+2
  ], center = true);
}

difference() {
  ring(bigCircleDiam);
  bigCircleHole();
}

if (smallCircleDiam) {
  translate([
    0,
    (bigCircleDiam + smallCircleDiam)/2 + thickness,
    0
  ]) ring(smallCircleDiam);
}

translate([
  0,
  -bagNeckLength - bigCircleDiam/2 - thickness/2 + neckCircleFudge,
  0
]) slot();