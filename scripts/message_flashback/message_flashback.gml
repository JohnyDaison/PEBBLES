function message_flashback(argument0) {
	var query = argument0;
	var abi_color = g_black;

	switch(query)
	{
	    case "title":
	    {
	        return "Rewind";
	    }
	    break;
    
	    case "message":
	    {
	        return get_control_name(abi) + " = Rewind (Dark)\n"
	            +  "Return in time by 2 seconds";
	    }
	    break;
    
	    case "show_check":
	    {
	        return my_guy.potential_color == abi_color;
	    }
	    break;
    
	    case "hide_check":
	    {
	        if(my_guy.abi_cooldown[? abi_color] > 0)
	        {
	            return true;
	        }
	        return false;
	    }
	    break;
    
	    case "cancel_check":
	    {
	        return my_guy.potential_color != abi_color;
	    }
	    break;
	}



}
