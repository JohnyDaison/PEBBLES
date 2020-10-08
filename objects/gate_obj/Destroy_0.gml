for(i=0; i<4; i++)
{
    if(instance_exists(field[? i]))
    {
        instance_destroy(field[? i]);
    }
}

for(i=0; i<4; i++)
{
    ds_list_destroy(tints[? i]);
}

ds_map_destroy(enabled);
ds_map_destroy(active);
ds_map_destroy(field);
ds_map_destroy(tints);

event_inherited();