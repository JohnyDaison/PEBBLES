/// @param {empty_frame} frame_id
function close_frame(frame_id) {
	if(instance_exists(frame_id))
	{
	    show_debug_message("ID: "+string(frame_id));
	    if(object_is_ancestor(frame_id.object_index, empty_frame))
	    {
	        show_debug_message("Closing frame \"" + object_get_name(frame_id.object_index) + "\"");
	        if(frame_manager.focused_child == frame_id)
	        {
	            gui_clear_focus(frame_manager);
	        }
	        with(frame_id) {
	            instance_destroy();
	        };
        
	        show_debug_message("Closed frame.");
	        with(empty_frame)
	        {
	            alarm[0] = 1;
	        }
	        return true;
	    }
	    else
	    {
	        show_debug_message("Dat is no frame!");
	        return false;
	    }
	}
	else
	{
	    show_debug_message("Not closin' noone!");
	    return false;
	}
}
