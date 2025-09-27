/// @description HOLOGRAPHIC

// HOLOGRAPHIC
if (self.holographic) {
    self.holo_alpha += self.holo_alpha_step;

    if (self.holo_alpha < self.holo_minalpha) {
        self.holo_alpha = self.holo_minalpha;
        self.holo_alpha_step *= -1;
    }

    if (self.holo_alpha > self.holo_maxalpha) {
        self.holo_alpha = self.holo_maxalpha;
        self.holo_alpha_step *= -1;
    }
}
