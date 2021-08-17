$fa = 1;
$fs = 0.4;

radius1Inches =.5;
radius1Label = "1/2\"";

radius2Inches = 1.75;
radius2Label = "1 3/4\"";

plateThickness = 8;
fingerHoleRadius = 20;

millimetersPerInch = 25.4;

radius1 = radius1Inches * millimetersPerInch;
radius2 = radius2Inches * millimetersPerInch;

font = "Liberation Sans:style=Bold";
fontSize = 10;
labelDepth = 3;


module plate() {
    union() {
        translate([-radius1, radius1, 0])
            cylinder(r = radius1, h = plateThickness);
            
        translate([radius2, -radius2, 0])
            cylinder(r = radius2, h = plateThickness);
            
        translate([-radius1 * 2, -radius2 * 2, 0])
            cube([(radius1 * 2) + radius2, radius1 + (radius2 * 2), plateThickness]);
            
        translate([-radius1, -radius2, 0])
            cube([radius1 + (radius2 * 2), (radius1 * 2) + radius2, plateThickness]);
        
        translate([-radius1 * 2 - plateThickness, -radius2 * 2 - plateThickness, 0])
            difference() {
                cube([plateThickness, radius2 * 2, plateThickness * 2]);
                translate([0, radius2 * 2, -plateThickness / 2])
                    cylinder(r = plateThickness, h = plateThickness * 3);
            }

        translate([-radius1 * 2 - plateThickness, -radius2 * 2 - plateThickness, 0])
            difference() {
                cube([radius1 * 2, plateThickness, plateThickness * 2]);
                translate([radius1 * 2, 0, -plateThickness / 2])
                    cylinder(r = plateThickness, h = plateThickness * 3);
            }

        translate([radius2 * 2, plateThickness, 0])
            difference() {
                cube([plateThickness, radius1 * 2, plateThickness * 2]);
                translate([plateThickness, 0, -plateThickness / 2])
                    cylinder(r = plateThickness, h = plateThickness * 3);
                
            }
    
        translate([plateThickness, radius1 * 2, 0])
            difference() {
                cube([radius2 * 2, plateThickness, plateThickness * 2]);
                translate([0, plateThickness, -plateThickness / 2])
                    cylinder(r = plateThickness, h = plateThickness * 3);
            }
    }
    
       
    

}

module fingerHole() {
    plateDimension = (radius1 * 2) + (radius2 * 2);

    fingerHoleShift = plateDimension / 2 - (radius1 * 2);

    translate([fingerHoleShift, -fingerHoleShift, -plateThickness / 2])
        cylinder(r = fingerHoleRadius, h = plateThickness * 2);
}

difference() {
    plate();
    fingerHole();
    
    translate([-radius1 - fontSize, radius1 + fontSize, plateThickness - labelDepth])
        rotate([0, 0, 45])
            linear_extrude(height = plateThickness * 3) {
                text(text = radius1Label, font = "Liberation Sans", size = fontSize, valign = "center", halign = "center");
            }
            
     translate([radius2 + fontSize, -radius2 - fontSize, plateThickness - labelDepth])
        rotate([0, 0, -135])
            linear_extrude(height = plateThickness * 3) {
                text(text = radius2Label, font = "Liberation Sans", size = fontSize, valign = "center", halign = "center");
            }
}
