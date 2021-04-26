number = -1;
team_number = -1;
name = "";
flag = "";
icon = empty_mask;
control_set = 0;
control_index = -1;
control_obj = noone;
handicaps = ds_map_create();
stats = ds_map_create();
my_spawner = noone;
my_base = noone;
my_cannons = ds_list_create();
my_camera = noone;
my_player = id;
my_guy = noone;
winner = false;
loser = false;
rgb_color_order = false;
achiev_delay = 2;
last_room = noone;
is_cpu = false;
cpu_difficulty = 1;
title = "";
battlefeed = noone;
display_color_info = false;
color_info = noone;

var i;

// HANDICAPS
handicaps[? "min_damage"] = 0;

// LEVELS
levels = ds_map_create();
levels_roomstart = ds_map_create();
init_levels_player();

init_stats(id, stats);

stat_count = ds_map_size(stats);

achievs = ds_map_create();
i=1;
ds_map_add(achievs, i++ , achiev_first_blood);
ds_map_add(achievs, i++ , achiev_shadow_ninja);
ds_map_add(achievs, i++ , achiev_undying);
ds_map_add(achievs, i++ , achiev_idle_pickup);
ds_map_add(achievs, i++ , achiev_crunchy);
achiev_count = ds_map_size(achievs);

// 0 - AVAILABLE, 1 - EARNED, -1 - FAILED
achiev_state = ds_map_create();
for(var i = 1; i <= achiev_count; i++)
{
    achiev_state[? i] = 0;
}

alarm[2] = achiev_delay;

// QUESTS
player_quests_init(id);
