/// @description fire_event(target, event, source, [event_params_map])
/// @function fire_event
/// @param target
/// @param event
/// @param source
/// @param [event_params_map]
function fire_event(target, event, source, params = undefined) {
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
                    if (!is_undefined(subscription[? "script"])) {
                        script_execute(subscription[? "script"], event, source, subscription[? "context"], params);
                    } else if (is_method(subscription[? "method"])) {
                        var handler_method = subscription[? "method"];
                        handler_method(event, source, subscription[? "context"], params);
                    }
                }
            
                fired++;
            }
        }
    }

    return fired;
}
