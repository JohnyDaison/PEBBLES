/// @description list_instances([object])
/// @function list_instances
/// @param [object]
function list_instances() {
    var object = noone;

    if(argument_count > 0)
    {
        object = argument[0];   
    }

    var count = 0;
    // if no object specified, show objectmap keys
    if(object == noone)
    {
        var key = ds_map_find_first(DB.objectmap);
    
        while(!is_undefined(key))
        {
            my_console_write(string(key));
        
            key = ds_map_find_next(DB.objectmap, key);
        }
    }
    else
    {
        // show list of instances of given object
        with(object)
        {
            my_console_write(string(id)+ " " +object_get_name(object_index));
            count++;
        }   
    }

    return count;
}
