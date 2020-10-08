function gui_get_focus() {
	//show_debug_message("getting focus");
	//show_debug_message("id: "+string(id));
	if(object_is_ancestor(self.object_index, gui_object) && instance_exists(gui_parent))
	{
	    //show_debug_message("parent exists");
	    with(gui_parent)
	    {
	        if(object_index == frame_manager && object_is_ancestor(other.object_index, empty_frame))
	        {
	            //show_debug_message("focusing frame "+string(other.id));
	            if(focused_child == other.id)
	            {
	                other.focused = true;
	                return true;
	            }
	            else if(gui_clear_focus(focused_child))
	            {
	                self.content_focused = ds_list_find_index(self.gui_content, other.id);
	                self.focused_child = other.id;
    
	                other.focused = true;
	                self.focused = true;
                
	                return true;
	            }
	            else
	                return false;
	        }
	        else if(object_is_ancestor(object_index, empty_frame))
	        {
	            if(focused)
	            {
	                if(self.focused_child != other.id)
	                {
	                    //show_debug_message("parent is focused frame but not on me");
	                    if(gui_clear_focus(self.focused_child))
	                    {
	                        self.content_focused = ds_list_find_index(self.gui_content, other.id);
	                        self.focused_child = other.id;
	                        other.focused = true;
	                        return true;
	                    }
	                    else
	                        return false;
	                }
	                else
	                {
	                    //show_debug_message("parent frame already focused on me");
	                    other.focused = true;   
	                    return true;
	                }
                
	            }
	            else
	            {
	                //show_debug_message("parent is unfocused frame");
	                return false;
	            }
	        }
	        else
	        {
	            if(!focused) //!other.focused
	            {
	                //show_debug_message("parent is not focused");
	                if(gui_get_focus())
	                {
	                    self.content_focused = ds_list_find_index(self.gui_content, other.id);
	                    self.focused_child = other.id;
	                    other.focused = true;
	                    self.focused = true;
	                    return true;
	                }
	                else
	                {
	                    //show_debug_message("parent could not get focused");
	                    return false;
	                }
	            }
	            else
	            {
	                if(self.focused_child != other.id)
	                {
	                    //show_debug_message("parent is focused but not on me");
	                    if(gui_clear_focus(self.focused_child))
	                    {
	                        self.content_focused = ds_list_find_index(self.gui_content, other.id);
	                        self.focused_child = other.id;
	                        other.focused = true;
	                        self.focused = true;
	                        return true;    
	                    }
	                    else
	                        return false;
	                }
	                else
	                {
	                    //show_debug_message("parent already focused on me");
	                    other.focused = true;  
	                    return true;
	                }
	            }
	        }
	    }
	}



}
