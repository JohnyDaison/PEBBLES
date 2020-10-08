// CENTERING
if(!centered)
{
    if(align == "center")
    {
        var x_diff = -width/2;
        var y_diff = -height/2;
        x += x_diff;
        y += y_diff;
        
        if(rel_position == "relative")
        {
            rel_x += x_diff;
            rel_y += y_diff;
        }
    }
    centered = true;
}

// BG
draw_set_alpha(bg_alpha);
if(self.draw_bg_color)
{
    draw_set_color(self.bg_color);
    draw_roundrect(x,y,x+self.width,y+self.height,false)
}

// BORDER
draw_set_alpha(self.border_alpha);
if(self.draw_border)
{
    draw_set_color(self.border_color);
    draw_roundrect(x,y,x+self.width,y+self.height,true)
}

// HEADING TEXT AND ICON
if(self.draw_heading)
{
    draw_set_alpha(1);
    draw_set_color(self.color);
    my_draw_set_font(self.font);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    if(icon == noone)
    {
        my_draw_text(x+self.width/2,y+16, self.text);
    }
    else
    {
        if(show_icon)
        {
            if(center_icon)
            {
                str_width = string_width(self.text);
                draw_sprite_ext(icon,image_index, x+self.width/2-str_width/2-16,y, 1,1,0, c_white,icon_alpha);
            }
            else
            {
                draw_sprite_ext(icon,image_index, x,y, 1,1,0, c_white,icon_alpha);
            }
        }
        my_draw_text(x+self.width/2+16, y+16, self.text);
    }            
}
