$fn=64;

//globals

module complexObject()
				
			{
			translate([5.5,4.75,4.5])
			rotate([0,-35,45])
			cube([10,1,1]);

			translate([5,4.2,-5])
			rotate([0,35,45])
			cube([11,1,1]);

			translate([-4.5,5.2,-5.2])
			rotate([0,35,135])
			cube([11,1,1]);
			
			translate([-4.5,5.2,4.5])
			rotate([0,-35,135])
			cube([10,1,1]);
			}
{
			mirror([0,1,0]){

			translate([5.5,4.75,4.5])
			rotate([0,-35,45])
			cube([10,1,1]);
			
			translate([5,4.2,-5])
			rotate([0,35,45])
			cube([11,1,1]);

			translate([-4.5,5.2,-5.2])
			rotate([0,35,135])
			cube([11,1,1]);
			
			translate([-4.5,5.2,4.5])
			rotate([0,-35,135])
			cube([10,1,1]);
			}
			}
			
{
			difference() {
			union()//add
				{	
					cube(25, center=true);
				}
				
				union()//subtract
				{
					cube([40,20,20], center=true);
					cube([20,40,20], center=true);
					cube([20,20,40], center=true);
					}
				}
			}

			scale(.7) {
			difference() {
			union()//add
				{	
					cube(25, center=true);
				}
				
				union()//subtract
				{
					cube([40,20,20], center=true);
					cube([20,40,20], center=true);
					cube([20,20,40], center=true);
					}
				}
			}

			scale(.45) {
			difference() {
			union()//add
				{	
					cube(25, center=true);
				}
				
				union()//subtract
				{
					cube([40,20,20], center=true);
					cube([20,40,20], center=true);
					cube([20,20,40], center=true);
					}
				}
			}

complexObject();