thickness = 3;
bigCircleDiam = 50;
smallCircleDiam = 0;
bagNeckGap = 5;
bagNeckLength = 50;
neckCircleFudge = 0.37;

/* [Hidden] */
$fn = 50;

module ring(d, angle=360) {
  rotate_extrude(angle = angle) {
    translate([(d + thickness) / 2, 0, 0])
      circle(d = thickness);
  }  
}

module slotSide() {
  translate([-(bagNeckGap + thickness)/2, 0, 0]) {
    cylinder(d = thickness, h = bagNeckLength);
    translate([0, 0, bagNeckLength])
      sphere(d = thickness);
  }
  rotate([-90, 90, 0])
    ring(d = bagNeckGap, angle=90);
}

module slot() {
  rotate([-90, 0, 0]) {
    slotSide();
    rotate([0, 0, 180])
    slotSide();
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