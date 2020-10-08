action_inherited();
trigger_group_id = "color_orb_tut/triggers";
trigger_group = noone;

anim_groups = ds_map_create();
anim_sets = ds_map_create();
active_display_group = noone;

anim_groups[? "orb_green"] = noone;
anim_sets[? "orb_green"] = orb_green_anim_set;

anim_groups[? "orb_green_confirm"] = noone;
anim_sets[? "orb_green_confirm"] = press_cast_anim_set;

anim_groups[? "orb_blue"] = noone;
anim_sets[? "orb_blue"] = orb_blue_anim_set;

anim_groups[? "orb_red"] = noone;
anim_sets[? "orb_red"] = orb_red_anim_set;

anim_groups[? "clear"] = noone;
anim_sets[? "clear"] = noone;

anim_group_count = ds_map_size(anim_groups);

alarm[1]=2;

