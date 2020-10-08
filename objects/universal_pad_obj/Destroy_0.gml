ds_map_destroy(ready_power);
ds_map_destroy(recharge_speed);
ds_map_destroy(deactivate_power);

ds_list_destroy(meeting_guys_list);
ds_list_destroy(blinked_guys_list);
/*
with(glow_obj)
{
    instance_destroy();
}
*/

event_inherited();
