/// @description get_control_name(control, [control_obj])
/// @function get_control_name
/// @param control
/// @param [control_obj]
function get_control_name() {
    var control = argument[0];
    var obj = noone;
    var val = undefined;

    if(argument_count >= 2)
    {
        obj = argument[1];
    }
    else if(instance_exists(my_guy))
    {
        obj = my_guy.control_obj;   
    }


    if(instance_exists(obj))
    {
        if(control >= 0)
        {
            val = obj.binds[? control];
        
            if(val != undefined)
            {
                return get_const_name(obj.type, val);
            }
        }
        else if(control == directions)
        {
            return obj.directions_str;
        }
    }
    else
    {
        return "[INVALID CONTROL OBJ]";
    }

    if(val == undefined)
    {
        return "[INVALID CONTROL]";
    }
}
