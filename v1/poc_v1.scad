MAGNET_DIAMETER = 10;
MAGNET_HOLDER_WIDTH = 4;
SPACE_FOR_CONTACT = (MAGNET_DIAMETER - MAGNET_HOLDER_WIDTH) / 2;
MAGNET_HEIGHT = 2;
KEY_DIAMETER = 15;

TRAVEL_DISTANCE = 2;
BOTTOM_HEIGHT = 1 + MAGNET_HEIGHT + 1;
SWITCH_HEIGHT = BOTTOM_HEIGHT + TRAVEL_DISTANCE + 1 + 2;
STOPPER_WIDTH = 2;
INNER_WIDTH = KEY_DIAMETER + STOPPER_WIDTH;
HOUSING_WIDTH = 2;
KEY_WIDTH = INNER_WIDTH + HOUSING_WIDTH * 2;

MP = (KEY_WIDTH - MAGNET_DIAMETER) / 2;
TL_RADIUS = sqrt((INNER_WIDTH / 2 + 1)^2 + (INNER_WIDTH / 2)^2);

E = 0.1;
$fn=50;

*difference() {
    cube([KEY_WIDTH, KEY_WIDTH, SWITCH_HEIGHT]);

    // bottom magnet space
    translate([0, MP, 1]) cube([KEY_WIDTH, MAGNET_DIAMETER, MAGNET_HEIGHT - 1]);
    translate([MP + MAGNET_DIAMETER / 2, MP + MAGNET_DIAMETER / 2, 1]) cylinder(r=MAGNET_DIAMETER / 2, h=MAGNET_HEIGHT);

    // bottom magnet cutouts
    translate([-E, MP, -E]) cube([MP + SPACE_FOR_CONTACT + E, MAGNET_DIAMETER, MAGNET_HEIGHT + E]);
    translate([MP + MAGNET_DIAMETER - SPACE_FOR_CONTACT, MP, -E]) cube([MP + E + SPACE_FOR_CONTACT, MAGNET_DIAMETER, MAGNET_HEIGHT + E]);

    // bottom space for top magnet holder when pressed
    translate([MP + SPACE_FOR_CONTACT, HOUSING_WIDTH, BOTTOM_HEIGHT - 1 - E]) cube([MAGNET_HOLDER_WIDTH, INNER_WIDTH, 1 + 2 * E]);

    // top cutout
    translate([HOUSING_WIDTH, HOUSING_WIDTH, BOTTOM_HEIGHT]) cube([INNER_WIDTH, INNER_WIDTH, SWITCH_HEIGHT - BOTTOM_HEIGHT + E]);

    // top cutouts for top lid
    translate([HOUSING_WIDTH, -E, SWITCH_HEIGHT - 2]) cube([INNER_WIDTH, KEY_WIDTH + 2 * E, 2 + E]);
    translate([-E, HOUSING_WIDTH, SWITCH_HEIGHT - 2]) cube([KEY_WIDTH + 2 * E, INNER_WIDTH, 2 + E]);

    translate([HOUSING_WIDTH, HOUSING_WIDTH, SWITCH_HEIGHT - 2])
    intersection()
    {
      translate([-1, -1, 0]) cube([INNER_WIDTH + 2,INNER_WIDTH + 2, 1]);
      translate([INNER_WIDTH / 2, INNER_WIDTH / 2, 0]) cylinder(r=TL_RADIUS + E, h=1);
    };

    // holes for wires
    translate([-E, KEY_WIDTH / 2 - 0.5, BOTTOM_HEIGHT + 0.5]) rotate([0, 90, 0]) cylinder(r=0.5,h=HOUSING_WIDTH + 2 * E);
    translate([KEY_WIDTH - HOUSING_WIDTH - E, KEY_WIDTH / 2 - 0.5, BOTTOM_HEIGHT + 0.5]) rotate([0, 90, 0]) cylinder(r=0.5,h=HOUSING_WIDTH + 2 * E);
}

*translate([HOUSING_WIDTH, HOUSING_WIDTH, SWITCH_HEIGHT - 2])
difference() {
    intersection()
    {
      translate([-1, -1, 0]) cube([INNER_WIDTH + 2,INNER_WIDTH + 2, 1]);
      translate([INNER_WIDTH / 2, INNER_WIDTH / 2, 0]) cylinder(r=TL_RADIUS + E, h=1);
    };

    translate([STOPPER_WIDTH - 1 + KEY_DIAMETER / 2, STOPPER_WIDTH - 1 + KEY_DIAMETER / 2, -E]) cylinder(r=KEY_DIAMETER / 2, h=1 + 2 * E);
}

//translate([0, 0, SWITCH_HEIGHT - 4])
difference() {
  union() {
      translate([MP + SPACE_FOR_CONTACT + E, HOUSING_WIDTH + E, 0]) cube([MAGNET_HOLDER_WIDTH - 2 * E, INNER_WIDTH - 2 * E, 1 + E]);

      translate([HOUSING_WIDTH + 1 + E, HOUSING_WIDTH + 1 + E, 1])
      minkowski()
      {
        cube([INNER_WIDTH - 2 - 2 * E,INNER_WIDTH - 2 - 2 * E, 0.5]);
        cylinder(r=1,h=0.5);
      };

      translate([
        HOUSING_WIDTH + STOPPER_WIDTH - 1 + KEY_DIAMETER / 2 + E,
        HOUSING_WIDTH + STOPPER_WIDTH - 1 + KEY_DIAMETER / 2 + E,
        2])
      cylinder(r=KEY_DIAMETER / 2 - E, h=3 + 2 * E);
  }

  translate([MP + MAGNET_DIAMETER / 2, MP + MAGNET_DIAMETER / 2, 1 - E]) cylinder(r=MAGNET_DIAMETER / 2, h=MAGNET_HEIGHT + E);

  translate([HOUSING_WIDTH, MP, 1 - E]) cube([INNER_WIDTH, MAGNET_DIAMETER, 1 + 2 * E]);
}
