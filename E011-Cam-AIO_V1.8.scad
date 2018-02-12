q = 20;

wi = 38.0 + 0.5;   // drone widith
hi = 5.40;         
di = 1.4 +0.3;
li = 18;

th = 1.8;          // structure thickness
la = 5.0;          // structure length
le =-7;            //degrees of lean back


translate([wi/2, 5, th*3+1]) rotate([0,-15,90]) cam();
support();

//rotate([90,0,0]) support();
//cam();

module support() {
    difference() {
        union() {
            //lensSupport();
            translate([wi/2,la/2, 2.8+37]) rotate([90,0,0]) difference() {               // Roll cage
                cylinder(d=wi-10,      h=la, $fn=5*q);
                translate([0,0,-1]) cylinder(d=wi-10-th*2, h=la+2, $fn=5*q);
                translate([-50,-50,-50]) cube([100,50,100]);
            }
            translate([    5,   -la/2,  2.8+0.1]) cube([th,la,39.2-th]);                 // Side arm
            translate([wi-5-th, -la/2,  2.8+0.1]) cube([th,la,39.2-th]);                 // Side arm
            translate([    0,   -la/2,  2.8+14+th ]) rotate([15+le, 0 ,0]) {
                translate([5,0,0.3]) cube([wi-10,la,th*0.7]);                            // middle arm
            }
            translate([wi/5., la/3-0.9, th*3+13.6]) rotate([-47,0,-40]) cube([th,li*1.35+1,la/2]);                 // Side support
            translate([wi-wi/5.-th, la/3-th/1.5-0.9, th*3+13.6]) rotate([-47,0,40]) cube([th,li*1.35+1,la/2]);     // Side support
            #translate([13.,5.5,013]) rotate([90,0,0]) cylinder(d=2,h=3,$fn=2*q);
            translate([0,-0.5,0]) rotate([le,0,0]) {
                translate([wi/2-0.75, -la/2, 2.8-2]) cube([1.5,li+la/2,2]);              // front reinforcment
                hull() {
                    translate([wi/2-th/2, li-6,0.8]) cube([1.5, 1, 2]);                  // front reinforcment
                    translate([wi/2, li, -1]) cylinder(d2=la+2, d1=la+1, h=5.5, $fn=3*q);// Front fix
                }
                translate([ 0,-la/2,   0]) fix();
                translate([wi, la/2,   0]) rotate([0,0,180]) fix();
                hull() {
                    translate([ 0,0,2.8]) cylinder(d=la, h=th, $fn=3*q);
                    translate([wi,0,2.8]) cylinder(d=la, h=th, $fn=3*q);
                }
                hull() {
                    translate([wi/2,   li, 2.8]) cylinder(d=la,   h=th, $fn=3*q);
                    translate([wi/2, la/2, 2.8]) cylinder(d=la*2, h=th, $fn=3*q);
                }
            }
        }
        translate([ -50  ,-50-la/2+0.02,-50]) cube([100,50,100]);                                        // Back surfacing
        //translate([wi/2.3,-la/2*0.6,     11]) rotate([15, 0 ,0])  cylinder(d=la*1.2, h=10, $fn=2*q);   // middle arm cutout
        //translate([wi/2,0,21.4]) rotate([15, 0 ,0])  cube([24.5,20,1], center=true);                   // middle arm cutout
        translate([0,-0.5,0]) rotate([le,0,0]) {
        translate([wi/2-8,   -la/2+1  , 14.5+2.0+th-0.01]) rotate([45,0,0]) cube([16,1.5,1.5]);          // top strip
        translate([wi/2-8,   -la/2+1.5,      2.0+th-0.01]) rotate([45,0,0]) cube([16,1.5,1.5]);          // botom strip
        translate([wi/2  ,    li      ,    -10          ]) cylinder(d=2.0, h=th*100, $fn=2*q);           // Front hole small
        translate([wi/2  ,    li      ,      0          ]) cylinder(d=4.5, h=10,     $fn=2*q);           // Front hole
        }
    }
}






module fix() {
    translate([0,la/2,0]) cylinder(d=la, h=2.8, $fn=3*q);
    difference() {
        hull() {
            difference() {
                translate([0,la/2,0]) cylinder(d=la, h=th+0.01, $fn=3*q);
                translate([0,0,0]) cube([la+1,la+1, th+1]);
                }
            translate([-2,la/2,-hi]) rotate([0,90,0]) cylinder(d=la,h=2, $fn=3*q);
        }
        translate([-th*4,la/2,-hi]) rotate([0,90,0]) cylinder(d=di,h=th*10, $fn=2*q);
    }
}

module lensSupport() {
    translate([wi/2-la/2,li-12.5,th*2]) difference() {
        cube([la, 5, 10]); 
        translate([la/2,5,9.35]) rotate([105,0,0]) cylinder(d=8, h=10, $fn=3*q);
        translate([-2,-8,6.7]) rotate([-40,0,0]) cube([10,10,20]);
    }
}

module cam() {
    color("green")    {
        translate([0,-9.5, 0]) cube([0.8,19,13]);
        translate([-5,-9.5, 0]) cube([0.8,19,13]);
        translate([-5,-2.5,13]) cube([0.8, 5, 4]);
    }
    color("grey") {
        translate([0,0, 6]) rotate([0,90,0]) cylinder(d=8, h=6);
        translate([6,0, 6]) rotate([0,90,0]) cylinder(d=10, h=3);
        translate([-6,5.5,0.5]) cube([8, 3.6, 2]);
        translate([-5,0, 13+4]) cylinder(d=2.2, h=6);
    }
    color("silver") {
        translate([-5,0, 13+4+6]) cylinder(d1=30, d2=18, h=10);
    }
}