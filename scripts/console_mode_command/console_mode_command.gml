/// @description console_mode_command([mode])
/// @function console_mode_command
/// @param [mode]
function console_mode_command() {

	var newMode = "";

	if(argument_count > 0)
	{
	    newMode = argument[0];
	}

	if(newMode != "" && !is_undefined(DB.console_modes[? newMode]))
	{
	    DB.console_mode = newMode;
	}

	return DB.console_mode;


}
