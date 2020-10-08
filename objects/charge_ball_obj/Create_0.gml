event_inherited();

my_guy = noone;
my_chunkgrid = noone;
orbs = ds_list_create();
max_orbs = 9;
orb_count = 0; //3
orb_dist = 8;
orb_base_size = 0.75;
orb_angle_offset = 0;
orb_min_rot_speed = 1/480;
orb_rot_speed = orb_min_rot_speed;
orb_max_rot_speed = 1/24;
self.alarm[2] = 2;
self.alarm[3] = 2;

image_index = 0;
image_speed = 0.4;
image_alpha = 0.75;
//size_pulse = 0;
bar_dist = 28;
bar_height = 6;

dash_dist = 18;
dash_base_steps = 12;
dash_step_ratio = 0.75;
dash_end_ratio = 2;

self.holo_alpha = 1;
self.holo_alpha_step = 0.005;
self.holo_minalpha = 0.4;
self.holo_maxalpha = 0.6;

base_speed = 1.5;
desired_angle = 0;
desired_dist = 0;
cur_dist = 0;
cur_dir = 0;
cur_speed = 0;
rel_x = 0;
rel_y = 0;
center_offset_x = 0;
center_offset_y = 0;
 
charge_step = 0.025;
charge = 0;
energy = charge;
trig_charge = 0;
chargerate = 1;
channelrate = 0.5;
shield_channel_threshold = 2;
channeling = false;
firing = false;
dash_steps_left = 0;
dash_interrupted = false;
small_charge = 0.2;
shot_delay = 6;
smoke_charge = 0.05;
smoke_delay = 3;
max_charge = 1;
overcharge = 0;
size_coef = 1;
sprite_size = 0;
feedingrate = 1;
feeding_max = 0.5;
safety_lock = true;
autofire = false;
charging = false;
triggerable = true;
trigger_script = chargeball_trigger_script;

highlight_alpha = 0;
shape = shape_circle;
base_radius = 24;
radius = base_radius;
glow_tint = tint;

comp[g_black] = 0;
comp[g_red] = 0;
comp[g_green] = 0;
comp[g_blue] = 0;
num_colors_used = 0;
    
charge_cost = 0;
energy_cost[g_black] = 0;
energy_cost[g_red] = 0;
energy_cost[g_green] = 0;
energy_cost[g_blue] = 0;

soundtime = 0;
my_charge_sound = noone;
started = false;
return_energy = false;

light_bg_color = merge_colour(c_ltgray, c_white, 0.5);
dark_bg_color = merge_colour(c_dkgray, c_black, 0.5);
base_bar_color = DB.colormap[? g_red];
feed_bar_color = merge_colour(base_bar_color, c_white, 0.5);

// COLOR EXHAUSTION
/*
color_exhaustion = ds_map_create();
for(var col=g_black; col <= g_octarine; col++)
{
    color_exhaustion[? col] = 0;     
}
color_exhaustion_rate = 1;
color_exhaustion_regen = 0.015;
color_exhaustion_max = 10;
color_exhaustion_ratio = 1;
*/

orb_exhaustion_rate = 0.12;
orb_exhaustion_ratio = 1;
display_exhaustion_ratio = 1;

// INIT
threshold = (max_charge+overcharge+feeding_max) * orb_exhaustion_ratio;

// LIGHT
gives_light = true;
ambient_light = 0.66;
direct_light = 0;

// PARTICLES 
system = part_system_create();
part_system_automatic_draw(system, true);
part_system_automatic_update(system, true);
part_system_depth(system, -20);
part_system_draw_order(system, true);
pt = part_type_create();
part_type_alpha2(pt,0.8,0);
part_type_blend(pt,true);

part_type_color1(pt,c_white);
part_type_shape(pt,pt_shape_sphere);
part_type_size(pt,0.1,0.1,-0.01,0);
part_type_life(pt,10,10);

part_type_orientation(pt,0,0,0,0,0);
em = part_emitter_create(system);

// LIGHTNING

lightning_steps = 5;
lightning_thickness = 4;
lightning_width = 10;
lightning_alpha = 1;
lgt_r1 = -0.5*lightning_width; 
lgt_r2 = 0.5*lightning_width;
