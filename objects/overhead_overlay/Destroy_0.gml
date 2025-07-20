ds_map_destroy(last_orbs);
ds_map_destroy(orb_light);

ds_map_destroy(status_order);
ds_map_destroy(status_card_visible);
ds_map_destroy(status_last_active);

group_count = ds_map_size(abi_groups);
for(var i = 1; i <= group_count; i++)
{
    ds_map_destroy(abi_groups[? i]);
}
ds_map_destroy(abi_groups);

ds_map_destroy(show_belt);
for(var col = g_dark; col <= g_blue; col++)
{
    if(col != g_yellow)
    {
        ds_list_destroy(belt_list[? col]);
    }   
}
ds_map_destroy(belt_list);
ds_list_destroy(left_side_belt_order);
ds_list_destroy(right_side_belt_order);

event_inherited();
