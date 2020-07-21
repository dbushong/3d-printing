mode = "dinnerForks"; // ["dinnerForks","teaspoons","tablespoons","saladForks"]
blockerBottomHeight = 5;
blockerTopHeight = 38;
farCornerRadius = 6;
bottomInset = 3;
$fn = 100;

module rrCylinder(width, length, height, scale = 1) {
  linear_extrude(height = height, scale = scale) hull() {
    translate([-width / 2, 0, 0]) square([width, 1]);
    translate([-width / 2 + farCornerRadius, length - farCornerRadius, 0])
      circle(farCornerRadius);
    translate([width / 2 - farCornerRadius, length - farCornerRadius, 0])
      circle(farCornerRadius);
  }
}

module blocker(width, length) {
  topWidth = width - 0.5;
  bottomWidth = width - bottomInset * 2;
  widthScale = bottomWidth / topWidth;
  lengthScale = (length - bottomInset) / length;
  scale = min(widthScale, lengthScale);
  union() {
    translate([0, 0, blockerBottomHeight])
    rotate([0, 180, 0])
    rrCylinder(topWidth, length, blockerBottomHeight, scale);
    // top
    translate([0, 0, blockerBottomHeight])
      rrCylinder(topWidth, length, blockerTopHeight);
  }
}

if (mode == "teaspoons") blocker(48, 90);
if (mode == "tablespoons") blocker(48, 75);
if (mode == "dinnerForks") blocker(48, 55);
if (mode == "saladForks") blocker(50, 75);