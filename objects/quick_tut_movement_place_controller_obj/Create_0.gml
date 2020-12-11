event_inherited();

trigger_group_id = "quick_tut_movement/triggers";
trigger_group = noone;

anim_groups = ds_map_create();
anim_sets = ds_map_create();
active_display_group = noone;

anim_groups[? "run"] = noone;
anim_sets[? "run"] = run_anim_set;

anim_groups[? "press_jump"] = noone;
anim_sets[? "press_jump"] = simple_jump_anim_set;

anim_groups[? "press_jump_climb"] = noone;
anim_sets[? "press_jump_climb"] = jump_climb_anim_set;

/*
anim_groups[? "grab_ledge"] = noone;
anim_sets[? "grab_ledge"] = grab_ledge_anim_set;
*/

anim_groups[? "double_jump"] = noone;
anim_sets[? "double_jump"] = double_jump2_anim_set;

anim_groups[? "charged_jump_up"] = noone;
anim_sets[? "charged_jump_up"] = charged_jump_up_anim_set;

anim_groups[? "triple_jump"] = noone;
anim_sets[? "triple_jump"] = triple_jump_anim_set;

anim_groups[? "wall_climb"] = noone;
anim_sets[? "wall_climb"] = wall_climb_anim_set;

anim_groups[? "wall_jump"] = noone;
anim_sets[? "wall_jump"] = wall_jump_anim_set;

anim_groups[? "impact_mechanic"] = noone;
anim_sets[? "impact_mechanic"] = impact_mechanic_anim_set;

anim_groups[? "dive_jump"] = noone;
anim_sets[? "dive_jump"] = dive_jump_anim_set;

anim_groups[? "clear"] = noone;
anim_sets[? "clear"] = noone;

anim_group_count = ds_map_size(anim_groups);

nav_graph_create();

auto_init_waypoints = true;
auto_generate_nav_graph = false;
generate_nav_graph = true;

// TODO: can be triggered by event

var i;

for(i = 0; i <= gamemode_obj.player_count; i++)
{
    player_quest_start_command(i, "quick_tutorial_movement", "quick_tut_level1", "main");

    player_quests_recheck_command(i);

    //player_quest_log_printout(i);
}

alarm[1] = 6;
alarm[2] = 4;