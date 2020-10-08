/// @function regenerate_nav_graph([steps_to_wait], [remove_redundancy])
/// @param [steps_to_wait]
/// @param [remove_redundancy]
function regenerate_nav_graph() {
	var steps_to_wait = 2;
	var remove_redundancy = false;

	if(argument_count > 0)
	{
	    steps_to_wait = argument[0];
	}

	if(argument_count > 1)
	{
	    remove_redundancy = argument[1];
	}

	var result = false;

	if(instance_exists(place_controller_obj) && place_controller_obj.auto_generate_nav_graph)
	{
	    place_controller_obj.generate_nav_graph = true;
	    if(!is_undefined(remove_redundancy))
	    {
	        place_controller_obj.remove_redundancy = remove_redundancy;
	    }
	    place_controller_obj.alarm[2] = steps_to_wait;
    
	    result = true;
	}

	return result;



}
