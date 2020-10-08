function gui_clear_focus(argument0) {
	var ret = true;
	if(instance_exists(argument0))
	{
	    with(argument0)
	    {
	         ret = gui_lose_focus();
	    }
	}
	return ret;



}
