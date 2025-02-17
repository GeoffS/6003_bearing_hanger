include <../OpenSCADdesigns/MakeInclude.scad>
include <../OpenSCAD_Lib/chamferedCylinders.scad>

shaftDia = 16.1;

screwDia = 2.8;

stopperZ = 12;

module itemModule()
{
	difference()
	{
		simpleChamferedCylinderDoubleEnded(d = shaftDia + 8, h = stopperZ, cz = 2);
        tcy([0,0,-1], d=shaftDia, h=100);
        translate([0,0,stopperZ/2]) rotate([90,0,0]) cylinder(d=screwDia, h=100);
	}
}

module clip(d=0)
{
	// tc([-200, -400-d, -10], 400);
	// tc([-200, -200, screwCtrZ], 400);
}

if(developmentRender)
{
	display() itemModule();
}
else
{
	itemModule();
}