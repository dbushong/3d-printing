/* [Lid Cover] */
capH = 1;

/* [Lid] */
lidDiam = 93;
lidH = 6.75;
outerLip = 1.75;
gasketGap = 5;
innerLip = 1;

/* [Hinge] */
hingeW = 9.25;
hingeD = 15;
hingeHoleDiam = 3.5;
hingeHoleInset = 4;
hingeMerge = 1;

/* [Hook] */
hookW = 6.75;
hookD = 12.25;
hookTabW = 2.25;
hookGrooveH = 3;
hookGrooveW = 3;
hookMerge = 1;

$fn = 300;

union() {
  // cap + outer lip: rest on build plate (currently flat)
  difference() {
    cylinder(h = capH + lidH, d = lidDiam);
    translate([0, 0, capH]) {
      cylinder(h = lidH + 1, d = lidDiam - 2 * outerLip);
    }
  }
  
  // inner lip
  translate([0, 0, capH]) {
    difference() {
      innerLipOuterDiam = lidDiam - 2 * outerLip - 2 * gasketGap;
      cylinder(h = lidH, d = innerLipOuterDiam);
      translate([0, 0, -1])
        cylinder(h = lidH + 2, d = innerLipOuterDiam - 2 * innerLip);
    }
  }
  
  // hinge
  translate([lidDiam / 2 - hingeMerge, -hingeD / 2, 0])
  difference() {
    union() {
      cube([hingeW - hingeHoleInset, hingeD, lidH + capH]);
      translate([hingeW - hingeHoleInset, 0, (lidH + capH) / 2])
      rotate([-90, 0, 0])
        cylinder(h = hingeD, d = lidH + capH);
    }
    translate([hingeW - hingeHoleInset, -1, (lidH + capH) / 2])
    rotate([-90, 0, 0])
      cylinder(h = hingeD + 2, d = hingeHoleDiam);
  }
  
  // hook
  translate([-lidDiam / 2 - hookW + hookMerge, -hookD / 2, 0])
  difference() {
    cube([hookW, hookD, lidH + capH]);
    translate([hookTabW, -1, -1])
      cube([hookGrooveW, hookD + 2, hookGrooveH + 1]);
  }
}