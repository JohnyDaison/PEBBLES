function subscribe_event(event, handler, source = all, context = "") {
    var event_subscriptions, subscription;
    var result = false;

    touch_event(event);

    event_subscriptions = event_manager.subscriptions[? event];

    if(!is_undefined(event_subscriptions))
    {
        subscription = ds_map_create();
        subscription[? "subscriber"] = id;
        if (is_method(handler)) {
            subscription[? "method"] = handler;
        } else {
            subscription[? "script"] = handler;
        }
        
        subscription[? "source"] = source;
        subscription[? "context"] = context;
    
        ds_list_add(event_subscriptions, subscription);
        result = true;
    }

    return result;
}
