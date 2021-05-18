event_inherited();

var count = ds_list_size(detect_list), obj, i, instance;
var zone = id;

for(i = count -1; i >= 0; i--)
{
    obj = detect_list[| i];

    with(obj)
    {
        instance = id;
        
        with(other)
        {
            if(ds_list_find_index(zone.inside_list, instance) == -1 && place_meeting(zone.x, zone.y, instance))
            {
                var log_str = "CONNECTOR ZONE " + zone.zone_id + " entered by " + instance.name;
                
                my_console_log(log_str);
            
                ds_list_add(zone.inside_list, instance);
            
                var params = ds_map_create();
                params[? "who"] = instance;
                register_ds("params", ds_type_map, params, id);
            
                broadcast_event("connector_enter", id, params);
                
                // TODO: this part should be somewhere else, 
                // reacting to guy leaving room while inside a connector
                {
                    var world = gamemode_obj.world;
                    var place_graph = world.place_graph;
                    var connection_id = place_graph.find_connection(zone.node_id);
                    var connection = place_graph.connections[? connection_id];
                    var to_node = place_graph.nodes[? connection.to];
                
                    world.next_place = to_node.place;
                
                    gamemode_obj.limit_reached = true;
                }
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

