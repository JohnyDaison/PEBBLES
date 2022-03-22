function unsubscribe_event(event, handler = all, source = all) {
    var event_subscriptions, subscription, count, i, deleted = 0;
    
    if(!is_undefined(event_manager.subscriptions[? event]))
    {
        event_subscriptions = event_manager.subscriptions[? event];
    
        count = ds_list_size(event_subscriptions);
    
        for(i = count - 1; i >= 0; i--)
        {
            subscription = event_subscriptions[| i];
        
            if (subscription[? "subscriber"] == id
            && (handler == all || subscription[? "script"] == handler || subscription[? "method"] == handler)
            && (source == all || subscription[? "source"] == source) )
            {
                ds_list_delete(event_subscriptions, i);
                deleted++;
            }
        }
    }

    return deleted;
}
