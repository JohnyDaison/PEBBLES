event_inherited();

image_speed = 0;
my_next_color = my_color;
my_old_color = my_color;
color_locked = false;
is_burner = false;
burn_to_dark = false;
lock_alpha = 1;
sound_played = false;
aoe_met = false;
beam_end_met = false;
direct_input_buffer = 0;
max_energy = DB.terrain_config[? "max_energy"];

//falling = true;

hp = 3;
core = core_energy;

if(mod_get_state("weak_terrain"))
{
    hp = 1;
}
if(mod_get_state("indestr_terrain"))
{
    cover = cover_indestr;
}

last_attacker_init();

att_forget_delay = 60;
last_dmg = 0;
spread_count = 0;

orig_energy = energy;
orig_color = my_color;
orig_damage = damage;
orig_locked = color_locked;

max_scale_amount = 1;
max_scale_distance = 1;
unscale_speed = 0.01;

has_changed = false;
active = true;
start_glow = false;
do_glow = false;
strong_glow = false;
spreading = false;
bursting = false;
burst_rate = 0.04;
burst_count = 0;
burst_recheck = false;

light_shape = shape_circle;

light_xoffset = 14.5;
light_yoffset = 14.5;

corner_radius = 4;
/*
//light_shape = choose(shape_circle, shape_rect);
if(light_shape == shape_rect)
{
    light_xoffset = 15.5;
    light_yoffset = 15.5;
}
*/
grate = noone;

self.holo_alpha = 1;
self.holo_alpha_step = 0.005;
self.holo_minalpha = 0.4;
self.holo_maxalpha = 0.6;

will_spread = ds_map_create();

name = "Wall Block";

alarm[0]=1;
alarm[4]=2;
