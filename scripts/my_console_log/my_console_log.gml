/// @description my_console_log(string)
/// @function my_console_log
/// @param string
function my_console_log(str) {
    my_console_write("log: " + str);
    show_debug_message(str);

    if(singleton_obj.show_console == "hide" && DB.console_popup_on_log)
    {
        singleton_obj.show_console = "peek";
    }
}
