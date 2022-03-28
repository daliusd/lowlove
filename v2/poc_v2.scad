MAGNET_DIAMETER = 10;
MAGNET_HOLDER_WIDTH = 4;
SPACE_FOR_CONTACT = (MAGNET_DIAMETER - MAGNET_HOLDER_WIDTH) / 2;
MAGNET_HEIGHT = 2;
KEY_DIAMETER = 17;

TRAVEL_DISTANCE = 2;
BOTTOM_HEIGHT = 1 + MAGNET_HEIGHT + 1;
SWITCH_HEIGHT = BOTTOM_HEIGHT + TRAVEL_DISTANCE + 1 + 2;
STOPPER_WIDTH = 3;
INNER_WIDTH = KEY_DIAMETER + STOPPER_WIDTH;
HOUSING_WIDTH = 2;
KEY_WIDTH = INNER_WIDTH + HOUSING_WIDTH * 2;

MP = (KEY_WIDTH - MAGNET_DIAMETER) / 2;
TL_RADIUS = sqrt((INNER_WIDTH / 2 + 1)^2 + (INNER_WIDTH / 2)^2);

TOLERANCE = 0.5;
E = 0.1;
$fn=100;

// Box
difference() {
    cube([KEY_WIDTH, KEY_WIDTH, SWITCH_HEIGHT]);

    // bottom magnet space
    translate([0, MP - TOLERANCE, 1]) cube([KEY_WIDTH, MAGNET_DIAMETER + TOLERANCE * 2, MAGNET_HEIGHT - 1]);
    translate([MP + MAGNET_DIAMETER / 2, MP + MAGNET_DIAMETER / 2, 1])
      cylinder(r=MAGNET_DIAMETER / 2 + TOLERANCE, h=MAGNET_HEIGHT);

    // bottom magnet cutouts
    translate([-E, MP - TOLERANCE, -E])
      cube([MP + SPACE_FOR_CONTACT + E, MAGNET_DIAMETER + TOLERANCE * 2, MAGNET_HEIGHT + E]);
    translate([MP + MAGNET_DIAMETER - SPACE_FOR_CONTACT, MP - TOLERANCE, -E])
      cube([MP + E + SPACE_FOR_CONTACT, MAGNET_DIAMETER + TOLERANCE * 2, MAGNET_HEIGHT + E]);

    // bottom space for top magnet holder when pressed
    translate([MP + SPACE_FOR_CONTACT, HOUSING_WIDTH, BOTTOM_HEIGHT - 1 - E]) cube([MAGNET_HOLDER_WIDTH, INNER_WIDTH, 1 + 2 * E]);

    // top cutout
    translate([HOUSING_WIDTH, HOUSING_WIDTH, BOTTOM_HEIGHT]) cube([INNER_WIDTH, INNER_WIDTH, SWITCH_HEIGHT - BOTTOM_HEIGHT + E]);

    // top cutouts for top lid
    translate([-E, HOUSING_WIDTH, SWITCH_HEIGHT - 2]) cube([KEY_WIDTH + 2 * E, INNER_WIDTH, 1]);

    // holes for wires
    translate([-E, KEY_WIDTH / 2 - 0.5, BOTTOM_HEIGHT + 0.5]) rotate([0, 90, 0]) cylinder(r=0.5,h=HOUSING_WIDTH + 2 * E);
    translate([KEY_WIDTH - HOUSING_WIDTH - E, KEY_WIDTH / 2 - 0.5, BOTTOM_HEIGHT + 0.5]) rotate([0, 90, 0]) cylinder(r=0.5,h=HOUSING_WIDTH + 2 * E);
}

// Top
translate([0, 0, SWITCH_HEIGHT - 1.75])
difference() {
    translate([-TOLERANCE, HOUSING_WIDTH + TOLERANCE, 0]) cube([KEY_WIDTH + TOLERANCE * 2, INNER_WIDTH - TOLERANCE * 2, 0.5]);

    translate([
      HOUSING_WIDTH + STOPPER_WIDTH / 2 + KEY_DIAMETER / 2,
      HOUSING_WIDTH + STOPPER_WIDTH / 2 + KEY_DIAMETER / 2,
      -E])
      cylinder(r=KEY_DIAMETER / 2, h=1 + 2 * E);
}

// Button
translate([0, 0, SWITCH_HEIGHT - 4])
difference() {
  union() {
      translate([MP + SPACE_FOR_CONTACT + TOLERANCE, HOUSING_WIDTH + TOLERANCE, 0])
        cube([MAGNET_HOLDER_WIDTH - 2 * TOLERANCE, INNER_WIDTH - 2 * TOLERANCE, 1 + E]);

      translate([HOUSING_WIDTH + TOLERANCE, HOUSING_WIDTH + TOLERANCE, 1])
        cube([INNER_WIDTH - TOLERANCE * 2, INNER_WIDTH - TOLERANCE * 2, 1]);

      translate([
        HOUSING_WIDTH + STOPPER_WIDTH / 2 + KEY_DIAMETER / 2,
        HOUSING_WIDTH + STOPPER_WIDTH / 2 + KEY_DIAMETER / 2,
        2])
        cylinder(r=KEY_DIAMETER / 2 - TOLERANCE * 2, h=3);
  }

  translate([MP + MAGNET_DIAMETER / 2, MP + MAGNET_DIAMETER / 2, 1 - E])
    cylinder(r=MAGNET_DIAMETER / 2 + TOLERANCE, h=MAGNET_HEIGHT + E);

  translate([HOUSING_WIDTH, MP - TOLERANCE, 1 - E]) cube([INNER_WIDTH, MAGNET_DIAMETER + TOLERANCE * 2, 1 + 2 * E]);
}
