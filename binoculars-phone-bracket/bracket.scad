binocEyecupWidth = 35;
binocEyecupDepth = 17;
binocEyecupSeparation = 39;
binocClipDepth = 83;
phoneWidth = 155;
phoneHeight = 75;
phoneDepth = 11.5;
phoneLensHorizInset = 17;
phoneLensVertInset = 15.5;
// frameThickness = 1;
frameThickness = 0.8;

/* [Hidden] */
$fa = 1;
$fs = 0.1;


module phoneFrame() {
  difference() {
    cube([
      phoneWidth + frameThickness * 2,
      phoneHeight + frameThickness * 2,
      phoneDepth
    ]);
    translate([frameThickness, frameThickness, -1])
      cube([phoneWidth, phoneHeight, phoneDepth + 2]);
  }
}

module eyecup() {
  difference() {
    cylinder(h=binocEyecupDepth, d=binocEyecupWidth + frameThickness * 2);
    translate([0, 0, -1])
      cylinder(h=binocEyecupDepth + 2, d=binocEyecupWidth);
  }
}

phoneFrame();
translate([
  phoneLensHorizInset + frameThickness,
  phoneLensVertInset + frameThickness,
  phoneDepth
]) eyecup();
translate([
  phoneLensHorizInset + frameThickness*3 + binocEyecupSeparation
    + binocEyecupWidth,
  phoneLensVertInset + frameThickness,
  phoneDepth
]) eyecup();
