function tool_activate(argument0) {
	if(object_is_ancestor(argument0,tool_object))
	{
	    tool = argument0;
	    if(!instance_exists(tool))
	    {
	        instance_create(0,0,tool);
	    }
    
	    if(!tool.active || cursor_obj.active_tool != tool.id)
	    {
	        clear_tools();
	        tool.active = true;
	        cursor_obj.active_tool = tool.id;
	        cursor_obj.sprite_index = tool.tool_sprite[tool.mode];
        
	        with(cursor_obj.active_tool)
	        {
	            event_perform(ev_other,ev_user0);
	        }
	    }
	}



}
