event_inherited();

self.shape = shape_circle;
self.orig_friction = 0.4;
self.normal_radius = 20;
self.core_radius = 12;
self.scale = 0.1;
self.scale_speed = 0.1;
self.radius = self.scale * self.normal_radius;
self.gives_light = true;
self.orig_ambient_light = 0.35;
self.orig_direct_light = 0;
self.ambient_light = self.orig_ambient_light;
self.direct_light = self.orig_direct_light;
self.max_force = 0;
self.gui_x = 0;
self.gui_y = 0;
self.fall_gravity = 0.1;
self.is_resting = true;
self.force_decay = 0.00001;
self.force_usage = 0.001;
self.consolidated = false;
self.image_index = irandom(self.image_number - 1);
self.image_speed = 0;

// holo
self.holo_alpha = 1;
self.holo_alpha_step = 0.005;
self.holo_minalpha = 0.4;
self.holo_maxalpha = 0.6;

self.col_group = noone; // collision group
self.inv_col_group = noone;

if (self.y > 0) {
    // TODO: own sound?
    my_sound_play(jump_sound);
}

self.name = "Gas Cloud";
