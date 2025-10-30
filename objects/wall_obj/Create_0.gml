event_inherited();

self.RuleID = DB.RuleID_DynEnum.dynEnum;
var RuleID = self.RuleID;

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

if(rule_get_state(RuleID.WeakTerrain))
{
    hp = 1;
}

if(rule_get_state(RuleID.IndestructibleTerrain))
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

burst_position_free = function(dir, burst_x, burst_y) {
    var meeting_terrain = place_meeting(burst_x -(burst_x mod 32), burst_y - (burst_y mod 32), solid_terrain_obj);
    
    if (meeting_terrain) {
        return false;
    }
    
    var meeting_item_spawner = false;
    
    if (dir == 90) {
        var spawner = instance_place(x, y, item_spawner_obj);
        meeting_item_spawner = instance_exists(spawner) && spawner.my_block == id;
        
        if (meeting_item_spawner) {
            return false;
        }
    }
    
    return true;
}