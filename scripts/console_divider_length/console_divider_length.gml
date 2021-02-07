function console_divider_length(characters, length) {
    var str = "", index;
    var step = string_length(characters);
    var count = ds_list_size(DB.console_history);
    var last_line = DB.console_history[| count-1];
    
    if(step == 0) {
        if(last_line != str) {
            my_console_write(str);
        }
        return;
    }
    
    for(index = 0; index < length; index += step) {
        str += characters;
    }
    
    if(last_line != str) {
        my_console_write(str);
    }
}