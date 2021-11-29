function number_mod_change_value_script() {
    var gmmod_customs = play_menu_window.gamemode_pane.gmmod_customs;
    var mod_control = play_menu_window.gamemode_pane.gmmod_controls[? gmmod_id];
    
    gmmod_customs[? gmmod_id] = mod_control.get_value();
    schedule_play_summary_update();
}