/// @param {String} event
/// @param {Id.Instance} source
/// @param {Id.DsMap<Any>} [event_params_map]
/// @return {Real} How many subscriptions to the event actually fired
function broadcast_event(event, source, event_params_map = undefined) {
    return fire_event(all, event, source, event_params_map);
}
