event_inherited();

trigger_group_id = "catalyst_tut/triggers";
trigger_group = noone;
anim_groups = ds_map_create();
anim_sets = ds_map_create();
active_display_group = noone;

anim_groups[? "normal_shot"] = noone;
anim_sets[? "normal_shot"] = normal_shot_anim_set;

anim_groups[? "aim_shot"] = noone;
anim_sets[? "aim_shot"] = aim_shot_anim_set;

anim_groups[? "clear"] = noone;
anim_sets[? "clear"] = noone;

anim_group_count = ds_map_size(anim_groups);

alarm[1] = 2;

