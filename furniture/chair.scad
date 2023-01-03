/* [Dimensions] */
// width of the entire chair when viewed from the front
width = 59;
// depth of the entire chair, including the back
depth = 56;
// height of the back above the seat
backHeight = 64;
// thickness of the back
backDepth = 8;
// height of the legs
legHeight = 40;
// thickness of legs
legThickness = 6.5;
// thickness of seat, as viewed from outside
seatHeight = 16;
// height of hole in underside of seat
seatCavityHeight = 12;

/* [Back Slats] */
// put a hole in the back
backSlats = true;
// how high the hole should be (centered)
backHoleHeight = 42;
// how many vertical slats in the hole
numBackSlats = 3;

/* [Printing Aids] */
// lay the model flat on the print bed
layFlat = true;
// include a 45° bevel to avoid cavity support
frontHoleBevel = true;

/* [Hidden] */
backHoleWidth = width / (numBackSlats * 2 + 3);

translate([0, 0, layFlat ? depth : 0])
rotate([layFlat ? -90 : 0, 0, 0])
union() {
  difference() {
    // cube the size of the whole chair
    cube([width, depth, backHeight + legHeight + seatHeight]);
    
    // cut x-axis hole through the legs
    translate([-1, legThickness, -1])
      cube([ width + 2, depth - legThickness * 2, legHeight + 1]);
    
    // cut y-axis hole through the legs
    translate([legThickness, -1, -1])
      cube([ width - legThickness * 2, depth + 2, legHeight + 1]);
    
    // cut hole defining seat vs back
    translate([-1, -1, legHeight + seatHeight])
      cube([width + 2, depth - backDepth + 1, backHeight + 1]);
    
    // cut out the under-the-seat cavity
    translate([legThickness, legThickness, legHeight - 1])
      cube([
        width - legThickness * 2,
        depth - legThickness * 2,
        seatCavityHeight + 1
      ]);
    
    if (backSlats) {
      for (i = [0:numBackSlats]) {
        // holes between the back slats
        translate([
          (i * 2 + 1) * backHoleWidth,
          depth - backDepth - 1,
          legHeight + seatHeight + (backHeight - backHoleHeight) / 2
        ]) cube([backHoleWidth, backDepth + 2, backHoleHeight]);
      }
    }
  }
  
  if (frontHoleBevel) {
    // prism to bevel the front edge of the seat cavity
    // (which would otherwise need support)
    translate([legThickness - 0.1, legThickness, legHeight + seatCavityHeight])
    rotate([0, 90, 0])
    linear_extrude(width - legThickness * 2 + 0.2)
      polygon([[0, 0], [seatCavityHeight, 0], [0, seatCavityHeight]]);
  }
}