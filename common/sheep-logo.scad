addBase = false;

logoWidth = 30;
logoHeight = 1;
dxfWidth = 25;
baseThickness = 0.5;
$fn = 100;

module logo(w = logoWidth, h = logoHeight) {
  difference() {
    scaleUp = w / dxfWidth;
    linear_extrude(h)
    scale([scaleUp, scaleUp, 0])
    import("fss-logo-img-bw-gaps.dxf");
    
    // delete the ugly rough circle
    translate([w/2, w/2, -1]) difference() {
      cylinder(h=h+2, d=w+2);
      translate([0, 0, -1])
        cylinder(h=h+4, d=w-4);
    }
  }
  
  // add a nicer circle
  translate([w/2, w/2, 0]) difference() {
    cylinder(h=h, d=w);
    translate([0, 0, -1]) cylinder(h=h+2, d=w-2);
  }
}

if (addBase) {
  translate([0, 0, baseThickness]) logo();
  translate([logoWidth/2, logoWidth/2, 0])
    cylinder(h=baseThickness, d=logoWidth);
} else {
  logo();
}