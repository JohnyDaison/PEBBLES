action_inherited();
trigger_group_id = "display_test/triggers";
trigger_group = noone;
anim_groups = ds_map_create();
anim_sets = ds_map_create();
active_display_group = noone;

anim_groups[? "display_test"] = noone;
anim_sets[? "display_test"] = display_test_anim_set;

anim_groups[? "clear"] = noone;
anim_sets[? "clear"] = noone;

anim_group_count = ds_map_size(anim_groups);

alarm[1]=2;

