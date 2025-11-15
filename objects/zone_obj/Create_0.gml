event_inherited();

self.triggerable = true;
self.trigger_script = empty_script;
self.triggerables = ds_list_create();
self.trigger_targets = ds_list_create();

self.detect_list = ds_list_create();
self.inside_list = ds_list_create();

self.zone_id = "";
self.in_group = false;
self.group_id = "zones";

self.zone_debug_tint = c_white;
