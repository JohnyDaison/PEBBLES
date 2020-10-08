event_inherited();

trigger_group_id = "basic_combat_tut/triggers";
trigger_group = noone;

anim_groups = ds_map_create();
anim_sets = ds_map_create();
active_display_group = noone;

anim_groups[? "charge_pad"] = noone;
anim_sets[? "charge_pad"] = charge_pad_anim_set;

anim_groups[? "barrage"] = noone;
anim_sets[? "barrage"] = barrage_anim_set;

anim_groups[? "channeling"] = noone;
anim_sets[? "channeling"] = channeling_anim_set;

anim_groups[? "white_overload"] = noone;
anim_sets[? "white_overload"] = white_overload_anim_set;

anim_groups[? "dashwave"] = noone;
anim_sets[? "dashwave"] = dashwave_anim_set;

/*
anim_groups[? "quick_shot"] = noone;
anim_sets[? "quick_shot"] = quick_shot_anim_set;

anim_groups[? "aim_shot"] = noone;
anim_sets[? "aim_shot"] = aim_shot_anim_set;

anim_groups[? "use_item"] = noone;
anim_sets[? "use_item"] = use_item1_anim_set;
*/
anim_groups[? "clear"] = noone;
anim_sets[? "clear"] = noone;

anim_group_count = ds_map_size(anim_groups);

nav_graph_create();

auto_init_waypoints = true;
//auto_generate_nav_graph = true;
generate_nav_graph = true;

// TODO: can be triggered by event

var i;

for(i = 0; i <= gamemode_obj.player_count; i++)
{
    player_quest_start_command(i, "quick_tutorial_basic_combat", "quick_tut_level4", "main");

    player_quests_recheck_command(i);

    //player_quest_log_printout(i);
}

subscribe_event("zone_enter", quick_basic_combat_event_script);
subscribe_event("mob_spawn", quick_basic_combat_event_script);

with(mob_portal_obj)
{
    spawn_spitters = false;
    
    first_spawn = particles_time -1;
    particles_time = 6 * singleton_obj.game_speed;
    siren_time = 5 * singleton_obj.game_speed;   
    respawn_time = particles_time -1;
    
    enabled = false;
    active = true;
}

alarm[1] = 6;
alarm[2] = 4;

