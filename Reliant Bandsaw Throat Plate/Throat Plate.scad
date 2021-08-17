$fa = 1;
$fs = 0.4;

plate_diameter = 63;
plate_thickness = 2.8;

cutout_diameter = 1.8;

kerf_length = 35;
kerf_width = 2;

grid_spacing = 7;
grid_margin = 5;
grid_width = 2;
grid_height = 4;
grid_taper_height = 6;

module plate() {
    difference() {
        cylinder(r = plate_diameter / 2, h = plate_thickness);
        
        translate([0, -(kerf_length - (plate_diameter / 2)), -plate_thickness / 2])
            cube([kerf_width, kerf_length, plate_thickness * 2]);
        
        translate([plate_diameter /2, 0, -plate_thickness / 2])
            cylinder(r = cutout_diameter, h = plate_thickness * 2);
    }
    

}

module grid() {
    difference() {
    translate([-plate_diameter / 2, -plate_diameter / 2, plate_thickness])
        intersection() {
            union() {
                for(i = [0 : plate_diameter / grid_spacing]) {
                    translate([grid_spacing * i, 0, 0])
                        cube([grid_width, plate_diameter, grid_height]);
                }
                
                for(i = [0 : plate_diameter / grid_spacing]) {
                    translate([0, grid_spacing * i, 0])
                        cube([plate_diameter, grid_width, grid_height]);
                }
            }
            
            translate([plate_diameter / 2, plate_diameter / 2, 0])
                cylinder(h = grid_taper_height, r1 = plate_diameter  / 2 - grid_margin, r2 = 0);
        }
    
        cube([kerf_width, kerf_length, grid_height * 2]);
    }
}

grid();

plate();