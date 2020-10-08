function message_create_shield(argument0) {
	var query = argument0;

	switch(query)
	{
	    case "title":
	    {
	        return "Shield";
	    }
	    break;
    
	    case "message":
	    {
	        return get_control_name(cast) + " + no direction = Shield";
	    }
	    break;
    
	    case "show_check":
	    {
	        return my_guy.my_color > g_black;
	    }
	    break;
    
	    case "hide_check":
	    {
	        if(instance_exists(my_guy.my_shield))
	        {
	            return true;
	        }
	        return false;
	    }
	    break;
    
	    case "cancel_check":
	    {
	        return my_guy.my_color <= g_black;
	    }
	    break;
	}



}
