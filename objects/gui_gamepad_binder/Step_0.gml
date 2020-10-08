if(visible)
{
    if(enabled)
    {
        if(cursor_obj.x>=x && cursor_obj.x<(x+self.width)
        && cursor_obj.y>=y && cursor_obj.y<(y+self.height)
        && DB.mouse_has_moved)
        {
            mouse_over = true;
            if(!focused) gui_get_focus();
        }
        else
        {
            if(mouse_over && focused && !active)
            { 
                gui_lose_focus();
                self.depressed = false;
            }
            mouse_over = false;  
        }
    
        if(focused && mouse_check_button_pressed(mb_left) && mouse_over)
        {
            self.depressed = true;
            self.active = true;
            self.bg_color = self.depressed_color;
        }
    
        if(self.depressed)
        {
            var is_pressed = false;
            var gp_id = 0;
        
            while(gp_id < gp_face1 + 30)
            {
                if(gp_id == 11)
                {
                    gp_id = gp_face1;
                }
            
                if(gp_id > 10)
                {
                    is_pressed = gamepad_button_check_pressed(control_obj.index, gp_id);
                }
                else if(!is_undefined(gp_id))
                {
                    is_pressed = control_obj.states[# (gp_id), pressed];
                }
        
                if(is_pressed)
                {
                    break;
                }
            
                gp_id++;
            }
        
            if(is_pressed)
            {
                self.control_id = gp_id;
                self.depressed = false;
                self.active = false;
            }
        }
    
        var gp_id = control_id;
        var is_held = false;
        
        if(gp_id > 10)
        {
            is_held = gamepad_button_check(control_obj.index, gp_id);
        }
        else if(!is_undefined(gp_id))
        {
            is_held = control_obj.states[# (gp_id), held];
        }
    
    
        if(is_held)
        {
            icon = green_dot_spr;
        }
        else
        {
            icon = red_dot_spr;
        }

    
        self.text = get_const_name(gamepad,self.control_id);
    
        if(!self.depressed && focused) self.bg_color = self.highlight_color;
        if(!self.depressed && !focused) self.bg_color = self.base_bg_color;
    
        if(!had_focus && focused)
            my_sound_play(blip_sound);
        had_focus = focused;
    }
    else
    {
        self.bg_color = self.disabled_color;
        /*
        if(joystick_id == 1)
        {   
            self.text = get_const_name(joystick,self.joy)+" | "+string(joystick1_obj.states[# self.joy,held]);
        }
    
        if(joystick_id == 2)
        {
            self.text = get_const_name(joystick,self.joy)+" | "+string(joystick2_obj.states[# self.joy,held]);
        }
        */
        self.text = get_const_name(gamepad,self.control_id);
        self.depressed = false;
        self.active = false;
    }
}
