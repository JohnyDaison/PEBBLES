function console_divider_length(characters, length){
    var str = "", index;
    var step = string_length(characters);
    
    if(step == 0) {
        my_console_write("");
        return;
    }
    
    for(index = 0; index < length; index += step) {
        str += characters;
    }
    
    my_console_write(str);
}