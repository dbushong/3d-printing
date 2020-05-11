/* Plant Identification Stakes */

/* [Stake] */
stakeLength = 100;
stakeWidth = 17;
stakeHeight = 2;

/* [Label Inset] */
labelDepth = 0.5;
labelBorder = 2;

labelLength = stakeLength / 5 * 3;
pointDim = stakeWidth / sqrt(2);

union() {
  difference() {
    // stake shaft
    cube([stakeLength, stakeWidth, stakeHeight]);
    
    // label inset
    translate([ labelBorder, labelBorder, stakeHeight-labelDepth ])
    cube([labelLength, stakeWidth - labelBorder*2, labelDepth+1]);
  }

  // stake point
  translate([ stakeLength, 0, 0 ])
  rotate([0, 0, 45])
  cube([pointDim, pointDim, stakeHeight]);
}