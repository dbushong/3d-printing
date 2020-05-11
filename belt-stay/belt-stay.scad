outerWidth = 6;
beltHeight = 37.75;
beltThickness = 2.75;
outerThickness = 2;
dividerThickness = /* 1.2 */ 0;

use <roundedcube.scad>;

module beltHole(m=1) {
  cube([
    beltHeight,
    beltThickness*m,
    outerWidth+2
  ]);
}

difference() {
  roundedcube([
    beltHeight + outerThickness*2,
    beltThickness*2 + outerThickness*2 + dividerThickness,
    outerWidth
  ]);
  
  if (dividerThickness > 0) {
    translate([outerThickness, outerThickness, -1])
    beltHole();
    
    translate([
      outerThickness,
      outerThickness + beltThickness + dividerThickness,
      -1
    ]) beltHole();
  } else {
    translate([outerThickness, outerThickness, -1])
    beltHole(2);
  }
}
