function achiev_crunchy(argument0) {
    var query = argument0;

    switch(query)
    {
        case "title":
        {
            return "Crunchy";
        }
        break;
    
        case "verb":
        {
            return "is Crunchy!";
        }
        break;
    
        case "success":
        {
            if(gamemode_obj.is_campaign)
            {
                return false;
            }
        
            return my_player.stats[? "score"] >= gamemode_obj.score_values[? "crunchy_limit"];
        }
        break;
    
        case "fail":
        {
            var ret=false;
            return ret;
        }
        break;
    
        case "reward":
        {
            display_stat(my_player, "score");
        
            return true;
        }
        break;
    }
}
