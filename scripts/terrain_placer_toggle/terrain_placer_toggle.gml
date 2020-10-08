function terrain_placer_toggle() {
	if(instance_exists(terrain_placer_toolbar))
	{
	    close_frame(terrain_placer_toolbar)
	}
	else
	{
	    i = add_frame(terrain_placer_toolbar);
	    i.x = main_editor_toolbar.x + main_editor_toolbar.width+1;
	    i.y = main_editor_toolbar.y;
	}



}
