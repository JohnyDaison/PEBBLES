function destroy_console_DB() {
    var count = ds_list_size(self.debug_keys_list);

    for (var i = 0; i < count; i++) {
        var item = self.debug_keys_list[| i];
        delete item;
    }

    ds_list_destroy(self.debug_keys_list);

    var script = ds_map_find_first(self.console_scripts);
    while (!is_undefined(script)) {
        ds_map_destroy(self.console_scripts[? script]);
        script = ds_map_find_next(self.console_scripts, script);
    }

    var mode = ds_map_find_first(self.console_modes);
    while (!is_undefined(mode)) {
        ds_list_destroy(self.console_modes[? mode]);
        mode = ds_map_find_next(self.console_modes, mode);
    }

    ds_list_destroy(self.console_history);
    ds_list_destroy(self.console_command_history);
    ds_list_destroy(self.console_watches);
    ds_list_destroy(self.console_secrets);
    ds_list_destroy(self.console_commands_saved);
    ds_map_destroy(self.console_menu);
    ds_map_destroy(self.console_scripts);
    ds_map_destroy(self.console_vars);
    ds_map_destroy(self.console_modes);
    ds_map_destroy(self.objectmap);

    ds_list_destroy(self.watch_type_name_list);
    ds_list_destroy(self.watch_type_id_list);
}
