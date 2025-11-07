// PULSING
self.alpha += self.alpha_dir * self.alpha_speed;

if (self.alpha_dir == -1) {
    if (self.alpha <= self.min_alpha) {
        self.alpha = self.min_alpha;
        self.alpha_dir = 1;
    }
}
else if (self.alpha_dir == 1) {
    if (self.alpha >= self.max_alpha) {
        self.alpha = self.max_alpha;
        self.alpha_dir = -1;
    }
}

self.ambient_light = self.alpha / 4;

// COLOR UPDATE
var firstProjector = self.my_projectors[? 1];
var secondProjector = self.my_projectors[? 2];
var new_col = firstProjector.my_color & secondProjector.my_color;

if (new_col <= g_dark || new_col >= g_octarine) {
    instance_destroy();
    exit;
}

if (new_col != self.my_color) {
    self.my_color = new_col;
    self.tint_updated = false;
}

// POSITION AND DIMENSIONS UPDATE
if (!self.ready) {
    self.x1 = min(firstProjector.x, secondProjector.x) - 1;
    self.x2 = max(firstProjector.x, secondProjector.x) - 1;

    self.y1 = min(firstProjector.y, secondProjector.y);
    self.y2 = max(firstProjector.y, secondProjector.y);

    self.x = ceil(mean(self.x1, self.x2));
    self.y = ceil(mean(self.y1, self.y2));

    self.x1 = floor(self.x1) - 14;
    self.y1 = floor(self.y1) - 15;
    self.x2 = ceil(self.x2) + 14;
    self.y2 = ceil(self.y2) + 13;

    self.width = self.x2 - self.x1;
    self.height = self.y2 - self.y1;

    self.radius = max(self.width, self.height) / 2;

    self.image_xscale = (self.width + 2 * self.check_dist) / self.mask_size;
    self.image_yscale = (self.height + 2 * self.check_dist) / self.mask_size;

    self.ready = true;
}

event_inherited();
