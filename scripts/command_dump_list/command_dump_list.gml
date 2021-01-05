function command_dump_list(list) {
    if(!ds_exists(list, ds_type_list)) {
        return 0;
    }
    
    var count = ds_list_size(list);
    
    show_debug_message("command: dumplist "  + string(list));
    
    for(var i = 0; i < count; i++) {
        var value = list[| i];
        var line = my_string_format(i, 3, 0) + " : " + string(value);
        
        my_console_write(line);
        show_debug_message(line);
    }
    
    return count;
}