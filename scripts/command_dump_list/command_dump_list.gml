function command_dump_list(list, to_file = false) {
    if(!ds_exists(list, ds_type_list)) {
        return 0;
    }
    
    var count = ds_list_size(list);
    var filename, file;
    
    show_debug_message("command: dumplist "  + string(list));
    
    if (to_file) {
        filename = DB.dumpfile_folder + "/ds_list_" + string(list) + ".txt";
        file = file_text_open_write(filename);
    }
    
    for (var i = 0; i < count; i++) {
        var value = list[| i];
        var line = my_string_format(i, 3, 0) + " : " + string(value);
        
        my_console_write(line);
        show_debug_message(line);
        
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