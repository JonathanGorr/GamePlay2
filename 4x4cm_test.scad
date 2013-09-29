$fn=64;
//globals
co_radius = 30;
co_height = 45;

module complexObject()
{
			intersection()
				{
			union()//subtract
				{
					cylinder(r=co_radius, h =22, center=true);
					rotate([90,0,0])
					cylinder(r=33, h =15, center=true);
					sphere(r=co_radius, center=true);
				}
				
				union()//add
				{
					cube([co_height,co_height,co_height], center=true);
					cylinder(r=co_radius, h=5, center=true);
						
					}
				}
			}

complexObject();