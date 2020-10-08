/// @param frame
function close_frame(argument0) {
	var window_id;

	if(instance_exists(argument0))
	{
	    window_id = argument0;
	    show_debug_message("ID: "+string(window_id));
	    if(object_is_ancestor(window_id.object_index,empty_frame))
	    {
	        show_debug_message("Closing window \""+object_get_name(window_id.object_index)+"\"");
	        if(frame_manager.focused_child == window_id)
	        {
	            gui_clear_focus(frame_manager);
	        }
	        with(window_id){
	            ds_list_delete(frame_manager.gui_content,ds_list_find_index(frame_manager.gui_content,id));
	            instance_destroy();
	        };
        
	        show_debug_message("Closed window.");
	        with(empty_frame)
	        {
	            alarm[0] = 1;
	        }
	        return true;
	    }
	    else
	    {
	        show_debug_message("Dat is no window!");
	        return false;
	    }
	}
	else
	{
	    show_debug_message("Not closin' noone!");
	    return false;
	}



}
