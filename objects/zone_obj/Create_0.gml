event_inherited();

triggerable = true;
trigger_script = empty_script;
triggered = false;
triggerables = ds_list_create();
trigger_targets = ds_list_create();

detect_list = ds_list_create();
inside_list = ds_list_create();

zone_id = "";
in_group = false;
group_id = "zones";

zone_debug_tint = c_white;
