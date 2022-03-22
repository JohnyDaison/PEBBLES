/// @description broadcast_event(event, source, [event_params_map])
/// @function broadcast_event
/// @param event
/// @param source
/// @param [event_params_map]
function broadcast_event(event, source, params = undefined) {
    fire_event(all, event, source, params);
}
