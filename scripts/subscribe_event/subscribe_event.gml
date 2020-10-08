/// @description subscribe_event(event, script, [source, context])
/// @function subscribe_event
/// @param event
/// @param  script
/// @param  [source
/// @param  context]
function subscribe_event() {
	var event = argument[0];
	var script = argument[1];
	var source = all;
	var context = "";

	if(argument_count > 2)
	{
	    source = argument[2];
	}

	if(argument_count > 3)
	{
	    context = argument[3];
	}

	var event_subscriptions, subscription
	var result = false;


	touch_event(event);

	event_subscriptions = event_manager.subscriptions[? event];

	if(!is_undefined(event_subscriptions))
	{
	    subscription = ds_map_create();
	    subscription[? "subscriber"] = id;
	    subscription[? "script"] = script;
	    subscription[? "source"] = source;
	    subscription[? "context"] = context;
    
	    ds_list_add(event_subscriptions, subscription);
	    result = true;
	}

	return result;



}
