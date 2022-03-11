function command_dump_instance(instance, to_file = false) {
    if (!instance_exists(instance)) {
        return 0;
    }
    
    var names = variable_instance_get_names(instance);
    array_sort(names, true);
    var count = variable_instance_names_count(instance);
    var filename, file;
    
    show_debug_message("command: dumpinst "  + string(instance));
    
    if (to_file) {
        filename = DB.dumpfile_folder + "/" + string(instance.id) + "_" + object_get_name(instance.object_index) + ".txt";
        file = file_text_open_write(filename);
    }
    
    for (var i = 0; i < count; i++) {
        var name = names[i];
        var value = variable_instance_get(instance, name);
        var line_number_str = my_string_format(i, 3, 0) + " ";
        var line = string(name) + " : " + string(value);
        
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