function number_rule_change_value_script() {
    var gmrule_customs = play_menu_window.gmrule_customs;
    var rule_control = play_menu_window.gmrule_controls[? gmrule_id];
    
    gmrule_customs[? gmrule_id] = rule_control.get_value();
    schedule_play_summary_update();
}