event_inherited();

show_debug_message("init bot at "+string(x)+","+string(y));

is_npc = true;
is_general_npc = false;

bot_type = "";
bot_activation_distance = 640;
bot_deactivation_distance = 1480;
stay_activated = false;

hp_bar_width = 100;
bar_dist = -32;
bar_height = 6;
health_bar_color = DB.colormap[? g_green];

draw_label = true;

difficulty = 1;
sustain_tick_time = 60;
spawn_batteries = false;

// for npc debug
next_body_terrain = noone;
blocking_terrain = noone;
next_takeoff_terrain = noone;
landing_terrain = noone;
nearest_waypoint = noone;
current_path = ds_list_create();

attack_targets = ds_list_create();
attack_target = noone;
move_target = noone;