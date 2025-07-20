event_inherited();

my_guy = noone;
image_index = 0;
image_speed = 0.2;
image_alpha = 0.75;

// charge
charge_step = 0.0005;
charge = charge_step;
energy = charge;
chargerate = 1;
regenrate = 4;
faderate = 20;
max_charge = 1;
low_charge = 0.5;
collapse_threshold = 6;
overcharge = 0;
threshold = 0;
channel_maxboost = 0;
cur_step = 0;

// glitching effect
low_charge_ratio = 0.75;
glitch_min = 5;
glitch_max = 30;
glitch_delay = 15;
glitch_length = 8;
glitch_start = 0;
glitch_end = 0;
glitch_alpha = 1;
glitching = false;

// holo
self.holo_alpha = 1;
self.holo_alpha_step = 0.005;
self.holo_minalpha = 0.4;
self.holo_maxalpha = 0.6;

diff = 0;
size = 1;
//min_size = 1;
size_coef = 0.5;
alpha = 0;
done_for = false;
dead = false; // hack, should be solved in basic_bot or arena_bot
collapsed = false;
damage_tint_ratio = 0.66;
bar_dist = 46;
bar_height = 6;
light_bg_color = merge_colour(c_ltgray, c_white, 0.5);
dark_bg_color = merge_colour(c_dkgray, c_black, 0.5);
base_bar_color = DB.colormap[? g_magenta];
feed_bar_color = DB.colormap[? g_red];
channeled = false;
draw_bar = true;
// FORCE FIELD VARS
repels = true;
field_power = 2;
shape = shape_circle;
base_radius = 50;
radius = base_radius;
bounce_radius_threshold = 56;
field_ratio = 0.5;
field_focus = radius*field_ratio;
my_shield = id; // questionable

// IMPACT ANIM
impact_sprite = shield_impact2_spr;
impact_anim_speed = 0.5;
impact_anim_length = 9;
impact_image_index = impact_anim_length;
impact_newtint = -1;
impact_newdir = -1;
impact_draw = false;

impact_tints = ds_map_create();
impact_directions = ds_map_create();
for(i=0; i<impact_anim_length; i+=1)
{
    ds_map_add(impact_tints,i,-1);
    ds_map_add(impact_directions,i,-1);
}

// PARTICLES 
system = part_system_create();
part_system_automatic_draw(system, false);
part_system_automatic_update(system, true);
part_system_depth(system, depth);
part_system_draw_order(system, true);
pt = part_type_create();
part_type_alpha1(pt,0.4);
part_type_blend(pt,0);

part_type_color1(pt,c_white);
part_type_shape(pt,pt_shape_pixel);
part_type_size(pt,1,1,0,0);
part_type_life(pt,2,2);
part_type_gravity(pt,0,90);

part_type_orientation(pt,0,0,0,0,0);
em = part_emitter_create(system);
