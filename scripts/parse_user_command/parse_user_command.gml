/// @description parse_user_command()
/// @function parse_user_command
function parse_user_command() {
    var command = console_window.command_input.text, result = "";
    
    command = string_trim(command);
    
    if (command == "") {
        return;
    }

    console_divider_level("=", 1);
    my_console_write("command: " + command, true);
    console_divider_level("-", 2);

    result = parse_command(command);
    ds_list_add(DB.console_command_history, command);

    console_divider_level("-", 2);
    my_console_write("result: " + string(result), true);
    console_divider_level("=", 1);

    if(instance_exists(console_window))
    {
        console_window.command_input.text = "";
        console_jump_to_end();
    }
    
    write_command_history_file();
}
