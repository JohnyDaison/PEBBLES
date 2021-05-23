function message_channeling(argument0) {
    var query = argument0;

    switch(query)
    {
        case "title":
        {
            return "Channeling";
        }
        break;
    
        case "message":
        {
            return "Low on energy? Return to base, or hold " + get_control_name(channel);
        }
        break;
    
        case "show_check":
        {
            var low_color = false;
            if(my_guy.my_color > g_dark)
            {
                comp = color_to_components(my_guy.my_color);
                for(i = g_red; i <= g_blue; i++)
                {
                    if(i != g_yellow)
                    {
                        if(comp[i]) //  && my_guy.energy_left[i] < 5 - needs to be updated for Orb energy
                        {
                            low_color = true;
                        }   
                    }
                }
            }
            return low_color;
        }
        break;
    
        case "hide_check":
        {
            return false;  
        }
        break;
    
        case "cancel_check":
        {
            var low_color = false;
            comp = color_to_components(my_guy.my_color);
        
            for(i = g_red; i <= g_blue; i++)
            {
                if(i != g_yellow)
                {
                    if(comp[i]) //  && my_guy.energy_left[i] < 5
                    {
                        low_color = true;
                    }   
                }
            }
        
            return !low_color;
        }
        break;
    }
}
