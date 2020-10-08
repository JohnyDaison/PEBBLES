function tool_set_mode(argument0, argument1) {
	if(object_is_ancestor(argument0,tool_object))
	{
	    tool = argument0;
	    mode = 0 + argument1;
	    if(instance_exists(tool))
	    {
	        if(tool.mode != mode && sprite_exists(tool.tool_sprite[mode]))
	        {
	            tool.mode = mode;
	            with(tool)
	            {
	                event_perform(ev_other,ev_user0);
	            }
	        }
    
	        if(tool.active && cursor_obj.active_tool == tool.id)
	        {
	            cursor_obj.sprite_index = tool.tool_sprite[tool.mode];
	        }
	    }
	}



}
