/// @description touch_event(event);
/// @function touch_event
/// @param event
function touch_event() {
	var event = argument[0];

	if(event != "" && is_undefined(event_manager.subscriptions[? event]))
	{
	    event_manager.subscriptions[? event] = ds_list_create();
	    ds_list_add(event_manager.event_list, event);
	}



}
