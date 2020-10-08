event_inherited();

my_guy = noone;
my_camera = noone;
ready = false;

width = 0;
height = 48;
guy_height = 32;
base_height = 16;
bg_alpha = 0;
hide_own_hp = false;
hide_hp_alpha = 0;
hide_base_hp = true;
hide_basehp_alpha = 0;
hide_speed = 0.02;

draw_own_hp = true;
own_hp_blink_time = 0;
own_hp_blink_rate = 10;

bg_color = c_black; //merge_colour(DB.colormap[? g_red], DB.colormap[? g_purple], 0.5);;
bar_bg_color = c_gray;
hp_bar_color = DB.colormap[? g_green]; //merge_colour(DB.colormap[? g_green], DB.colormap[? g_azure], 0.5);
handicap_color = DB.colormap[? g_purple];
basehp_bar_color = merge_colour(DB.colormap[? g_blue], DB.colormap[? g_azure], 0.5);;
border_width = 3;
label_color = c_yellow;
score_value = 0;
last_score_value = score_value;
last_stable_score_value = score_value;

shield_color = c_blue;
shield_phase = 0;
shield_pulse_speed = 0.001;
shield_pulse_dir = 1;
shieldloss_last_value = 0;

health_last_value = 1;
healthloss_fade_ratio = 1;
healthloss_blink_time = 20;
healthloss_fade_speed = 0.005;
healthloss_last_value = 1;
healthloss_color = DB.colormap[? g_red];
healthgain_fade_ratio = 1;
healthgain_blink_time = 20;
healthgain_fade_speed = 0.005;
healthgain_last_value = 1;
healthgain_color = DB.colormap[? g_yellow];

base_exists = false;
basehealth_last_value = 1;
basehealthloss_fade_ratio = 1;
basehealthloss_blink_time = 20;
basehealthloss_fade_speed = 0.005;
basehealthloss_last_value = 1;
basehealthloss_color = DB.colormap[? g_red];
basehealthgain_fade_ratio = 1;
basehealthgain_blink_time = 20;
basehealthgain_fade_speed = 0.005;
basehealthgain_last_value = 1;
basehealthgain_color = DB.colormap[? g_yellow];

scorepulse_max = 4;
scorepulse_normal = 1;
scorepulse_scale = scorepulse_normal;
scorepulse_speed = 0;
scorepulse_grow_speed = 0.075;
scorepulse_shrink_speed = 0.025;

// PARTICLES 
system = part_system_create();
part_system_automatic_draw(system, false);
part_system_automatic_update(system, true);
part_system_depth(system, depth-20);
part_system_draw_order(system, true);

particle_size = 2;
particle_distance = 8;
pt = part_type_create();
part_type_alpha2(pt,0.6,0.4);
part_type_blend(pt,true);
part_type_sprite(pt, part_pixel_spr,0,1,0);
part_type_size(pt,particle_size,particle_size,0,0);
part_type_life(pt,4,8);
part_type_speed(pt,1,1,0,0);
part_type_colour1(pt, c_white);
//part_type_direction(pt,270,270,0,0);
//part_type_orientation(pt,0,0,0,0,0);

em = part_emitter_create(system);

