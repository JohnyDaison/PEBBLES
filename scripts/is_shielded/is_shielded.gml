/// @description is_shielded(who, [modifier])
/// @function is_shielded
/// @param who
/// @param [modifier]
function is_shielded() {
    var who = argument[0];
    var modifier = "";
    if(argument_count > 1)
    {
        modifier = argument[1];
    }

    var ret = false;

    if(instance_exists(who) && instance_exists(who.my_shield) && !who.my_shield.done_for)
    {
        if(modifier == "uber")
        {
            if(object_is_ancestor(who.object_index, guy_obj))
            {
                ret = (who.status_left[? "ubershield"] > 0);
            }
        }
        else
        {
            ret = true;
        }
    }

    return ret;
}
