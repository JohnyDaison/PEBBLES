function message_movement(argument0) {
	var query = argument0;

	switch(query)
	{
	    case "title":
	    {
	        return "Movement";
	    }
	    break;
    
	    case "message":
	    {
	        return get_control_name(directions) + " = Move/Aim\n"+
	               get_control_name(jump) +" = Jump \nMOVE OUT!";
	    }
	    break;
    
	    case "show_check":
	    {
	        return true;
	    }
	    break;
    
	    case "hide_check":
	    {
	        var base = my_guy.my_base;
	        if(instance_exists(base))
	        {
	            if(base.object_index == guy_spawner_obj)
	            {
	                if(instance_exists(base.my_shield) && point_distance(base.x,base.y,my_guy.x,my_guy.y) > base.my_shield.radius)
	                {
	                    return true;
	                }
            
	                if(base.destroyed)
	                    return true;
	            } 
	            else
	            {
	                return true;
	            }
	        }
        
	        return false;
	    }
	    break;
    
	    case "cancel_check":
	    {
	        return false;
	    }
	    break;
	}



}
