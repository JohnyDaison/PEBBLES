event_inherited();

self.enabled = ds_map_create();
self.active = ds_map_create();
self.field = ds_map_create();
self.tints = ds_map_create();

for (var sideIndex = 0; sideIndex < 4; sideIndex++) {
    self.enabled[? sideIndex] = false;
    self.active[? sideIndex] = false;
    self.field[? sideIndex] = noone;
    self.tints[? sideIndex] = ds_list_create();
}

self.image_speed = 0;
self.my_last_color = g_nothing;
self.rotate_by = 0;
self.has_rotated = true;

self.transfer_packet_size = 0.2;

self.disc_tint = c_black;
self.disc_alpha = 0.8;
self.dot_distance = 8;
self.disc_angle = 0;
self.desired_disc_angle = 0;
self.rotation_speed = 0;
self.rotation_time = 60;
self.rotation_acc_coef = 90 / self.rotation_time;
self.rotation_acc = 0;

self.alarm[1] = 2;
