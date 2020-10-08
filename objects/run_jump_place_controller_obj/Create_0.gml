action_inherited();
trigger_group_id = "run_jump/triggers";
trigger_group = noone;
anim_groups = ds_map_create();
anim_sets = ds_map_create();
active_display_group = noone;

anim_groups[? "simple_jump"] = noone;
anim_sets[? "simple_jump"] = simple_jump_anim_set;

anim_groups[? "charged_jump"] = noone;
anim_sets[? "charged_jump"] = charged_jump_anim_set;

anim_groups[? "charged_triple_jump"] = noone;
anim_sets[? "charged_triple_jump"] = charged_triple_jump_anim_set;

anim_groups[? "charged_wall_climb"] = noone;
anim_sets[? "charged_wall_climb"] = charged_wallclimb_anim_set;

anim_groups[? "clear"] = noone;
anim_sets[? "clear"] = noone;

anim_group_count = ds_map_size(anim_groups);

alarm[1]=2;

