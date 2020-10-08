function message_fire_cannon(argument0) {
	var query = argument0;

	switch(query)
	{
	    case "title":
	    {
	        return "Fire Cannon";
	    }
	    break;
    
	    case "message":
	    {
	        return "Inside cannon: " + get_control_name(cast) + " + directions = Aim\n"
	            +  "In or outside: " + get_control_name(altfire) + " = Toggle Autofire";
	    }
	    break;
    
	    case "show_check":
	    {
	        var base = my_guy.my_base;
        
	        if(instance_exists(base))
	        {
	            if(base.object_index == guy_spawner_obj)
	            {
	                if(!instance_exists(base.base_cannon))
	                    return false;
                
	                if(base.base_cannon.shot_color > g_black)
	                    return true;
	            }
	            else
	            {
	                return false;
	            }
	        }
	        return false;
	    }
	    break;
    
	    case "hide_check":
	    {
	        var base = my_guy.my_base;
        
	        if(instance_exists(base))
	        {
	            if(base.object_index == guy_spawner_obj)
	            {
	                if(!instance_exists(base.base_cannon))
	                    return true;
                
	                var found = false;
	                with(big_projectile_obj)
	                {
	                    if(my_guy == other.base.base_cannon)
	                        found = true;
	                }
	                return found;
	            }
	            else
	            {
	                return true;
	            }
	        }
	        else
	        {
	            return true;
	        }
	    }
	    break;
    
	    case "cancel_check":
	    {
	        return cur_message_step > 900;
	    }
	    break;
	}



}
