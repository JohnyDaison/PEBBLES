function gui_clear_focus(frame) {
	var ret = true;
    var force = false;
    if(argument_count > 1) {
        force = argument[1];
    }
    
	if(instance_exists(frame))
	{
	    with(frame)
	    {
	         ret = gui_lose_focus(force);
	    }
	}
	return ret;
}
