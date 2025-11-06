if (place_meeting(self.xprevious, self.yprevious, other.id)) {
    if (self.speed > 0) {
        self.speed *= 1.3;
    }
}

self.gate_bounce_count += 1;
self.gate_bounced = true;

if (self.gate_bounce_count > self.gate_bounce_limit) {
    self.collided = true;
}

if (self.bounced || self.collided) {
    exit;
}

var orig_x = self.x;
var orig_y = self.y;

self.x_return = self.xprevious - orig_x;
self.y_return = self.yprevious - orig_y;

if (other.horizontal) {
    self.vspeed *= -1;
    self.vspeed += sign(self.x_return) * 0.2;
    self.bounced = true;
    self.corner_bounced = false;
    //show_debug_message("vert bounce");
}

if (other.vertical) {
    self.hspeed *= -1;
    self.hspeed += sign(self.y_return) * 0.2;
    self.bounced = true;
    self.corner_bounced = false;
    //show_debug_message("hor bounce");
}

if (self.bounced) {
    my_sound_play_colored(shot_bounce_sound, self.my_color, false, self.sound_volume);
}
