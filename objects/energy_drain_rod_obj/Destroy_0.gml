ds_map_destroy(enabled);
ds_list_destroy(drainables);
ds_list_destroy(potential_targets);
ds_list_destroy(potential_drain_rods);
ds_map_destroy(nearest_drain_target);

for(dir = 0; dir < 4; dir++)
{
    var list = drain_target_list[? dir];
    ds_list_destroy(list);
}
ds_map_destroy(drain_target_list);

action_inherited();
