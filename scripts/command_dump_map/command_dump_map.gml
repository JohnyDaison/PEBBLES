function command_dump_map(map, to_file = false) {
    if(!ds_exists(map, ds_type_map)) {
        return 0;
    }
    
    var keys = ds_map_keys_to_array(map);
    array_sort(keys, true);
    var count = ds_map_size(map);
    var filename, file;
    
    show_debug_message("command: dumpmap "  + string(map));
    
    if (to_file) {
        filename = DB.dumpfile_folder + "/ds_map_" + string(map) + ".txt";
        file = file_text_open_write(filename);
    }
    
    for (var i = 0; i < count; i++) {
        var key = keys[i];
        var value = map[? key];
        var line_number_str = my_string_format(i, 3, 0) + " ";
        var line = string(key) + " : " + string(value);
        
        my_console_write(line_number_str + line);
        show_debug_message(line_number_str + line);
        
        if (to_file) {
            file_text_write_string(file, line);
            file_text_writeln(file);
        }
    }
    
    if (to_file) {
        file_text_close(file);
    }
    
    return count;
}