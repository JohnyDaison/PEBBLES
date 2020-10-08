function message_sprinkler(argument0) {
	var query = argument0;

	switch(query)
	{
	    case "title":
	    {
	        return "Sprinkler";
	    }
	    break;
    
	    case "message":
	    {
	        return "Kill the Sprinkler for score and color orbs.";
	    }
	    break;
    
	    case "show_check":
	    {
	        return (instance_exists(sprinkler_body_obj));
	    }
	    break;
    
	    case "hide_check":
	    {
	        if(instance_exists(sprinkler_body_obj))
	        {
	            return (sprinkler_body_obj.last_attacker_map[? "source"] == my_guy);
	        }
	        return false;
	    }
	    break;
    
	    case "cancel_check":
	    {
	        return (self.cur_message_step > 600);
	    }
	    break;
	}



}
