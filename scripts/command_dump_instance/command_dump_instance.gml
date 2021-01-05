function command_dump_instance(instance) {
    if(!instance_exists(instance)) {
        return 0;
    }
    
    var names = variable_instance_get_names(instance);
    array_sort(names, true);
    var count = variable_instance_names_count(instance);
    
    show_debug_message("command: dumpinst "  + string(instance));
    
    for(var i = 0; i < count; i++) {
        var name = names[i];
        var value = variable_instance_get(instance, name);
        var line = my_string_format(i, 3, 0) + " " + string(name) + " : " + string(value);
        
        my_console_write(line);
        show_debug_message(line);
    }
    
    return count;
}