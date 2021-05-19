event_inherited();

trigger_group_id = "color_orb_tut/triggers";
trigger_group = noone;

anim_groups = ds_map_create();
anim_sets = ds_map_create();
active_display_group = noone;

anim_groups[? "color_belts"] = noone;
anim_sets[? "color_belts"] = color_belts_anim_set;

anim_groups[? "weak_effect"] = noone;
anim_sets[? "weak_effect"] = weak_effect_anim_set;

anim_groups[? "strong_effect"] = noone;
anim_sets[? "strong_effect"] = strong_effect_anim_set;

anim_groups[? "cant_reach"] = noone;
anim_sets[? "cant_reach"] = cant_reach_anim_set;

anim_groups[? "slime_pit"] = noone;
anim_sets[? "slime_pit"] = slime_pit_anim_set;

anim_groups[? "green_orb_label"] = noone;
anim_sets[? "green_orb_label"] = green_orb_label_anim_set;

anim_groups[? "orb_green"] = noone;
anim_sets[? "orb_green"] = orb_green_anim_set;

anim_groups[? "orb_green_confirm"] = noone;
anim_sets[? "orb_green_confirm"] = press_cast_anim_set;

anim_groups[? "green_charged_jump"] = noone;
anim_sets[? "green_charged_jump"] = green_charged_jump_anim_set;

anim_groups[? "orb_blue"] = noone;
anim_sets[? "orb_blue"] = orb_blue_anim_set;

anim_groups[? "blast_turret"] = noone;
anim_sets[? "blast_turret"] = blast_turret_anim_set;

anim_groups[? "pressure_plate"] = noone;
anim_sets[? "pressure_plate"] = pressure_plate_anim_set;

anim_groups[? "orb_red"] = noone;
anim_sets[? "orb_red"] = orb_red_anim_set;

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
    player_quest_start_command(i, "quick_tutorial_base_colors", "quick_tut_level2", "main");

    player_quests_recheck_command(i);

    //player_quest_log_printout(i);
}

alarm[1] = 6;
alarm[2] = 4;

