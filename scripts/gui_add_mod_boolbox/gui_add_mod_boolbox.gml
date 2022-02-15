function gui_add_mod_boolbox(xx, yy, gmmod_id, size) {
    var pane = gui_add_pane(0, 0, "");
    
    with(pane) {
        var spacing = 8;
        eloffset_x = x + spacing;
        eloffset_y = y + spacing;
        
        checkbox = gui_add_mod_checkbox(0, 0, gmmod_id, size);
        
        default_value = false;
        default_bg_color = bg_color;
        customized_bg_color = c_yellow;
        bg_alpha = 0.3;
        
        width = checkbox.width + 2 * spacing;
        height = checkbox.height + 2 * spacing;
        centered = true;
    
        get_value = function() {
            return checkbox.get_value();
        }
        
        set_value = function(value, custom, forced) {
            with(checkbox)
            {
                if (forced) {
                    locked = true;
                }
                gui_checkbox_script(value);
            }
            
            if (custom && get_value() != default_value) {
                bg_color = customized_bg_color;
            }
            
            if (forced) {
                bg_color = default_bg_color;
            }
        }
        
        reset_value = function() {
            bg_color = default_bg_color;
            
            with(checkbox)
            {
                locked = false;
                gui_checkbox_script(false);
            }
        }
    }

    return pane;
}
