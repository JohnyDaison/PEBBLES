function message_use_abi(argument0) {
	var query = argument0;

	switch(query)
	{
	    case "title":
	    {
	        return "Ability";
	    }
	    break;
    
	    case "message":
	    {
	        return get_control_name(abi) + " = use Ability";
	    }
	    break;
    
	    case "show_check":
	    {
	        return true;
	    }
	    break;
    
	    case "hide_check":
	    {
	        if(my_guy.abi_cooldown > 0)
	        {
	            return true;
	        }
	        return false;
	    }
	    break;
      
	    case "cancel_check":
	    {
	        return message_teleport("show_check");
	    }
	    break;
	}



}
