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
achiev_delay = 2;
last_room = undefined;
is_cpu = false;
cpu_difficulty = 1;
title = "";
battlefeed = noone;
display_color_info = false;
color_info = noone;

// HANDICAPS
handicaps[? "min_damage"] = 0;

// LEVELS
levels = ds_map_create();
levels_roomstart = ds_map_create();
init_levels_player();

init_stats(id, stats);

achievs = ds_map_create();
var i=1;
ds_map_add(achievs, i++ , achiev_first_blood);
ds_map_add(achievs, i++ , achiev_shadow_ninja);
ds_map_add(achievs, i++ , achiev_undying);
ds_map_add(achievs, i++ , achiev_idle_pickup);
ds_map_add(achievs, i++ , achiev_crunchy);
achiev_count = ds_map_size(achievs);

// 0 - AVAILABLE, 1 - EARNED, -1 - FAILED
achiev_state = ds_map_create();
for (i = 1; i <= achiev_count; i++) {
    achiev_state[? i] = 0;
}

alarm[2] = achiev_delay;

// QUESTS
player_quests_init(id);

// LOAD LEVEL CONFIGS
function load_level_configs() {
    if (!instance_exists(gamemode_obj.world) || !instance_exists(gamemode_obj.world.current_place)) {
        return;
    }
    
    // TODO: Is this code supposed to be run for every player or should it be run just once?
    var place = gamemode_obj.world.current_place;
    var count = ds_list_size(place.level_configs_list);

    with (gamemode_obj) {
        for (var i = 0; i < count; i++) {
            levels_load_config(place.level_configs_list[| i]);
        }
    }
    
    // This does need to be run per player
    init_levels_player();
}

/// @description update achievements if my_guy exists
function update_achievements() {
    if (!instance_exists(my_guy)) {
        return;
    }
    
    for (var i = 1; i <= achiev_count; i++) {
        var state = achiev_state[? i];

        if (state == 0) {
            var achiev_script = ds_map_find_value(achievs, i);
            var title = script_execute(achiev_script, "title");

            if (script_execute(achiev_script, "fail")) {
                state = -1;
            }
            else if (script_execute(achiev_script, "success")) {
                state = 1;
                battlefeed_post_string(gamemode_obj.environment, my_player.name + " " + script_execute(achiev_script, "verb"));

                var reward_score = script_execute(achiev_script, "reward_score");
                var score_str = "";
                if (is_number(reward_score) && reward_score != 0) {
                    score_str = stat_label("score", reward_score, "+");
                    increase_achievement_score(my_player, reward_score, false);
                }

                battlefeed_post_achievement(achiev_script, my_player, score_str);
                script_execute(achiev_script, "reward");
            }

            achiev_state[? i] = state;
        }
    }
}
