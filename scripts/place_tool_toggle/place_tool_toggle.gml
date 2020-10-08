function place_tool_toggle() {
	if(instance_exists(place_toolbar))
	{
	    close_frame(place_toolbar)
	}
	else
	{
	    i = add_frame(place_toolbar);
	    i.x = main_editor_toolbar.x + main_editor_toolbar.width - i.width;
	    i.y = main_editor_toolbar.y + main_editor_toolbar.height+1;
	}



}
