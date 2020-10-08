/// @description is_shielded(who, [modifier])
/// @function is_shielded
/// @param who
/// @param  [modifier]
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
	        //TODO: This should be decided from status effect, not abi script
	        if(object_is_ancestor(who.object_index, guy_obj))
	        {
	            ret = (who.abi_script[? g_purple] != empty_script);
	        }
	        else
	        {
	            ret = (who.my_shield.charge > who.my_shield.max_charge);
	        }
	    }
	    else
	    {
	        ret = true;
	    }
	}

	return ret;



}
