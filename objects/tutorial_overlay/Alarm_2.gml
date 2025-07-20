/// @description  UPDATE MESSAGE
var message_script;

if(instance_exists(my_guy))
{
    old_message = message;
    var change_made = false;
    // UPDATE MESSAGE
    for(var i = 1; i<= message_count; i++)
    { 
        message_script = ds_map_find_value(messages,i);
        
        var state = message_state[? i];
        
        if(state == 0 && message == "" && fadeout_step == fadeout_time)
        {
            title = script_execute(message_script,"title");
            if(script_execute(message_script,"show_check"))
            {
                message = script_execute(message_script,"message");
                blink_step = 0;
                self.cur_message_step = 0;
                state = 1;
                change_made = true;
            }
            
        }
        
        if(state != 2 && !change_made)
        {
            if(script_execute(message_script,"hide_check"))
            {
                title = script_execute(message_script,"title");
                if(state == 1) {
                    fadeout_step = 0;
                    blink_step = blink_time;
                } //message = "";
                state = 2;
                change_made = true;
            }
            
            if(state == 1) {
                if(script_execute(message_script,"cancel_check"))
                {
                    title = script_execute(message_script,"title");
                    fadeout_step = 0;
                    blink_step = blink_time; //message = "";
                    state = 0;
                    change_made = true;
                }
            }
        }
        
        message_state[?i] = state;
          
        //if(message != old_message) break;
        if(change_made) break;
    }

    // UPDATE FRAME
    var view = my_player.my_camera.view;
    max_width = __view_get( e__VW.WPort, view ) - 192;
    
    if(message != "")
    {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        my_draw_set_font(self.font);
        
        width = 256;
        height = 1000;
        while(width <= max_width && height > (line_height*max_lines)) 
        {   
            width += 32;
            height = string_height_ext(string_hash_to_newline(message), line_height, width);  
        }
        width += 32;
        height += 32;
        
        focused = true;
    }
    else
    {
        width = 0;
        height = 0;
    }
    
    x = __view_get( e__VW.XPort, view ) + __view_get( e__VW.WPort, view )/2 - width/2;
    y = __view_get( e__VW.YPort, view ) + __view_get( e__VW.HPort, view )*0.8 - height/2;
}
else
{
    width = 0;
    height = 0;
}

alarm[2] = message_delay;


