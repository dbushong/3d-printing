thickness = 0.6;
loopWidth = 5;
totalWidth = 20;
totalLength = 150;
hookGapDiam = 3.75;
hookShaftWidth = 5.25;
hookShaftAngle = 45;

$fn = 100;

module blank() {
  cylinder(h = thickness, d = totalWidth);
  translate([totalLength - totalWidth, 0, 0])
    cylinder(h = thickness, d = totalWidth);
  translate([0, -totalWidth / 2, 0])
    cube([totalLength - totalWidth, totalWidth, thickness]);
}

module blankCutout() {
  union() {
    translate([0, 0, -1])
      cylinder(h = thickness + 2, d = totalWidth - loopWidth * 2);
    translate([totalLength - totalWidth * 1.5, 0, -1])
      cylinder(h = thickness + 2, d = totalWidth - loopWidth * 2);
    translate([0, loopWidth - totalWidth/2, -1])
      cube([totalLength - totalWidth*1.5, totalWidth - loopWidth * 2, thickness + 2]);
  }
}

module hookCutout() {
  translate([
    totalLength - totalWidth + hookGapDiam/2,
    (hookShaftWidth + hookGapDiam) / 2,
    -1
  ]) {
    cylinder(h = thickness + 2, d = hookGapDiam);
    rotate([0, 0, hookShaftAngle])
      translate([-hookGapDiam/2, 0, 0])
        cube([hookGapDiam, totalWidth, thickness+2]);
  }
}

difference() {
  blank();
  blankCutout();
  hookCutout();
  rotate([180, 0, 0]) hookCutout();
}

