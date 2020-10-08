if(visible)
{
    if(enabled)
    {
        if(cursor_obj.x >= x && cursor_obj.x < (x + self.width)
        && cursor_obj.y >= y && cursor_obj.y < (y + self.height)
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
    
        if(joystick_id == 1)
        {
            if(self.depressed && joystick1_obj.last_control != 0)
            {
                if(joystick1_obj.states[# joystick1_obj.last_control, pressed])
                {
                    self.joy = joystick1_obj.last_control;
                    self.depressed = false;
                    self.active = false;
                }
            }
        
            var is_held = joystick1_obj.states[# self.joy,held];
            //self.text = get_const_name(joystick,self.joy)+" | "+string(is_held);
            if(is_held)
            {
                icon = green_dot_spr;
            }
            else
            {
                icon = red_dot_spr;
            }
        
        }
    
        if(joystick_id == 2)
        {
            if(self.depressed && joystick2_obj.last_control != 0)
            {
                if(joystick2_obj.states[# joystick2_obj.last_control, pressed])
                {
                    self.joy = joystick2_obj.last_control;
                    self.depressed = false;
                    self.active = false;
                }
            }
        
            var is_held = joystick2_obj.states[# self.joy,held];
            //self.text = get_const_name(joystick,self.joy)+" | "+string(is_held);
            if(is_held)
            {
                icon = green_dot_spr;
            }
            else
            {
                icon = red_dot_spr;
            }
        
        }
    
        self.text = get_const_name(joystick,self.joy);
    
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
        self.text = get_const_name(joystick,self.joy);
        self.depressed = false;
        self.active = false;
    }
}
