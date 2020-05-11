/* Delta(Moen?)-style Faucet Knob Cap */

/* [Knob] */
// inside diameter of faucet knob
diameter = 36.8;
// depth of outer knob recess
depth = 9;
// how wide top notch is
notchWidth = 3;
// diameter of deeper screw hole
screwDiam = 14;
// depth of deeper screw hole
screwDepth = 10;

/* [Walls] */
// side walls thickness
thickness = 1;

/* [Front Face] */
// thickness of front overlapping flange
flangeThickness = 1;
// how far should flange stick out (on each side)
flangeLip = 1;

/* [Markings] */
// width of center arrow
arrowWidth = 4;
// engrave depth of front labels
markDepth = 0.8;

/* [Hidden] */
// smoothness
$fn = 200;

use <../common/sheep-logo.scad>;

module notch(bottom = false) {
  yCoeff = bottom ? -1 : 1;
  thickCoeff = bottom ? 0.5 : 2;
  translate([
    -notchWidth/2,
    yCoeff*diameter/2 - thickness*thickCoeff,
    thickness
  ]) cube([notchWidth, thickness * 2, depth]);
}

module capBase() {
  difference() {
    // main cylinder
    cylinder(h = depth, d = diameter);
      
    // turn solid cylinder into ring
    translate([0, 0, thickness])
      cylinder(h = depth, d = diameter - thickness * 2);
    
    // cut out top & bottom notches
    notch();
    notch(true);
  }
}

module centerShaft() {
  difference() {
    cylinder(h = screwDepth + depth, d = screwDiam);
    translate([0, 0, thickness])
      cylinder(h = screwDepth + depth, d = screwDiam - thickness * 2);
  }
}


module arrow() {
  translate([0, diameter/2 - arrowWidth, flangeThickness - markDepth])
    rotate([0, 0, 90])
    cylinder(h = markDepth+1, d = arrowWidth, $fn = 3);
}

module letter(c, xCoeff = 1) {
  translate([xCoeff * diameter / 2.5, 0, flangeThickness - markDepth])
  linear_extrude(height = markDepth+1)
    text(c, size = diameter / 8, valign = "center", halign = "center");
}

module emblem() {
  logoWidth = diameter / 2;
  translate([-logoWidth/2, -logoWidth/2, flangeThickness - markDepth])
    logo(w = logoWidth, h = markDepth + 1);
}

module flange() {
  rotate([180, 0, 0])
  difference() {
    cylinder(
      h = flangeThickness, d1 = diameter + flangeLip*2, d2 = diameter
    );
      
    arrow();
    
    letter("H", -1);
    letter("C");
    
    emblem();
  };
}

module cap() {
  union() {
    capBase();
    if (screwDepth > 0) centerShaft();
    flange();
  }    
}

cap();