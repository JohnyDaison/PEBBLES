/// @description place_controller_trigger_script()
/// @function place_controller_trigger_script
function place_controller_trigger_script(argument0, argument1) {
	var arg_count = argument0;
	var args = argument1;

	if(arg_count < 1)
	    return false;
    
	var key = args[0];
	var context = self;
	var list = trigger_map[? key];
	var display_group = self.anim_groups[? key];
	var anim_set = self.anim_sets[? key];
	var i, count;

	if(arg_count >= 2)
	{
	    context = args[1];
	}

	// new triggers
	if(!is_undefined(list) && is_undefined(display_group))
	{
	    count = ds_list_size(list);
    
	    with(context)
	    {
	        for(i=0; i<count; i++)
	        {
	            trigger((list[| i]));
	        }
	    }
    
	    return true;
	}

	// anims
	if(context != id && !context.is_npc)
	{
	    if(key == "clear")
	    {
	        with(self.active_display_group)
	        {
	            clear_anim_set(true);
	        }
	        self.active_display_group = noone;
	        return true;
	    }

	    if(!is_undefined(display_group) && instance_exists(display_group) && !is_undefined(anim_set) && anim_set != noone)
	    {
	        if(display_group != self.active_display_group)
	        {
	            with(self.active_display_group)
	            {
	                clear_anim_set(true);
	            }
        
	            with(display_group)
	            {
	                clear_anim_set(false);
	                script_execute(anim_set);
	                anim_set_start = singleton_obj.step_count+1;
	                other.active_display_group = id;
	            }
	        }
	        return true;
	    }
	}


}
