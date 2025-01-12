u = 19.05;
ol = 0.001;

$fs = 0.15;
$fn=100;


key_to_window_margin = 6.35;
window_height = 30.162;

case_side_margin = u;
case_bottom_margin = 1.5*u;
case_top_margin = u;
case_height = 14;

inner_bz_top = 10;
inner_bz_bottom = 10;
inner_bz_side = 10;
outer_bz_top = 10;
outer_bz_bottom = 15;
outer_bz_side = 5;
bz_top = inner_bz_top  + outer_bz_top;
bz_bottom = inner_bz_bottom  + outer_bz_bottom;
bz_side = inner_bz_side  + outer_bz_side;
bz_drop = 6;

top_corner_radius = 4;
bottom_corner_radius = 8;

top_fillet = 1;
mid_fillet = 1;
bottom_fillet = 0.5;

key_area_inner_radius = 2.5;

module ooo(r=1){
  offset(r)offset(-r*2)offset(r)children();
 }

module torus(radii = [2, 1]) {
    rotate_extrude()translate([radii[0]-radii[1],0,0])circle(radii[1]);
}

module two_radius_cube(size = [100,100], radius = [20, 5]) {
    hull(){
        translate([radius[0],radius[0],0])torus(radius);
        translate([size[0]-radius[0],radius[0],0])torus(radius);
        translate([radius[0],size[1]-radius[0],0])torus(radius);
        translate([size[0]-radius[0],size[1]-radius[0],0])torus(radius);
    }
}

module keyarea() {
    // Define key areas
    // Main keys
    ooo(key_area_inner_radius)  {
        translate([0, 2*u, 0])
            square([15*u, 3*u]);
        translate([0, 1*u, 0])
            square([14*u, 1*u+ol]);
        translate([0, 0, 0])
            square([13*u, 1*u+ol]);
    }
    // Right cluster
    ooo(key_area_inner_radius)  {
        translate([15.5*u, 1*u, 0]) 
            square([1*u, 4*u]);
    }
    // Arrow cluster
    ooo(key_area_inner_radius)  {
        translate([14.25*u, 0.75*u-ol, 0])
            square([1*u, 1*u+ol]);
        translate([13.25*u, -0.25*u, 0])
            square([3*u, 1*u]);
    }
}

module screws() {
        translate([-0.938,-5.700])
            circle
}

module window() {
    // Define window size and placement
    translate([0,5*u+key_to_window_margin,0])
        ooo(key_area_inner_radius)
            square([16.5*u,window_height]);
}

module case_bottom_footprint() {
    translate([-bz_side,-bz_bottom,bottom_fillet])
        two_radius_cube([16.5*u+2*bz_side,
                5*u+key_to_window_margin+window_height+bz_bottom+bz_top],
                [bottom_corner_radius,bottom_fillet]);
}

module case_middle_footprint() {
    translate([-bz_side,-bz_bottom,case_height-bz_drop-mid_fillet])
        two_radius_cube([16.5*u+2*bz_side,
                5*u+key_to_window_margin+window_height+bz_bottom+bz_top],
                [bottom_corner_radius,mid_fillet]);
}

module case_top_footprint() {
    translate([-inner_bz_side,-inner_bz_bottom,case_height-top_fillet])
        two_radius_cube([16.5*u+2*inner_bz_side,
                5*u+key_to_window_margin+window_height+inner_bz_bottom+inner_bz_top],
                [top_corner_radius,top_fillet]);
}


 
// linear_extrude(case_height)
//    difference() {
//        case_base();
//        keyarea();
//       window();
//    }
// $fn=40;
// module ooo(r=1){
//  offset(r)offset(-r*2)offset(r)children();
// }

//hull(){
//linear_extrude(1)ooo()square([10,20],center=true);
//translate([0,0,2])linear_extrude(1)ooo()square([8,17],center=true);
//}
 

module case_hull() {
    hull() {
        case_top_footprint();
        case_middle_footprint();    
        case_bottom_footprint();    
    }
}


color([0.843, 0.792, 0.718])
difference() {
    case_hull();
    translate([0,0,-ol])
        linear_extrude(case_height+2*ol)
                keyarea();
    translate([0,0,-ol])
        linear_extrude(case_height+2*ol)
                window();
}

//two_radius_cube([300,150],[20,5]);
