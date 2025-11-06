if (!self.bounced && !self.collided) {
    var orig_x = self.x;
    var orig_y = self.y;

    self.x_return = self.xprevious - orig_x;
    self.y_return = self.yprevious - orig_y;

    var h_diff = self.xprevious - (other.x + 16);
    var v_diff = self.yprevious - (other.y + 16);

    if (abs(v_diff) >= abs(h_diff)) {
        if (abs(self.hspeed) > abs(self.vspeed) && sign(v_diff) == -sign(self.vspeed)) {
            self.vspeed *= -1;
            self.bounced = true;
            self.corner_bounced = false;
            //show_debug_message("vert bounce");
        }
    }

    if (abs(h_diff) >= abs(v_diff)) {
        if (abs(self.hspeed) < abs(self.vspeed) && sign(h_diff) == -sign(self.hspeed)) {
            self.hspeed *= -1;
            self.bounced = true;
            self.corner_bounced = false;
            //show_debug_message("hor bounce");
        }
    }

    if (self.speed < 1 && self.y < other.y) {
        self.bounced = false;
    }

    if (self.bounced) {
        self.speed -= 0.2;

        if (abs(self.speed) < 0.2) {
            self.speed = 0;
        }
    }
}
