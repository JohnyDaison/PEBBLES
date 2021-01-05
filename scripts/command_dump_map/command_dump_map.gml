function command_dump_map(map) {
    if(!ds_exists(map, ds_type_map)) {
        return 0;
    }
    
    var keys = ds_map_keys_to_array(map);
    array_sort(keys, true);
    var count = ds_map_size(map);
    
    show_debug_message("command: dumpmap "  + string(map));
    
    for(var i = 0; i < count; i++) {
        var key = keys[i];
        var value = map[? key];
        var line = my_string_format(i, 3, 0) + " " + string(key) + " : " + string(value);
        
        my_console_write(line);
        show_debug_message(line);
    }
    
    return count;
}