/// @description zone_trigger_script
function zone_trigger_script(argument0, argument1) {
	var arg_count = argument0;
	var args = argument1;

	var i, count = ds_list_size(my_groups), group, detected_object = noone;

	if(arg_count > 0)
	{
	    detected_object = args[0];
	}

	for (i=0; i<count; i++)
	{
	    group = my_groups[| i];
	    key = my_keys[? group];
	    if(key != "")
	    {
	        /*if(instance_exists(detected_object))
	        {*/
	            trigger(place_controller_obj, key, detected_object);
	            /*
	        }
	        else
	        {
	            trigger(place_controller_obj, key);
	        }*/
	    }    
	}



}
