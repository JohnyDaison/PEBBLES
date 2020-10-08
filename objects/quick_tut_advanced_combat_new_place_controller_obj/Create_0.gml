event_inherited();

trigger_group_id = "advanced_combat_tut/triggers";
trigger_group = noone;

anim_groups = ds_map_create();
anim_sets = ds_map_create();
active_display_group = noone;

anim_groups[? "turn_dark"] = noone;
anim_sets[? "turn_dark"] = turn_dark_anim_set;

anim_groups[? "dark_shot"] = noone;
anim_sets[? "dark_shot"] = quick_shot_anim_set;

anim_groups[? "shield"] = noone;
anim_sets[? "shield"] = shield_anim_set;

anim_groups[? "color_sheet"] = noone;
anim_sets[? "color_sheet"] = color_sheet_anim_set;

anim_groups[? "gate_90"] = noone;
anim_sets[? "gate_90"] = gate_90_anim_set;

anim_groups[? "gate_180"] = noone;
anim_sets[? "gate_180"] = gate_180_anim_set;

anim_groups[? "grenade_aim"] = noone;
anim_sets[? "grenade_aim"] = grenade_aim_anim_set;

anim_groups[? "crystal"] = noone;
anim_sets[? "crystal"] = crystal_anim_set;

anim_groups[? "cannon"] = noone;
anim_sets[? "cannon"] = cannon_anim_set;

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
    player_quest_start_command(i, "quick_tutorial_advanced_combat_new", "quick_tut_level5_new", "main");

    player_quests_recheck_command(i);

    //player_quest_log_printout(i);
}

/*
with(mob_portal_obj)
{
    spawn_sprinkler = false;
    
    first_spawn = particles_time +1;
    particles_time = 6 * singleton_obj.game_speed;
    siren_time = 5 * singleton_obj.game_speed;   
    respawn_time = particles_time + 40 * singleton_obj.game_speed;
}
*/

with(main_camera_obj)
{
    bg_hspeed = 10;
}

alarm[1] = 6;
alarm[2] = 4;

