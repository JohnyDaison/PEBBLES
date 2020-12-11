event_inherited();

if(!hidden)
{
    my_draw_set_font(mod_name_label.font);
    
    var width = string_width(mod_name_label.text);
    mod_name_label.width = max(192, width + 8);
    
    self.width = 3*spacing + mod_icon_label.width + mod_name_label.width;
    
    mod_description_label.width = self.width - 2*spacing;
    my_draw_set_font(mod_description_label.font);
    var height = string_height_ext(mod_description_label.text, mod_description_label.line_separation, mod_description_label.width-16);
    mod_description_label.height = height + 8;
    
    self.height = 3*spacing + mod_icon_label.height + mod_description_label.height;
    
    if(instance_exists(mod_button))
    {
        x = mod_button.x;
        y = mod_button.y - 8 - self.height;
    }
}