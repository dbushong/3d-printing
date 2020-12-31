mode = "dinnerForks"; // ["dinnerForks","teaspoons","tablespoons","saladForks"]
blockerBottomHeight = 5;
blockerTopHeight = 38;
farCornerRadius = 6;
bottomInset = 3;
thickness = 1;
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


module blockerShape(width, length, topHeight = blockerTopHeight) {
  topWidth = width - 0.5;
  bottomWidth = width - bottomInset * 2;
  
  scale = min(bottomWidth / topWidth, 1 - bottomInset / length);
  
  translate([0, -length/2, blockerBottomHeight]) {
    // bottom
    rotate([0, 180, 0])
    rrCylinder(topWidth, length, blockerBottomHeight, scale);
    // top
    rrCylinder(topWidth, length, topHeight);
  }
}

module blocker(width, length) {
  difference() {
    // outside of cup
    blockerShape(width, length);
    
    // inside to remove
    translate([0, 0, thickness])
      blockerShape(
        width - thickness*2, length - thickness*2, blockerTopHeight+2
      );
  }
}

if (mode == "teaspoons") blocker(48, 90);
if (mode == "tablespoons") blocker(48, 75);
if (mode == "dinnerForks") blocker(48, 55);
if (mode == "saladForks") blocker(50, 75);