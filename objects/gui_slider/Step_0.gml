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
            if(focused)
            {
                gui_lose_focus();
                cursor_obj.tooltip = "";
            }
            mouse_over = false;
        }
    
        if(focused)
        {
            active = mouse_over;
        
            if(self.active)
            {
                if(mouse_check_button(mb_left) && mouse_over) {
                    var mouse_ratio = (cursor_obj.x - x) / width;
                    set_value(bar_min_value + mouse_ratio * (bar_max_value - bar_min_value));
                }
                
                if(DB.gui_controls[# up,pressed] || mouse_wheel_up())
                {
                    self.value = min(self.max_value, self.value + self.value_step);
                }
                if(DB.gui_controls[# down,pressed] || mouse_wheel_down())
                {
                    self.value = max(self.min_value, self.value - self.value_step);
                }
            }
        }
    
       if(!focused && had_focus)
        {
            self.active = false;
            self.text_color = self.base_text_color;
            self.bg_color = self.base_bg_color;
        }

        if(!had_focus && focused)
            my_sound_play(blip_sound);
        
        if(active)
        {
            
        }
        else
        {
            self.value = clamp(self.value, min_value, max_value);
            self.value = min_value + round((self.value - min_value) / value_step) * value_step;
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
