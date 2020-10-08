function achiev_idle_pickup(argument0) {
	var query = argument0;

	switch(query)
	{
	    case "title":
	    {
	        return "Idle Recipient";
	    }
	    break;
    
	    case "verb":
	    {
	        return "was delivered something";
	    }
	    break;
    
	    case "success":
	    {
	        if(instance_exists(my_guy))
	        {
	            return my_guy.idle && my_guy.idle_start < (my_guy.last_added_item_step-300);        
	        }

	        return false;
	    }
	    break;
    
	    case "fail":
	    {
	        return false;
	    }
	    break;
    
	    case "reward":
	    {
	        return true;
	    }
	    break;
	}



}
