function info_close() {
	if(gui_parent != noone)
	{
	    if(gui_parent.object_index == info_window)
	    {
	        show_debug_message("gui_parent is info_window");
	        close_frame(gui_parent);
	    }
	    else
	    {
	        show_debug_message("gui_parent is not info_window");
	        close_frame(info_window);
	    }
	}
	else
	{
	    show_debug_message("gui_parent is noone");
	    close_frame(info_window);
	}



}
