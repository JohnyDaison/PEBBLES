event_inherited();

if(!hidden)
{
    my_draw_set_font(rule_name_label.font);
    
    var width = string_width(rule_name_label.text);
    rule_name_label.width = max(192, width + 2 * text_padding);
    
    self.width = 3*spacing + rule_icon_label.width + rule_name_label.width;
    
    rule_description_label.width = self.width - 2 * spacing;
    my_draw_set_font(rule_description_label.font);
    var height = string_height_ext(rule_description_label.text, rule_description_label.line_separation, rule_description_label.width-16);
    rule_description_label.height = height + 2 * text_padding;
    
    self.height = 3*spacing + rule_icon_label.height + rule_description_label.height;
    
    if(instance_exists(rule_button))
    {
        x = rule_button.x;
        y = rule_button.y - rule_button_margin - self.height;
        
        if (x + self.width > room_width) {
            x = rule_button.x + rule_button.width + rule_button_margin - self.width;
        }
        
        if (y < 0) {
            y = rule_button.y + rule_button.height + rule_button_margin;
        }
    }
}
