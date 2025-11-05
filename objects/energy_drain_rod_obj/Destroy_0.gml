ds_map_destroy(self.enabled);
ds_list_destroy(self.drainables);
ds_list_destroy(self.potential_targets);
ds_list_destroy(self.potential_drain_rods);
ds_map_destroy(self.nearest_drain_target);

for(var dir = 0; dir < 4; dir++)
{
    var list = self.drain_target_list[? dir];
    
    ds_list_destroy(list);
}

ds_map_destroy(self.drain_target_list);

event_inherited();
