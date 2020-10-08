function structure_placer_toggle() {
	if(instance_exists(structure_placer_toolbar))
	{
	    close_frame(structure_placer_toolbar)
	}
	else
	{
	    i = add_frame(structure_placer_toolbar);
	    i.x = main_editor_toolbar.x + main_editor_toolbar.width+1;
	    i.y = main_editor_toolbar.y + main_editor_toolbar.height+1;
	}



}
