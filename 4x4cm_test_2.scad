$fn=64;
//globals
co_radius = 30;
co_height = 30;

module complexObject()
{
			difference()
				{
			union()//add
				{	
					translate([0,0,15])
					cylinder(r=co_radius, h =5, center=true);
					translate([0,0,-15])
					cylinder(r=co_radius, h =5, center=true);
					rotate([90,0,0])
					cube([8,55,60], center=true);
					rotate([0,0,90])
					cube([8,60,55], center=true);
					sphere(r=co_radius, center=true);
				}
				
				union()//subtract
				{
					sphere(r=co_radius*.9, center=true);
					cylinder(r=15, h=60, center=true);
						
					}
				}
			}

complexObject();