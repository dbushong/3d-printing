/* [Settings] */
// Height of closed laptop
laptop_h = 18;
// Maximum height of mountains
mountain_h = 50;
// Height of base between mountains
base_h = 4;
// Thickness of mountains at tips
mountain_d = 4;

/* [Hidden] */
$fa = 1;   // default minimum facet angle is now 1 mm
$fs = 0.5; // default minimum facet size is now 0.5 mm

module pyramid(w, d, h) {
  polyhedron(
    // the four points at base
    points=[ [d,w,0],[d,-w,0],[0,-w,0],[0,w,0],
    // the apex point
       [0,0,h]  ],
    // each triangle side   
    faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4], 
    // two triangles for square base
    [1,0,3],[2,1,3] ],
    convexity = 10
  );
}
 
module mountain(w, d, h, slope_sides=true, use_snow=true) {  
  if (slope_sides) {
    difference() {
      pyramid(w, d, h);
      if (use_snow) {
        stretch = 15;
        h1 = h * 0.65;
        h2 = h - h1;
        d2 = h2 * d / h;
        translate([d2 - 0.5, -w*stretch/40, h1]) {
          resize([0, w*stretch, 0]) {
            rotate([0,-atan(d/h),0]) {
              snowcap();
            }
          }
        }
      }
    }
  } else {
    translate([0, -w, 0]) {
      polyhedron(
        points=[[0,0,0], [d,0,0], [d,2*w,0], [0,2*w,0],
                [0,w,h], [d,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]],
        convexity = 10
      );
    }
  }
}

module mtn_range(max_mtn_h, slope_sides=true) {
  mtn_w = max_mtn_h * 0.75;
  mtn_d = max_mtn_h * 0.4;
  
  tall_mtn_w  = mtn_w * 1.5;
  med_mtn_w   = mtn_w;
  short_mtn_w = mtn_w * 1.25;

  tall_mtn_d  = mtn_d;
  med_mtn_d   = mtn_d;
  short_mtn_d = mtn_d;

  tall_mtn_h  = max_mtn_h;
  med_mtn_h   = max_mtn_h * 0.88;
  short_mtn_h = max_mtn_h * 0.75;
  
  translate([0, tall_mtn_w, 0]) {
    mountain(tall_mtn_w, tall_mtn_d, tall_mtn_h, slope_sides);
    translate([0, max_mtn_h * 0.75, 0]) {
      mountain(short_mtn_w, short_mtn_d, short_mtn_h, slope_sides);
    }
    translate([0, max_mtn_h * 1.125, 0]) {
      mountain(med_mtn_w, med_mtn_d, med_mtn_h, slope_sides);
    }
  }
}

module snow_bottom() {
  polygon(points=[
    [0,0], [4,0],
    [1,1],   [4,2],
    [2.5,3], [4,4],
    [2,5],   [4,6],
    [0.5,7], [4,8],
    [1.5,9], [4,10],
    [0,10]]
  );
}

module snowline() {
  translate([0, 0, 4.5]) {
    rotate([0, 90, 0]) {
      linear_extrude(height=5) {
        difference() {
          translate([0.5, 0, 0]) {
            snow_bottom();
          }
          snow_bottom();
        }
      }
    }
  }
}

module snow_top() {
  polygon(points=[
    [100,-100], [4, -100], [4,0],
    [0.5,1], [4,2],
    [2,3],   [4,4],
    [1.5,5], [4,6],
    [0,7],   [4,8],
    [1,9],   [4,10],
    [4, 100], [100,100]]
  );
}

module snowcap() {
  translate([0, 0, 4]) {
    rotate([0, 90, 0]) {
      linear_extrude(height=5) {
        snow_top();
      }
    }
  }
}

difference() {
  union() {
    translate([laptop_h + (2 * mountain_d), 0, 0]) {
      mtn_range(mountain_h);
    }
    mirror([1, 0, 0]) {
      mtn_range(mountain_h);
    }
    resize([laptop_h + (2 * mountain_d), 0, 0]) {
      mtn_range(mountain_h, false);
    }
  }
  translate([mountain_d, 0, base_h]) {
    cube(size=[laptop_h, mountain_h*3, mountain_h]);
  }
}
