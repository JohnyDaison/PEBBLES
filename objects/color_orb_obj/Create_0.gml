event_inherited();

sprite_index = no_sprite;
image_speed = 0;
image_index = 0;
//my_guy = noone;
old_guy = noone;
my_color = g_nothing;
multicolor = true;
my_angle = 0;
my_distance = 0;
orb_dist = 0;
orbit_anchor = noone;

color_added = false;
color_held = false;
color_consumed = false;
in_use = false;

image_alpha = 0.9;
airborne = false;
max_speed = 24;
gravity_coef = 0.04;
friction_coef = 0.01;
custom_sprite = true;
draw_label = false;
if(gamemode_obj.is_campaign) // TODO: change condition
{
    draw_label = true;
}
cur_y = 0;
base_energy = 1;
max_energy = 2;
energy = base_energy;
cur_regen_speed = spd_normal;
direct_input_buffer = 0;
distribution_step = 0.005;

newly_got_steps = 0;
newly_got_anim_cycle = 20;
newly_got_anim_sizecoef = 4;
newly_got_anim_duration = 60;
newly_got_anim_peak = 30;

drained_object = noone;
drain_radius = 160;
drain_update_delay = 30;
drain_quick_update_delay = 10;
drain_energy_step = 0.003;
min_drain_efficiency = 0.5;
max_drain_efficiency = 1.6;
//for read_terrain
self.ter_right = 2;
self.ter_left = 2;
self.ter_up = 2;
self.ter_down = 2;

//color_exhaustion_ratio = 1;
base_size = 1.25;
size_coef = 1;
size = 1;

// LIGHT
gives_light = true;
ambient_light = 0.66;
direct_light = 0.1;
radius = 9;
shape = shape_circle;

//PARTICLES
part_system = part_system_create();
part_system_depth(part_system, depth);
part_system_automatic_draw(part_system, false);
part_type = part_type_create();
part_type_sprite(part_type,color_slot,false,false,false);
part_type_blend(part_type,true);
part_type_scale(part_type, 1, 1);
part_type_size(part_type, 0, 1, -0.025, 0);
part_type_life(part_type,40,40);
part_type_gravity(part_type,0,0);
part_type_orientation(part_type,0,0,9,0,0);

// LIGHTNING

draw_lightning = false;
receives_lightning = false;
lightning_target = noone;
lightning_x = x;
lightning_y = y;
lightning_color = -1;
lightning_steps = 5;
lightning_thickness = 5;
lightning_width = 16;
lightning_alpha = 1;
lgt_r1 = -0.5*lightning_width; 
lgt_r2 = 0.5*lightning_width;

// RESONANCE
/*
resonance_level = 0;
resonance_size_coef = 0.5;
resonance_size_boost = 1;
resonance_cycle = 60;
resonance_stepdir = 1;
resonance_step = 0;
*/
self.name = "Color Orb";

self.description = 
@"Lets you change your color, powers your spells.
Recharges itself slowly.";

