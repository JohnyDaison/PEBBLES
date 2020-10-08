/// @description parse_user_command()
/// @function parse_user_command
function parse_user_command() {
	var command = console_window.command_input.text, result = "";

	my_console_write("command: " + command);

	result = parse_command(command);
	ds_list_add(DB.console_command_history, command);

	my_console_write("result: " + string(result));
	my_console_write("====================================================");

	if(instance_exists(console_window))
	{
	    console_window.command_input.text = "";
	}



}
