event_inherited();

var count = ds_list_size(detect_list), obj;

for(i = count -1; i >= 0; i--)
{
    obj = detect_list[| i];

    with(obj)
    {
        with(other)
        {
            if(ds_list_find_index(inside_list, other.id) == -1 && place_meeting(x,y, other.id))
            {
                var log_str = "GATE FIELD ZONE " + zone_id + " ";
                /*
                if(trigger_script == trigger_target_script)
                {
                    log_str += "trigger_target fired by" + string(other.id);
                    script_execute(trigger_script, other.id);
                }
                else
                {
                    log_str += "trigger fired by" + string(other.id);
                    trigger(id, other.id);
                }
                */
                params = ds_map_create();
                params[? "who"] = other.id;
                register_ds("params", ds_type_map, params, id);
                broadcast_event("gatezone_close", id, params);
            
                //my_console_log(log_str);
            
                ds_list_add(inside_list, other.id);
            }
        }
    }

}

var count = ds_list_size(inside_list);

for(i = count -1; i >= 0; i--)
{
    inst = inside_list[| i];
    if(!place_meeting(x,y, inst))
    {
        ds_list_delete(inside_list, i);
        
        params = ds_map_create();
        params[? "who"] = inst;
        register_ds("params", ds_type_map, params, id);
        broadcast_event("gatezone_open", id, params);
    }
}

