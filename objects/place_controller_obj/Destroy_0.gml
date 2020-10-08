if(nav_graph_exists)
{
    nav_graph_destroy();   
}

var i, key, list, count = ds_list_size(trigger_list);
for(i = count-1; i >= 0; i--)
{
    key = trigger_list[| i];
    list = trigger_map[? key];
    
    ds_list_destroy(list);
}

ds_list_destroy(trigger_list);
ds_map_destroy(trigger_map);

ds_list_destroy(item_list);

event_inherited();
