function destroy_console_DB() {
    var count = ds_list_size(debug_keys_list);

    var i, item;

    for(i=0; i < count; i++)
    {
        item = debug_keys_list[| i];
        delete item;
    }
    ds_list_destroy(debug_keys_list);

    var script = ds_map_find_first(console_scripts);
    while(!is_undefined(script))
    {
        ds_map_destroy(console_scripts[? script]);
        script = ds_map_find_next(console_scripts, script);
    }

    var mode = ds_map_find_first(console_modes);
    while(!is_undefined(mode))
    {
        ds_list_destroy(console_modes[? mode]);
        mode = ds_map_find_next(console_modes, mode);
    }

    ds_list_destroy(console_history);
    ds_list_destroy(console_command_history);
    ds_list_destroy(console_watches);
    ds_list_destroy(console_secrets);
    ds_list_destroy(console_commands_saved);
    ds_map_destroy(console_menu);
    ds_map_destroy(console_scripts);
    ds_map_destroy(console_vars);
    ds_map_destroy(console_modes);
    ds_map_destroy(objectmap);
    
    ds_list_destroy(watch_type_name_list);
    ds_list_destroy(watch_type_id_list);
}
