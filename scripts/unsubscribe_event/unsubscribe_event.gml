/// @description unsubscribe_event(event, script, [source])
/// @function unsubscribe_event
/// @param event
/// @param  script
/// @param  [source]
function unsubscribe_event() {
	var event = argument[0];
	var script = argument[1];
	var source = all;

	if(argument_count > 2)
	{
	    source = argument[2];
	}

	var event_subscriptions, subscription, count, i, deleted = 0;


	if(!is_undefined(event_manager.subscriptions[? event]))
	{
	    event_subscriptions = event_manager.subscriptions[? event];
    
	    count = ds_list_size(event_subscriptions);
    
	    for(i = count - 1; i >= 0; i--)
	    {
	        subscription = event_subscriptions[| i];
        
	        if( subscription[? "subscriber"] == id
	        && (subscription[? "script"] == script || script == "all")
	        && (subscription[? "source"] == source || source == "all") )
	        {
	            ds_list_delete(event_subscriptions, i);
	            deleted++;
	        }
	    }
	}

	return deleted;



}
