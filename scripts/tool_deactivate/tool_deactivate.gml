function tool_deactivate(argument0) {
	if(object_is_ancestor(argument0,tool_object))
	{
	    tool = argument0;
	    if(instance_exists(tool))
	    {
	        if(cursor_obj.active_tool == tool.id && tool.active)
	        {
	            tool.active = false;
	            with(tool)
	            {
	                event_perform(ev_other,ev_user0);
	            }
	            cursor_obj.active_tool = noone;
	            cursor_obj.sprite_index = cursor_arrow;
	        }
	    }
	}



}
