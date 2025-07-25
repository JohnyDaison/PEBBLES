// common
player_count = 0;
team_count = 0;
inited_player_count = 0;
human_player_count = 0;
last_human_player = 0;
players = ds_map_create();
stats = ds_map_create();
arena_name = "";
mode = "";
name = "";
rule_preset = noone;
shown_welcome = false;
closed_welcome = false;
match_started = false;
created_gui = false;
limit_reached = false;
reached_limit_name = "";
match_start_time = current_time;
last_minute = -1;
match_finished = false;
restart_match = false;
is_coop = false;
is_deathmatch = false;
is_campaign = false;
team_based = false;
tournament_length = 0;
matches_remaining = 0;
random_place_order = false;
regenerate_terrain_delay = 8 * 60; //300
cpu_player_exists = false;
game_started = false;
game_ended = false;

sudden_death = false;

// mods
mods_state = ds_map_create();
custom_mods = ds_map_create();

winner = noone;
loser = noone;
losers = ds_list_create();

/*
pixelating_left = 0;
pixelate_time = 1;
*/

time_window = noone;
battlefeed = noone;

init_match_stats();

DB.mob_spawner_start_offset = 0;


//gamemode_obj
single_cam = false;
visible_checkpoints = false;
no_inventory = false;
no_orbs_start = false;
star_fall = false;

soul_tear = 0.1;
time_limit = 0;
item_labels = "normal";


//(seconds)
mob_spawners_first_delay = 2 * 60; //2
mob_spawners_respawn_delay = 6 * 60;

score_values = ds_map_create();

// TODO: only some the score_values are actually used in code, needs more design

// deaths
score_values[? "guy_kills_guy"] = 40;
score_values[? "guy_kills_mob"] = 40;
score_values[? "guy_kills_npc"] = 20;
score_values[? "guy_kills_turret"] = 20;
score_values[? "npc_kills_guy"] = 20;
score_values[? "npc_kills_mob"] = 20;
score_values[? "npc_kills_npc"] = 10;
score_values[? "npc_kills_turret"] = 10;
score_values[? "guy_suicide"] = -20;
score_values[? "cannon_killed"] = 30;
score_values[? "snake_killed"] = 30;
score_values[? "base_crystal_killed"] = 40;

// quests
score_values[? "artifact_destroyed"] = 20;
score_values[? "snake_trophy"] = 10;
score_values[? "extra_shard"] = 20;
score_values[? "extra_orb"] = 10;
score_values[? "underdog_kill_bonus"] = 20;

score_values[? "achiev_first_blood"] = 20;
score_values[? "achiev_undying"] = 20;
score_values[? "achiev_shadow_ninja"] = 20;
score_values[? "crunchy_limit"] = 350;

//levels
level_min = ds_map_create();
level_max = ds_map_create();
level_minstart = ds_map_create();
level_maxstart = ds_map_create();

init_levels_gamemode();

world = noone;

player = instance_create(0,0,player_obj);
player.number = 0;
player.name = "The World";
player.flag = "world_flag";
player.icon = DB.battlefeed_icon_map[? player.flag];
player.battlefeed = battlefeed;
players[? 0] = player;

environment = player;

find_player_by_view = function(view_number) {
    for(var player_i = 0; player_i <= player_count; player_i++) {
        var player = players[? player_i];
        
        if (instance_exists(player.my_camera) && player.my_camera.view == view_number) {
            return player;
        }
    }
    
    return noone;
}
