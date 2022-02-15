function gui_checkbox_script() {
    var result = !checked;
    var user_clicked = true;
    if(argument_count > 0)
    {
        result = argument[0];
        user_clicked = false;
    }

    var changed = (checked != result);

    checked = result;
    show_icon = false;

    if(checked)
    {
        if(checked_icon != noone)
        {
            icon = checked_icon;
            show_icon = true;
        }
    
        self.base_bg_color = self.checked_bg_color;
        self.enabled_icon_color = self.checked_icon_color;
    }
    else
    {
        if(unchecked_icon != noone)
        {
            icon = unchecked_icon;
            show_icon = true;
        }
    
        self.base_bg_color = self.unchecked_bg_color;
        self.enabled_icon_color = self.unchecked_icon_color;
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

    if(changed)
    {
        if(user_clicked)
        {
            script_execute(self.user_clicked_script);
        }
        script_execute(self.onchange_script);
        self.onchange_function();
    }
}
