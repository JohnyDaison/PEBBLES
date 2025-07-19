/// @description list_event_subscriptions()
/// @function list_event_subscriptions
function list_event_subscriptions() {

    var event_count = ds_list_size(event_manager.event_list);
    var ev_i, event, sub_i, sub_count, subscriber, subscriber_str, script_str, method_str, source, source_str, final_str;
    var event_subscriptions, subscription;

    for(ev_i = 0; ev_i < event_count; ev_i++)
    {
        event = event_manager.event_list[| ev_i];
    
        if(ev_i != 0)
        {
            console_divider_level("-", 3);
        }
        my_console_write(event + ":");
    
        event_subscriptions = event_manager.subscriptions[? event];
    
        sub_count = ds_list_size(event_subscriptions);
    
        for(sub_i = sub_count - 1; sub_i >= 0; sub_i--)
        {
            subscription = event_subscriptions[| sub_i];
        
            subscriber = subscription[? "subscriber"];
            subscriber_str = string(subscriber);
            subscriber_str += "(" + object_get_name(subscriber.object_index) + ")";
        
            if (!is_undefined(subscription[? "script"])) {
                script_str = script_get_name(subscription[? "script"]);
            }
            else if (!is_undefined(subscription[? "method"])) {
                script_str = script_get_name(method_get_index(subscription[? "method"]));
            }
            
            source = subscription[? "source"];
            if(source == all)
            {
                source_str = "all";
            }
            else
            {
                if(!object_exists(source) && instance_exists(source))
                {
                    source_str = string(source);
                    source_str += "(" + object_get_name(source.object_index) + ")";
                }
                else if(object_exists(source))
                {
                    source_str += object_get_name(source);
                }
            }
        
            final_str = subscriber_str + " " + script_str + " " + source_str + " " + string(subscription[? "context"]);
        
            my_console_write(final_str);
        }
    }

    return event_count;
}
