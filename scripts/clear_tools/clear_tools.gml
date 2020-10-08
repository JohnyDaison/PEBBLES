function clear_tools() {
	if(instance_exists(cursor_obj.active_tool))
	{
	    cursor_obj.active_tool.active = false;
	    with(cursor_obj.active_tool)
	    {
	        event_perform(ev_other,ev_user0);
	    }
	    cursor_obj.active_tool = noone;
	    cursor_obj.sprite_index = cursor_arrow;
	}




}
