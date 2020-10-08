/// @description  GENERATE NAVIGATION

frame_manager.current_frame = self.id;
frame_manager.first_elem = noone;

with(gui_element)
{
    //if(!object_is_ancestor(object_index,empty_frame))
    //{
        if(parent_frame == frame_manager.current_frame && want_focus)
        {
            closest_right = noone;
            closest_left = noone;
            
            if(enabled)
            {
                frame_manager.first_elem = id;
            }
            
            with(gui_element)
            {
                if(parent_frame == frame_manager.current_frame && want_focus && abs(y-other.y) <= 16 && id != other.id)
                {
                    if((x - other.x) > 0)
                    {
                        if(!instance_exists(other.closest_right))
                        {
                            other.closest_right = self.id;
                        }
                        if((other.closest_right.x-self.x) > 0)
                        {
                            other.closest_right = self.id;
                        }
                    }
                    if((x - other.x) < 0)
                    {
                        if(!instance_exists(other.closest_left))
                        {
                            other.closest_left = self.id;
                        }
                        if((other.closest_left.x-self.x) < 0)
                        {
                            other.closest_left = self.id;
                        }
                    }   
                }
            }
            
            if(!instance_exists(right_hand_object))
            {
                right_hand_object = closest_right;
            }
            if(!instance_exists(left_hand_object))
            {
                left_hand_object = closest_left;
            }
        }
    //}
}

if(instance_exists(frame_manager.first_elem))
{
    with(frame_manager.first_elem)
    {
        gui_get_focus();
    }
    show_debug_message("first focused");
}

