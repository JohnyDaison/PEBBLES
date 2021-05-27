function control_config_OK() {
    var cswindow = control_settings_window.id;
    var gui_list = cswindow.gui_content;
    
    for(i=0; i < cswindow.input_count; i+=1)
    {
        keyboard1_obj.binds[? i] =
            (ds_list_find_value(gui_list, cswindow.key1[i])).key;
        keyboard2_obj.binds[? i] =
            (ds_list_find_value(gui_list, cswindow.key2[i])).key;
        
        var pad1 = gui_list[| cswindow.pad1[i] ];
        pad1.control_obj.binds[? i] = pad1.control_id;
        
        var pad2 = gui_list[| cswindow.pad2[i] ];
        pad2.control_obj.binds[? i] = pad2.control_id;
    }

    close_frame(cswindow);
    room_goto(mainmenu);
}
