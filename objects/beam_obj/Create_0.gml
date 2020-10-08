event_inherited();

beam_head_fired = false;
beam_head_landed = false;
beam_head_delay = 60;
alarm[1] = beam_head_delay;
beam_update_delay = 10;
beam_speed = 128;
beam_glow_size = 6;
beam_small_core_size = 5;
beam_big_core_size = 20;
beam_tex_glow_start = 4/32;
beam_tex_glow_end = 11/32;
beam_nodes = ds_list_create();
beam_head_node = 0;
beam_head_node_changed = true;
beam_head_dist = 0;
head_facing = 0;
beam_end = noone;
alarm[0] = 1;
collided = false;
endpoint_reached = false;
beam_tex = sprite_get_texture(beam_base,0);
beam_high_tex = sprite_get_texture(beam_base_highlight,0);
image_alpha = 0.9;
beam_alpha = 0.7;
beam_highlight_ratio = 1;
beam_draw_phase = 0;
small_beam_coef = 300;
big_beam_coef = 40;
invalid = true;
my_ball = noone;
my_holder = noone;
head_node = noone;
radii_updated = false;

self.name = "BEAM!!!";

