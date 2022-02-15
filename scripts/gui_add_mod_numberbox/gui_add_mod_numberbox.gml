function gui_add_mod_numberbox(xx, yy, gmmod_id, size) {
    var gmmod = DB.gamemode_mods[? gmmod_id];
    
    var pane = gui_add_pane(0, 0, "");
    
    with(pane) {
        var spacing = 8;
        eloffset_x = x + spacing;
        eloffset_y = y + spacing;
        
        self.gmmod_id = gmmod_id;
        
        checkbox = gui_add_mod_checkbox(0, 0, gmmod_id, size);
        number_input = gui_add_int_input(checkbox.width + 30, checkbox.height / 2, gmmod[? "default_value"], gmmod[? "min_value"], gmmod[? "max_value"]);
        number_input.value_step = gmmod[? "value_step"];
        number_input.gmmod_id = gmmod_id;
        
        default_value = false;
        default_bg_color = bg_color;
        customized_bg_color = c_yellow;
        bg_alpha = 0.3;
        
        with (number_input) {
            event_perform(ev_alarm, 0);
            alarm[0] = -1;
        }
        
        width = checkbox.width + number_input.width + 2.5 * spacing;
        height = checkbox.height + 2 * spacing;
        centered = true;
    
        get_value = function() {
            if (checkbox.checked) {
                return number_input.value;
            } else {
                return undefined;
            }
        }
    
        set_value = function(value, custom, forced) {
            var value_is_bool = is_bool(value);
            var value_is_number = is_number(value);
            
            with(checkbox) {
                if (forced) {
                    locked = true;
                }
                if (value_is_bool) {
                    gui_checkbox_script(value);
                } else {
                    gui_checkbox_script(true);
                }
            }
            
            if (custom && get_value() != default_value) {
                bg_color = customized_bg_color;
            }
            
            if (forced && value_is_bool) {
                var gmmod = DB.gamemode_mods[? gmmod_id];
                if (!value || (value && get_value() == gmmod[? "default_value"])) {
                    bg_color = default_bg_color;
                }
            }
            
            if (value_is_number) {
                number_input.set_value(value, true);
                if (forced) {
                    bg_color = default_bg_color;
                }
            }
            
            if (checkbox.checked) {
                number_input.locked = false;
            }
            
            if (forced && (value_is_number || value == false)) {
                number_input.locked = true;
            }
        }
    
        reset_value = function() {
            var gmmod = DB.gamemode_mods[? gmmod_id];
            
            bg_color = default_bg_color;
            
            with(checkbox) {
                locked = false;
                gui_checkbox_script(false);
            }
            
            number_input.locked = true;
            number_input.set_value(gmmod[? "default_value"], true);
        }
    }

    return pane;
}
