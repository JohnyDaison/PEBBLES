/// @param [new_state]
function command_infocursor_toggle() {
    var tool_obj = infocursor_tool_obj;
    var state = instance_exists(tool_obj) && tool_obj.active;
    var new_state = !state;

    if (argument_count > 0)
    {
        new_state = argument[0];
    }

    if (new_state != state) {
        if (!state && new_state) {
            tool_activate(tool_obj);
        } else {
            tool_deactivate(tool_obj);
        }
    }
    
    return new_state;
}
