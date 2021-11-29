function number_mod_change_state_script() {
    var mod_control = play_menu_window.gamemode_pane.gmmod_controls[? gmmod_id];
    
    mod_control.number_input.locked = !mod_control.checkbox.checked;
    
    schedule_play_summary_update();
}