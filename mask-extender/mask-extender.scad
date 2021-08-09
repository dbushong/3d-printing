thickness = 0.6;
loopWidth = 5;
totalWidth = 20;
totalLength = 150;
hookShaftWidth = 5.25;
hookShaftAngle = 45;
offsetRad = 1;
hookGapDiam = 3.75 + offsetRad*2;

$fn = 200;

module blank() {
  circle(d = totalWidth - offsetRad*2);
  translate([totalLength - totalWidth - offsetRad, 0, 0])
    circle(d = totalWidth - offsetRad*2);
  translate([0, offsetRad - totalWidth/2, 0])
    square([totalLength - totalWidth, totalWidth - offsetRad*2]);
}

module blankCutout() {
  union() {
    circle(d = totalWidth - loopWidth * 2 + offsetRad*2);
    translate([totalLength - totalWidth * 1.5, 0, 0])
      circle(d = totalWidth - loopWidth * 2 + offsetRad*2);
    translate([0, loopWidth - totalWidth/2 - offsetRad, 0])
      square([totalLength - totalWidth*1.5, totalWidth - loopWidth * 2 + offsetRad*2]);
  }
}

module hookCutout() {
  translate([
    totalLength - totalWidth - offsetRad*2 + hookGapDiam/2,
    (hookShaftWidth + hookGapDiam) / 2,
    0
  ]) {
    circle(d = hookGapDiam);
    rotate([0, 0, hookShaftAngle])
      translate([-hookGapDiam/2, 0, 0])
        square([hookGapDiam, totalWidth]);
  }
}

linear_extrude(height = thickness) {
  difference() {
    offset(r = offsetRad) {
      difference() {
        blank();
        hookCutout();
        rotate([180, 0, 0]) hookCutout();
      }
    }
    blankCutout();
  }
}
