event_inherited();

self.my_projectors = ds_map_create();

self.border_size = 8;
self.corner_radius = self.border_size * 2;
self.check_dist = 33;
self.stop_dist = 12;
self.speedlimit = 5;

self.mask_size = 32;

self.image_speed = 0;
self.height = 24;
self.width = 24;
self.ready = false;
self.x1 = 0;
self.y1 = 0;
self.x2 = 0;
self.y2 = 0;

self.alpha = 0.2;
self.alpha_speed = 0.003; // 0.005
self.alpha_dir = 1;
self.min_alpha = 0.35;
self.max_alpha = 0.6;

my_sound_play(gate_on_sound);

self.name = "Filter field";

// LIGHT
self.gives_light = true;
self.shape = shape_rect;
self.ambient_light = 0.25;
self.direct_light = 1;

/// @param {Id.Instance} instance
/// @param {Bool} precision
/// @return {Bool}
function isValidCollision(instance, precision) {
    if (instance.my_color == self.my_color) {
        return false;
    }

    var x1 = self.x1 - instance.hspeed;
    var y1 = self.y1 - instance.vspeed;
    var x2 = self.x2 - instance.hspeed;
    var y2 = self.y2 - instance.vspeed;

    return collision_rectangle(x1, y1, x2, y2, instance.id, precision, true) != noone;
}
