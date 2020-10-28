function gui_lose_focus() {
    var force = false;
    if(argument_count > 0) {
        force = argument[0];
    }
    
	//show_debug_message("losing focus");
	//show_debug_message("id: "+string(id));
	if(object_is_ancestor(object_index, gui_object))
	{
	    if(modal && !force) return false;
        
	    var count = ds_list_size(self.gui_content);
	    //show_debug_message("content count: "+string(count));
    
	    if(self.content_focused != -1 && count > 0)
	    {
	        //show_debug_message("has focused content");
	        var child = self.gui_content[| self.content_focused];
	        if(!is_undefined(child))
	        {
	            with(child)
	            {
	                if(gui_lose_focus(force))
	                {
	                    other.content_focused = -1;
	                    other.focused_child = noone;
	                    self.focused = false;
	                    //show_debug_message("lost focus");
	                }
	            }
	        }
	        return (self.content_focused == -1);
	    }
	    else
	    {
	        //show_debug_message("has no focused content");
	        if(!self.active)
	        {
	            self.focused = false;
	            if(instance_exists(gui_parent))
	            {
	                gui_parent.content_focused = -1;
	                gui_parent.focused_child = noone;
	            }
	            //show_debug_message("inactive lost focus");
	            return true;
	        }
	        else
	        {
	            self.active = false;
	            self.focused = false;
	            if(instance_exists(gui_parent))
	            {
	                gui_parent.content_focused = -1;
	                gui_parent.focused_child = noone;
                
	            }
	            //show_debug_message("active lost focus");
	            return true;

	        }
	    }
	}
    
	return true;
}
