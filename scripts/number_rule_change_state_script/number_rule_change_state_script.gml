function number_rule_change_state_script() {
    var rule_control = play_menu_window.gmrule_controls[? gmrule_id];
    
    rule_control.number_input.locked = !rule_control.checkbox.checked;
    
    schedule_play_summary_update();
}