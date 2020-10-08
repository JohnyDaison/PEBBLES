ds_map_destroy(anim_groups);
ds_map_destroy(anim_sets);

unsubscribe_event("zone_enter", quick_basic_combat_event_script);
unsubscribe_event("mob_spawn", quick_basic_combat_event_script);

event_inherited();
