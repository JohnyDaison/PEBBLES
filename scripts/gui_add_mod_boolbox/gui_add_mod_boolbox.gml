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
    }
    
    pane.get_value = method(pane, function() {
        return checkbox.get_value();
    });

    return pane;
}
