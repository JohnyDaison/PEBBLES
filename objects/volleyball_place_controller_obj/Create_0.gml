event_inherited();

trigger_group_id = "triggers";
trigger_group = noone;

anim_group_count = 0;

nav_graph_create();

auto_init_waypoints = true;
auto_generate_nav_graph = true;
generate_nav_graph = true;
ball_respawn_wait = 60;
ball_y_offset = 192;
has_ball_number = 0;
allowed_touches = 2;
current_color = g_white;

player_colors = ds_map_create();
player_colors[? 1] = g_red;
player_colors[? 2] = g_blue;
player_colors[? 3] = g_green;
player_colors[? 4] = g_yellow;

shield_generator_structure_obj.shield_max_charge = 2;
shield_generator_structure_obj.shield_size = 0.3;
shield_generator_structure_obj.my_guy = noone;

da_ball = noone;

subscribe_event("ballzone_enter", volleyball_event_script);

with(player_obj)
{
    ball_touches = 0;
    was_touching_ball = false;
    touching_ball = false;
}

alarm[1] = 2;
alarm[2] = 4;
