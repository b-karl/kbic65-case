u = 19.05;
ol = 0.001;

key_to_window_margin = 6.35;
window_height = 30.162;

case_side_margin = u;
case_bottom_margin = 1.5*u;
case_top_margin = u;
case_height = 25;

inner_bz_top = 5;
inner_bz_bottom = 10;
inner_bz_side = 5;
outer_bz_top = 5;
outer_bz_bottom = 10;
outer_bz_side = 5;
bz_top = inner_bz_top  + outer_bz_top;
bz_bottom = inner_bz_bottom  + outer_bz_bottom;
bz_side = inner_bz_side  + outer_bz_side;

module keyarea() {
    // Define key areas
    // Main keys
    translate([0, 2*u, 0])
        square([15*u, 3*u]);
    translate([0, 1*u, 0])
        square([14*u, 1*u+ol]);
    translate([0, 0, 0])
        square([13*u, 1*u+ol]);

    // Right cluster
    translate([15.5*u, 1*u, 0]) 
        square([1*u, 4*u]);
        
    // Arrow cluster
    translate([14.25*u, 0.75*u-ol, 0])
        square([1*u, 1*u+ol]);
    translate([13.25*u, -0.25*u, 0])
        square([3*u, 1*u]);
}

module window() {
    // Define window size and placement
    translate([0,5*u+key_to_window_margin,0])
        square([16.5*u,window_height]);
}

module case_bottom_footprint() {
    translate([-bz_side,-bz_bottom,0])
        square([16.5*u+2*bz_side,
                5*u+key_to_window_margin+window_height+bz_bottom+bz_top]);
}

module case_top_footprint() {
    translate([-inner_bz_side,-inner_bz_bottom,0])
        square([16.5*u+2*inner_bz_side,
                5*u+key_to_window_margin+window_height+inner_bz_bottom+inner_bz_top]);
}

module ooo(r=1){
  offset(r)offset(-r*2)offset(r)children();
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
    translate([0,0,case_height*0.5])
        linear_extrude(1)
            ooo(10)case_top_footprint();
    linear_extrude(case_height*0.25)
        ooo(10)case_bottom_footprint();
    }
}

$fn=100;
difference() {
    case_hull();
    translate([0,0,-ol])linear_extrude(case_height*0.5+2*ol+1)keyarea();
    translate([0,0,-ol])linear_extrude(case_height*0.5+2*ol+1)window();
}