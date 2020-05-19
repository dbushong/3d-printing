/* [Body] */
bodyThickness = 2;
bodyLength = 50;
bodyWidth = 19;
bodyRoundHeight = 8;
bodyRoundDiameter = pow(bodyWidth, 2) / (4*bodyRoundHeight) + bodyRoundHeight;

/* [Shelf] */
shelfThickness = 1.5;
shelfDepth = 12.5;
shelfSupportThickness = 1;
shelfSupportHeight = 10;
shelfSupportDepth = 10;
shelfInset = 3;
shelfRoundRadius = 2;

/* [Retention Tab] */
tabWidth = 10;
tabHeight = 24.5;
tabAngle = 10; // [1:45]

/* [Peg] */
// how fat the peg going into the desk is
pegDiameter = 6;
pegLength = 7;

/* [Hidden] */
$fn = 75;

module bodyRound() {
  rotate([-90, 0, 0])
  translate([bodyWidth/2, bodyRoundDiameter/2 - bodyRoundHeight, 0])
  difference() {
    cylinder(h = bodyThickness, d = bodyRoundDiameter);
    translate([0, bodyRoundHeight, 1])
      cube([
        bodyRoundDiameter + 2,
        bodyRoundDiameter,
        bodyThickness + 2
      ], center = true);
  }
}

module tab() {
  translate([
    (bodyWidth - tabWidth) / 2,
    0,
    bodyLength + bodyRoundHeight
  ])
  rotate([tabAngle, 0, 0])
  translate([0, 0, -tabHeight])
  cube([tabWidth, bodyThickness, tabHeight]);
}

module body() {
  union() {
    difference() {
      union() {
        translate([0, 0, bodyLength+bodyRoundHeight]) bodyRound();
        translate([bodyWidth, 0, bodyRoundHeight])
          rotate([0, 180, 0]) bodyRound();
        translate([0, 0, bodyRoundHeight])
          cube([bodyWidth, bodyThickness, bodyLength]);
      }
      // tab hole
      translate([
        (bodyWidth - tabWidth - 0.5)/2,
        -1,
        bodyLength + bodyRoundHeight - tabHeight
      ]) cube([tabWidth + 0.5, bodyThickness+2, tabHeight]);
    }
    tab();
  }
}

module shelfSupport() {
  translate([0, 0, -shelfSupportHeight])
  rotate([0, -90, 0])
  linear_extrude(height = shelfThickness)
  polygon([
    [0, 0],
    [shelfSupportDepth, 0],
    [shelfSupportDepth, shelfSupportHeight]
  ]);
}

module shelf() {
  translate([0, bodyThickness, shelfSupportHeight + 3])
  union() {
    translate([bodyWidth-shelfInset, 0, 0])
      shelfSupport();
    translate([shelfSupportThickness+shelfInset, 0, 0])
      shelfSupport();
    
    // the shelf itself
    // main part
    cube([bodyWidth, shelfDepth - shelfRoundRadius, shelfThickness]);
    // extra bit between the rounds
    translate([shelfRoundRadius, shelfDepth - shelfRoundRadius, 0])
      cube([
        bodyWidth - shelfRoundRadius * 2,
        shelfRoundRadius,
        shelfThickness
      ]);
    // right round (baby)
    translate([shelfRoundRadius, shelfDepth - shelfRoundRadius, 0])
      cylinder(h = shelfThickness, r = shelfRoundRadius);
    // left round
    translate([bodyWidth - shelfRoundRadius, shelfDepth - shelfRoundRadius, 0])
      cylinder(h = shelfThickness, r = shelfRoundRadius);
  }
}

module peg() {
  translate([
    bodyWidth / 2,
    0,
    shelfSupportHeight + 3 - pegDiameter / 2
  ])
  rotate([90, 0, 0])
  union() {
    cylinder(h = pegLength - 1, d = pegDiameter);
    translate([0, 0, pegLength - 1])
      cylinder(h = 1, d1 = pegDiameter, d2 = pegDiameter - 1);
  }
}

body();
shelf();
peg();
