function message_crystals(argument0) {
	var query = argument0;

	switch(query)
	{
	    case "title":
	    {
	        return "Shard";
	    }
	    break;
    
	    case "message":
	    {
	        return "Break its Shield and collect it";
	    }
	    break;
    
	    case "show_check":
	    {
	        var found = false;
	        with(crystal_obj)
	        {
	            var dist = point_distance(x,y, other.my_guy.x,other.my_guy.y);
	            if(my_guy == id && dist < 320)
	                found = true;
	        }
	        return found;
	    }
	    break;
    
	    case "hide_check":
	    {
	        var found = false;
	        with(guy_obj)
	        {
	            if(find_in_inventory(crystal_obj) != noone)
	                found = true;
	        }
	        return found;
	    }
	    break;
    
	    case "cancel_check":
	    {
	        var found = false;
	        with(crystal_obj)
	        {
	            var dist = point_distance(x,y, other.my_guy.x,other.my_guy.y);
	            if(my_guy == id && dist < 480)
	                found = true;
	        }
	        return !found || cur_message_step > 900;
	    }
	    break;
	}



}
