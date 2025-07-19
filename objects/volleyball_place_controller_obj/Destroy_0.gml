unsubscribe_event("ballzone_enter", volleyball_event_script);
unsubscribe_event("player_death");
ds_map_destroy(player_colors);
ds_list_destroy(arena_colors);

event_inherited();