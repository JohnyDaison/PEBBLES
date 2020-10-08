if(read_terrain)
{
    ds_list_destroy(ter_list);
}

var i, count = ds_list_size(my_groups);
for(i = count - 1; i >= 0; i--)
{
    group_remove_member(my_groups[| i], id);
}

ds_list_destroy(my_groups);
ds_map_destroy(my_keys);
ds_map_destroy(transform_memory);

