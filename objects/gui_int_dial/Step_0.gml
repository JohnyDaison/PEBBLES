if (!self.custom_width) {
    self.width = max_digits * digit_width;
}

if(self.is_int_input)
{
    self.min_value = gui_parent.min_value;
    self.max_value = gui_parent.max_value;
    self.enabled = !gui_parent.locked;
    self.base_border_color = gui_parent.base_border_color;
    self.disabled_border_color = gui_parent.disabled_border_color;
}

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
    
        if(cursor_obj.focus == id)
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
                    keyboard_string = string(self.value);
                }
                self.active = !self.active;
                self.depressed = self.active;
                my_sound_play(click_sound);    
            }
        
            if(self.active)
            {
                if(DB.gui_controls[# up,pressed] || mouse_wheel_up())
                {
                    self.value = min(self.max_value, self.value + self.value_step);
                    keyboard_string = string(self.value);
                }
                if(DB.gui_controls[# down,pressed] || mouse_wheel_down())
                {
                    self.value = max(self.min_value, self.value - self.value_step);
                    keyboard_string = string(self.value);
                }
            }
        }
    
       if(!focused && had_focus)
        {
            if(was_active)
            {             
                self.value = real(string_digits(keyboard_string));
            }
            self.active = false;
            self.depressed = false;
            self.text_color = self.base_text_color;
            self.bg_color = self.base_bg_color;
        }
    
        if(self.depressed && focused)
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
        
        if(active)
        {
            if(string_length(keyboard_string) > self.max_digits)
            {
                keyboard_string = string_copy(keyboard_string,0,self.max_digits);
            }
            var digits = string_digits(keyboard_string);
            if(digits == "")
            {
                self.value = 0;
            }
            else
            {
                self.value = real(digits);
            }
            keyboard_string = string(self.value);
            self.text = keyboard_string;
        }
        else
        {
            self.value = clamp(self.value, min_value, max_value);
            self.value = min_value + round((self.value - min_value) / value_step) * value_step;
            self.text = string(self.value);
        }
    
        if(is_percent)
        {
            self.text += "%";
        }
    
        had_focus = focused;
        was_active = active;
    }
    else
    {
        self.text_color = self.base_text_color;
        self.bg_color = self.disabled_color;
        self.border_color = self.disabled_border_color;
    }
}
