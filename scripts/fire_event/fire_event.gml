/// @param {Id.Instance|Asset.GMObject|Constant.All} target
/// @param {String} event
/// @param {Id.Instance} source
/// @param {Id.DsMap<Any>} [event_params_map]
/// @return {Real} How many subscriptions to the event actually fired
function fire_event(target, event, source, event_params_map = undefined) {
    var event_subscriptions, subscription, count, i, fired = 0;

    if (!is_undefined(event_manager.subscriptions[? event])) {
        event_subscriptions = event_manager.subscriptions[? event];

        count = ds_list_size(event_subscriptions);

        for (i = count - 1; i >= 0; i--) {
            subscription = event_subscriptions[| i];

            if ((target == all
                || (object_exists(target) && object_is_child(subscription[? "subscriber"], target))
                || subscription[? "subscriber"] == target)

                && (subscription[? "source"] == all
                    || (object_exists(subscription[? "source"]) && object_is_child(source, subscription[? "source"]))
                    || subscription[? "source"] == source)) {
                with (subscription[? "subscriber"]) {
                    if (!is_undefined(subscription[? "script"])) {
                        script_execute(subscription[? "script"], event, source, subscription[? "context"], event_params_map);
                    } else if (is_method(subscription[? "method"])) {
                        var handler_method = subscription[? "method"];
                        handler_method(event, source, subscription[? "context"], event_params_map);
                    }
                }

                fired++;
            }
        }
    }

    return fired;
}
