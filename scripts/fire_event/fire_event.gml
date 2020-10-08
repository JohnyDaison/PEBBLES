/// @description fire_event(target, event, source, [event_params_map])
/// @function fire_event
/// @param target
/// @param  event
/// @param  source
/// @param  [event_params_map]
function fire_event() {
	var target = argument[0];
	var event = argument[1];
	var source = argument[2];
	var params = undefined;

	if(argument_count > 3)
	{
	    params = argument[3];
	}

	var event_subscriptions, subscription, count, i, fired = 0;


	if(!is_undefined(event_manager.subscriptions[? event]))
	{
	    event_subscriptions = event_manager.subscriptions[? event];
    
	    count = ds_list_size(event_subscriptions);
    
	    for(i = count - 1; i >= 0; i--)
	    {
	        subscription = event_subscriptions[| i];

	        if((target == all
	            || ( object_exists(target) && object_is_child(subscription[? "subscriber"], target))
	            || subscription[? "subscriber"] == target)
            
	        && (subscription[? "source"] == all
	            || (object_exists(subscription[? "source"]) && object_is_child(source, subscription[? "source"]))
	            || subscription[? "source"] == source))
	        {
	            with(subscription[? "subscriber"])
	            {
	                script_execute(subscription[? "script"], event, source, subscription[? "context"], params);
	            }
            
	            fired++;
	        }
	    }
	}

	return fired;



}
