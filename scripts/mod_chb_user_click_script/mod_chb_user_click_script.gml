function mod_chb_user_click_script() {
    var gmmod_customs = play_menu_window.gamemode_pane.gmmod_customs;
    var custom_value = gmmod_customs[? gmmod_id];
    var gmmod = DB.gamemode_mods[? gmmod_id];
    var mod_control = play_menu_window.gamemode_pane.gmmod_controls[? gmmod_id];
    var control_value = mod_control.get_value();
        
    if (gmmod[? "type"] == "bool") {
        if (is_undefined(custom_value)) {
            var mod_control = play_menu_window.gamemode_pane.gmmod_controls[? gmmod_id];
            gmmod_customs[? gmmod_id] = mod_control.get_value();
        } else {
            ds_map_delete(gmmod_customs, gmmod_id);
        }
    } else if (gmmod[? "type"] == "number") {
        if (control_value == mod_control.default_value) {
            ds_map_delete(gmmod_customs, gmmod_id);
        } else if (is_undefined(control_value)) {
            gmmod_customs[? gmmod_id] = false;
        } else {
            gmmod_customs[? gmmod_id] = control_value;
        }
    }
    
    script_execute(onmouseover_script);
}
