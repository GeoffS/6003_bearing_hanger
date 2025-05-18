include <../OpenSCADdesigns/MakeInclude.scad>
include <../OpenSCAD_Lib/chamferedCylinders.scad>

bearingOD = 35.1;
bearingZ = 10;

screwDia = 3;

endZBottom = 2;
endZTop = 5.5;

hangerZ = bearingZ + endZBottom + endZTop;
hangerCZ = 2;

ropeCtrX = 60;
ropeHoleDia = 10;

screwCtrZ = endZBottom + bearingZ + screwDia/2;

bearingRetainerID = 31;

module itemModule()
{
	difference()
	{
		hull()
		{
			simpleChamferedCylinderDoubleEnded(d=bearingOD+12, h=hangerZ, cz=hangerCZ);
			translate([ropeCtrX,0,0]) simpleChamferedCylinderDoubleEnded(d=ropeHoleDia+16, h=hangerZ, cz=hangerCZ);
		}

		// Bearing recess:
		tcy([0,0,endZBottom], d=bearingOD, h=100);
		translate([0,0,hangerZ-bearingOD/2-1]) cylinder(d2=60, d1=0, h=30);
		translate([0,0,-30+bearingRetainerID/2+0.6]) cylinder(d1=60, d2=0, h=30);

		// Bearing retaining lip:
		tcy([0,0,-1], d=bearingRetainerID, h=100);

		// Rope hole:
		translate([ropeCtrX,0,0])
		{
			cylinder(d=ropeHoleDia, h=100);
			translate([0,0,hangerZ/2]) doubleZ() translate([0,0,hangerZ/2-ropeHoleDia/2-4]) cylinder(d2=40, d1=0, h=20);
		}

		// Retaining screw holes:
		for (a=[0, 180]) 
		{
			rotate([0,0,a]) translate([0,0,screwCtrZ]) rotate([90,0,0]) cylinder(d=screwDia, h=100);
		}
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
	displayGhost() translate([0,0,endZBottom]) bearing();
}
else
{
	itemModule();
}

module bearing()
{
	difference()
	{
		cylinder(d=35, h=bearingZ);
		tcy([0,0,-1], d=17, h=100);
	}
}