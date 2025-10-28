function gui_add_rule_numberbox(xx, yy, gmrule_id, size) {
    var gmRule = DB.gamemode_rules[? gmrule_id];
    
    var pane = gui_add_pane(0, 0, "");
    
    with(pane) {
        var spacing = 9;
        eloffset_x = x + spacing;
        eloffset_y = y + spacing;
        
        self.gmrule_id = gmrule_id;
        
        checkbox = gui_add_rule_checkbox(0, 0, gmrule_id, size);
        
        var num_x = checkbox.width + checkbox.thick_border_size + size / 2;
        var num_y = checkbox.height / 2;
        
        number_input = gui_add_int_input(num_x, num_y, gmRule[? "default_value"], gmRule[? "min_value"], gmRule[? "max_value"]);
        number_input.value_step = gmRule[? "value_step"];
        number_input.gmrule_id = gmrule_id;
        number_input.custom_width = true;
        number_input.width = size;
        number_input.draw_thick_border = true;
        number_input.thick_border_size = checkbox.thick_border_size;
        number_input.base_bg_color = checkbox.checked_bg_color;
        number_input.bg_color = number_input.base_bg_color;
        number_input.disabled_color = checkbox.unchecked_bg_color;
        
        
        default_value = false;
        draw_bg_color = false;
        bg_color = c_yellow;
        bg_alpha = 0.8;
        
        with (number_input) {
            event_perform(ev_alarm, 0);
            alarm[0] = -1;
        }
        
        width = checkbox.width + checkbox.thick_border_size + number_input.width + 2 * spacing;
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
            
            if (value_is_number) {
                number_input.set_value(value, true);
            }
            
            if (custom && get_value() != default_value) {
                draw_bg_color = true;
            }
            
            number_input.base_border_color = checkbox.border_color;
            number_input.disabled_border_color = checkbox.border_color;
            
            if (forced && value_is_bool) {
                if (!value || (value && get_value() == default_value)) {
                    draw_bg_color = false;
                }
                
                if (value) {
                    number_input.base_border_color = checkbox.unlocked_border_color;
                    number_input.disabled_border_color = checkbox.unlocked_border_color;   
                }
                
                if (!play_menu_window.show_hidden_rules && !value) {
                   gui_hide_element(id);
                }
            }
            
            if (forced && value_is_number) {
                draw_bg_color = false;
                
                with (number_input) {
                    dial.bg_color = dial.base_bg_color;
                    dial.disabled_color = self.base_bg_color;
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
            var gmRule = DB.gamemode_rules[? gmrule_id];
            
            draw_bg_color = false;
            gui_show_element(id);
            
            with(checkbox) {
                locked = false;
                gui_checkbox_script(false);
            }
            
            number_input.locked = true;
            number_input.set_value(gmRule[? "default_value"], true);
            
            number_input.base_border_color = checkbox.border_color;
            number_input.disabled_border_color = checkbox.border_color;
            
            with (number_input) {
                dial.base_bg_color = self.base_bg_color;
                dial.disabled_color = self.disabled_color;
                
                if (locked) {
                    dial.bg_color = dial.disabled_color;
                } else {
                    dial.bg_color = dial.base_bg_color;
                }
            }
        }
    }

    return pane;
}
