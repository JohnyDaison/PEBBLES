if (!self.bounced) {
    var orig_x = self.x;
    var orig_y = self.y;

    self.x_return = self.xprevious - orig_x;
    self.y_return = self.yprevious - orig_y;

    var h_diff = self.xprevious - (other.x + 15);
    var v_diff = self.yprevious - (other.y + 15);

    self.orig_speed = self.speed;

    self.speed_delta = (other.energy / other.bounce_threshold - 1) * other.bounce_speedchange_ratio;
    self.energy_delta = self.speed_delta * -other.bounce_speedenergy_ratio;

    if (abs(h_diff) <= 16 || abs(v_diff) <= 16) {
        if (abs(v_diff) >= abs(h_diff)) {
            if (sign(v_diff) == -sign(self.vspeed)) // abs(self.hspeed) > abs(self.vspeed) && 
            {
                self.vspeed *= -1;
                self.bounced = true;
                self.corner_bounced = false;
                //show_debug_message("vert bounce");
            }
        }

        if (abs(h_diff) >= abs(v_diff)) {
            if (sign(h_diff) == -sign(self.hspeed)) // abs(self.hspeed) < abs(self.vspeed) && 
            {
                self.hspeed *= -1;
                self.bounced = true;
                self.corner_bounced = false;
                //show_debug_message("hor bounce");
            }
        }
    }
    else {
        h_diff -= sign(h_diff) * 12;
        v_diff -= sign(v_diff) * 12;

        //show_debug_message("corner h_diff: "+string(h_diff));
        //show_debug_message("corner v_diff: "+string(v_diff));

        self.corner_bounced = true;
        //show_debug_message("corner bounce found");
    }

    if (self.bounced) {
        if (self.orig_speed + self.speed_delta > 0.2) {
            self.speed = self.orig_speed + self.speed_delta;
            other.energy += self.energy_delta;
        }
        else {
            //self.speed = 0;
            self.gravity = 0;
        }

        if (abs(self.speed) < 0.2) {
            self.speed = 0;
        }
    }
}
