action_inherited();
trigger_group_id = "movement_tut/triggers";
trigger_group = noone;

anim_groups = ds_map_create();
anim_sets = ds_map_create();
active_display_group = noone;

anim_groups[? "press_jump"] = noone;
anim_sets[? "press_jump"] = simple_jump_anim_set;

anim_groups[? "grab_ledge"] = noone;
anim_sets[? "grab_ledge"] = grab_ledge_anim_set;

anim_groups[? "double_jump"] = noone;
anim_sets[? "double_jump"] = double_jump_anim_set;

anim_groups[? "triple_jump"] = noone;
anim_sets[? "triple_jump"] = triple_jump_anim_set;

anim_groups[? "charged_jump"] = noone;
anim_sets[? "charged_jump"] = charged_jump_anim_set;

anim_groups[? "charged_jump_up"] = noone;
anim_sets[? "charged_jump_up"] = charged_jump_up_anim_set;

anim_groups[? "wall_climb"] = noone;
anim_sets[? "wall_climb"] = wall_climb_anim_set;

anim_groups[? "wall_jump"] = noone;
anim_sets[? "wall_jump"] = wall_jump_anim_set;

anim_groups[? "clear"] = noone;
anim_sets[? "clear"] = noone;

anim_group_count = ds_map_size(anim_groups);

nav_graph_create();

move_mountain_nav_graph();

// TODO: multiple players, can be triggered by event

var i, count = ds_map_size(gamemode_obj.players);

for(i = 0; i < count; i++)
{
    player_quest_start_command(i, "tutorial_movement", "tut_level1", "main");

    player_quests_recheck_command(i);

    //player_quest_log_printout(i);
}

alarm[1]=2;