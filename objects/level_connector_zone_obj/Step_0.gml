event_inherited();

var count = ds_list_size(detect_list), obj, i, instance;

for(i = count -1; i >= 0; i--)
{
    obj = detect_list[| i];

    with(obj)
    {
        instance = id;
        
        with(other)
        {
            if(ds_list_find_index(inside_list, instance) == -1 && place_meeting(x,y, instance))
            {
                var log_str = "CONNECTOR ZONE " + zone_id + " entered by " + instance.name;
            
                params = ds_map_create();
                params[? "who"] = instance;
                register_ds("params", ds_type_map, params, id);
            
                broadcast_event("connector_enter", id, params);
            
                var connection = world_obj.place_graph.connections[? connection_id];
                
                world_obj.next_place = world_obj.place_graph.nodes[? connection.to];
                
                gamemode_obj.limit_reached = true;
                
                my_console_log(log_str);
            
                ds_list_add(inside_list, instance);
            }
        }
    }

}

var count = ds_list_size(inside_list);

for(i = count -1; i >= 0; i--)
{
    var inst = inside_list[| i];
    if(!place_meeting(x,y, inst))
    {
        ds_list_delete(inside_list, i);
    }
}

