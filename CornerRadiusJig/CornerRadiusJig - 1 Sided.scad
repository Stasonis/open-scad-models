$fa = 1;
$fs = 0.4;

radiusInches =1.75;
radiusLabel = "1 3/4\"";

//Used for a bunch of things, but really defines the thickness of the overall jig
plateThickness = 6;

//Length of the wings for registering on the side of the surface
wingLength = 12;

//This is the amount of setback from the edge of the radius
wingBuffer = 10;

//Font for the label radius
font = "Liberation Sans:style=Bold";
fontSize = 10;


//radiusLabel will be inset this far into the plate
labelDepth = 1;



millimetersPerInch = 25.4;
radius = radiusInches * millimetersPerInch;

module plate() {
    union() {
        translate([radius + wingLength, radius + wingLength, 0])
            cylinder(r = radius, h = plateThickness);
            
        translate([0,0, 0])
            cube([radius * 2 + wingLength, radius + wingLength, plateThickness]);
           
        translate([0, 0, 0])
            cube([radius + wingLength, radius * 2 + wingLength, plateThickness]);
        
        //Wings
        translate([wingLength + (radius * 2) - .01, 0, 0])
            difference() {
                cube([plateThickness, wingLength + radius - wingBuffer, plateThickness * 2]);
                translate([plateThickness, radius + wingLength - wingBuffer, -plateThickness / 2])
                    cylinder(r = plateThickness, h = plateThickness * 3);
            }
    
        translate([0, wingLength + (radius * 2) - .01, 0])
            difference() {
                cube([wingLength + radius - wingBuffer, plateThickness, plateThickness * 2]);
                translate([wingLength + radius - wingBuffer, plateThickness, -plateThickness / 2])
                    cylinder(r = plateThickness, h = plateThickness * 3);
            }
    }

}

module fingerHold() {
    translate([radius + wingLength, radius + wingLength, 0])
    difference() {
            cylinder(r = radius, h = plateThickness);
        
            translate([0, 0, -plateThickness])
                cylinder(r = radius - plateThickness, h = plateThickness * 3);
    }
}

//Place the label at the halfway point between the inner curve and the outer curve
labelOffset = ((radius * 2) - (radius * 1.5)) / 2 + (radius * 1.5);

echo("RADIUS: ", radius);
echo("LABEL OFFSET: " , labelOffset);

union() {
    difference() {
         plate();

        #translate([0, 0, -plateThickness])
            cylinder(r=wingLength + (radius * 1.5), h=plateThickness * 3);
        
        //translate([radius * 2 - wingLength, radius * 2 - wingLength, plateThickness - labelDepth])
        #translate([labelOffset, labelOffset, plateThickness - labelDepth])
            #rotate([0, 0, -45])
                linear_extrude(height = plateThickness * 3) {
                    text(text = radiusLabel, font = "Liberation Sans", size = fontSize, valign = "center", halign = "center");
                }
    }
    
    fingerHold();
}


