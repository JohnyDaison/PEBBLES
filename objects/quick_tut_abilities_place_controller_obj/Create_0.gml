event_inherited();

trigger_group_id = "abilities/triggers";
trigger_group = noone;

anim_groups = ds_map_create();
anim_sets = ds_map_create();
active_display_group = noone;

anim_groups[? "use_ability"] = noone;
anim_sets[? "use_ability"] = use_ability_anim_set;

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
    player_quest_start_command(i, "quick_tutorial_abilities", "quick_tut_level6", "main");

    player_quests_recheck_command(i);

    //player_quest_log_printout(i);
}


alarm[1] = 6;
alarm[2] = 4;

