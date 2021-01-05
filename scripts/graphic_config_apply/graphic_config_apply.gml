function graphic_config_apply() {
    var gswindow = graphic_settings_window.id;
    var gui_list = gswindow.gui_content;

    singleton_obj.fullscreen = gswindow.fullscreen_checkbox.checked;
    singleton_obj.draw_object_labels = gswindow.labels_checkbox.checked;
    singleton_obj.scale_up_gui = gswindow.scale_gui_checkbox.checked;
    singleton_obj.force_feedback = gswindow.ff_checkbox.checked;
    singleton_obj.game_speed = gswindow.gamespeed_input.value; // clamp(gswindow.gamespeed_input.value,30,60);
    DB.npc_speech_tick = (DB.max_npc_speech_tick + 1) - gswindow.speechspeed_input.value;
    update_master_volume(gswindow.master_volume_input.value);

    var res_list = gswindow.resolution_picker.scroll_list.id;

    var res = res_list.items[| res_list.cur_item];

    var xpos = string_pos("x", res);
    var res_width = real(string_copy(res, 1, xpos - 1));
    var res_height = real(string_copy(res, xpos + 1, string_length(res) - xpos));

    with(singleton_obj)
    {
        windowed_width = res_width;
        windowed_height = res_height;
    
        fullscreen_width = res_width;
        fullscreen_height = res_height;
    }

    singleton_obj.aa_level = gswindow.aa_input.value;
    singleton_obj.interpolate_menu = gswindow.interpolate_menu_checkbox.checked;
    singleton_obj.interpolate_game = gswindow.interpolate_game_checkbox.checked;
    singleton_obj.vsync = gswindow.vsync_checkbox.checked;

    singleton_obj.display_updated = false;
    update_display();

    with(gswindow)
    {
        x = view_wport[0]/2 - self.width/2;
        y = view_hport[0]/2 - self.height/2;   
    }


}
