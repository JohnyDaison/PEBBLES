if (self.done_for) {
    exit;
}

if (!instance_exists(self.my_guy)) {
    self.done_for = true;
    exit;
}

self.my_color = self.my_guy.my_color;
self.tint_updated = false;

self.image_angle = self.direction;
var rads = degtorad(self.image_angle);

self.base_xcoord = -cos(rads);
self.base_ycoord = sin(rads);

self.right_xcoord = -cos(rads - pi / 2);
self.right_ycoord = sin(rads - pi / 2);

// vertical burst
if (self.base_ycoord != 0 && self.right_xcoord != 0) {
    self.x1 = self.x + self.right_xcoord * 14;
    self.x2 = self.x - self.right_xcoord * 15;

    self.y1 = self.y + self.base_ycoord * 17;
    self.y2 = self.y + self.base_ycoord * 17;

    self.x3 = self.x + self.right_xcoord * 14;
    self.x4 = self.x - self.right_xcoord * 15;

    self.y3 = self.y - self.base_ycoord * 15;
    self.y4 = self.y - self.base_ycoord * 15;
}

// horizontal burst
if (self.base_xcoord != 0 && self.right_ycoord != 0) {

    self.x1 = self.x + self.base_xcoord * 17;
    self.x2 = self.x + self.base_xcoord * 17;

    self.y1 = self.y + self.right_ycoord * 14;
    self.y2 = self.y - self.right_ycoord * 15;

    self.x3 = self.x - self.base_xcoord * 15;
    self.x4 = self.x - self.base_xcoord * 15;

    self.y3 = self.y + self.right_ycoord * 14;
    self.y4 = self.y - self.right_ycoord * 15;
}
