if (self.source != noone && other.source != noone) {
    if (self.source == other.source && self.my_color == other.my_color && self.type == other.type) {
        if (other.y > self.y) {
            other.damage += self.damage;
            other.tint = self.tint;
            other.fade_ratio = max(0.6, other.fade_ratio);

            instance_destroy();
        }
    }
    else {
        if (other.x > self.x) {
            other.x += 1;
            self.x -= 1;
        }
    }
}
