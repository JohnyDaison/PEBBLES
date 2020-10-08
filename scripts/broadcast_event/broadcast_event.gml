/// @description broadcast_event(event, source, [event_params_map])
/// @function broadcast_event
/// @param event
/// @param source
/// @param [event_params_map]
function broadcast_event() {
	if(argument_count > 2)
	{
	    fire_event(all, argument[0], argument[1], argument[2]);
	}
	else
	{
	    fire_event(all, argument[0], argument[1]);
	}



}
