function rule_chb_user_click_script() {
    var gmrule_customs = play_menu_window.gmrule_customs;
    var gmmod = DB.gamemode_rules[? gmrule_id];
    var rule_control = play_menu_window.gmrule_controls[? gmrule_id];
    var control_value = rule_control.get_value();
        
    if (gmmod[? "type"] == "bool") {
        if (control_value == rule_control.default_value) {
            ds_map_delete(gmrule_customs, gmrule_id);
        } else {
            gmrule_customs[? gmrule_id] = control_value;
        }
    } else if (gmmod[? "type"] == "number") {
        if (control_value == rule_control.default_value) {
            ds_map_delete(gmrule_customs, gmrule_id);
        } else if (is_undefined(control_value)) {
            gmrule_customs[? gmrule_id] = false;
        } else {
            gmrule_customs[? gmrule_id] = control_value;
        }
    }
    
    script_execute(onmouseover_script);
}
