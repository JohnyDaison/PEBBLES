event_inherited();

my_guy = noone;
my_chunkgrid = noone;
orbs = ds_list_create();
max_orbs = 9;
orb_count = 0;
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

centered_dist = 8;
base_speed = 1.5;
rest_x_offset = 16;
rest_ratio = 1/6;
desired_angle = 0;
desired_dist = 0;
cur_dist = 0;
cur_dir = 0;
cur_speed = 0;
rel_x = 0;
rel_y = 0;
center_offset_x = 0;
center_offset_y = 0;
visual_rel_x = 0;

charge_step = 0.025;
charge = 0;
energy = charge;
trig_charge = 0;
chargerate = 1;
channelrate = 0.5;
channeling = false;
firing = false;
dash_steps_left = 0;
dash_interrupted = false;
small_charge = 0.2;
shot_delay = 9;
smoke_charge = 0.05;
smoke_delay = 3;
max_charge = 1;
overcharge = 0;
size_coef = 1;
sprite_size = 0;
autofire = false;
charging = false;
triggerable = true;
trigger_script = chargeball_trigger_script;

highlight_alpha = 0;
shape = shape_circle;
base_radius = 24;
radius = base_radius;
glow_tint = tint;

comp[g_dark] = 0;
comp[g_red] = 0;
comp[g_green] = 0;
comp[g_blue] = 0;
num_colors_used = 0;

energy_cost[g_dark] = 0;
energy_cost[g_red] = 0;
energy_cost[g_green] = 0;
energy_cost[g_blue] = 0;

soundtime = 0;
my_charge_sound = noone;
started = false;

light_bg_color = merge_colour(c_ltgray, c_white, 0.5);
dark_bg_color = merge_colour(c_dkgray, c_black, 0.5);
base_bar_color = DB.colormap[? g_red];

orb_exhaustion_rate = 0.12;
orb_exhaustion_ratio = 1;
display_exhaustion_ratio = 1;

// INIT
threshold = (max_charge + overcharge) * orb_exhaustion_ratio;

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

is_my_guy_los_blocked = function(rel_x, rel_y) {
    var blocked = false, ter, field, body;
    
    var next_guy_x = my_guy.x + my_guy.hspeed + center_offset_x;
    var next_guy_y = my_guy.y + my_guy.vspeed + center_offset_y;
    
    var current_x = next_guy_x + rel_x;
    var current_y = next_guy_y + rel_y;
    
    ter = collision_line(next_guy_x, next_guy_y, current_x, current_y, solid_terrain_obj, false, true);
    if (ter != noone)
    {
        blocked = true;
    }
    
    if (!blocked)
    {
        field = collision_line(next_guy_x, next_guy_y, current_x, current_y, gate_field_obj, false, true);
        if (field != noone && (holographic || !field.holographic))
        {
            blocked = true;
        }
    }
    
    if (!blocked)
    {
        body = collision_line(next_guy_x, next_guy_y, current_x, current_y, phys_body_obj, false, true);
        if (body != noone && body.my_player.team_number != my_player.team_number && (holographic || !body.holographic))
        {
            blocked = true;
        }
    }
    
    return blocked;
}