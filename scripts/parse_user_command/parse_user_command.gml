/// @description parse_user_command()
/// @function parse_user_command
function parse_user_command() {
	var command = console_window.command_input.text, result = "";

	my_console_write("command: " + command, true);

	result = parse_command(command);
	ds_list_add(DB.console_command_history, command);

	my_console_write("result: " + string(result), true);
	my_console_write("====================================================", true);

	if(instance_exists(console_window))
	{
	    console_window.command_input.text = "";
	}
}
