/// @description my_console_log(string)
/// @function my_console_log
/// @param string
function my_console_log(argument0) {
	var str = argument0;

	my_console_write("log: " + str);
	show_debug_message(str);

	if(singleton_obj.show_console == "hide" && DB.console_mode == "debug")
	{
	    singleton_obj.show_console = "peek";
	}




}
