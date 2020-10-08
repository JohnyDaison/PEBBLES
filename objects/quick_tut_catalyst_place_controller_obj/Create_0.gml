event_inherited();

trigger_group_id = "catalyst_tut/triggers";
trigger_group = noone;

anim_groups = ds_map_create();
anim_sets = ds_map_create();
active_display_group = noone;

anim_groups[? "choose_body_color"] = noone;
anim_sets[? "choose_body_color"] = choose_body_color_anim_set;

anim_groups[? "quick_shot"] = noone;
anim_sets[? "quick_shot"] = quick_shot_anim_set;

anim_groups[? "gate_closed"] = noone;
anim_sets[? "gate_closed"] = gate_closed_anim_set;

anim_groups[? "ricochet"] = noone;
anim_sets[? "ricochet"] = ricochet_anim_set;

anim_groups[? "yellow"] = noone;
anim_sets[? "yellow"] = yellow_confusion_anim_set;

anim_groups[? "open_gate_manual"] = noone;
anim_sets[? "open_gate_manual"] = color_wheel_90gate_anim_set;

anim_groups[? "cyan"] = noone;
anim_sets[? "cyan"] = cyan_bounce_anim_set;

anim_groups[? "magenta"] = noone;
anim_sets[? "magenta"] = magenta_suppression_anim_set;

anim_groups[? "aim_shot"] = noone;
anim_sets[? "aim_shot"] = aim_shot_anim_set;

anim_groups[? "use_item"] = noone;
anim_sets[? "use_item"] = use_item1_anim_set;

anim_groups[? "octarine"] = noone;
anim_sets[? "octarine"] = octarine_disable_anim_set;

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
    player_quest_start_command(i, "quick_tutorial_catalyst", "quick_tut_level3", "main");

    player_quests_recheck_command(i);

    //player_quest_log_printout(i);
}

alarm[1] = 6;
alarm[2] = 4;

