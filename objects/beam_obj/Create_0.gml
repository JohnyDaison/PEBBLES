event_inherited();

self.beam_head_fired = false;
self.beam_head_landed = false;
self.beam_head_delay = 60;
self.alarm[1] = self.beam_head_delay;
self.beam_update_delay = 10;
self.beam_speed = 128;
self.beam_glow_size = 6;
self.beam_small_core_size = 5;
self.beam_big_core_size = 20;
self.beam_tex_glow_start = 4 / 32;
self.beam_tex_glow_end = 11 / 32;
self.beam_nodes = ds_list_create();
self.beam_head_node = 0;
self.beam_head_node_changed = true;
self.beam_head_dist = 0;
self.head_facing = 0;
self.beam_end = noone;
self.alarm[0] = 1;
self.collided = false;
self.endpoint_reached = false;
self.beam_tex = sprite_get_texture(beam_base, 0);
self.beam_high_tex = sprite_get_texture(beam_base_highlight, 0);
self.image_alpha = 0.9;
self.beam_alpha = 0.7;
self.beam_highlight_ratio = 1;
self.beam_draw_phase = 0;
self.small_beam_coef = 300;
self.big_beam_coef = 40;
self.invalid = true;
self.my_ball = noone;
self.my_holder = noone;
self.head_node = noone;
self.facing_right = false;
self.facing = -1;

self.node_x = 0;
self.next_node_x = 0;

self.radii_updated = false;
self.core_radius = 0;
self.next_core_radius = 0;
self.beam_radius = 0;
self.next_beam_radius = 0;

self.name = "BEAM!!!";
