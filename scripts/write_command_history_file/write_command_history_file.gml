function write_command_history_file() {
    var file = file_text_open_write("command_history.txt");
    var total_count = ds_list_size(DB.console_command_history);
    var start_index = max(0, total_count - 10);
    
    for (var i = start_index; i < total_count; i++) {
        file_text_write_string(file, DB.console_command_history[| i]);
        file_text_writeln(file);
    }
    
    file_text_close(file);
}