function message_load_cannon(argument0) {
    var query = argument0;

    switch(query)
    {
        case "title":
        {
            return "Load Cannon";
        }
        break;
    
        case "message":
        {
            return "You have extra Color Orbs," + "\n" + "get inside your Cannon to load them.";
        }
        break;
    
        case "show_check":
        {
            var orb_found = false;
            with(my_guy)
            {
                for(var col=g_red; col<=g_blue; col++)
                {
                    if(orb_reserve[? col] >= 1)
                        orb_found = true;   
                }
            }
            return orb_found;
        }
        break;
    
        case "hide_check":
        {
            var base = my_guy.my_base;
        
            if(instance_exists(base))
            {
                if(base.object_index == guy_spawner_obj)
                {
                    if(!instance_exists(base.base_cannon))
                        return true;
                
                    if(base.base_cannon.shot_color > g_dark)
                        return true;
                } 
                else
                {
                    return true;
                }
            }        
            return false;
        }
        break;
    
        case "cancel_check":
        {
            var orb_found = false;
            with(my_guy)
            {
                for(var col=g_red; col<=g_blue; col++)
                {
                    if(orb_reserve[? col] >= 1)
                        orb_found = true;   
                }
            }
            return !orb_found || cur_message_step > 900;
        }
        break;
    }
}
