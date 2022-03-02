if(visible)
{
    if(enabled)
    {
        if(self.bg_color == self.disabled_color)
        {
            self.text_color = self.base_text_color;
            self.bg_color = self.base_bg_color;
        }
    
        self.border_color = self.base_border_color;
    
        if(cursor_obj.x >= x && cursor_obj.x <= (x+self.width)
        && cursor_obj.y >= y && cursor_obj.y <= (y+self.height)
        && DB.mouse_has_moved)
        {
            mouse_over = true;
            if(!focused) gui_get_focus();
            cursor_obj.tooltip = tooltip;
        }
        else
        {
            if(!active && mouse_over && focused)
            {
                gui_lose_focus();
                cursor_obj.tooltip = "";
            }
            mouse_over = false;  
        }
    
        if(focused)
        {
            if((mouse_check_button_released(mb_left) && mouse_over) || (DB.gui_controls[# confirm,released] && (!mouse_over || active)))
            {
                if(!self.active)
                {
                    if(self.text == self.prompt_str)
                    {
                        keyboard_string = "";
                    }
                    else
                    {
                        keyboard_string = self.text;
                    }
                }
                if(was_active)
                {
                    self.text = keyboard_string;
                    if(self.onup_script != noone)
                    {
                        script_execute(self.onup_script);
                    }
                    onup_function();
                }
                self.active = !self.active;
                self.depressed = self.active;
                my_sound_play(click_sound);
            }
        }
    
        if(!mouse_over && mouse_check_button_released(mb_left))
        {
            focused = false;
        }
    
        if(!focused && had_focus)
        {
            if(was_active)
            {
                self.text = keyboard_string;
            }
            self.active = false;
            self.depressed = false;
            self.text_color = self.base_text_color;
            self.bg_color = self.base_bg_color;
        }
    
        if(self.depressed)
        {
            self.text_color = self.depressed_text_color;
            self.bg_color = self.depressed_color;
        }
        if(!self.depressed && focused)
        {
            self.text_color = self.highlight_text_color;
            self.bg_color = self.highlight_color;
        }
    
        if(!had_focus && focused)
            my_sound_play(blip_sound);
 
        if(depressed)
        {
            if(string_length(keyboard_string) > self.max_chars)
            {
                keyboard_string = string_copy(keyboard_string,0,self.max_chars);
            }
            self.text = keyboard_string;
            if(active)
            {
                self.text += "_";
            }
        }
    
        if(was_active && !active)
        {
            if(string_length(text) > 0)
            {
                while(string_char_at(text,string_length(text)) == " ")
                {
                    text = string_copy(text,1,string_length(text)-1);
                }
                while(string_char_at(text,1) == " ")
                {
                    text = string_copy(text,2,string_length(text)-1);
                }
            }
        
            if(string_length(text) == 0)
            {
                text = prompt_str;
            }  
        }
    
        had_focus = focused;
        was_active = active;
    }
    else
    {
        self.text_color = self.base_text_color;
        self.bg_color = self.disabled_color;
    }
}
