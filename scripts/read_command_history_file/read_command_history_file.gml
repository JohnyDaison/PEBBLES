function read_command_history_file() {
    var file = file_text_open_read("command_history.txt");
    
    while (!file_text_eof(file)) {
        var line = file_text_read_string(file);
        file_text_readln(file);
        
        if (line != "") {
            ds_list_add(DB.console_command_history, line);
        }
    }
    file_text_close(file);
}