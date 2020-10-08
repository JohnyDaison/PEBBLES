function selection_tool_onup() {
	if(instance_exists(selection_obj))
	{
	    with(selection_obj)
	    {
	        instance_destroy();
	    }
	}
	tool_activate(selection_tool_obj);



}
