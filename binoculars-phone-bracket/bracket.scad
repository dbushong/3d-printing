// Bracket for holding phone camera against binoculars

/* [Binocular Dimensions] */
// outside diameter of eyecup for tight fit
binocEyecupDiam = 33.5;
// how deep you want eyecup brackets
binocEyecupDepth = 19;
// how wide the lens is
binocLensDiam = 15;
// binocClipDepth = 83;

/* [Phone Dimensions] */
// how wide your phone is when held vertically
phoneWidth = 74.5;
// how thick your phone is
phoneThickness = 11.5;
// distance from top of phone to lens center
phoneLensHorizInset = 17.5;
// distance from nearest side of phone to lens center
phoneLensVertInset = 16.5;

/* [Bracket Settings] */
// how thick you want most of the frame to be
frameThickness = 1.4;
// how deep you want the pocket holding one side of phone
pocketDepth = 13.5;

/* [Print Options] */
// print the extra support loop - skip for telescope/monocular
printLeft = true;
// print the lens-centering side
printRight = true;

/* [Hidden] */
$fa = 1;
$fs = 0.1;

module eyecup() {
  cylinder(h=binocEyecupDepth, d=binocEyecupDiam + frameThickness * 2);
}

module eyecupHole() {
  cylinder(h=binocEyecupDepth + 1, d=binocEyecupDiam);
}

module rightSide() {
  // slide over to make room for left loop
  translate([
    -10,
    0,
    0
  ]) 
  rotate([0, -90, 0]) // lay flat for easier printing
  {
    difference() {
      // nicely blended eyecup & phone pocket w/ no holes
      hull() {
        // block to receive phone edge
        cube([
          pocketDepth + frameThickness,
          phoneWidth + frameThickness * 2,
          phoneThickness + frameThickness * 2
        ]);
        
        // eyecup block
        translate([
          phoneLensHorizInset + frameThickness,
          phoneLensVertInset + frameThickness,
          phoneThickness + frameThickness * 2
        ]) eyecup();
        
        // flat plane at 0 to ensure flat print
        translate([
          0,
          phoneLensVertInset + frameThickness - binocEyecupDiam / 6,
          0
        ]) {
          cube([
            frameThickness,
            binocEyecupDiam / 3,
            binocEyecupDepth + frameThickness*2 + phoneThickness
          ]);
        }
      }
      
      // hole for eyecup
      translate([
        phoneLensHorizInset + frameThickness,
        phoneLensVertInset + frameThickness,
        phoneThickness + frameThickness * 2
      ]) eyecupHole();
      
      // cut out phone pocket
      translate([frameThickness, frameThickness, frameThickness]) {
        cube([
          pocketDepth * 10, // plenty to overshoot
          phoneWidth,
          phoneThickness
        ]);
      }
      
      // lens hole
      translate([
        phoneLensHorizInset + frameThickness,
        phoneLensVertInset + frameThickness,
        phoneThickness + frameThickness - 1
      ]) cylinder(h=frameThickness + 2, d=binocLensDiam*1.1);
    }
  }
}

module leftSide() {
  // slide over to leave gap from right frame
  translate([
    10,
    0,
    phoneThickness + frameThickness
  ])
  rotate([0, 90, 0]) // lay flat for printing
  {
    difference() {
      // nicely blended eyecup & loop block w/ no holes
      hull() {
        // outer loop block
        cube([
          pocketDepth,
          phoneWidth + frameThickness * 2,
          phoneThickness + frameThickness * 2
        ]);
        
        // eyecup block
        translate([
          pocketDepth - (binocEyecupDiam / 2 + frameThickness),
          phoneLensVertInset + frameThickness,
          phoneThickness + frameThickness * 2
        ]) eyecup();
      }
      
      // hole for eyecup
      translate([
        pocketDepth - (binocEyecupDiam / 2 + frameThickness),
        phoneLensVertInset + frameThickness,
        phoneThickness + frameThickness + 1
      ]) eyecupHole();
      
      // cut out phone hole in side to make loop
      translate([-5 * pocketDepth, frameThickness, frameThickness]) {
        cube([
          pocketDepth * 10, // plenty to overshoot
          phoneWidth,
          phoneThickness
        ]);
      }
    }
  }
}

if (printLeft) leftSide();
if (printRight) rightSide();