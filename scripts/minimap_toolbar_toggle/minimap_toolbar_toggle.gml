function minimap_toolbar_toggle() {
	if(instance_exists(minimap_toolbar))
	{
	    close_frame(minimap_toolbar)
	}
	else
	{
	    i = add_frame(minimap_toolbar);
	    i.x = singleton_obj.current_width - i.width -1;
	    i.y = singleton_obj.current_height - i.height -1;
	}



}
