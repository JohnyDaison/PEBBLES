function graphic_config_OK() {
    ini_open("pebbles_settings.ini");
    ini_write_real("Graphics", "fullscreen", singleton_obj.fullscreen);
    ini_write_real("Graphics", "draw_object_labels", singleton_obj.draw_object_labels);
    ini_write_real("Graphics", "scale_up_gui", singleton_obj.scale_up_gui);
    ini_write_string("Graphics", "resolution", string(singleton_obj.windowed_width) + "x" + string(singleton_obj.windowed_height));
    ini_write_real("Graphics", "vsync", singleton_obj.vsync);
    ini_write_real("Graphics", "aa_level", singleton_obj.aa_level);
    ini_write_real("Graphics", "interpolate_menu", singleton_obj.interpolate_menu);
    ini_write_real("Graphics", "interpolate_game", singleton_obj.interpolate_game);

    ini_write_real("Sound", "master_volume", singleton_obj.master_volume);
    ini_write_real("Game", "game_speed", singleton_obj.game_speed);
    ini_write_real("Game", "force_feedback", singleton_obj.force_feedback);
    ini_write_real("Game", "npc_speech_tick", DB.npc_speech_tick);
    ini_close();

    goto_mainmenu();


}
