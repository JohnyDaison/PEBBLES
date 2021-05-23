function message_change_color(argument0) {
    var query = argument0;

    switch(query)
    {
        case "title":
        {
            return "Change color";
        }
        break;
    
        case "message":
        {
            return  get_control_name(b) + "," +
                    get_control_name(g) + "," +
                    get_control_name(r) + " = choose Color\n" +
                    get_control_name(cast) + " = accept";
        }
        break;
    
        case "show_check":
        {
            return true;
        }
        break;
    
        case "hide_check":
        {
            if(my_guy.my_color != g_dark)
            {
                return true;
            }
            return false;
        }
        break;
    
        case "cancel_check":
        {
            return my_guy.slot_number == 0;
        }
        break;
    }
}
