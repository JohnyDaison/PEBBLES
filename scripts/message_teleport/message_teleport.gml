function message_teleport(argument0) {
	var query = argument0;
	var abi_color = g_blue;

	switch(query)
	{
	    case "title":
	    {
	        return "Blink";
	    }
	    break;
    
	    case "message":
	    {
	        return "direction + " + get_control_name(abi) + " = Blink (Blue)\n"
	            +  "Teleport in a direction by up to 8 blocks";
	    }
	    break;
    
	    case "show_check":
	    {
	        return my_guy.potential_color == abi_color && rule_get_state("abilities") && has_level(my_guy, "teleport", 1);
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
