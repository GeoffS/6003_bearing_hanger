include <../OpenSCADdesigns/MakeInclude.scad>
include <../OpenSCAD_Lib/chamferedCylinders.scad>

shaftDia = 16.1;

screwDia = 3.1;
nutXY = 5.6;
nutZ = 3;

stopperZ = 25;

module itemModule()
{
	difference()
	{
		simpleChamferedCylinderDoubleEnded(d = shaftDia + 14, h = stopperZ, cz = 4);
        tcy([0,0,-1], d=shaftDia, h=100);
        translate([0,0,stopperZ/2]) rotate([90,0,0]) cylinder(d=screwDia, h=100);
        mirror([0,1,0]) tcu([-nutXY/2, 0, stopperZ/2-nutXY/2], [nutXY, shaftDia/2+nutZ, nutXY]);
        translate([0,0,stopperZ/2]) doubleZ() translate([0,0,stopperZ/2-shaftDia/2-1]) cylinder(d2=40, d1=0, h=20);
	}
}

module clip(d=0)
{
	// tc([-200, -400-d, -10], 400);
    tc([-400-d, -200, -10], 400);
	// tc([-200, -200, screwCtrZ], 400);
}

if(developmentRender)
{
	display() itemModule();
    // displayGhost() bearing();
}
else
{
	itemModule();
}

module bearing()
{
    bearingZ = 10;
	translate([0,0,-bearingZ]) difference()
	{
		cylinder(d=35, h=bearingZ);
		tcy([0,0,-1], d=17, h=100);
	}
}