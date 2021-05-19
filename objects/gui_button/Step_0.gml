if(enabled && visible)
{
    if(self.bg_color == self.disabled_color)
    {
        self.text_color = self.base_text_color;
        self.bg_color = self.base_bg_color;
    }
    
    self.border_color = self.base_border_color;
    
    if(cursor_obj.focus == id)
    {
        if(!focused) gui_get_focus();
        if(focused && !mouse_over)
        {
            if(self.onmouseover_script != noone)
                script_execute(self.onmouseover_script);
        }
        cursor_obj.tooltip = tooltip;
        mouse_over = true;
    }
    else
    {
        if(mouse_over && focused && !active)
        { 
            if(self.onmouseleave_script != noone)
                script_execute(self.onmouseleave_script);
            gui_lose_focus();
            cursor_obj.tooltip = "";
        }
        mouse_over = false;  
    }
    
    if(focused && !locked)
    {
        if((mouse_check_button_pressed(mb_left) && mouse_over) || DB.gui_controls[# confirm,pressed])
        {
            self.depressed = true;
            if(self.ondown_script != noone)
                script_execute(self.ondown_script);
            step_count = 0;
        }
        
        if(self.repeater && self.depressed)
        {
            right_step = (step_count mod round(repeat_rate) == 0);
            if(right_step && step_count > repeat_wait)
            {
                if((mouse_check_button(mb_left) && mouse_over) || DB.gui_controls[# confirm,held])
                {
                    my_sound_play(click_sound, true, 0.1);
                    if(self.onrepeat_script != noone)
                        script_execute(self.onrepeat_script);
                }
            }
            step_count += 1;
        }
        
        if((mouse_check_button_released(mb_left) && mouse_over) || DB.gui_controls[# confirm,released])
        {   
            if(self.depressed)
            {
                my_sound_play(click_sound);
                if(self.onup_script != noone)
                    script_execute(self.onup_script);
            }
            if(!sticky)
            {
                self.depressed = false;      
            }
            
        }
    }
    
    if(!focused)
    {
        if(!sticky)
        {
            self.depressed = false;
        }
        self.text_color = self.base_text_color;
        self.bg_color = self.base_bg_color;
    }
    
    if(self.depressed)
    {
        self.text_color = self.depressed_text_color;
        self.bg_color = self.depressed_color;
    }
    
    if(!self.depressed && focused && !locked)
    {
        self.text_color = self.highlight_text_color;
        self.bg_color = self.highlight_color;
    }
    
    
    if(locked)
    {
        self.border_color = self.locked_border_color;
        self.draw_thick_border = true;
    }
    else
    {
        self.border_color = self.base_border_color;
        self.draw_thick_border = false;
        
        if(self.draw_unlocked_border)
        {
            self.border_color = self.unlocked_border_color;
            self.draw_thick_border = true;
        }
    }
    
    if(!had_focus && focused && !locked)
    {
        my_sound_play(blip_sound);
    }
    had_focus = focused;
}
else
{
    if(visible)
    {
        self.text_color = self.base_text_color;
        self.bg_color = self.disabled_color;
        self.border_color = self.disabled_border_color;
    }
    self.active = false;
    if(!sticky)
    {
        self.depressed = false;
    }
    
    if(cursor_obj.focus == id)
    {
        cursor_obj.tooltip = tooltip;
        mouse_over = true;
    }
    else
    {
        if(mouse_over)
        { 
            cursor_obj.tooltip = "";
        }
        mouse_over = false;  
    }
}

if(alarm[1] > 0)
{
    self.autoclick_text = string(floor(alarm[1]/60));
}
else
{
    self.autoclick_text = "";
}
