/// @description get_value_command(object, prop)
/// @function get_value_command
/// @param object
/// @param prop
function get_value_command() {
    var object = noone;
    var prop = undefined;

    if(argument_count > 0)
    {
        object = argument[0];   
    }
    
    if(argument_count > 1)
    {
        prop = argument[1];   
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
        
        return 0;
    }
    
    // no instances
    if(!instance_exists(object)) {
        my_console_write("No instance found.");
        return 0;
    }
    
    // if prop is undefined, show list of props
    if(prop == undefined) {
        var instance = noone;
        with(object) {
            if(object_index == object || id == object) {
                instance = id;
            }
        }
        
        var names = variable_instance_get_names(instance);
        array_sort(names, true);
        var count = variable_instance_names_count(instance);
    
        for(var i = 0; i < count; i++) {
            var name = names[i];
            my_console_write(name);
        }
        
        return 0;
    }

    // show value of prop for each of instances of given object
    with(object)
    {
        var result = "";
        var prop_exists = variable_instance_exists(id, prop);
        if(prop_exists) {
            result = variable_instance_get(id, prop);
                
            if(is_string(result)) {
                result = "\"" + result + "\"";
            } else {
                result = string(result);
            }
        }
            
        my_console_write(string(id) + " " + result);
        count++;
    }

    return count;
}
