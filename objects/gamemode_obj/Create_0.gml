// common
self.player_count = 0;
self.team_count = 0;
self.inited_player_count = 0;
self.human_player_count = 0;
self.last_human_player = 0;
self.players = ds_map_create();
self.stats = ds_map_create();
self.arena_name = "";
self.mode = "";
self.name = "";
self.rule_preset = noone;
self.shown_welcome = false;
self.closed_welcome = false;
self.match_started = false;
self.created_gui = false;
self.limit_reached = false;
self.reached_limit_name = "";
self.match_start_time = current_time;
self.last_minute = -1;
self.match_finished = false;
self.restart_match = false;
self.is_coop = false;
self.is_deathmatch = false;
self.is_campaign = false;
self.team_based = false;
self.tournament_length = 0;
self.matches_remaining = 0;
self.random_place_order = false;
self.regenerate_terrain_delay = 8 * 60; //300
self.cpu_player_exists = false;
self.game_started = false;
self.game_ended = false;

self.sudden_death = false;

// rules
self.rules_state = ds_map_create();
self.custom_rules = ds_map_create();

self.winner = noone;
self.loser = noone;
self.losers = ds_list_create();

/*
self.pixelating_left = 0;
self.pixelate_time = 1;
*/

self.time_window = noone;
self.battlefeed = noone;

init_match_stats();

DB.mob_spawner_start_offset = 0;


//gamemode_obj
self.single_cam = false;
self.visible_checkpoints = false;
self.no_inventory = false;
self.no_orbs_start = false;
self.star_fall = false;

self.soul_tear = 0.1;
self.time_limit = 0;
self.item_labels = "normal";


//(seconds)
self.mob_spawners_first_delay = 2 * 60; //2
self.mob_spawners_respawn_delay = 6 * 60;

self.score_values = ds_map_create();

// TODO: only some the score_values are actually used in code, needs more design

// deaths
self.score_values[? "guy_kills_guy"] = 40;
self.score_values[? "guy_kills_mob"] = 40;
self.score_values[? "guy_kills_npc"] = 20;
self.score_values[? "guy_kills_turret"] = 20;
self.score_values[? "npc_kills_guy"] = 20;
self.score_values[? "npc_kills_mob"] = 20;
self.score_values[? "npc_kills_npc"] = 10;
self.score_values[? "npc_kills_turret"] = 10;
self.score_values[? "guy_suicide"] = -20;
self.score_values[? "cannon_killed"] = 30;
self.score_values[? "snake_killed"] = 30;
self.score_values[? "base_crystal_killed"] = 40;

// quests
self.score_values[? "artifact_destroyed"] = 20;
self.score_values[? "snake_trophy"] = 10;
self.score_values[? "extra_shard"] = 20;
self.score_values[? "extra_orb"] = 10;
self.score_values[? "underdog_kill_bonus"] = 20;

self.score_values[? "achiev_first_blood"] = 20;
self.score_values[? "achiev_undying"] = 20;
self.score_values[? "achiev_shadow_ninja"] = 20;
self.score_values[? "crunchy_limit"] = 350;

//levels
self.level_min = ds_map_create();
self.level_max = ds_map_create();
self.level_minstart = ds_map_create();
self.level_maxstart = ds_map_create();

init_levels_gamemode();

self.world = noone;

var player = instance_create(0, 0, player_obj);

player.number = 0;
player.name = "The World";
player.flag = "world_flag";
player.icon = DB.battlefeed_icon_map[? player.flag];
player.battlefeed = self.battlefeed;

self.players[? 0] = player;
self.environment = player;

/// @param {Real} view_number
/// @return {Id.Instance}
function find_player_by_view(view_number) {
    for (var player_i = 0; player_i <= self.player_count; player_i++) {
        var player = self.players[? player_i];

        if (instance_exists(player.my_camera) && player.my_camera.view == view_number) {
            return player;
        }
    }

    return noone;
}
