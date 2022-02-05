function gui_add_mod_numberbox(xx, yy, gmmod_id, size) {
    var gmmod = DB.gamemode_mods[? gmmod_id];
    
    var pane = gui_add_pane(0, 0, "");
    
    with(pane) {
        var spacing = 8;
        eloffset_x = x + spacing;
        eloffset_y = y + spacing;
        
        checkbox = gui_add_mod_checkbox(0, 0, gmmod_id, size);
        checkbox.gmmod_id = gmmod_id;
        number_input = gui_add_int_input(checkbox.width + 30, checkbox.height / 2, gmmod[? "default_value"], gmmod[? "min_value"], gmmod[? "max_value"]);
        number_input.value_step = gmmod[? "value_step"];
        number_input.gmmod_id = gmmod_id;
        
        default_value = false;
        
        with (number_input) {
            event_perform(ev_alarm, 0);
            alarm[0] = -1;
        }
        
        width = checkbox.width + number_input.width + 2.5 * spacing;
        height = checkbox.height + 2 * spacing;
        centered = true;
    }
    
    pane.get_value = method(pane, function() {
        if (checkbox.checked) {
            return number_input.value;
        } else {
            return undefined;
        }
    });

    return pane;
}
