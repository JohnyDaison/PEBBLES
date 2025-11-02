event_inherited();

self.trigger_group_id = "display_test/triggers";
self.trigger_group = noone;
self.anim_groups = ds_map_create();
self.anim_sets = ds_map_create();
self.active_display_group = noone;

self.anim_groups[? "display_test"] = noone;
self.anim_sets[? "display_test"] = display_test_anim_set;

self.anim_groups[? "clear"] = noone;
self.anim_sets[? "clear"] = noone;

self.anim_group_count = ds_map_size(self.anim_groups);

self.alarm[1] = 2;
