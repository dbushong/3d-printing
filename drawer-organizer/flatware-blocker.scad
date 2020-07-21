blockerBottomHeight = 5;
blockerTopHeight = 38;
farCornerRadius = 6;
bottomInset = 3;
$fn = 100;

module rrCylinder(width, length, height) {
  linear_extrude(height = height, center = false) hull() {
    square([width, 1]);
    translate([farCornerRadius, length - farCornerRadius, 0])
      circle(farCornerRadius);
    translate([width - farCornerRadius, length - farCornerRadius, 0])
      circle(farCornerRadius);
  }
}

module blocker(width, length) {
  topWidth = width - 0.5;
  bottomWidth = width - bottomInset * 2;
  union() {
    // bottom
    translate([(bottomInset * 2 - 0.5) / 2, 0, 0])
      rrCylinder(bottomWidth, length - bottomInset, blockerBottomHeight + 1);
    // top
    translate([0, 0, blockerBottomHeight])
      rrCylinder(topWidth, length, blockerTopHeight);
  }
}

// teaspoons
// blocker(48, 90);

// tablespoons
// blocker(48, 75);

// dinner forks
blocker(48, 55);

// salad forks
// blocker(50, 75);