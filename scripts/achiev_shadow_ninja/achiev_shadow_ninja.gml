function achiev_shadow_ninja(argument0) {
	var query = argument0;

	switch(query)
	{
	    case "title":
	    {
	        return "Shadow Ninja";
	    }
	    break;
    
	    case "verb":
	    {
	        return "has killed without leaving the shadows";
	    }
	    break;
    
	    case "success":
	    {
	        var dead_guy = noone;
	        var what = noone;
        
	        with(guy_obj)
	        {
	            if(dead && my_player != other.id && last_attacker_map[? "player"] == other.id)
	            {
	                dead_guy = id;
	                what = last_attacker_map[? "source"];
	            }
	        }
        
	        return my_player.stats[? "kills"] > 0 && what == guy_obj;
	    }
	    break;
    
	    case "fail":
	    {
	        return my_player.my_guy.my_color > g_black && !my_player.my_guy.channeling;
	    }
	    break;
    
	    case "reward":
	    {
	        /*
	        var score_value = gamemode_obj.score_values[? "achiev_shadow_ninja"];
        
	        increase_stat(my_player, "score", score_value, true);
	        increase_stat(my_player, "achievements_score", score_value, false);
	        */
	        increase_achievement_score(my_player, gamemode_obj.score_values[? "achiev_shadow_ninja"], true);
        
	        return true;
	    }
	    break;
	}



}
