/* [Settings] */
// Thickness of entire extender
thickness = 1; // 5 layers @ 0.2mm
// Width of long band
shaftWidth = 5.25;
// Width of wide parts (hook & loop)
totalWidth = 20;
// Length of entire extender
totalLength = 170;
// Length of loop for attaching one end
loopLength = totalWidth * 2;
// How much to round off sharp edges
offsetRad = 1.5;

/* [Hidden] */
$fn = 200;

module loop() {
  // build a smooth transition from loop circle to shaft stub
  hull() {
    circle(d = totalWidth);
    // shaft stub
    translate([loopLength - totalWidth / 2, -shaftWidth/2, 0])
      square([1, shaftWidth]);
  }
}

// main length of shaft
module shaft() {
  translate([loopLength - totalWidth / 2, -shaftWidth/2, 0])
    square([totalLength - loopLength - totalWidth / 10, shaftWidth]);
}

module hook() {
  translate([totalLength - totalWidth, 0, 0])
  difference() {
    circle(d = totalWidth);
    // hollow out circle
    circle(d = totalWidth * 0.7);
    // chop off more than half
    translate([5 - totalWidth/2, 0, 0])
      square([totalWidth, totalWidth + 2], center = true);
  }
  // ends are a bit rough; round them off
  hookCap();
  rotate([180, 0, 0]) hookCap();
}

module hookCap() {
  // full of fudging :-(
  translate([
    totalLength - totalWidth + 4.9,
    totalWidth / 2 - totalWidth * 0.7 / 8 - 1.1,
    0
  ])
  difference() {
    circle(d = totalWidth * 0.3 / 2 + 0.1);
    translate([0, -totalWidth/2, 0])
      square([totalWidth, totalWidth]);
  }
}

module maskExtender() {
  linear_extrude(height = thickness) {
    // round off inside & outside
    offset(r = -offsetRad) {
      offset(r = offsetRad) {    
        difference() {
          loop();
          scale([0.7, 0.7, 1]) loop();
        }
        shaft();
        hook();
      }
    }
  }
}

maskExtender();
