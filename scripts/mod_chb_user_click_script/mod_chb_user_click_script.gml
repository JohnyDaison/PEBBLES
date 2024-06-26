function mod_chb_user_click_script() {
    var gmmod_customs = play_menu_window.gmmod_customs;
    var gmmod = DB.gamemode_mods[? gmmod_id];
    var mod_control = play_menu_window.gmmod_controls[? gmmod_id];
    var control_value = mod_control.get_value();
        
    if (gmmod[? "type"] == "bool") {
        if (control_value == mod_control.default_value) {
            ds_map_delete(gmmod_customs, gmmod_id);
        } else {
            gmmod_customs[? gmmod_id] = control_value;
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
