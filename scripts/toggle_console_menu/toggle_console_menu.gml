/// @description toggle_console_menu()
/// @function toggle_console_menu
function toggle_console_menu() {
	if(!console_window.menu_open)
	{
	    gui_show_element(console_window.menu_pane);
	    console_window.menu_open = true;   
	}
	else
	{
	    gui_hide_element(console_window.menu_pane);
	    console_window.menu_open = false;
	}



}
