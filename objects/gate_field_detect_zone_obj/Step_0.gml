event_inherited();

var count, i, obj, instance, params;
var zone = id;

count = ds_list_size(detect_list);
for(i = count -1; i >= 0; i--)
{
    obj = detect_list[| i];

    with(obj)
    {
        instance = id;
        
        with(zone)
        {
            if(ds_list_find_index(inside_list, instance) == -1 && place_meeting(x,y, instance))
            {
                params = create_params_map();
                params[? "who"] = instance;
                
                broadcast_event("gatezone_close", zone, params);
            
                ds_list_add(inside_list, instance);
            }
        }
    }
}

count = ds_list_size(inside_list);
for(i = count -1; i >= 0; i--)
{
    instance = inside_list[| i];
    if(!place_meeting(x,y, instance))
    {
        ds_list_delete(inside_list, i);
        
        params = create_params_map();
        params[? "who"] = instance;
        
        broadcast_event("gatezone_open", zone, params);
    }
}
