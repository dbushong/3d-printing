// Bracket for holding phone camera against binoculars

/* [Binocular Dimensions] */
// outside diameter of eyecup for tight fit
binocEyecupWidth = 35;
// how deep you want eyecup brackets
binocEyecupDepth = 17;
// how wide the lens is
binocLensWidth = 15;
// binocClipDepth = 83;

/* [Phone Dimensions] */
// how wide your phone is when held vertically
phoneWidth = 75;
// how thick your phone is
phoneThickness = 11.5;
// distance from top of phone to lens center
phoneLensHorizInset = 18;
// distance from nearest side of phone to lens center
phoneLensVertInset = 16;

/* [Bracket Settings] */
// how deep the clips holding the other side should be
phoneClipHeight = 7;
// how thick you want most of the frame to be
frameThickness = 0.8;
// how deep you want the pocket holding one side of phone
pocketDepth = 10;

/* [Hidden] */
$fa = 1;
$fs = 0.1;
clipThickness = frameThickness * 2;

module eyecup() {
  cylinder(h=binocEyecupDepth, d=binocEyecupWidth + frameThickness * 2);
}

module eyecupHole() {
  cylinder(h=binocEyecupDepth + 1, d=binocEyecupWidth);
}

module rightSide() {
  // slide over to make room for left clip
  translate([
    -(binocEyecupWidth/2 + frameThickness*2 + phoneLensHorizInset + 10),
    0,
    0
  ]) {
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
        phoneThickness - 1
      ]) cylinder(h=frameThickness + 2, d=binocLensWidth*1.1);
    }
  }
}

module leftSide() {
  // slide over to leave gap from right frame
  translate([
    binocEyecupWidth/2 + frameThickness + 10,
    0,
    0
  ]) {
    difference() {
      // nicely blended eyecup & clip block w/ no holes
      hull() {
        // center horizontally to match eyecup
        translate([-pocketDepth/2, 0, 0]) {
          // outer clip block
          cube([
            pocketDepth,
            phoneWidth + clipThickness * 2,
            phoneThickness + clipThickness + frameThickness
          ]);
        }
        
        // eyecup block
        translate([
          0,
          phoneLensVertInset + frameThickness,
          phoneThickness + frameThickness * 2
        ]) eyecup();
      }
      
      // hole for eyecup
      translate([
        0,
        phoneLensVertInset + frameThickness,
        phoneThickness + frameThickness + 1
      ]) eyecupHole();
      
      // cut out phone hole in clip side to make loop
      translate([-5 * pocketDepth, clipThickness, frameThickness]) {
        cube([
          pocketDepth * 10, // plenty to overshoot
          phoneWidth,
          phoneThickness
        ]);
      }
        
      // turn into clip instead of loop
      translate([
        -5 * pocketDepth,
        phoneClipHeight + clipThickness,
        -1
      ]) {
        cube([
          pocketDepth * 10,
          phoneWidth - phoneClipHeight * 2,
          clipThickness + 2
        ]);
      }
    }
  }
}

leftSide();
rightSide();