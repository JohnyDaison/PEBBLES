function message_attack(argument0) {
	var query = argument0;

	switch(query)
	{
	    case "title":
	    {
	        return "Attack";
	    }
	    break;
    
	    case "message":
	    {
	        return get_control_name(cast) + " + direction = Attack\n"
	             + "hold for stronger shot";
	    }
	    break;
    
	    case "show_check":
	    {
	        return true;
	    }
	    break;
    
	    case "hide_check":
	    {
	        if(my_guy.has_casted_ever)
	        {
	            return true;
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
