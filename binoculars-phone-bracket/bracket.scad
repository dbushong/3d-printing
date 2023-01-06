// Bracket for holding phone camera against binoculars

/* [Binocular Dimensions] */
// outside diameter of eyecup for tight fit
binocEyecupWidth = 35;
// how deep you want eyecup brackets
binocEyecupDepth = 17;
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


// possible extra space below frame & cup
vertExtra = max(
  0,
  binocEyecupWidth / 2 - phoneLensVertInset
);

module rightPhoneFrame() {
  difference() {
    cube([
      pocketDepth + frameThickness,
      phoneWidth + frameThickness * 2 + vertExtra,
      phoneThickness + frameThickness * 2
    ]);
    translate([frameThickness, frameThickness + vertExtra, frameThickness])
      cube([
        pocketDepth + 1, phoneWidth, phoneThickness]);
  }
}

module leftPhoneClip() {
  // center horizontally to match eyecup
  translate([-pocketDepth/2, 0, 0])
    difference() {
      // outer block
      cube([
        pocketDepth,
        phoneWidth + frameThickness * 2 + vertExtra,
        phoneThickness + frameThickness * 2
      ]);
      // cut out phone hole
      translate([-1, frameThickness + vertExtra, frameThickness])
        cube([
          pocketDepth + 2,
          phoneWidth,
          phoneThickness
        ]);
      // turn into clip instead of loop
      translate([
        -1,
        phoneClipHeight + frameThickness + vertExtra,
        -1
      ])
        cube([
          pocketDepth + 2,
          phoneWidth - phoneClipHeight * 2,
          frameThickness + 2
        ]);
    }
}

module eyecup() {
  difference() {
    cylinder(h=binocEyecupDepth, d=binocEyecupWidth + frameThickness * 2);
    translate([0, 0, -1])
      cylinder(h=binocEyecupDepth + 2, d=binocEyecupWidth);
  }
}

module rightSide() {
  // slide over to make room for left clip
  translate([
    -(binocEyecupWidth/2 + frameThickness*2 + phoneLensHorizInset + 10),
    0,
    0
  ]) {
    rightPhoneFrame();
    translate([
      phoneLensHorizInset + frameThickness,
      phoneLensVertInset + frameThickness + vertExtra,
      phoneThickness + frameThickness
    ]) eyecup();
  }
}

module leftSide() {
  // slide over to leave gap from right frame
  translate([
    binocEyecupWidth/2 + frameThickness + 10,
    0,
    0
  ]) {
    leftPhoneClip();
    translate([
      0,
      phoneLensVertInset + frameThickness + vertExtra,
      phoneThickness + frameThickness
    ]) eyecup();
  }
}

// flip the whole thing around to make it easier(?) to print
rotate([0, 180, 0]) {
  leftSide();
  rightSide();
}